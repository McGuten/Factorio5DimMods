-- =============================================================================
-- 5dim_enemies - Tier Utilities Library
-- =============================================================================
-- Shared utility functions for generating tiered enemies.
-- =============================================================================

local Tiers = require("prototypes.config.tiers")
local TierUtils = {}

-- =============================================================================
-- NAME GENERATION
-- =============================================================================

-- Generate entity name for a tiered enemy
-- Format: "5d-{type}-{category}-t{tier}" e.g., "5d-laser-biter-t5"
function TierUtils.getEntityName(typeName, category, tier)
    return string.format("5d-%s-%s-t%d", typeName, category, tier)
end

-- Generate entity name for a boss enemy
-- Format: "5d-{type}-{category}-boss" e.g., "5d-laser-biter-boss"
function TierUtils.getBossName(typeName, category)
    return string.format("5d-%s-%s-boss", typeName, category)
end

-- Generate corpse name
function TierUtils.getCorpseName(entityName)
    return entityName .. "-corpse"
end

-- Generate spawner name
-- Format: "5d-{type}-{category}-spawner" e.g., "5d-laser-biter-spawner"
function TierUtils.getSpawnerName(typeName, category)
    return string.format("5d-%s-%s-spawner", typeName, category)
end

-- =============================================================================
-- RESISTANCE CALCULATION
-- =============================================================================

-- Calculate resistances for a specific tier based on type configuration
-- Parameters:
--   typeConfig: The type configuration (from biter-types.lua or spitter-types.lua)
--   tier: The tier number (1-10)
-- Returns: Array of resistance definitions
function TierUtils.calculateResistances(typeConfig, tier)
    local resistances = {}
    local maxPercent = typeConfig.resistances.max_percent or 100
    
    -- Add base resistances
    if typeConfig.resistances.base then
        for _, baseRes in pairs(typeConfig.resistances.base) do
            local res = {
                type = baseRes.type,
                decrease = baseRes.decrease or 0,
                percent = baseRes.percent or 0
            }
            table.insert(resistances, res)
        end
    end
    
    -- Apply per-tier increments
    if typeConfig.resistances.per_tier then
        for _, tierRes in pairs(typeConfig.resistances.per_tier) do
            -- Find existing resistance of this type or create new
            local found = false
            for i, res in ipairs(resistances) do
                if res.type == tierRes.type then
                    -- Apply increments
                    res.decrease = res.decrease + (tierRes.decrease_increment or 0) * (tier - 1)
                    res.percent = math.min(maxPercent, res.percent + (tierRes.percent_increment or 0) * (tier - 1))
                    found = true
                    break
                end
            end
            
            -- If not found, create new resistance entry
            if not found then
                local res = {
                    type = tierRes.type,
                    decrease = (tierRes.decrease_increment or 0) * (tier - 1),
                    percent = math.min(maxPercent, (tierRes.percent_increment or 0) * (tier - 1))
                }
                table.insert(resistances, res)
            end
        end
    end
    
    -- Filter out zero resistances
    local filteredResistances = {}
    for _, res in ipairs(resistances) do
        if res.decrease > 0 or res.percent > 0 then
            table.insert(filteredResistances, res)
        end
    end
    
    return filteredResistances
end

-- =============================================================================
-- AMMO TYPE HELPERS
-- =============================================================================

-- Create melee ammo type for biters with typed damage and special effects
-- Parameters:
--   damage: Base damage amount
--   typeName: Enemy type name (fire, poison, electric, impact, etc.)
--   tier: The tier number (1-10)
function TierUtils.makeMeleeAmmoType(damage, typeName, tier)
    tier = tier or 1
    typeName = typeName or "normal"
    
    local target_effects = {}
    
    -- Check if typed damage is enabled in settings
    local typedDamageEnabled = Tiers.Settings.typed_damage_enabled
    local stickersEnabled = Tiers.Settings.attack_stickers_enabled
    
    -- ==========================================================================
    -- DAMAGE TYPE BY ENEMY TYPE
    -- ==========================================================================
    
    if typedDamageEnabled and typeName == "fire" then
        -- Fire damage + burning sticker
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.7, type = "physical" }
        })
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.3, type = "fire" }
        })
        -- Higher tiers apply fire sticker
        if stickersEnabled and tier >= 3 then
            table.insert(target_effects, {
                type = "create-sticker",
                sticker = "fire-sticker"
            })
        end
        
    elseif typedDamageEnabled and typeName == "poison" then
        -- Physical + poison damage with slowdown
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.6, type = "physical" }
        })
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.4, type = "poison" }
        })
        -- Poison slows down targets
        if stickersEnabled and tier >= 2 then
            table.insert(target_effects, {
                type = "create-sticker",
                sticker = "slowdown-sticker"
            })
        end
        
    elseif typedDamageEnabled and typeName == "electric" then
        -- Electric damage with chance to stun/slow
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.5, type = "physical" }
        })
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.5, type = "electric" }
        })
        -- Electric stun effect (slowdown)
        if stickersEnabled and tier >= 4 then
            table.insert(target_effects, {
                type = "create-sticker",
                sticker = "slowdown-sticker"
            })
        end
        
    elseif typedDamageEnabled and typeName == "laser" then
        -- Laser damage (energy-based)
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.4, type = "physical" }
        })
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.6, type = "laser" }
        })
        
    elseif typedDamageEnabled and typeName == "impact" then
        -- Heavy impact damage with knockback
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.3, type = "physical" }
        })
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 0.7, type = "impact" }
        })
        -- Knockback effect - stronger at higher tiers
        table.insert(target_effects, {
            type = "push-back",
            distance = 0.3 + tier * 0.1  -- 0.4 tiles at T1 to 1.3 tiles at T10
        })
        
    elseif typedDamageEnabled and typeName == "railgun" then
        -- Armor-piercing physical damage
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage, type = "physical" }
        })
        -- Railgun attacks ignore some armor (via higher raw damage)
        
    elseif typedDamageEnabled and typeName == "physical" then
        -- Pure physical with higher armor penetration
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage * 1.1, type = "physical" }  -- 10% bonus
        })
        
    else
        -- Normal/default - pure physical damage
        table.insert(target_effects, {
            type = "damage",
            damage = { amount = damage, type = "physical" }
        })
    end
    
    return {
        target_type = "entity",
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = target_effects
            }
        }
    }
