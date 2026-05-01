<#
.SYNOPSIS
    Validates 5Dim mod locale coverage.

.DESCRIPTION
    For each 5dim_* mod (excluding the configurable list), scans prototype
    files for prototype name = "..." declarations and the corresponding
    locale section in locale/en/*.cfg. Reports:
      - Missing locale keys (prototype defined but no .cfg entry).
      - Inline localised_name / localised_description usage in .lua (anti-pattern).

    Read-only: never modifies files. Returns non-zero exit code if any
    CRITICAL issue (inline localised_*) is found.

.PARAMETER ModsRoot
    Path to mods/ directory. Defaults to script location.

.PARAMETER ExcludeMods
    Mod folder names to skip.

.EXAMPLE
    .\validate-locales.ps1
    .\validate-locales.ps1 -ExcludeMods @('5dim_decoration','5dim_dev','5dim_locale','5dim_compatibility')
#>

[CmdletBinding()]
param(
    [string]$ModsRoot = $PSScriptRoot,
    [string[]]$ExcludeMods = @('5dim_decoration', '5dim_dev', '5dim_locale')
)

$ErrorActionPreference = 'Stop'

# Map prototype types (subset relevant to 5Dim) to locale section names.
$TypeToSection = @{
    'item'                          = 'item-name'
    'item-with-entity-data'         = 'item-name'
    'capsule'                       = 'item-name'
    'ammo'                          = 'item-name'
    'armor'                         = 'item-name'
    'gun'                           = 'item-name'
    'tool'                          = 'item-name'
    'module'                        = 'item-name'
    'rail-planner'                  = 'item-name'
    'repair-tool'                   = 'item-name'
    'spidertron-remote'             = 'item-name'
    'recipe'                        = 'recipe-name'
    'technology'                    = 'technology-name'
    'fluid'                         = 'fluid-name'
    'equipment-grid'                = 'equipment-grid-name'
    'battery-equipment'             = 'equipment-name'
    'energy-shield-equipment'       = 'equipment-name'
    'movement-bonus-equipment'      = 'equipment-name'
    'generator-equipment'           = 'equipment-name'
    'solar-panel-equipment'         = 'equipment-name'
    'roboport-equipment'            = 'equipment-name'
    'belt-immunity-equipment'       = 'equipment-name'
    'night-vision-equipment'        = 'equipment-name'
    'active-defense-equipment'      = 'equipment-name'
    'inventory-bonus-equipment'     = 'equipment-name'
    'ammo-category'                 = 'ammo-category-name'
}
$EntityTypes = @(
    'container','logistic-container','storage-tank','transport-belt','underground-belt',
    'splitter','loader','loader-1x1','inserter','pipe','pipe-to-ground','pump',
    'electric-pole','small-electric-pole','medium-electric-pole','big-electric-pole',
    'substation','accumulator','solar-panel','boiler','generator','reactor',
    'heat-pipe','heat-interface','lab','assembling-machine','furnace','rocket-silo',
    'mining-drill','offshore-pump','beacon','radar','lamp','wall','gate','turret',
    'ammo-turret','electric-turret','fluid-turret','car','tank','spider-vehicle',
    'locomotive','cargo-wagon','fluid-wagon','artillery-wagon','roboport',
    'logistic-robot','construction-robot','combat-robot','rail','straight-rail',
    'curved-rail','train-stop','rail-signal','rail-chained-signal',
    'unit','unit-spawner','spitter','biter','worm-turret','simple-entity',
    'simple-entity-with-owner','programmable-speaker','arithmetic-combinator',
    'decider-combinator','constant-combinator','power-switch','market',
    'agricultural-tower','asteroid-collector','cargo-bay','cargo-landing-pad',
    'crusher','fusion-generator','fusion-reactor','lightning-attractor',
    'thruster','space-platform-hub','captive-biter-spawner'
)
foreach ($t in $EntityTypes) { $TypeToSection[$t] = 'entity-name' }

$ProtoRegex   = [regex]'type\s*=\s*"([a-zA-Z0-9\-_]+)"\s*,\s*name\s*=\s*"([a-zA-Z0-9\-_]+)"'
$SectionRegex = [regex]'^\s*\[([^\]]+)\]\s*$'
$KeyRegex     = [regex]'^\s*([^=;\s][^=]*?)\s*='

function Get-CfgKeysBySection {
    param([string]$Path)
    $bySection = @{}
    if (-not (Test-Path -LiteralPath $Path)) { return $bySection }
    $current = $null
    foreach ($line in [System.IO.File]::ReadAllLines($Path)) {
        $m = $SectionRegex.Match($line)
        if ($m.Success) {
            $current = $m.Groups[1].Value
            if (-not $bySection.ContainsKey($current)) { $bySection[$current] = @{} }
            continue
        }
        if (-not $current) { continue }
        $trim = $line.TrimStart()
        if ($trim.Length -eq 0 -or $trim.StartsWith(';')) { continue }
        $km = $KeyRegex.Match($line)
        if ($km.Success) {
            $bySection[$current][$km.Groups[1].Value.Trim()] = $true
        }
    }
    return $bySection
}

function Get-LuaFiles {
    param([string]$ModPath)
    return Get-ChildItem -LiteralPath $ModPath -Recurse -File -Filter '*.lua' -ErrorAction SilentlyContinue |
        Where-Object {
            $_.FullName -notmatch '\\locale\\' -and
            $_.FullName -notmatch '\\graphics\\' -and
            $_.FullName -notmatch '\\sound\\' -and
            $_.FullName -notmatch '\\migrations\\'
        }
}

# --- Main ---
$mods = Get-ChildItem -LiteralPath $ModsRoot -Directory |
    Where-Object { $_.Name -like '5dim_*' -and $_.Name -notin $ExcludeMods } |
    Sort-Object Name

# Pre-load aggregated locale pool from 5dim_locale (translations may live there).
$aggregateKeys = @{}
$aggregateDir  = Join-Path $ModsRoot '5dim_locale\locale\en'
if (Test-Path -LiteralPath $aggregateDir) {
    foreach ($cfg in Get-ChildItem -LiteralPath $aggregateDir -File -Filter *.cfg) {
        $sec = Get-CfgKeysBySection -Path $cfg.FullName
        foreach ($s in $sec.Keys) {
            if (-not $aggregateKeys.ContainsKey($s)) { $aggregateKeys[$s] = @{} }
            foreach ($k in $sec[$s].Keys) { $aggregateKeys[$s][$k] = $true }
        }
    }
}

$totalCritical = 0
$totalMissing  = 0

foreach ($mod in $mods) {
    Write-Host ""
    Write-Host "=== $($mod.Name) ==="

    $luaFiles = Get-LuaFiles -ModPath $mod.FullName

    # --- Inline localised_* (single Select-String pass over all files) ---
    # Skip lines like `localised_name = nil` (legitimate reset to force locale lookup).
    $inline = @($luaFiles | Select-String -Pattern 'localised_(name|description)\s*=(?!\s*nil\b)')
    if ($inline.Count -gt 0) {
        Write-Host "  [CRITICAL] Inline localised_* usage ($($inline.Count)):"
        foreach ($h in $inline) {
            $rel = $h.Path.Substring($ModsRoot.Length).TrimStart('\','/')
            Write-Host "    - $($rel):$($h.LineNumber)  $($h.Line.Trim())"
        }
        $totalCritical += $inline.Count
    }

    # --- Locale coverage ---
    $localeDir = Join-Path $mod.FullName 'locale\en'
    $hasOwnLocale = Test-Path -LiteralPath $localeDir

    $keys = @{}
    if ($hasOwnLocale) {
        foreach ($cfg in Get-ChildItem -LiteralPath $localeDir -File -Filter *.cfg) {
            $sec = Get-CfgKeysBySection -Path $cfg.FullName
            foreach ($s in $sec.Keys) {
                if (-not $keys.ContainsKey($s)) { $keys[$s] = @{} }
                foreach ($k in $sec[$s].Keys) { $keys[$s][$k] = $true }
            }
        }
    }
    # Merge aggregate pool from 5dim_locale.
    foreach ($s in $aggregateKeys.Keys) {
        if (-not $keys.ContainsKey($s)) { $keys[$s] = @{} }
        foreach ($k in $aggregateKeys[$s].Keys) { $keys[$s][$k] = $true }
    }

    # Prototype declarations: read each lua raw and run regex.
    # Filter out matches that look like recipe ingredients (next ~80 chars contain `amount`,
    # `probability` or recipe markers `count =`).
    $missing  = New-Object System.Collections.Generic.List[string]
    $scanned  = 0
    foreach ($f in $luaFiles) {
        $content = [System.IO.File]::ReadAllText($f.FullName)
        foreach ($m in $ProtoRegex.Matches($content)) {
            $type = $m.Groups[1].Value
            $name = $m.Groups[2].Value
            $section = $TypeToSection[$type]
            if (-not $section) { continue }
            # Skip names that look like concatenation prefixes (e.g. "5d-tank-" .. tier).
            if ($name.EndsWith('-')) { continue }
            # Heuristic: ingredient/result entries usually have `amount =` or `probability =` within ~120 chars.
            $tail = $content.Substring($m.Index + $m.Length, [Math]::Min(120, $content.Length - $m.Index - $m.Length))
            if ($tail -match '\b(amount|probability|catalyst_amount|amount_min|amount_max)\s*=') { continue }
            $scanned++
            if (-not $keys.ContainsKey($section) -or -not $keys[$section].ContainsKey($name)) {
                $missing.Add("    [MISSING] [$section] $name  (type=$type)") | Out-Null
            }
        }
    }
    if ($missing.Count -gt 0) {
        Write-Host "  Missing locale keys: $($missing.Count) (of $scanned tracked prototypes)"
        $missing | Select-Object -First 25 | ForEach-Object { Write-Host $_ }
        if ($missing.Count -gt 25) { Write-Host "    ... ($($missing.Count - 25) more)" }
        $totalMissing += $missing.Count
    } else {
        Write-Host "  Locale coverage OK ($scanned tracked prototypes)."
    }
}

Write-Host ""
Write-Host "--- Summary ---"
Write-Host "CRITICAL inline localised_*: $totalCritical"
Write-Host "Missing locale keys:        $totalMissing"

if ($totalCritical -gt 0) { exit 1 } else { exit 0 }
