<#
.SYNOPSIS
    Runs local Factorio validation profiles for 5Dim's mod suite.

.DESCRIPTION
    Generates temporary mod directories and config files outside the workspace so
    multiple DLC and module combinations can be validated without mutating the
    tracked mod-list.json or config files. The default execution mode focuses on
    smoke tests for data-stage loading using --dump-data so Factorio exits on its
    own after validation.

.PARAMETER FactorioPath
    Optional explicit path to factorio.exe. When omitted, the script tries to read
    it from .vscode/settings.json inside the workspace.

.PARAMETER TestSet
    Which profile family to run:
      - Smoke: suite without DLC, suite without Space Age, full suite.
      - Module: core-only plus core + each 5Dim module separately.
      - All: both Smoke and Module.

.PARAMETER Profiles
    Optional explicit profile names to run after the set is generated.

.PARAMETER DryRun
    Prints the resolved profiles without launching Factorio.

.PARAMETER RunLocaleValidation
    Runs validate-locales.ps1 before launching Factorio.

.PARAMETER KeepArtifacts
    Keeps heavy dump artifacts under the temporary run directory.

.EXAMPLE
    .\scripts\validate-factorio-profiles.ps1 -ListProfiles

.EXAMPLE
    .\scripts\validate-factorio-profiles.ps1 -TestSet Smoke

.EXAMPLE
    .\scripts\validate-factorio-profiles.ps1 -TestSet Module -Profiles module-5dim_transport,module-5dim_space_age
#>

