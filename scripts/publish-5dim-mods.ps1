# Publica los mods 5dim_* en el Factorio Mod Portal (mods.factorio.com).
#
# Por defecto hace DRY-RUN: consulta el portal, compara versiones y muestra
# que haria, sin subir nada. Solo publica de verdad con -Publish.
#
# Requiere una API key del Mod Portal en scripts\.portal-key (una linea).
# Se crea en https://factorio.com/profile con permisos:
#   - "ModPortal: Upload Mods"  (subir versiones nuevas)
#   - "ModPortal: Publish Mods" (publicar mods que aun no existen en el portal)
[CmdletBinding()]
param(
    [string]$ModsRoot,
    [string[]]$Mods = @(),
    [string[]]$ExcludeMods = @(),
    [switch]$Publish,
    [string]$ApiKeyFile,
    [string]$KeepZips
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

if ([string]::IsNullOrWhiteSpace($ModsRoot)) {
    $ModsRoot = Join-Path -Path $PSScriptRoot -ChildPath '..'
}

if ([string]::IsNullOrWhiteSpace($ApiKeyFile)) {
    $ApiKeyFile = Join-Path -Path $PSScriptRoot -ChildPath '.portal-key'
}

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

# En Windows PowerShell 5.1, ZipFile.CreateFromDirectory crea las entradas con
# '\' como separador; el spec zip (y el Mod Portal) exigen '/'. Este switch
# fuerza el separador correcto y debe fijarse antes del primer uso de ZipFile.
[System.AppContext]::SetSwitch('Switch.System.IO.Compression.ZipFile.UseBackslash', $false)

$portalApiBase = 'https://mods.factorio.com/api/mods'
$uploadApiBase = 'https://mods.factorio.com/api/v2/mods'
$newModLicense = 'default_mit'
$newModSourceUrl = 'https://github.com/McGuten/Factorio5DimMods'

$alwaysExcludedMods = @(
    '5dim_decoration',
    '5dim_dev',
    '5dim_compatibility'
)

$effectiveExcludeMods = @($ExcludeMods + $alwaysExcludedMods | Select-Object -Unique)

# Contenido del mod que nunca debe ir dentro del zip publicado
$stagingExcludePatterns = @('*.zip', '.git*', '.vscode', '.DS_Store')

function New-EmptyDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Recurse -Force
    }

    New-Item -ItemType Directory -Path $Path | Out-Null
}

function Compress-DirectoryAsZip {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SourceDirectory,

        [Parameter(Mandatory = $true)]
        [string]$DestinationPath
    )

    if (Test-Path -LiteralPath $DestinationPath) {
        Remove-Item -LiteralPath $DestinationPath -Force
    }

    [System.IO.Compression.ZipFile]::CreateFromDirectory(
        $SourceDirectory,
        $DestinationPath,
        [System.IO.Compression.CompressionLevel]::Optimal,
        $true
    )
}

function Invoke-CurlJson {
    # Ejecuta curl.exe y devuelve la respuesta parseada como JSON.
    # Lanza si curl falla a nivel de transporte o si el portal devuelve un error.
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$CurlArguments,

        [Parameter(Mandatory = $true)]
        [string]$Context
    )

    $rawOutput = & curl.exe -sS @CurlArguments

    if ($LASTEXITCODE -ne 0) {
        throw "curl fallo ($Context), exit code $LASTEXITCODE`: $rawOutput"
    }

    $rawText = ($rawOutput | Out-String).Trim()

    try {
        $parsed = $rawText | ConvertFrom-Json
    }
    catch {
        throw "Respuesta no-JSON del portal ($Context): $rawText"
    }

    if ($parsed.PSObject.Properties['error']) {
        $message = ''
        if ($parsed.PSObject.Properties['message']) {
            $message = $parsed.message
        }
        throw "Error del portal ($Context): $($parsed.error) $message"
    }

    return $parsed
}

