-- =============================================================================
-- 5dim_enemies - Tier Configuration
-- =============================================================================
-- This file defines the base configuration for the 10-tier + boss system.
-- All enemy types (biters, spitters, worms) use these tier definitions.
-- 
-- IMPORTANT: TypeMultipliers, BossConfig are loaded from shared-config.lua
-- which is the SINGLE SOURCE OF TRUTH shared with control.lua (GUI)
-- =============================================================================

-- Load shared configuration
local SharedConfig = require("shared-config")

local Tiers = {}

local function appendSpawnPoint(curve, evolutionFactor, weight)
    local lastPoint = curve[#curve]

    if not lastPoint then
        table.insert(curve, {evolutionFactor, weight})
        return
    end

    if evolutionFactor > lastPoint[1] then
        table.insert(curve, {evolutionFactor, weight})
        return
    end

    if evolutionFactor == lastPoint[1] then
        lastPoint[2] = weight
    end
end

-- Number of tiers in the system (excluding boss)
Tiers.COUNT = 10

-- =============================================================================
-- GLOBAL SETTINGS (User-configurable multipliers)
-- =============================================================================
-- These are applied to ALL enemies on top of type-specific multipliers

Tiers.Settings = {
    health_multiplier = (settings.startup["5d-health-multiplier"] and settings.startup["5d-health-multiplier"].value) or 1.0,
    damage_multiplier = (settings.startup["5d-damage-multiplier"] and settings.startup["5d-damage-multiplier"].value) or 1.0,
    speed_multiplier = (settings.startup["5d-speed-multiplier"] and settings.startup["5d-speed-multiplier"].value) or 1.0,
    death_effects_enabled = (settings.startup["5d-death-effects"] and settings.startup["5d-death-effects"].value) ~= false,
    death_effect_scale = (settings.startup["5d-death-effect-scale"] and settings.startup["5d-death-effect-scale"].value) or 1.0,
    typed_damage_enabled = (settings.startup["5d-typed-damage"] and settings.startup["5d-typed-damage"].value) ~= false,
    attack_stickers_enabled = (settings.startup["5d-attack-stickers"] and settings.startup["5d-attack-stickers"].value) ~= false
}

-- =============================================================================
-- BASE STATS (Extended with prepare_range for worms)
-- =============================================================================
-- These extend SharedConfig.BaseStats with additional fields needed by prototypes

Tiers.base = {
    biter = SharedConfig.BaseStats.biter,
    spitter = SharedConfig.BaseStats.spitter,
    worm = {
        -- Worms scale above vanilla, but should stay within a readable envelope.
        [1]  = { scale = 0.55, health = 200,  damage = 25,  range = 22, prepare_range = 6,  speed = 0, healing = 0.022 },
        [2]  = { scale = 0.62, health = 300,  damage = 32,  range = 24, prepare_range = 8,  speed = 0, healing = 0.028 },
        [3]  = { scale = 0.70, health = 450,  damage = 40,  range = 26, prepare_range = 10, speed = 0, healing = 0.0375 },
        [4]  = { scale = 0.78, health = 675,  damage = 50,  range = 28, prepare_range = 12, speed = 0, healing = 0.0475 },
        [5]  = { scale = 0.88, health = 1000, damage = 64,  range = 31, prepare_range = 14, speed = 0, healing = 0.0625 },
        [6]  = { scale = 0.98, health = 1500, damage = 80,  range = 34, prepare_range = 16, speed = 0, healing = 0.0825 },
        [7]  = { scale = 1.10, health = 2250, damage = 100, range = 37, prepare_range = 20, speed = 0, healing = 0.110 },
        [8]  = { scale = 1.25, health = 3375, damage = 125, range = 41, prepare_range = 24, speed = 0, healing = 0.150 },
        [9]  = { scale = 1.45, health = 4800, damage = 155, range = 45, prepare_range = 27, speed = 0, healing = 0.210 },
        [10] = { scale = 1.70, health = 6500, damage = 190, range = 50, prepare_range = 30, speed = 0, healing = 0.290 }
    }
}

-- =============================================================================
-- TYPE MULTIPLIERS (from shared-config.lua - SINGLE SOURCE OF TRUTH)
-- =============================================================================

Tiers.TypeMultipliers = SharedConfig.TypeMultipliers

-- =============================================================================
-- BOSS CONFIGURATION (from shared-config.lua - SINGLE SOURCE OF TRUTH)
-- =============================================================================

Tiers.boss = SharedConfig.BossConfig

-- =============================================================================
-- EVOLUTION CALCULATION FUNCTIONS
-- =============================================================================

-- Evolution offset for spitters (they appear slightly later than biters)
Tiers.SPITTER_EVOLUTION_OFFSET = 0.02

-- Calculate evolution values for a specific type
-- Returns a table with evolution values for each tier (1-10) and boss (11)
-- Only 3 tiers are active at any given evolution level
-- Parameters:
--   typeName: The type name (e.g., "normal", "fire", "suicide")
--   category: Optional - "biter", "spitter", or "worm" (spitters get +5% offset)
function Tiers.calculateEvolution(typeName, category)
    local multipliers = Tiers.TypeMultipliers[typeName] or Tiers.TypeMultipliers.default
    local evMin = multipliers.evolution_min
    local evMax = multipliers.evolution_max
    
    -- 11 levels: T1-T10 + Boss
    local levels = 11
    local step = (evMax - evMin) / (levels - 1)
    
    -- Spitters spawn at +5% evolution compared to biters
    local offset = (category == "spitter") and Tiers.SPITTER_EVOLUTION_OFFSET or 0
    
    local evolution = {}
    for i = 1, levels do
        -- Calculate base evolution, add offset, cap at 1.0
        evolution[i] = math.min(1.0, evMin + (i - 1) * step + offset)
    end
    
    return evolution
end

-- Get the spawn weight curve for a specific tier at different evolution levels
-- This creates the "3 tiers active" behavior
-- Returns: {{evolution, weight}, {evolution, weight}, ...}
-- Parameters:
--   typeName: The type name (e.g., "normal", "fire")
--   tier: 1-10 for normal tiers, 11 for boss
--   category: Optional - "biter", "spitter", or "worm" (affects evolution offset)
function Tiers.getSpawnCurve(typeName, tier, category)
    local evolution = Tiers.calculateEvolution(typeName, category)
    local curve = {}
    
    -- Each tier has a spawn curve:
    -- - Starts spawning at its evolution value (weight 0 -> 0.3)
    -- - Peaks one tier later (weight 0.3)
    -- - Declines and stops two tiers later (weight 0.3 -> 0)
    
    local tierEvo = evolution[tier]
    local nextEvo = evolution[tier + 1] or 1.0
    local nextNextEvo = evolution[tier + 2] or 1.0
    local nextNextNextEvo = evolution[tier + 3] or 1.0
    
    if tier == 1 then
        -- Tier 1 starts with weight at evolution_min, then declines
        appendSpawnPoint(curve, tierEvo, 0.3)
        appendSpawnPoint(curve, nextEvo, 0.3)
        appendSpawnPoint(curve, nextNextEvo, 0.1)
        if tier + 3 <= 11 then
            appendSpawnPoint(curve, nextNextNextEvo, 0.0)
        end
    elseif tier == 11 then
        -- Boss (tier 11) only spawns at very end
        local prevEvo = evolution[tier - 1] or evolution[10]
        appendSpawnPoint(curve, prevEvo, 0.0)
        appendSpawnPoint(curve, tierEvo, 0.3)
    else
        -- Normal tiers: ramp up, peak, ramp down
        local prevEvo = evolution[tier - 1] or 0
        appendSpawnPoint(curve, prevEvo, 0.0)
        appendSpawnPoint(curve, tierEvo, 0.3)
        if tier + 1 <= 11 then
            appendSpawnPoint(curve, nextEvo, 0.3)
        end
        if tier + 2 <= 11 then
            appendSpawnPoint(curve, nextNextEvo, 0.1)
        end
        if tier + 3 <= 11 then
            appendSpawnPoint(curve, nextNextNextEvo, 0.0)
        end
    end
    
    return curve
end

-- Get a "filler" spawn curve for normal enemies in specialized spawners
-- When a type has evolution_min > 0, this curve spawns normal T1 biters/spitters
-- from evolution 0.0 until the type's evolution_min
-- Returns: {{evolution, weight}, ...} or nil if no filler needed
-- Parameters:
--   typeName: The type name (e.g., "fire", "railgun")
--   category: "biter" or "spitter" (affects evolution offset)
function Tiers.getNormalFillerCurve(typeName, category)
    local multipliers = Tiers.TypeMultipliers[typeName] or Tiers.TypeMultipliers.default
    
    -- Apply spitter offset to evolution_min
    local offset = (category == "spitter") and Tiers.SPITTER_EVOLUTION_OFFSET or 0
    local evMin = math.min(1.0, multipliers.evolution_min + offset)
    
    -- No filler needed if type starts at 0
    if evMin < 0.01 then
        return nil
    end
    
    -- Spawn normal T1 from 0.0 to evolution_min, then fade out
    local curve = {}
    appendSpawnPoint(curve, 0.0, 0.3)
    appendSpawnPoint(curve, evMin, 0.3)
    appendSpawnPoint(curve, math.min(1.0, evMin + 0.05), 0.0)  -- Quick fade out once the type's own tiers start
    return curve
end

-- =============================================================================
-- STAT CALCULATION FUNCTIONS
-- =============================================================================

-- Get stats for a specific tier with type multipliers applied
-- Parameters:
--   category: "biter", "spitter", or "worm"
--   typeName: The type name (e.g., "normal", "fire", "suicide")
--   tier: 1-10 for normal tiers, 11 for boss
-- Returns: Table with calculated stats
function Tiers.getStats(category, typeName, tier)
    local multipliers = Tiers.TypeMultipliers[typeName] or Tiers.TypeMultipliers.default
    local baseStats = Tiers.base[category]
    
    if not baseStats then
        error("Unknown category: " .. tostring(category))
    end
    
    local stats = {}
    
    -- Global setting multipliers
    local globalHealth = Tiers.Settings.health_multiplier
    local globalDamage = Tiers.Settings.damage_multiplier
    local globalSpeed = Tiers.Settings.speed_multiplier
    
    if tier >= 1 and tier <= 10 then
        -- Normal tier
        local base = baseStats[tier]
        if not base then
            error("Invalid tier: " .. tostring(tier))
        end
        
        stats.scale = base.scale
        stats.health = math.floor(base.health * multipliers.health * globalHealth)
        stats.damage = math.floor(base.damage * multipliers.damage * globalDamage)
        stats.speed = base.speed * multipliers.speed * globalSpeed
        stats.healing = base.healing * multipliers.healing
        
        -- Category-specific stats
        if base.range then stats.range = base.range end
        if base.prepare_range then stats.prepare_range = base.prepare_range end
        
    elseif tier == 11 then
        -- Boss tier (based on T10 with boss multipliers)
        local base = baseStats[10]
        
        stats.scale = base.scale * Tiers.boss.scale_multiplier
        stats.health = math.floor(base.health * multipliers.health * Tiers.boss.health_multiplier * globalHealth)
        stats.damage = math.floor(base.damage * multipliers.damage * Tiers.boss.damage_multiplier * globalDamage)
        stats.speed = base.speed * multipliers.speed * Tiers.boss.speed_multiplier * globalSpeed
        
        -- Boss healing: calculated to heal in boss.healing_time seconds
        stats.healing = stats.health / (Tiers.boss.healing_time * 60)  -- 60 ticks per second
        
        -- Category-specific stats for boss
        if base.range then 
            stats.range = math.ceil(base.range * 1.2)  -- 20% more range for boss, rounded up
        end
        if base.prepare_range then 
            stats.prepare_range = math.ceil(base.prepare_range * 1.2)
        end
    else
        error("Invalid tier: " .. tostring(tier) .. " (must be 1-11)")
    end
    
    -- Get evolution for this tier (pass category for spitter offset)
    local evolution = Tiers.calculateEvolution(typeName, category)
    stats.evolution = evolution[tier]
    
    return stats
end

-- =============================================================================
-- BASE TIER TABLES
-- =============================================================================
-- Pre-calculated stats for "normal" type enemies.
-- Used as base values that type multipliers are applied to.
-- =============================================================================

local function generateBaseTiers(category)
    local tiers = {}
    for i = 1, 10 do
        tiers[i] = Tiers.getStats(category, "normal", i)
    end
    return tiers
end

-- Base tier stats (normal type)
Tiers.biter = generateBaseTiers("biter")
Tiers.spitter = generateBaseTiers("spitter")
Tiers.worm = generateBaseTiers("worm")

-- =============================================================================
-- SPAWNER CONFIGURATION
-- =============================================================================
-- Spawners don't have tiers, but their stats scale with enemy types
-- =============================================================================

Tiers.spawner = {
    health = 350,
    healing = 0.02,
    spawning_cooldown = {360, 150},  -- {max, min} in ticks
    max_count_of_owned_units = 7,
    max_friends_around_to_spawn = 5,
    call_for_help_radius = 50
}

return Tiers
