[CmdletBinding()]
param(
    [string]$ModsRoot = $PSScriptRoot,
    [string]$OutputDirectory = $PSScriptRoot,
    [string]$BundleName = '5dim_mods_bundle.zip',
    [string[]]$ExcludeMods = @('5dim_decoration', '5dim_dev'),
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

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

function New-ZipFromFiles {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$SourceFiles,

        [Parameter(Mandatory = $true)]
        [string]$DestinationPath
    )

    if (Test-Path -LiteralPath $DestinationPath) {
        Remove-Item -LiteralPath $DestinationPath -Force
    }

    $fileStream = [System.IO.File]::Open($DestinationPath, [System.IO.FileMode]::CreateNew)

    try {
        $zipArchive = New-Object System.IO.Compression.ZipArchive(
            $fileStream,
            [System.IO.Compression.ZipArchiveMode]::Create,
            $false
        )

        try {
            foreach ($sourceFile in ($SourceFiles | Sort-Object)) {
                [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                    $zipArchive,
                    $sourceFile,
                    [System.IO.Path]::GetFileName($sourceFile),
                    [System.IO.Compression.CompressionLevel]::NoCompression
                ) | Out-Null
            }
        }
        finally {
            $zipArchive.Dispose()
        }
    }
    finally {
        $fileStream.Dispose()
    }
}

$resolvedModsRoot = (Resolve-Path -LiteralPath $ModsRoot).Path

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
}

$resolvedOutputDirectory = (Resolve-Path -LiteralPath $OutputDirectory).Path
$bundlePath = Join-Path -Path $resolvedOutputDirectory -ChildPath $BundleName

if ((Test-Path -LiteralPath $bundlePath) -and -not $Force) {
    throw "The output bundle already exists: $bundlePath`nUse -Force to overwrite it."
}

if (Test-Path -LiteralPath $bundlePath) {
    Remove-Item -LiteralPath $bundlePath -Force
}

$tempRoot = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath ("5dim-build-" + [System.Guid]::NewGuid().ToString('N'))
$packageRoot = Join-Path -Path $tempRoot -ChildPath 'packages'
$zipRoot = Join-Path -Path $tempRoot -ChildPath 'zips'

New-EmptyDirectory -Path $packageRoot
New-EmptyDirectory -Path $zipRoot

try {
    $modDirectories = Get-ChildItem -LiteralPath $resolvedModsRoot -Directory -Filter '5dim_*' |
        Where-Object {
            $ExcludeMods -notcontains $_.Name -and
            (Test-Path -LiteralPath (Join-Path -Path $_.FullName -ChildPath 'info.json'))
        } |
        Sort-Object -Property Name

    if (-not $modDirectories) {
        throw "No matching 5dim mods were found under $resolvedModsRoot."
    }

    $packagedMods = New-Object System.Collections.Generic.List[object]

    foreach ($modDirectory in $modDirectories) {
        $infoPath = Join-Path -Path $modDirectory.FullName -ChildPath 'info.json'
        $info = Get-Content -LiteralPath $infoPath -Raw | ConvertFrom-Json

        if ([string]::IsNullOrWhiteSpace($info.name) -or [string]::IsNullOrWhiteSpace($info.version)) {
            throw "Missing name or version in $infoPath."
        }

        $packageBaseName = '{0}_{1}' -f $info.name, $info.version
        $stagingDirectory = Join-Path -Path $packageRoot -ChildPath $packageBaseName
        $modZipPath = Join-Path -Path $zipRoot -ChildPath ($packageBaseName + '.zip')

        Write-Host ("Packing {0}..." -f $packageBaseName)

        New-Item -ItemType Directory -Path $stagingDirectory | Out-Null

        Get-ChildItem -LiteralPath $modDirectory.FullName -Force |
            Copy-Item -Destination $stagingDirectory -Recurse -Force

        Compress-DirectoryAsZip -SourceDirectory $stagingDirectory -DestinationPath $modZipPath

        $packagedMods.Add([pscustomobject]@{
            Name = $info.name
            Version = $info.version
            ZipPath = $modZipPath
        }) | Out-Null
    }

    $zipFiles = $packagedMods | Sort-Object -Property Name | Select-Object -ExpandProperty ZipPath
    Write-Host 'Building outer bundle...'
    New-ZipFromFiles -SourceFiles $zipFiles -DestinationPath $bundlePath

    Write-Host "Bundle created:" -ForegroundColor Green
    Write-Host "  $bundlePath"
    Write-Host ''
    Write-Host 'Included mods:'
    foreach ($packagedMod in ($packagedMods | Sort-Object -Property Name)) {
        Write-Host ("  - {0} {1}" -f $packagedMod.Name, $packagedMod.Version)
    }
    Write-Host ''
    Write-Host 'Extract the outer zip and copy the mod zip files into your Factorio mods folder.'
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        Remove-Item -LiteralPath $tempRoot -Recurse -Force
    }
}