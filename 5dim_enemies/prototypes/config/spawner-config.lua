-- =============================================================================
-- 5dim_enemies - Spawner Configuration
-- =============================================================================
-- This file defines spawner behavior, evolution curves, and autoplace.
-- ALL type data comes from shared-config.lua (SINGLE SOURCE OF TRUTH)
-- =============================================================================

local SharedConfig = require("shared-config")
local Tiers = require("prototypes.config.tiers")
local SpawnerConfig = {}

-- =============================================================================
-- EVOLUTION CURVES
-- =============================================================================
-- Each tier has a spawn probability curve based on evolution factor.
-- Format: {{evolution, probability}, {evolution, probability}, ...}
-- 
-- The curve defines when enemies start appearing, peak, and decline.
-- =============================================================================

-- Generate evolution curve for a specific tier
-- Parameters:
--   tier: The tier number (1-10, or 11 for boss)
--   tierData: The tier configuration from tiers.lua
--   isBoss: If true, this is the boss variant (tier 11)
function SpawnerConfig.generateEvolutionCurve(tier, tierData, isBoss)
    if isBoss then
        -- Boss enemies only appear at very high evolution
        return {
            {0.98, 0.0},
            {1.0, 0.1}  -- Low spawn rate even at max evolution
        }
    end
    
    local evolution_start = tierData.evolution
    local evolution_peak = evolution_start + 0.10
    local evolution_end = evolution_start + 0.30
    
    -- T10 stays relevant at max evolution
    if tier == Tiers.COUNT then
        return {
            {evolution_start, 0.0},
            {math.min(0.98, evolution_start + 0.02), 0.3},
            {1.0, 0.4}
        }
    end
    
    -- T9 also stays but fades slightly
    if tier == 9 then
        return {
            {evolution_start, 0.0},
            {evolution_start + 0.05, 0.3},
            {1.0, 0.2}
        }
    end
    
    -- T8 fades at max evolution
    if tier == 8 then
        return {
            {evolution_start, 0.0},
            {evolution_start + 0.10, 0.3},
            {1.0, 0.1}
        }
    end
    
    -- Regular tiers (1-7) fade out completely
    -- Ensure evolution_end doesn't exceed 1.0 and is strictly ascending
    if evolution_end > 1.0 then
        evolution_end = 1.0
    end
    if evolution_peak >= evolution_end then
        evolution_peak = evolution_start + (evolution_end - evolution_start) * 0.4
    end
    
    -- Make sure all values are strictly ascending
    if evolution_peak <= evolution_start then
        evolution_peak = evolution_start + 0.05
    end
    if evolution_end <= evolution_peak then
        evolution_end = evolution_peak + 0.05
    end
    
    return {
        {evolution_start, 0.0},
        {evolution_peak, 0.3},
        {evolution_end, 0.0}  -- Goes to 0% - disappears completely
    }
end

-- =============================================================================
-- SPAWNER RESULT UNITS GENERATOR
-- =============================================================================
-- Generates the result_units table for a spawner based on enemy type
-- =============================================================================

-- Generate result_units for a biter spawner
-- Parameters:
--   typeName: The biter type name (e.g., "laser", "physical")
--   isVanillaOverride: If true, uses vanilla naming convention
--   includeBoss: If true, includes boss variant (tier 11)
function SpawnerConfig.generateBiterSpawnerUnits(typeName, isVanillaOverride, includeBoss)
    local result = {}
    
    -- If this type has evolution_min > 0, add normal biter T1 as filler
    local fillerCurve = Tiers.getNormalFillerCurve(typeName, "biter")
    if fillerCurve and typeName ~= "normal" then
        table.insert(result, {"5d-normal-biter-t1", fillerCurve})
    end
    
    for tier = 1, Tiers.COUNT do
        local unitName = string.format("5d-%s-biter-t%d", typeName, tier)
        local curve = Tiers.getSpawnCurve(typeName, tier, "biter")
        table.insert(result, {unitName, curve})
    end
    
    -- Add boss if enabled
    if includeBoss and settings.startup["5d-boss"] and settings.startup["5d-boss"].value then
        local bossName = string.format("5d-%s-biter-boss", typeName)
        local bossCurve = Tiers.getSpawnCurve(typeName, 11, "biter")
        table.insert(result, {bossName, bossCurve})
    end
    
    return result
