-- 5Dim's Development Tools Library
-- Utility functions for debugging and testing

local DevTools = {}

local function isSyntheticSpawner(name)
    return string.find(name, "^creative%-mod_enemy%-object_") ~= nil
end

-- Helper to format tables for logging
local function tableToString(tbl, indent)
    indent = indent or 0
    local result = {}
    local prefix = string.rep("  ", indent)
    
    if type(tbl) ~= "table" then
        return tostring(tbl)
    end
    
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            table.insert(result, prefix .. tostring(k) .. ": {")
            table.insert(result, tableToString(v, indent + 1))
            table.insert(result, prefix .. "}")
        else
            table.insert(result, prefix .. tostring(k) .. ": " .. tostring(v))
        end
    end
    
    return table.concat(result, "\n")
end

-- Report all unit-spawners in the game
function DevTools.reportSpawners()
    log("[5dim_dev] === SPAWNERS REPORT ===")
    
    if not data.raw["unit-spawner"] then
        log("[5dim_dev] No spawners found in data.raw")
        return
    end
    
    local spawnerCount = 0
    local syntheticSpawnerCount = 0
    local spawnersByMod = {}
    
    for name, spawner in pairs(data.raw["unit-spawner"]) do
        if isSyntheticSpawner(name) then
            syntheticSpawnerCount = syntheticSpawnerCount + 1
        else
            spawnerCount = spawnerCount + 1

            -- Determine which mod this spawner belongs to
            local modName = "unknown"
            if string.find(name, "^5d%-") then
                modName = "5dim_enemies"
            elseif string.find(name, "^biter%-spawner") or string.find(name, "^spitter%-spawner") then
                modName = "base"
            end

            spawnersByMod[modName] = spawnersByMod[modName] or {}
            table.insert(spawnersByMod[modName], {
                name = name,
                hasAutoplace = spawner.autoplace ~= nil,
                autoplaceOrder = spawner.autoplace and spawner.autoplace.order or "none",
                resultUnitsCount = spawner.result_units and #spawner.result_units or 0
            })
        end
    end
    
    log("[5dim_dev] Total gameplay spawners: " .. spawnerCount)
    log("[5dim_dev] Skipped synthetic debug spawners: " .. syntheticSpawnerCount)
    
    for modName, spawners in pairs(spawnersByMod) do
        log("[5dim_dev] --- " .. modName .. " (" .. #spawners .. " spawners) ---")
        for _, s in ipairs(spawners) do
            local autoplaceInfo = s.hasAutoplace and ("order=" .. s.autoplaceOrder) or "NO AUTOPLACE!"
            log("[5dim_dev]   " .. s.name .. " [" .. autoplaceInfo .. "] units=" .. s.resultUnitsCount)
        end
    end
end

-- Report all units (biters/spitters) in the game
function DevTools.reportUnits()
    log("[5dim_dev] === UNITS REPORT ===")
    
    if not data.raw["unit"] then
        log("[5dim_dev] No units found in data.raw")
        return
    end
    
    local unitCount = 0
    local unitsByType = {
        biters_5dim = {},
        spitters_5dim = {},
        biters_vanilla = {},
        spitters_vanilla = {},
        other = {}
    }
    
    for name, unit in pairs(data.raw["unit"]) do
        unitCount = unitCount + 1
        
        local category = "other"
        if string.find(name, "^5d%-.*%-biter") then
            category = "biters_5dim"
        elseif string.find(name, "^5d%-.*%-spitter") then
            category = "spitters_5dim"
        elseif string.find(name, "%-biter$") or string.find(name, "%-biter%-") then
            category = "biters_vanilla"
        elseif string.find(name, "%-spitter$") or string.find(name, "%-spitter%-") then
            category = "spitters_vanilla"
        end
        
        table.insert(unitsByType[category], name)
    end
    
    log("[5dim_dev] Total units: " .. unitCount)
    log("[5dim_dev] 5Dim Biters: " .. #unitsByType.biters_5dim)
    log("[5dim_dev] 5Dim Spitters: " .. #unitsByType.spitters_5dim)
    log("[5dim_dev] Vanilla Biters: " .. #unitsByType.biters_vanilla)
    log("[5dim_dev] Vanilla Spitters: " .. #unitsByType.spitters_vanilla)
    log("[5dim_dev] Other: " .. #unitsByType.other)
end

-- Report all damage types
function DevTools.reportDamageTypes()
    log("[5dim_dev] === DAMAGE TYPES REPORT ===")
    
    if not data.raw["damage-type"] then
        log("[5dim_dev] No damage types found in data.raw")
        return
    end
    
    local damageTypes = {}
    for name, _ in pairs(data.raw["damage-type"]) do
        table.insert(damageTypes, name)
    end
    
    table.sort(damageTypes)
    
    log("[5dim_dev] Available damage types (" .. #damageTypes .. "):")
    for _, name in ipairs(damageTypes) do
        log("[5dim_dev]   - " .. name)
    end
end

-- Report autoplace controls for enemies
function DevTools.reportAutoplaceControls()
    log("[5dim_dev] === AUTOPLACE CONTROLS REPORT ===")
    
    if not data.raw["autoplace-control"] then
        log("[5dim_dev] No autoplace controls found")
        return
    end
    
    local enemyControls = {}
    for name, control in pairs(data.raw["autoplace-control"]) do
        if control.category == "enemy" then
            table.insert(enemyControls, name)
        end
    end
    
    table.sort(enemyControls)
    
    log("[5dim_dev] Enemy autoplace controls (" .. #enemyControls .. "):")
    for _, name in ipairs(enemyControls) do
        log("[5dim_dev]   - " .. name)
    end
end

-- Report what units each spawner can spawn
function DevTools.reportSpawnerUnits()
    log("[5dim_dev] === SPAWNER -> UNITS MAPPING ===")
    
    if not data.raw["unit-spawner"] then
        log("[5dim_dev] No spawners found")
        return
    end
    
    -- Only report 5dim spawners to keep log readable
    for name, spawner in pairs(data.raw["unit-spawner"]) do
        if string.find(name, "^5d%-") then
            log("[5dim_dev] " .. name .. ":")
            if spawner.result_units then
                for _, result in ipairs(spawner.result_units) do
                    local unitName = result[1]
                    local spawnPoints = result[2]
                    local spawnInfo = {}
                    if type(spawnPoints) == "table" then
                        for _, point in ipairs(spawnPoints) do
                            table.insert(spawnInfo, string.format("%.2f@%.1f", point[2] or point.weight or 0, point[1] or point.evolution_factor or 0))
                        end
                    end
                    log("[5dim_dev]   -> " .. unitName .. " [" .. table.concat(spawnInfo, ", ") .. "]")
                end
            else
                log("[5dim_dev]   (no result_units defined!)")
            end
        end
    end
end

-- Report enemy statistics summary
function DevTools.reportEnemySummary()
    log("[5dim_dev] === ENEMY SUMMARY ===")
    
    local stats = {
        spawners = { total = 0, with_autoplace = 0, without_autoplace = 0 },
        units = { total = 0, biters = 0, spitters = 0 },
        worms = { total = 0 },
        synthetic_spawners = 0
    }
    
    -- Count spawners
    if data.raw["unit-spawner"] then
        for name, spawner in pairs(data.raw["unit-spawner"]) do
            if isSyntheticSpawner(name) then
                stats.synthetic_spawners = stats.synthetic_spawners + 1
            else
                stats.spawners.total = stats.spawners.total + 1
                if spawner.autoplace then
                    stats.spawners.with_autoplace = stats.spawners.with_autoplace + 1
                else
                    stats.spawners.without_autoplace = stats.spawners.without_autoplace + 1
                    log("[5dim_dev] WARNING: Spawner without autoplace: " .. name)
                end
            end
        end
    end
    
    -- Count units
    if data.raw["unit"] then
        for name, _ in pairs(data.raw["unit"]) do
            stats.units.total = stats.units.total + 1
            if string.find(name, "biter") then
                stats.units.biters = stats.units.biters + 1
            elseif string.find(name, "spitter") then
                stats.units.spitters = stats.units.spitters + 1
            end
        end
    end
    
    -- Count worms (turrets with specific names)
    if data.raw["turret"] then
        for name, _ in pairs(data.raw["turret"]) do
            if string.find(name, "worm") then
                stats.worms.total = stats.worms.total + 1
            end
        end
    end
    
    log("[5dim_dev] Spawners: " .. stats.spawners.total .. " total (" .. stats.spawners.with_autoplace .. " with autoplace, " .. stats.spawners.without_autoplace .. " without)")
    log("[5dim_dev] Synthetic debug spawners skipped: " .. stats.synthetic_spawners)
    log("[5dim_dev] Units: " .. stats.units.total .. " total (" .. stats.units.biters .. " biters, " .. stats.units.spitters .. " spitters)")
    log("[5dim_dev] Worms: " .. stats.worms.total .. " total")
    
    -- Calculate expected 5dim enemies
    local expected5dimBiters = 4 * 10 * 2  -- 4 types * 10 tiers * 2 (normal + behemoth)
    local expected5dimSpitters = 8 * 10 * 2  -- 8 types * 10 tiers * 2
    local expected5dimBiterSpawners = 4
    local expected5dimSpitterSpawners = 8
    
    log("[5dim_dev] Expected 5dim biters: " .. expected5dimBiters)
    log("[5dim_dev] Expected 5dim spitters: " .. expected5dimSpitters)
    log("[5dim_dev] Expected 5dim biter spawners: " .. expected5dimBiterSpawners)
    log("[5dim_dev] Expected 5dim spitter spawners: " .. expected5dimSpitterSpawners)
end

return DevTools