[CmdletBinding()]
param(
    [string]$WorkspaceRoot,
    [string]$ModsRoot,
    [string]$ConfigTemplatePath,
    [string]$FactorioPath,
    [ValidateSet('Smoke', 'Module', 'All')]
    [string]$TestSet = 'Smoke',
    [string[]]$Profiles,
    [int]$TimeoutSeconds = 900,
    [string]$OutputRoot = (Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath 'factorio-5dim-validation'),
    [switch]$DryRun,
    [switch]$ListProfiles,
    [switch]$RunLocaleValidation,
    [switch]$KeepArtifacts,
    [switch]$StopOnFailure,
    [switch]$NoDumpData
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$OfficialMods = @('base', 'elevated-rails', 'quality', 'space-age')
$ExcludedSuiteMods = @('5dim_compatibility', '5dim_decoration')

function Resolve-DefaultWorkspaceRoot {
    return (Resolve-Path -LiteralPath (Join-Path -Path $PSScriptRoot -ChildPath '..\..')).Path
}

function Resolve-DefaultModsRoot {
    return (Resolve-Path -LiteralPath (Join-Path -Path $PSScriptRoot -ChildPath '..')).Path
}

function Resolve-DefaultConfigTemplate {
    param([string]$ResolvedWorkspaceRoot)

    return Join-Path -Path $ResolvedWorkspaceRoot -ChildPath 'config\validation-automation.ini'
}

function New-CaseInsensitiveMap {
    return @{}
}

function Add-NamesToMap {
    param(
        [hashtable]$Map,
        [string[]]$Names
    )

    foreach ($name in $Names) {
        if (-not [string]::IsNullOrWhiteSpace($name)) {
            $Map[$name] = $true
        }
    }
}

function Get-MapKeys {
    param([hashtable]$Map)

    return $Map.Keys | Sort-Object
}

function Parse-DependencyDescriptor {
    param([string]$Descriptor)

    $match = [regex]::Match($Descriptor, '^\s*(?<kind>\(\?\)|\?|!|~)?\s*(?<name>[A-Za-z0-9\-_]+)')
    if (-not $match.Success) {
        return $null
    }

    $kind = $match.Groups['kind'].Value

    return [pscustomobject]@{
        Name = $match.Groups['name'].Value
        IsOptional = $kind -eq '?' -or $kind -eq '(?)'
        IsConflict = $kind -eq '!' -or $kind -eq '~'
    }
}

function Get-RequiredDependencyNames {
    param([pscustomobject]$Mod)

    return @($Mod.Dependencies | Where-Object { -not $_.IsOptional -and -not $_.IsConflict } | ForEach-Object { $_.Name })
}

function Get-ReferencedOfficialMods {
    param([pscustomobject]$Mod)

    return @(
        $Mod.Dependencies |
            Where-Object { $OfficialMods -contains $_.Name } |
            ForEach-Object { $_.Name }
    ) | Sort-Object -Unique
}

function Get-RequiredOfficialMods {
    param([pscustomobject]$Mod)

    return @(
        $Mod.Dependencies |
            Where-Object { -not $_.IsOptional -and -not $_.IsConflict -and ($OfficialMods -contains $_.Name) } |
            ForEach-Object { $_.Name }
    ) | Sort-Object -Unique
}

function Get-RequiredExternalMods {
    param([pscustomobject]$Mod)

    return @(
        $Mod.Dependencies |
            Where-Object {
                -not $_.IsOptional -and
                -not $_.IsConflict -and
                ($OfficialMods -notcontains $_.Name) -and
                ($_.Name -notlike '5dim_*')
            } |
            ForEach-Object { $_.Name }
    ) | Sort-Object -Unique
}

function Get-AvailableModCatalog {
    param([string]$ResolvedModsRoot)

    $catalog = New-CaseInsensitiveMap

    $modDirectories = Get-ChildItem -LiteralPath $ResolvedModsRoot -Directory | Where-Object {
        Test-Path -LiteralPath (Join-Path -Path $_.FullName -ChildPath 'info.json')
    }

    foreach ($modDirectory in ($modDirectories | Sort-Object -Property Name)) {
        $infoPath = Join-Path -Path $modDirectory.FullName -ChildPath 'info.json'
        $info = Get-Content -LiteralPath $infoPath -Raw | ConvertFrom-Json
        $dependencyObjects = @()

        if ($info.PSObject.Properties.Name -contains 'dependencies') {
            foreach ($descriptor in @($info.dependencies)) {
                $parsedDependency = Parse-DependencyDescriptor -Descriptor $descriptor
                if ($null -ne $parsedDependency) {
                    $dependencyObjects += $parsedDependency
                }
            }
        }

        $catalog[$info.name] = [pscustomobject]@{
            Name = [string]$info.name
            Version = [string]$info.version
            Path = $modDirectory.FullName
            FolderName = $modDirectory.Name
            PackageType = 'directory'
            Dependencies = $dependencyObjects
        }
    }

    $zipFiles = Get-ChildItem -LiteralPath $ResolvedModsRoot -File -Filter '*.zip'
    foreach ($zipFile in ($zipFiles | Sort-Object -Property Name)) {
        $match = [regex]::Match($zipFile.Name, '^(?<name>.+)_(?<version>\d+\.\d+.*)\.zip$')
        if (-not $match.Success) {
            continue
        }

        $modName = $match.Groups['name'].Value
        if ($catalog.ContainsKey($modName)) {
            continue
        }

        $catalog[$modName] = [pscustomobject]@{
            Name = $modName
            Version = $match.Groups['version'].Value
            Path = $zipFile.FullName
            FolderName = $zipFile.Name
            PackageType = 'zip'
            Dependencies = @()
        }
    }

    return $catalog
}

function Resolve-FactorioPath {
    param(
        [string]$ExplicitPath,
        [string]$ResolvedWorkspaceRoot
    )

    if (-not [string]::IsNullOrWhiteSpace($ExplicitPath)) {
        return (Resolve-Path -LiteralPath $ExplicitPath).Path
    }

    $settingsPath = Join-Path -Path $ResolvedWorkspaceRoot -ChildPath '.vscode\settings.json'
    if (-not (Test-Path -LiteralPath $settingsPath)) {
        throw "Factorio path was not provided and $settingsPath does not exist."
    }

    $settings = Get-Content -LiteralPath $settingsPath -Raw | ConvertFrom-Json
    $versions = @($settings.'factorio.versions')
    $candidate = $versions | Where-Object { -not [string]::IsNullOrWhiteSpace($_.factorioPath) } | Select-Object -First 1

    if ($null -eq $candidate) {
        throw "Unable to resolve factorioPath from $settingsPath."
    }

    return (Resolve-Path -LiteralPath $candidate.factorioPath).Path
}

function Get-CompatibleSuiteModules {
    param(
        [string[]]$CandidateModNames,
        [string[]]$EnabledOfficialMods,
        [hashtable]$Catalog
    )

    $officialLookup = New-CaseInsensitiveMap
    Add-NamesToMap -Map $officialLookup -Names $EnabledOfficialMods

    $selected = New-Object System.Collections.ArrayList
    $omitted = New-Object System.Collections.ArrayList

    foreach ($modName in ($CandidateModNames | Sort-Object)) {
        $mod = $Catalog[$modName]
        $missingOfficial = @(Get-RequiredOfficialMods -Mod $mod | Where-Object { -not $officialLookup.ContainsKey($_) })
        if ($missingOfficial.Count -gt 0) {
            [void]$omitted.Add("$modName (missing official: $($missingOfficial -join ', '))")
            continue
        }

        $missingExternal = @(Get-RequiredExternalMods -Mod $mod | Where-Object { -not $Catalog.ContainsKey($_) })
        if ($missingExternal.Count -gt 0) {
            [void]$omitted.Add("$modName (missing external: $($missingExternal -join ', '))")
            continue
        }

        [void]$selected.Add($modName)
    }

    return [pscustomobject]@{
        Selected = @($selected)
        Omitted = @($omitted)
    }
}

function Resolve-RequiredModClosure {
    param(
        [string[]]$SeedModNames,
        [string[]]$EnabledOfficialMods,
        [hashtable]$Catalog
    )

    $officialLookup = New-CaseInsensitiveMap
    Add-NamesToMap -Map $officialLookup -Names $EnabledOfficialMods

    $selectedLookup = New-CaseInsensitiveMap
    $queue = New-Object System.Collections.Generic.Queue[string]
    $missingRequired = New-Object System.Collections.ArrayList

    foreach ($seedModName in ($SeedModNames | Sort-Object -Unique)) {
        $queue.Enqueue($seedModName)
    }

    while ($queue.Count -gt 0) {
        $modName = $queue.Dequeue()
        if ($selectedLookup.ContainsKey($modName)) {
            continue
        }

        if (-not $Catalog.ContainsKey($modName)) {
            [void]$missingRequired.Add($modName)
            continue
        }

        $selectedLookup[$modName] = $true
        $mod = $Catalog[$modName]

        foreach ($dependencyName in (Get-RequiredDependencyNames -Mod $mod)) {
            if ($officialLookup.ContainsKey($dependencyName)) {
                continue
            }

            if ($OfficialMods -contains $dependencyName) {
                [void]$missingRequired.Add("$modName -> $dependencyName")
                continue
            }

            if ($Catalog.ContainsKey($dependencyName)) {
                if (-not $selectedLookup.ContainsKey($dependencyName)) {
                    $queue.Enqueue($dependencyName)
                }
                continue
            }

            [void]$missingRequired.Add("$modName -> $dependencyName")
        }
    }

    return [pscustomobject]@{
        SelectedModNames = Get-MapKeys -Map $selectedLookup
        MissingRequired = @($missingRequired | Sort-Object -Unique)
    }
}

function Get-RecommendOfficialModsForModule {
    param(
        [string]$ModuleName,
        [hashtable]$Catalog
    )

    $mod = $Catalog[$ModuleName]
    $officialMods = New-CaseInsensitiveMap
    Add-NamesToMap -Map $officialMods -Names @('base', 'elevated-rails', 'quality')

    if ($ModuleName -in @('5dim_core', '5dim_module', '5dim_space_age', '5dim_transport')) {
        $officialMods['space-age'] = $true
    }

    foreach ($dependency in @($mod.Dependencies)) {
        if ($OfficialMods -contains $dependency.Name) {
            $officialMods[$dependency.Name] = $true
        }
    }

    return Get-MapKeys -Map $officialMods
}

function New-ProfileDefinition {
    param(
        [string]$Name,
        [string]$Kind,
        [string]$Description,
        [string[]]$EnabledOfficialMods,
        [string[]]$SeedModNames,
        [string[]]$Notes
    )

    return [pscustomobject]@{
        Name = $Name
        Kind = $Kind
        Description = $Description
        EnabledOfficialMods = @($EnabledOfficialMods | Sort-Object -Unique)
        SeedModNames = @($SeedModNames | Sort-Object -Unique)
        Notes = @($Notes)
    }
}

function Get-ProfileDefinitions {
    param(
        [string]$RequestedTestSet,
        [hashtable]$Catalog,
        [string[]]$ProfileFilter
    )

    $profiles = New-Object System.Collections.ArrayList
    $normalizedProfileFilter = @()

    if ($null -ne $ProfileFilter) {
        foreach ($profileFilterEntry in $ProfileFilter) {
            foreach ($profileName in @([string]$profileFilterEntry -split ',')) {
                $trimmedProfileName = $profileName.Trim()
                if (-not [string]::IsNullOrWhiteSpace($trimmedProfileName)) {
                    $normalizedProfileFilter += $trimmedProfileName
                }
            }
        }
    }

    $suiteCandidates = @(
        Get-MapKeys -Map $Catalog |
            Where-Object {
                $_ -like '5dim_*' -and
                $_ -notin $ExcludedSuiteMods
            }
    )

    if ($RequestedTestSet -in @('Smoke', 'All')) {
        $suiteDefinitions = @(
            [pscustomobject]@{
                Name = 'suite-no-dlc'
                Description = '5Dim full suite without any official DLC enabled.'
                OfficialMods = @('base')
            },
            [pscustomobject]@{
                Name = 'suite-no-space-age'
                Description = '5Dim full suite with Quality and Elevated Rails, but without Space Age.'
                OfficialMods = @('base', 'elevated-rails', 'quality')
            },
            [pscustomobject]@{
                Name = 'suite-full'
                Description = '5Dim full suite with Space Age, Quality and Elevated Rails.'
                OfficialMods = @('base', 'elevated-rails', 'quality', 'space-age')
            }
        )

        foreach ($suiteDefinition in $suiteDefinitions) {
            $compatibility = Get-CompatibleSuiteModules -CandidateModNames $suiteCandidates -EnabledOfficialMods $suiteDefinition.OfficialMods -Catalog $Catalog
            $closure = Resolve-RequiredModClosure -SeedModNames $compatibility.Selected -EnabledOfficialMods $suiteDefinition.OfficialMods -Catalog $Catalog
            $notes = @($compatibility.Omitted)

            if ($closure.MissingRequired.Count -gt 0) {
                $notes += @("missing required mods: $($closure.MissingRequired -join ', ')")
            }

            [void]$profiles.Add((New-ProfileDefinition -Name $suiteDefinition.Name -Kind 'suite' -Description $suiteDefinition.Description -EnabledOfficialMods $suiteDefinition.OfficialMods -SeedModNames $closure.SelectedModNames -Notes $notes))
        }
    }

    if ($RequestedTestSet -in @('Module', 'All')) {
        [void]$profiles.Add((New-ProfileDefinition -Name 'module-core-only' -Kind 'module' -Description '5dim_core on its own, with the maximum official surface enabled.' -EnabledOfficialMods (Get-RecommendOfficialModsForModule -ModuleName '5dim_core' -Catalog $Catalog) -SeedModNames @('5dim_core') -Notes @()))

        $moduleTargets = @(
            Get-MapKeys -Map $Catalog |
                Where-Object {
                    $_ -like '5dim_*' -and
                    $_ -notin @('5dim_core', '5dim_compatibility', '5dim_decoration')
                }
        )

        foreach ($moduleName in $moduleTargets) {
            $officialMods = Get-RecommendOfficialModsForModule -ModuleName $moduleName -Catalog $Catalog
            $closure = Resolve-RequiredModClosure -SeedModNames @('5dim_core', $moduleName) -EnabledOfficialMods $officialMods -Catalog $Catalog
            $notes = @()

            if ($closure.MissingRequired.Count -gt 0) {
                $notes += @("missing required mods: $($closure.MissingRequired -join ', ')")
            }

            [void]$profiles.Add((New-ProfileDefinition -Name ("module-$moduleName") -Kind 'module' -Description ("5dim_core plus $moduleName on its own.") -EnabledOfficialMods $officialMods -SeedModNames $closure.SelectedModNames -Notes $notes))
        }
    }

    $result = @($profiles)

    if ($normalizedProfileFilter.Count -gt 0) {
        $filterLookup = New-CaseInsensitiveMap
        Add-NamesToMap -Map $filterLookup -Names $normalizedProfileFilter
        $result = @($result | Where-Object { $filterLookup.ContainsKey($_.Name) })
    }

    return @($result | Sort-Object -Property Name)
}

function Write-ProfileList {
    param([object[]]$ProfileDefinitions)

    foreach ($profile in $ProfileDefinitions) {
        Write-Host "- $($profile.Name)"
        Write-Host "    Kind: $($profile.Kind)"
        Write-Host "    Official mods: $($profile.EnabledOfficialMods -join ', ')"
        Write-Host "    Enabled mods: $($profile.SeedModNames -join ', ')"
        if ($null -ne $profile.Notes -and @($profile.Notes).Count -gt 0) {
            Write-Host "    Notes: $($profile.Notes -join ' | ')"
        }
    }
}

function Invoke-LocaleValidation {
    param([string]$ResolvedModsRoot)

    $validatorPath = Join-Path -Path $PSScriptRoot -ChildPath 'validate-locales.ps1'
    if (-not (Test-Path -LiteralPath $validatorPath)) {
        throw "Locale validator not found at $validatorPath."
    }

    & $validatorPath -ModsRoot $ResolvedModsRoot
    if ($LASTEXITCODE -ne 0) {
        throw "Locale validation failed with exit code $LASTEXITCODE."
    }
}

function New-ProfileEnvironment {
    param(
        [pscustomobject]$Profile,
        [hashtable]$Catalog,
        [string]$ResolvedConfigTemplatePath,
        [string]$RunRoot
    )

    $profileRoot = Join-Path -Path $RunRoot -ChildPath $Profile.Name
    $modDirectory = Join-Path -Path $profileRoot -ChildPath 'mods'
    $writeDataDirectory = Join-Path -Path $profileRoot -ChildPath 'write-data'
    $configPath = Join-Path -Path $profileRoot -ChildPath 'config.ini'
    $modListPath = Join-Path -Path $modDirectory -ChildPath 'mod-list.json'

    New-Item -ItemType Directory -Path $profileRoot -Force | Out-Null
    New-Item -ItemType Directory -Path $modDirectory -Force | Out-Null
    New-Item -ItemType Directory -Path $writeDataDirectory -Force | Out-Null

    foreach ($modName in $Profile.SeedModNames) {
        $mod = $Catalog[$modName]
        $linkPath = Join-Path -Path $modDirectory -ChildPath $mod.FolderName
        if (-not (Test-Path -LiteralPath $linkPath)) {
            if ($mod.PackageType -eq 'zip') {
                Copy-Item -LiteralPath $mod.Path -Destination $linkPath -Force
            }
            else {
                New-Item -ItemType Junction -Path $linkPath -Target $mod.Path | Out-Null
            }
        }
    }

    $modEntries = New-Object System.Collections.ArrayList

    foreach ($officialName in $OfficialMods) {
        [void]$modEntries.Add([pscustomobject]@{
            name = $officialName
            enabled = ($Profile.EnabledOfficialMods -contains $officialName)
        })
    }

    foreach ($modName in ($Profile.SeedModNames | Sort-Object)) {
        [void]$modEntries.Add([pscustomobject]@{
            name = $modName
            enabled = $true
        })
    }

    $modList = [pscustomobject]@{ mods = @($modEntries) }
    $modList | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $modListPath -Encoding UTF8

    $configTemplate = Get-Content -LiteralPath $ResolvedConfigTemplatePath -Raw
    $escapedWriteData = $writeDataDirectory -replace '\\', '/'
    $configContent = [regex]::Replace($configTemplate, '(?m)^write-data=.*$', "write-data=$escapedWriteData")
    $configContent | Set-Content -LiteralPath $configPath -Encoding UTF8

    return [pscustomobject]@{
        ProfileRoot = $profileRoot
        ModDirectory = $modDirectory
        WriteDataDirectory = $writeDataDirectory
        ConfigPath = $configPath
        ModListPath = $modListPath
        LogPath = Join-Path -Path $writeDataDirectory -ChildPath 'factorio-current.log'
        PreviousLogPath = Join-Path -Path $writeDataDirectory -ChildPath 'factorio-previous.log'
        ScriptOutputPath = Join-Path -Path $writeDataDirectory -ChildPath 'script-output'
        StdoutPath = Join-Path -Path $profileRoot -ChildPath 'factorio.stdout.log'
        StderrPath = Join-Path -Path $profileRoot -ChildPath 'factorio.stderr.log'
    }
}

function Get-FirstLogError {
    param([string]$LogPath)

    if (-not (Test-Path -LiteralPath $LogPath)) {
        return $null
    }

    $errorMatch = Select-String -LiteralPath $LogPath -Pattern '(^|\s)(Error|Exception|Failed)\b' | Select-Object -First 1
    if ($null -eq $errorMatch) {
        return $null
    }

    return $errorMatch.Line.Trim()
}

function Get-WarningCount {
    param([string]$LogPath)

    if (-not (Test-Path -LiteralPath $LogPath)) {
        return 0
    }

    return @(Select-String -LiteralPath $LogPath -Pattern '^\s*[0-9\.]+\s+Warning\b').Count
}

function Test-LogHasSuccessMarkers {
    param([string]$LogPath)

    if (-not (Test-Path -LiteralPath $LogPath)) {
        return $false
    }

    $hasInitialised = @(Select-String -LiteralPath $LogPath -Pattern 'Factorio initialised').Count -gt 0
    $hasGoodbye = @(Select-String -LiteralPath $LogPath -Pattern 'Goodbye').Count -gt 0

    return $hasInitialised -and $hasGoodbye
}

function Remove-HeavyArtifacts {
    param([pscustomobject]$Environment)

    if (Test-Path -LiteralPath $Environment.ScriptOutputPath) {
        Remove-Item -LiteralPath $Environment.ScriptOutputPath -Recurse -Force
    }
}

function Invoke-FactorioProfile {
    param(
        [pscustomobject]$Profile,
        [pscustomobject]$Environment,
        [string]$ResolvedFactorioPath,
        [int]$ProfileTimeoutSeconds,
        [switch]$DisableDumpData,
        [switch]$PreserveArtifacts
    )

    $notes = @($Profile.Notes)
    $missingRequirementNote = $notes | Where-Object { $_ -like 'missing required mods:*' } | Select-Object -First 1
    if ($missingRequirementNote) {
        return [pscustomobject]@{
            Name = $Profile.Name
            Kind = $Profile.Kind
            Status = 'Skipped'
            ExitCode = $null
            DurationSeconds = 0
            OfficialMods = @($Profile.EnabledOfficialMods)
            EnabledMods = @($Profile.SeedModNames)
            WarningCount = 0
            Summary = $missingRequirementNote
            LogPath = $null
            ProfileRoot = $Environment.ProfileRoot
            StdoutPath = $Environment.StdoutPath
            StderrPath = $Environment.StderrPath
        }
    }

    $arguments = @(
        '--config', $Environment.ConfigPath,
        '--mod-directory', $Environment.ModDirectory,
        '--check-unused-prototype-data'
    )

    if (-not $DisableDumpData) {
        $arguments += '--dump-data'
    }

    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $process = Start-Process -FilePath $ResolvedFactorioPath -ArgumentList $arguments -PassThru -WindowStyle Hidden -RedirectStandardOutput $Environment.StdoutPath -RedirectStandardError $Environment.StderrPath
    $timedOut = $false

    if (-not $process.WaitForExit($ProfileTimeoutSeconds * 1000)) {
        $timedOut = $true
        try {
            $process.Kill()
        }
        catch {
        }
    }
    else {
        $process.WaitForExit()
        $process.Refresh()
    }

    $stopwatch.Stop()

    $logPath = if (Test-Path -LiteralPath $Environment.LogPath) { $Environment.LogPath } elseif (Test-Path -LiteralPath $Environment.PreviousLogPath) { $Environment.PreviousLogPath } else { $null }
    $warningCount = if ($logPath) { Get-WarningCount -LogPath $logPath } else { 0 }
    $logError = if ($logPath) { Get-FirstLogError -LogPath $logPath } else { 'log file not found' }
    $logHasSuccessMarkers = if ($logPath) { Test-LogHasSuccessMarkers -LogPath $logPath } else { $false }

    if (-not $PreserveArtifacts) {
        Remove-HeavyArtifacts -Environment $Environment
    }

    if ($timedOut) {
        return [pscustomobject]@{
            Name = $Profile.Name
            Kind = $Profile.Kind
            Status = 'Timeout'
            ExitCode = $null
            DurationSeconds = [Math]::Round($stopwatch.Elapsed.TotalSeconds, 2)
            OfficialMods = @($Profile.EnabledOfficialMods)
            EnabledMods = @($Profile.SeedModNames)
            WarningCount = $warningCount
            Summary = 'Factorio did not exit before the timeout.'
            LogPath = $logPath
            ProfileRoot = $Environment.ProfileRoot
            StdoutPath = $Environment.StdoutPath
            StderrPath = $Environment.StderrPath
        }
    }

    $exitCode = $process.ExitCode
    $status = 'Passed'
    $summary = 'Factorio finished successfully.'

    if ($null -ne $exitCode -and $exitCode -ne 0) {
        $status = 'Failed'
        $summary = if ($logError) { $logError } else { "Factorio exited with code $exitCode." }
    }
    elseif ($logError) {
        $status = 'Failed'
        $summary = $logError
    }
    elseif (-not $logHasSuccessMarkers) {
        $status = 'Failed'
        $summary = 'Factorio finished without success markers in the log.'
    }

    return [pscustomobject]@{
        Name = $Profile.Name
        Kind = $Profile.Kind
        Status = $status
        ExitCode = $exitCode
        DurationSeconds = [Math]::Round($stopwatch.Elapsed.TotalSeconds, 2)
        OfficialMods = @($Profile.EnabledOfficialMods)
        EnabledMods = @($Profile.SeedModNames)
        WarningCount = $warningCount
        Summary = $summary
        LogPath = $logPath
        ProfileRoot = $Environment.ProfileRoot
        StdoutPath = $Environment.StdoutPath
        StderrPath = $Environment.StderrPath
    }
}

function Write-ResultTable {
    param([object[]]$Results)

    $Results |
        Sort-Object -Property Name |
        Select-Object Name, Kind, Status, ExitCode, DurationSeconds, WarningCount, Summary |
        Format-Table -AutoSize |
        Out-String |
        Write-Host
}

function New-RunReportText {
    param(
        [object[]]$Results,
        [string]$RunRoot
    )

    $resultList = @($Results)
    $totalCount = $resultList.Count
    $passed = @($resultList | Where-Object { $_.Status -eq 'Passed' })
    $failed = @($resultList | Where-Object { $_.Status -eq 'Failed' })
    $skipped = @($resultList | Where-Object { $_.Status -eq 'Skipped' })
    $timeouts = @($resultList | Where-Object { $_.Status -eq 'Timeout' })
    $totalWarnings = ($resultList | Measure-Object -Property WarningCount -Sum).Sum
    if ($null -eq $totalWarnings) {
        $totalWarnings = 0
    }

    $totalDuration = [Math]::Round((($resultList | Measure-Object -Property DurationSeconds -Sum).Sum), 2)
    if ($null -eq $totalDuration) {
        $totalDuration = 0
    }

    $lines = New-Object System.Collections.ArrayList
    [void]$lines.Add('Informe breve de tests')
    [void]$lines.Add("- Perfiles ejecutados: $totalCount")
    [void]$lines.Add("- Pasados: $($passed.Count)")
    [void]$lines.Add("- Fallidos: $($failed.Count)")
    [void]$lines.Add("- Omitidos: $($skipped.Count)")
    [void]$lines.Add("- Timeout: $($timeouts.Count)")
    [void]$lines.Add("- Warnings totales: $totalWarnings")
    [void]$lines.Add("- Tiempo acumulado: $totalDuration s")
    [void]$lines.Add("- Artefactos: $RunRoot")

    if ($failed.Count -gt 0) {
        [void]$lines.Add('')
        [void]$lines.Add('Fallos detectados:')
        foreach ($result in ($failed | Sort-Object -Property Name)) {
            [void]$lines.Add("- $($result.Name): $($result.Summary)")
        }
    }

    if ($timeouts.Count -gt 0) {
        [void]$lines.Add('')
        [void]$lines.Add('Perfiles con timeout:')
        foreach ($result in ($timeouts | Sort-Object -Property Name)) {
            [void]$lines.Add("- $($result.Name): $($result.Summary)")
        }
    }

    if ($skipped.Count -gt 0) {
        [void]$lines.Add('')
        [void]$lines.Add('Perfiles omitidos:')
        foreach ($result in ($skipped | Sort-Object -Property Name)) {
            [void]$lines.Add("- $($result.Name): $($result.Summary)")
        }
    }

    if ($passed.Count -gt 0) {
        [void]$lines.Add('')
        [void]$lines.Add('Perfiles pasados:')
        foreach ($result in ($passed | Sort-Object -Property Name)) {
            [void]$lines.Add("- $($result.Name): $($result.DurationSeconds) s, warnings=$($result.WarningCount)")
        }
    }

    return ($lines -join [Environment]::NewLine)
}

if ([string]::IsNullOrWhiteSpace($WorkspaceRoot)) {
    $WorkspaceRoot = Resolve-DefaultWorkspaceRoot
}

if ([string]::IsNullOrWhiteSpace($ModsRoot)) {
    $ModsRoot = Resolve-DefaultModsRoot
}

$WorkspaceRoot = (Resolve-Path -LiteralPath $WorkspaceRoot).Path
$ModsRoot = (Resolve-Path -LiteralPath $ModsRoot).Path

$catalog = Get-AvailableModCatalog -ResolvedModsRoot $ModsRoot
$profileDefinitions = Get-ProfileDefinitions -RequestedTestSet $TestSet -Catalog $catalog -ProfileFilter $Profiles

if ($null -eq $profileDefinitions -or @($profileDefinitions).Count -eq 0) {
    throw 'No profiles matched the requested filters.'
}

if ($ListProfiles -or $DryRun) {
    Write-ProfileList -ProfileDefinitions $profileDefinitions
    return
}

if ([string]::IsNullOrWhiteSpace($ConfigTemplatePath)) {
    $ConfigTemplatePath = Resolve-DefaultConfigTemplate -ResolvedWorkspaceRoot $WorkspaceRoot
}

$ConfigTemplatePath = (Resolve-Path -LiteralPath $ConfigTemplatePath).Path
$FactorioPath = Resolve-FactorioPath -ExplicitPath $FactorioPath -ResolvedWorkspaceRoot $WorkspaceRoot

if (-not (Test-Path -LiteralPath $FactorioPath)) {
    throw "Factorio executable not found: $FactorioPath"
}

New-Item -ItemType Directory -Path $OutputRoot -Force | Out-Null
$OutputRoot = (Resolve-Path -LiteralPath $OutputRoot).Path

if ($RunLocaleValidation) {
    Invoke-LocaleValidation -ResolvedModsRoot $ModsRoot
}

$runStamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$runRoot = Join-Path -Path $OutputRoot -ChildPath ("run-$runStamp")
New-Item -ItemType Directory -Path $runRoot -Force | Out-Null

$results = New-Object System.Collections.ArrayList

foreach ($profile in $profileDefinitions) {
    Write-Host "Running $($profile.Name)..."
    $environment = New-ProfileEnvironment -Profile $profile -Catalog $catalog -ResolvedConfigTemplatePath $ConfigTemplatePath -RunRoot $runRoot
    $result = Invoke-FactorioProfile -Profile $profile -Environment $environment -ResolvedFactorioPath $FactorioPath -ProfileTimeoutSeconds $TimeoutSeconds -DisableDumpData:$NoDumpData -PreserveArtifacts:$KeepArtifacts
    [void]$results.Add($result)

    Write-Host ("  -> {0} ({1}s)" -f $result.Status, $result.DurationSeconds)

    if ($StopOnFailure -and $result.Status -in @('Failed', 'Timeout')) {
        break
    }
}

$summaryPath = Join-Path -Path $runRoot -ChildPath 'summary.json'
@($results) | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $summaryPath -Encoding UTF8
$reportPath = Join-Path -Path $runRoot -ChildPath 'report.txt'
$reportText = New-RunReportText -Results @($results) -RunRoot $runRoot
$reportText | Set-Content -LiteralPath $reportPath -Encoding UTF8

Write-Host ''
Write-Host "Summary written to: $summaryPath"
Write-Host "Report written to: $reportPath"
Write-ResultTable -Results @($results)
Write-Host $reportText

$failedCount = @($results | Where-Object { $_.Status -eq 'Failed' }).Count
$timeoutCount = @($results | Where-Object { $_.Status -eq 'Timeout' }).Count

if ($timeoutCount -gt 0) {
    exit 2
}

if ($failedCount -gt 0) {
    exit 1
}

exit 0