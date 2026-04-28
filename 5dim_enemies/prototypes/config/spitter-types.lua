-- =============================================================================
-- 5dim_enemies - Spitter Types Configuration
-- =============================================================================
-- This file provides spitter type definitions by reading from shared-config.lua
-- ALL DATA COMES FROM shared-config.lua - THIS IS NOT A DATA SOURCE!
-- =============================================================================

local SharedConfig = require("shared-config")

local SpitterTypes = {}

-- =============================================================================
-- BUILD TYPES FROM SHARED CONFIG (SINGLE SOURCE OF TRUTH)
-- =============================================================================
-- This generates the types table from SharedConfig.TypeDefinitions
-- Only includes types that have spitter support (spitter_resistances defined)
-- =============================================================================

SpitterTypes.types = {}

for typeName, typeDef in pairs(SharedConfig.TypeDefinitions) do
    -- Only include types that support spitters
    local supportsSpitter = false
    local categories = SharedConfig.TypeCategories[typeName] or {}
    for _, cat in ipairs(categories) do
        if cat == "spitter" then
            supportsSpitter = true
            break
        end
    end
    
    if supportsSpitter then
        -- Check mod requirement at load time
        local modOk = true
        if typeDef.requires_mod then
            modOk = mods and mods[typeDef.requires_mod]
        end
        
        if modOk then
            SpitterTypes.types[typeName] = {
                -- Basic info
                name = typeName,
                order = typeDef.order or "z",
                is_vanilla_override = typeDef.is_vanilla_override or false,
                
                -- Setting requirement (from shared config)
                requires_setting = typeDef.requires_setting_spitter,
                requires_mod = typeDef.requires_mod,
                
                -- Attack type
                attack_type = typeDef.attack_type or "acid",
                
                -- Visual (from shared config)
                colors = typeDef.colors,
                spawner_tint = typeDef.spawner_tint,
                
                -- Resistances (from shared config - spitter specific)
                resistances = typeDef.spitter_resistances,
                
                -- Multipliers (from shared config)
                health_multiplier = typeDef.health,
                damage_multiplier = typeDef.damage,
                speed_multiplier = typeDef.speed,
                healing_multiplier = typeDef.healing,
                scale_multiplier = typeDef.scale,
                
                -- Spawner config
                spawner_cooldown_multiplier = typeDef.spawner_cooldown,
                spawner_max_count_multiplier = typeDef.spawner_max_count,
                
                -- Special behavior
                special_behavior = typeDef.special_behavior
            }
        end
    end
end

-- =============================================================================
-- HELPER FUNCTIONS
-- =============================================================================

-- Check if a spitter type is enabled
local function isTypeEnabled(typeData)
    -- Check mod requirement first
    if typeData.requires_mod then
        if not (mods and mods[typeData.requires_mod]) then
            return false
        end
    end
    if typeData.requires_setting then
        return settings.startup[typeData.requires_setting] and 
               settings.startup[typeData.requires_setting].value
    end
    return true  -- No setting required = always enabled (vanilla override)
end

-- Get all enabled spitter types as an ordered array
function SpitterTypes.getAll()
    local result = {}
    for _, typeData in pairs(SpitterTypes.types) do
        if isTypeEnabled(typeData) then
            table.insert(result, typeData)
        end
    end
    -- Sort by order
    table.sort(result, function(a, b) return a.order < b.order end)
    return result
end

-- Get a specific spitter type by name
function SpitterTypes.get(name)
    local typeData = SpitterTypes.types[name]
    if typeData and isTypeEnabled(typeData) then
        return typeData
    end
    return nil
end

-- Get all non-vanilla spitter types (for creating new entities)
function SpitterTypes.getNew()
    local result = {}
    for _, typeData in pairs(SpitterTypes.types) do
        if not typeData.is_vanilla_override and isTypeEnabled(typeData) then
            table.insert(result, typeData)
        end
    end
    table.sort(result, function(a, b) return a.order < b.order end)
    return result
end

-- Get vanilla override types (for modifying existing entities)
function SpitterTypes.getVanillaOverrides()
    local result = {}
    for _, typeData in pairs(SpitterTypes.types) do
        if typeData.is_vanilla_override and isTypeEnabled(typeData) then
            table.insert(result, typeData)
        end
    end
    table.sort(result, function(a, b) return a.order < b.order end)
    return result
end

return SpitterTypes
