-- =============================================================================
-- 5dim_enemies - Worm Type Definitions
-- =============================================================================
-- This file provides worm type definitions by reading from shared-config.lua
-- ALL DATA COMES FROM shared-config.lua - THIS IS NOT A DATA SOURCE!
-- =============================================================================

local SharedConfig = require("shared-config")

local WormTypes = {}

-- =============================================================================
-- BUILD TYPES FROM SHARED CONFIG (SINGLE SOURCE OF TRUTH)
-- =============================================================================
-- This generates worm types from SharedConfig.TypeDefinitions
-- Only includes types that have worm support (worm_resistances defined)
-- =============================================================================

for typeName, typeDef in pairs(SharedConfig.TypeDefinitions) do
    -- Only include types that support worms
    local supportsWorm = false
    local categories = SharedConfig.TypeCategories[typeName] or {}
    for _, cat in ipairs(categories) do
        if cat == "worm" then
            supportsWorm = true
            break
        end
    end
    
    if supportsWorm then
        -- Check mod requirement at load time
        local modOk = true
        if typeDef.requires_mod then
            modOk = mods and mods[typeDef.requires_mod]
        end
        
        if modOk then
            -- Determine stream type based on attack_type
            local streamType = typeDef.attack_type or "acid"
            
            WormTypes[typeName] = {
                enabled = true,
                
                -- Setting requirement (from shared config)
                requires_setting = typeDef.requires_setting_worm,
                requires_mod = typeDef.requires_mod,
                
                -- Naming
                name_prefix = "5d-" .. typeName,
                display_name = (typeDef.display_name or typeName) .. " Worm",
                
                -- Attack
                damage_type = typeDef.damage_type or "acid",
                stream_type = streamType,
                
                -- Visual (from shared config)
                tint = {
                    typeDef.colors.primary.r,
                    typeDef.colors.primary.g,
                    typeDef.colors.primary.b,
                    0.8
                },
                stream_tint = {
                    typeDef.colors.secondary.r,
                    typeDef.colors.secondary.g,
                    typeDef.colors.secondary.b,
                    0.8
                },
                splash_tint = {
                    typeDef.colors.primary.r * 0.5,
                    typeDef.colors.primary.g * 0.5,
                    typeDef.colors.primary.b * 0.5,
                    0.4
                },
                
                -- Resistances (from shared config - worm specific)
                resistances = typeDef.worm_resistances or {},
                
                -- Multipliers (from shared config, with worm-specific overrides)
                damage_multiplier = typeDef.worm_damage_multiplier or typeDef.damage or 1.0,
                health_multiplier = typeDef.worm_health_multiplier or typeDef.health or 1.0,
                
                -- Special flags
                lingering_damage = typeDef.lingering_damage
            }
        end
    end
end

-- =============================================================================
-- HELPER FUNCTIONS
-- =============================================================================

-- Check if a worm type is enabled
local function isTypeEnabled(typeData)
    if not typeData.enabled then return false end
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
    return true  -- No setting = always enabled (vanilla override/normal)
end

-- Get all enabled worm types
function WormTypes.getEnabledTypes()
    local enabled = {}
    for typeName, typeData in pairs(WormTypes) do
        if type(typeData) == "table" and typeData.enabled then
            if isTypeEnabled(typeData) then
                enabled[typeName] = typeData
            end
        end
    end
    return enabled
end

-- Get a specific worm type
function WormTypes.getType(typeName)
    local typeData = WormTypes[typeName]
    if typeData and type(typeData) == "table" and typeData.enabled then
        if isTypeEnabled(typeData) then
            return typeData
        end
    end
    return nil
end

return WormTypes