function Get-PortalVersions {
    # Consulta la API publica del portal y devuelve un hashtable
    # nombre -> ultima version publicada ([version]) para los mods que existen.
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$ModNames
    )

    $nameQuery = ($ModNames | ForEach-Object { 'namelist=' + [uri]::EscapeDataString($_) }) -join '&'
    $url = '{0}?page_size=max&{1}' -f $portalApiBase, $nameQuery

    $response = Invoke-RestMethod -Uri $url -Method Get

    $versions = @{}

    foreach ($result in $response.results) {
        $latest = $null

        if ($result.PSObject.Properties['latest_release'] -and $result.latest_release) {
            $latest = [version]$result.latest_release.version
        }
        elseif ($result.PSObject.Properties['releases'] -and $result.releases) {
            $latest = ($result.releases | ForEach-Object { [version]$_.version } |
                Sort-Object -Descending | Select-Object -First 1)
        }

        if ($null -ne $latest) {
            $versions[$result.name] = $latest
        }
    }

    return $versions
}

function Test-ChangelogHasVersion {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ModDirectory,

        [Parameter(Mandatory = $true)]
        [string]$Version
    )

    $changelogPath = Join-Path -Path $ModDirectory -ChildPath 'changelog.txt'

    if (-not (Test-Path -LiteralPath $changelogPath)) {
        return 'sin changelog.txt'
    }

    $content = Get-Content -LiteralPath $changelogPath -Raw
    $pattern = '(?m)^Version:\s*' + [regex]::Escape($Version) + '\s*$'

    if ($content -notmatch $pattern) {
        return "changelog sin entrada para $Version"
    }

    return $null
}

function New-ModZip {
    param(
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Mod,

        [Parameter(Mandatory = $true)]
        [string]$StagingRoot,

        [Parameter(Mandatory = $true)]
        [string]$ZipRoot
    )

    $packageBaseName = '{0}_{1}' -f $Mod.Name, $Mod.Version
    $stagingDirectory = Join-Path -Path $StagingRoot -ChildPath $packageBaseName
    $zipPath = Join-Path -Path $ZipRoot -ChildPath ($packageBaseName + '.zip')

    New-Item -ItemType Directory -Path $stagingDirectory | Out-Null

    Get-ChildItem -LiteralPath $Mod.Directory -Force |
        Where-Object {
            $item = $_
            -not ($stagingExcludePatterns | Where-Object { $item.Name -like $_ })
        } |
        Copy-Item -Destination $stagingDirectory -Recurse -Force

    Compress-DirectoryAsZip -SourceDirectory $stagingDirectory -DestinationPath $zipPath

    return $zipPath
}

function Publish-ModRelease {
    # Sube una version nueva de un mod que ya existe en el portal.
    param(
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Mod,

        [Parameter(Mandatory = $true)]
        [string]$ZipPath,

        [Parameter(Mandatory = $true)]
        [string]$ApiKey
    )

    $init = Invoke-CurlJson -Context "init_upload $($Mod.Name)" -CurlArguments @(
        '-X', 'POST',
        '-H', "Authorization: Bearer $ApiKey",
        '-F', ('mod={0}' -f $Mod.Name),
        "$uploadApiBase/releases/init_upload"
    )

    $result = Invoke-CurlJson -Context "upload $($Mod.Name)" -CurlArguments @(
        '-X', 'POST',
        '-F', ('file=@{0}' -f $ZipPath),
        $init.upload_url
    )

    if (-not $result.success) {
        throw "El portal no confirmo la subida de $($Mod.Name)."
    }
}

function Publish-NewMod {
    # Publica por primera vez un mod que aun no existe en el portal.
    param(
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Mod,

        [Parameter(Mandatory = $true)]
        [string]$ZipPath,

        [Parameter(Mandatory = $true)]
        [string]$ApiKey
    )

    $init = Invoke-CurlJson -Context "init_publish $($Mod.Name)" -CurlArguments @(
        '-X', 'POST',
        '-H', "Authorization: Bearer $ApiKey",
        '-F', ('mod={0}' -f $Mod.Name),
        "$uploadApiBase/init_publish"
    )

    $result = Invoke-CurlJson -Context "publish $($Mod.Name)" -CurlArguments @(
        '-X', 'POST',
        '-F', ('file=@{0}' -f $ZipPath),
        '-F', ('license={0}' -f $newModLicense),
        '-F', ('source_url={0}' -f $newModSourceUrl),
        $init.upload_url
    )

    if (-not $result.success) {
        throw "El portal no confirmo la publicacion de $($Mod.Name)."
    }
}

