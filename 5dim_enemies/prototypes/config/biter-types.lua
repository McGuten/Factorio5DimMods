-- =============================================================================
-- 5dim_enemies - Biter Types Configuration
-- =============================================================================
-- This file provides biter type definitions by reading from shared-config.lua
-- ALL DATA COMES FROM shared-config.lua - THIS IS NOT A DATA SOURCE!
-- =============================================================================

local SharedConfig = require("shared-config")

local BiterTypes = {}

-- =============================================================================
-- BUILD TYPES FROM SHARED CONFIG (SINGLE SOURCE OF TRUTH)
-- =============================================================================
-- This generates the types table from SharedConfig.TypeDefinitions
-- Only includes types that have biter support (biter_resistances defined)
-- =============================================================================

BiterTypes.types = {}

for typeName, typeDef in pairs(SharedConfig.TypeDefinitions) do
    -- Only include types that support biters
    local supportsBiter = false
    local categories = SharedConfig.TypeCategories[typeName] or {}
    for _, cat in ipairs(categories) do
        if cat == "biter" then
            supportsBiter = true
            break
        end
    end
    
    if supportsBiter then
        -- Check mod requirement at load time
        local modOk = true
        if typeDef.requires_mod then
            modOk = mods and mods[typeDef.requires_mod]
        end
        
        if modOk then
            BiterTypes.types[typeName] = {
                -- Basic info
                name = typeName,
                order = typeDef.order or "z",
                is_vanilla_override = typeDef.is_vanilla_override or false,
                
                -- Setting requirement (from shared config)
                requires_setting = typeDef.requires_setting_biter,
                requires_mod = typeDef.requires_mod,
                
                -- Damage type
                damage_type = typeDef.damage_type or "physical",
                
                -- Visual (from shared config)
                colors = typeDef.colors,
                spawner_tint = typeDef.spawner_tint,
                
                -- Resistances (from shared config - biter specific)
                resistances = typeDef.biter_resistances,
                
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

-- Check if a biter type is enabled
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
    return true  -- No setting required = always enabled
end

-- Get all enabled biter types as an ordered array
function BiterTypes.getAll()
    local result = {}
    for _, typeData in pairs(BiterTypes.types) do
        if isTypeEnabled(typeData) then
            table.insert(result, typeData)
        end
    end
    -- Sort by order
    table.sort(result, function(a, b) return a.order < b.order end)
    return result
end

-- Get a specific biter type by name
function BiterTypes.get(name)
    local typeData = BiterTypes.types[name]
    if typeData and isTypeEnabled(typeData) then
        return typeData
    end
    return nil
end

-- Get all non-vanilla biter types (for creating new entities)
function BiterTypes.getNew()
    local result = {}
    for _, typeData in pairs(BiterTypes.types) do
        if not typeData.is_vanilla_override and isTypeEnabled(typeData) then
            table.insert(result, typeData)
        end
    end
    table.sort(result, function(a, b) return a.order < b.order end)
    return result
end

-- Get vanilla override types (for modifying existing entities)
function BiterTypes.getVanillaOverrides()
    local result = {}
    for _, typeData in pairs(BiterTypes.types) do
        if typeData.is_vanilla_override and isTypeEnabled(typeData) then
            table.insert(result, typeData)
        end
    end
    table.sort(result, function(a, b) return a.order < b.order end)
    return result
end

return BiterTypes