end

-- =============================================================================
-- DEATH EFFECT HELPERS
-- =============================================================================

-- Check if death effects are enabled
function TierUtils.areDeathEffectsEnabled()
    return Tiers.Settings.death_effects_enabled
end

-- Get the death effect scale multiplier
function TierUtils.getDeathEffectScale()
    return Tiers.Settings.death_effect_scale
end

-- Scale a radius value by the death effect setting
function TierUtils.scaleDeathRadius(baseRadius)
    return baseRadius * Tiers.Settings.death_effect_scale
end

-- =============================================================================
-- ENTITY PROPERTY HELPERS
-- =============================================================================

-- Calculate vision distance based on tier
function TierUtils.getVisionDistance(tier)
    return 30 + (tier * 3)
end

-- Calculate pursue time based on tier (in ticks)
function TierUtils.getMinPursueTime(tier)
    return 10 * 60 + (tier * 60)  -- 10 seconds + 1 second per tier
end

-- Calculate max pursue distance based on tier
function TierUtils.getMaxPursueDistance(tier)
    return 50 + (tier * 5)
end

-- Calculate pollution absorption to join attack
function TierUtils.getAbsorptionsToJoinAttack(tier)
    return { pollution = math.max(1, 11 - tier) }  -- Lower tiers need more pollution
end

-- Calculate attack cooldown based on tier
function TierUtils.getAttackCooldown(tier)
    return math.max(20, 35 - tier)  -- Faster attacks at higher tiers
end

-- Calculate attack range bonus based on tier (for melee)
function TierUtils.getMeleeRangeBonus(tier)
    return 0.5 + (tier * 0.05)
end

-- =============================================================================
-- CORPSE GENERATION
-- =============================================================================

-- Create base corpse definition
function TierUtils.createCorpseBase(entityName, scale, order)
    return {
        type = "corpse",
        name = TierUtils.getCorpseName(entityName),
        icon = "__base__/graphics/icons/medium-biter-corpse.png",
        icon_size = 64,
        selectable_in_game = false,
        selection_box = {{-1 * scale, -1 * scale}, {1 * scale, 1 * scale}},
        subgroup = "corpses",
        order = order or "c[corpse]-a[biter]-t" .. string.format("%02d", 1),
        flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
    }
end

-- =============================================================================
-- VALIDATION
-- =============================================================================

-- Validate tier number (1-10 for normal, 11 for boss)
function TierUtils.isValidTier(tier)
    return tier >= 1 and tier <= Tiers.COUNT
end

-- Check if a tier is the boss tier
function TierUtils.isBossTier(tier)
    return tier == 11
end

-- Check if boss enemies are enabled
function TierUtils.isBossEnabled()
    return settings.startup["5d-boss"] and settings.startup["5d-boss"].value
end

-- Check if suicide spitters are enabled
function TierUtils.isSuicideEnabled()
    return settings.startup["5d-suicide"] and settings.startup["5d-suicide"].value
end

-- =============================================================================
-- STAT HELPERS (using new Tiers system)
-- =============================================================================

-- Get stats for a specific tier using the new TypeMultipliers system
-- Parameters:
--   category: "biter", "spitter", or "worm"
--   typeName: The type name (e.g., "normal", "fire", "suicide")
--   tier: 1-10 for normal tiers, 11 for boss
function TierUtils.getStats(category, typeName, tier)
    return Tiers.getStats(category, typeName, tier)
end

-- Get the spawn curve for result_units
-- Parameters:
--   typeName: The type name
--   tier: 1-11 (11 = boss)
function TierUtils.getSpawnCurve(typeName, tier)
    return Tiers.getSpawnCurve(typeName, tier)
end

-- Get evolution values for a type
function TierUtils.getEvolution(typeName)
    return Tiers.calculateEvolution(typeName)
end

return TierUtils