$resolvedModsRoot = (Resolve-Path -LiteralPath $ModsRoot).Path

# --- 1. Descubrir mods ---

$modDirectories = Get-ChildItem -LiteralPath $resolvedModsRoot -Directory -Filter '5dim_*' |
    Where-Object {
        $effectiveExcludeMods -notcontains $_.Name -and
        (Test-Path -LiteralPath (Join-Path -Path $_.FullName -ChildPath 'info.json'))
    } |
    Sort-Object -Property Name

if ($Mods.Count -gt 0) {
    $unknownMods = @($Mods | Where-Object { $modDirectories.Name -notcontains $_ })
    if ($unknownMods) {
        throw "Mods no encontrados (o excluidos): $($unknownMods -join ', ')"
    }
    $modDirectories = @($modDirectories | Where-Object { $Mods -contains $_.Name })
}

if (-not $modDirectories) {
    throw "No matching 5dim mods were found under $resolvedModsRoot."
}

$localMods = foreach ($modDirectory in $modDirectories) {
    $infoPath = Join-Path -Path $modDirectory.FullName -ChildPath 'info.json'
    $info = Get-Content -LiteralPath $infoPath -Raw | ConvertFrom-Json

    if ([string]::IsNullOrWhiteSpace($info.name) -or [string]::IsNullOrWhiteSpace($info.version)) {
        throw "Missing name or version in $infoPath."
    }

    [pscustomobject]@{
        Name = $info.name
        Version = [version]$info.version
        Directory = $modDirectory.FullName
    }
}

# --- 2 y 3. Validar changelogs y consultar el portal ---

Write-Host ("Consultando el Mod Portal para {0} mods..." -f @($localMods).Count)
$portalVersions = Get-PortalVersions -ModNames @($localMods | Select-Object -ExpandProperty Name)

$planEntries = foreach ($mod in $localMods) {
    $warning = Test-ChangelogHasVersion -ModDirectory $mod.Directory -Version $mod.Version.ToString()

    $portalVersion = $null
    if ($portalVersions.ContainsKey($mod.Name)) {
        $portalVersion = $portalVersions[$mod.Name]
    }

    if ($null -eq $portalVersion) {
        $action = 'PUBLISH'
    }
    elseif ($mod.Version -gt $portalVersion) {
        $action = 'UPLOAD'
    }
    else {
        $action = 'SKIP'
    }

    [pscustomobject]@{
        Mod = $mod
        Name = $mod.Name
        Local = $mod.Version.ToString()
        Portal = if ($null -ne $portalVersion) { $portalVersion.ToString() } else { '-' }
        Action = $action
        Warning = if ($warning) { $warning } else { '' }
    }
}

Write-Host ''
$planEntries |
    Select-Object -Property Name, Local, Portal, Action, Warning |
    Format-Table -AutoSize |
    Out-String |
    Write-Host

$warningEntries = @($planEntries | Where-Object { $_.Warning })
foreach ($entry in $warningEntries) {
    Write-Host ("AVISO: {0}: {1}" -f $entry.Name, $entry.Warning) -ForegroundColor Yellow
}

$pendingEntries = @($planEntries | Where-Object { $_.Action -ne 'SKIP' })