end

-- Generate result_units for a spitter spawner
function SpawnerConfig.generateSpitterSpawnerUnits(typeName, isVanillaOverride, includeBoss)
    local result = {}
    
    -- If this type has evolution_min > 0, add normal spitter T1 as filler
    local fillerCurve = Tiers.getNormalFillerCurve(typeName, "spitter")
    if fillerCurve and typeName ~= "normal" then
        table.insert(result, {"5d-normal-spitter-t1", fillerCurve})
    end
    
    for tier = 1, Tiers.COUNT do
        local unitName = string.format("5d-%s-spitter-t%d", typeName, tier)
        local curve = Tiers.getSpawnCurve(typeName, tier, "spitter")
        table.insert(result, {unitName, curve})
    end
    
    -- Add boss if enabled
    if includeBoss and settings.startup["5d-boss"] and settings.startup["5d-boss"].value then
        local bossName = string.format("5d-%s-spitter-boss", typeName)
        local bossCurve = Tiers.getSpawnCurve(typeName, 11, "spitter")
        table.insert(result, {bossName, bossCurve})
    end
    
    return result
end

-- =============================================================================
-- AUTOPLACE CONFIGURATION
-- =============================================================================
-- Uses distance_factor from SharedConfig.TypeDefinitions to control
-- where spawners appear on the map.
--
-- How it works:
--   enemy_autoplace_base(distance_factor, seed)
--   - distance_factor: 0=near spawn, higher=farther from spawn  
--   - seed: unique per type for different spawn patterns
-- =============================================================================

-- Get distance_factor for a type (from TypeDefinitions)
function SpawnerConfig.getDistanceFactor(typeName)
    local typeDef = SharedConfig.TypeDefinitions[typeName]
    if typeDef and typeDef.distance_factor then
        return typeDef.distance_factor
    end
    return 0  -- Default: spawn anywhere
end

-- Generate unique seed for each type
local function getTypeSeed(typeName, category)
    -- Use fixed seeds to ensure consistent patterns
    -- Vanilla: biter=6, spitter=7
    local seedMap = {
        -- Biters (start from vanilla seed 6)
        ["normal-biter"] = 6,
        ["laser-biter"] = 10,
        ["physical-biter"] = 11,
        ["impact-biter"] = 12,
        ["railgun-biter"] = 13,
        ["broodmother-biter"] = 14,
        ["swarm-biter"] = 15,
        ["regenerator-biter"] = 16,
        ["berserker-biter"] = 17,
        ["tank-biter"] = 18,
        -- Spitters (start from vanilla seed 7)
        ["normal-spitter"] = 7,
        ["laser-spitter"] = 20,
        ["physical-spitter"] = 21,
        ["fire-spitter"] = 22,
        ["rocket-spitter"] = 23,
        ["suicide-spitter"] = 24,
        ["poison-spitter"] = 25,
        ["electric-spitter"] = 26,
        ["broodmother-spitter"] = 27,
        ["railgun-spitter"] = 28,
        ["regenerator-spitter"] = 29,
        ["tank-spitter"] = 30,
    }
    
    local key = typeName .. "-" .. category
    return seedMap[key] or (category == "biter" and 6 or 7)
end

-- Build autoplace expression for spawners
-- Uses distance_factor to control where spawners appear
function SpawnerConfig.buildAutoplaceExpression(typeName, category)
    -- Validate inputs
    if not typeName or typeName == "" then
        log("[5dim_enemies] WARNING: buildAutoplaceExpression called with nil/empty typeName, category=" .. tostring(category))
        return "enemy_autoplace_base(0, 0)"  -- Safe fallback
    end
    
    local distanceFactor = SpawnerConfig.getDistanceFactor(typeName)
    local seed = getTypeSeed(typeName, category)
    
    -- Simple expression - each type has unique seed for different patterns
    return string.format("enemy_autoplace_base(%d, %d)", distanceFactor, seed)
end

-- Get autoplace order (legacy - for backwards compatibility)
-- Now uses distance_factor from TypeDefinitions
function SpawnerConfig.getAutoplaceOrder(category, typeName)
    -- This returns distance_factor for compatibility
    -- The actual autoplace is now handled by buildAutoplaceExpression
    return SpawnerConfig.getDistanceFactor(typeName)
end

return SpawnerConfig