if (-not $Publish -and [string]::IsNullOrWhiteSpace($KeepZips)) {
    Write-Host ''
    if ($pendingEntries) {
        Write-Host ("Dry-run: {0} mods se subirian ({1} PUBLISH, {2} UPLOAD). Ejecuta con -Publish para publicar." -f `
            $pendingEntries.Count,
            @($pendingEntries | Where-Object { $_.Action -eq 'PUBLISH' }).Count,
            @($pendingEntries | Where-Object { $_.Action -eq 'UPLOAD' }).Count) -ForegroundColor Cyan
    }
    else {
        Write-Host 'Dry-run: todos los mods estan al dia en el portal.' -ForegroundColor Green
    }
    exit 0
}

# --- 4. Leer API key (solo si se va a publicar) ---

$apiKey = $null
if ($Publish) {
    if (-not (Test-Path -LiteralPath $ApiKeyFile)) {
        throw @"
No existe el archivo de API key: $ApiKeyFile
Crea una API key en https://factorio.com/profile con permisos
"ModPortal: Upload Mods" y "ModPortal: Publish Mods", y guardala
en ese archivo (una sola linea). El archivo esta ignorado por git.
"@
    }
    $apiKey = (Get-Content -LiteralPath $ApiKeyFile -Raw).Trim()
    if ([string]::IsNullOrWhiteSpace($apiKey)) {
        throw "El archivo de API key esta vacio: $ApiKeyFile"
    }
}

# --- 5. Empaquetar y subir ---

$entriesToZip = if ($Publish) { $pendingEntries } else { $planEntries }

if (-not $entriesToZip) {
    Write-Host 'Nada que subir: todos los mods estan al dia en el portal.' -ForegroundColor Green
    exit 0
}

$tempRoot = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath ("5dim-publish-" + [System.Guid]::NewGuid().ToString('N'))
$stagingRoot = Join-Path -Path $tempRoot -ChildPath 'packages'
$zipRoot = Join-Path -Path $tempRoot -ChildPath 'zips'

New-EmptyDirectory -Path $stagingRoot
New-EmptyDirectory -Path $zipRoot

$failedEntries = New-Object System.Collections.Generic.List[object]
$uploadedEntries = New-Object System.Collections.Generic.List[object]

try {
    foreach ($entry in $entriesToZip) {
        try {
            Write-Host ("Empaquetando {0}_{1}..." -f $entry.Name, $entry.Local)
            $zipPath = New-ModZip -Mod $entry.Mod -StagingRoot $stagingRoot -ZipRoot $zipRoot

            if (-not [string]::IsNullOrWhiteSpace($KeepZips)) {
                if (-not (Test-Path -LiteralPath $KeepZips)) {
                    New-Item -ItemType Directory -Path $KeepZips | Out-Null
                }
                Copy-Item -LiteralPath $zipPath -Destination $KeepZips -Force
            }

            if (-not $Publish) {
                continue
            }

            if ($entry.Action -eq 'PUBLISH') {
                Write-Host ("Publicando mod nuevo {0}..." -f $entry.Name)
                Publish-NewMod -Mod $entry.Mod -ZipPath $zipPath -ApiKey $apiKey
            }
            else {
                Write-Host ("Subiendo {0} {1}..." -f $entry.Name, $entry.Local)
                Publish-ModRelease -Mod $entry.Mod -ZipPath $zipPath -ApiKey $apiKey
            }

            Write-Host ("  OK: {0} {1} ({2})" -f $entry.Name, $entry.Local, $entry.Action) -ForegroundColor Green
            $uploadedEntries.Add($entry) | Out-Null
        }
        catch {
            Write-Host ("  FALLO: {0}: {1}" -f $entry.Name, $_.Exception.Message) -ForegroundColor Red
            $failedEntries.Add($entry) | Out-Null
        }
    }
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        Remove-Item -LiteralPath $tempRoot -Recurse -Force
    }
}

# --- 6. Resumen ---

Write-Host ''
if (-not [string]::IsNullOrWhiteSpace($KeepZips)) {
    Write-Host ("Zips conservados en: {0}" -f (Resolve-Path -LiteralPath $KeepZips).Path)
}

if ($Publish) {
    Write-Host ("Resumen: {0} subidos, {1} saltados, {2} fallidos." -f `
        $uploadedEntries.Count,
        (@($planEntries).Count - $pendingEntries.Count),
        $failedEntries.Count)

    if ($failedEntries.Count -gt 0) {
        Write-Host ("Fallidos: {0}" -f (($failedEntries | Select-Object -ExpandProperty Name) -join ', ')) -ForegroundColor Red
        exit 1
    }
}
else {
    Write-Host ("Dry-run: zips generados sin publicar. Ejecuta con -Publish para publicar.") -ForegroundColor Cyan
}

exit 0
