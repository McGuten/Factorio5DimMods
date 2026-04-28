-- =============================================================================
-- 5dim_enemies - Tiered Worm Generator
-- =============================================================================
-- This file generates tiered worms (T1-T10) for special worm types.
-- Uses base game animations and vanilla streams.
-- =============================================================================

local Tiers = require("prototypes.config.tiers")
local WormTypes = require("prototypes.config.worm-types")
local SpawnerConfig = require("prototypes.config.spawner-config")

-- Base game animation functions
require("__base__/prototypes/entity/worm-animations")

local sounds = require("__base__/prototypes/entity/sounds")
local hit_effects = require("__base__/prototypes/entity/hit-effects")
local enemy_autoplace = require("__base__/prototypes/entity/enemy-autoplace-utils")

-- =============================================================================
-- HELPER FUNCTIONS
-- =============================================================================

-- Map tier to vanilla stream name
local function getStreamName(tier)
    if tier <= 3 then
        return "acid-stream-worm-small"
    elseif tier <= 6 then
        return "acid-stream-worm-medium"
    elseif tier <= 8 then
        return "acid-stream-worm-big"
    else
        return "acid-stream-worm-behemoth"
    end
end

-- Get size category for icons and sounds
local function getSizeCategory(tier)
    if tier <= 3 then return "small"
    elseif tier <= 6 then return "medium"
    elseif tier <= 8 then return "big"
    else return "behemoth"
    end
end

-- Calculate resistances for a tier
local function calculateResistances(baseResistances, tier)
    local resistances = {}
    
    -- Copy base resistances with scaling
    if baseResistances then
        for _, res in pairs(baseResistances) do
            table.insert(resistances, {
                type = res.type,
                decrease = (res.decrease or 0) + math.floor(tier / 3),
                percent = math.min((res.percent or 0) + tier * 2, 90)
            })
        end
    end
    
    -- Add tier-based resistances
    if tier >= 4 then
        table.insert(resistances, {type = "physical", decrease = math.floor(tier / 2)})
    end
    if tier >= 5 then
        table.insert(resistances, {type = "explosion", decrease = math.floor(tier / 2), percent = tier * 3})
    end
    
    return resistances
end

-- =============================================================================
-- WORM GENERATOR
-- =============================================================================

local function generateTieredWorm(wormType, tier, typeName)
    local tierData = Tiers.worm[tier]
    if not tierData then return nil end
    
    local wormName = wormType.name_prefix .. "-worm-t" .. tier
    local corpseName = wormName .. "-corpse"
    local corpseNameBurrowed = wormName .. "-corpse-burrowed"
    
    local scale = tierData.scale
    local tint = wormType.tint
    local healthMultiplier = wormType.health_multiplier or 1.0
    local damageMultiplier = wormType.damage_multiplier or 1.0
    local sizeCategory = getSizeCategory(tier)
    local streamName = getStreamName(tier)
    
    -- Collision box scales with tier
    local collisionWidth = 0.9 + (tier * 0.06)
    local collisionHeight = 0.8 + (tier * 0.05)
    
    -- Selection box larger than collision for easier clicking
    local selectionScale = 1.2 + (tier * 0.15)
    
    -- Resistances that scale with tier
    local resistances = calculateResistances(wormType.resistances, tier)
    
    -- Create the worm turret
    local worm = {
        type = "turret",
        name = wormName,
        icon = "__base__/graphics/icons/" .. sizeCategory .. "-worm.png",
        flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
        order = "b-c-" .. string.char(96 + tier),
        subgroup = "enemies",
        max_health = math.floor(tierData.health * healthMultiplier),
        impact_category = "organic",
        resistances = resistances,
        healing_per_tick = tierData.healing,
        collision_box = {{-collisionWidth, -collisionHeight}, {collisionWidth, collisionHeight}},
        map_generator_bounding_box = {{-collisionWidth - 1, -collisionHeight - 1}, {collisionWidth + 1, collisionHeight + 1}},
        selection_box = {{-selectionScale, -selectionScale}, {selectionScale, selectionScale}},
        damaged_trigger_effect = hit_effects.biter(),
        shooting_cursor_size = 3 + (tier * 0.1),
        rotation_speed = 1,
        corpse = corpseName,
        folded_state_corpse = corpseNameBurrowed,
        dying_explosion = sizeCategory .. "-worm-die",
        dying_sound = sizeCategory == "small" and sounds.worm_dying_small(0.57) or 
                      sizeCategory == "behemoth" and sounds.worm_dying_behemoth(0.8) or
                      sizeCategory == "big" and sounds.worm_dying_big(0.7) or
                      sounds.worm_dying(0.65),
        graphics_set = {},
        folded_speed = 0.01,
        folded_speed_secondary = 0.024,
        folded_animation_is_stateless = true,
        folded_animation = worm_folded_animation(scale, tint),
        preparing_speed = 0.024,
        preparing_animation = worm_preparing_animation(scale, tint, "forward"),
        preparing_sound = sizeCategory == "small" and sounds.worm_standup_small(0.6) or sounds.worm_standup(0.6 + tier * 0.01),
        prepared_speed = 0.024,
        prepared_speed_secondary = 0.012,
        prepared_sound = (sizeCategory == "big" or sizeCategory == "behemoth")
            and sounds.worm_breath_big(0.6, 0.9) 
            or sounds.worm_breath(0.4 + tier * 0.02, 0.6 + tier * 0.02),
        prepared_animation = worm_prepared_animation(scale, tint),
        prepared_alternative_speed = 0.014 + (tier * 0.001),
        prepared_alternative_speed_secondary = 0.010,
        prepared_alternative_chance = 0.2,
        prepared_alternative_animation = worm_prepared_alternative_animation(scale, tint),
        prepared_alternative_sound = (sizeCategory == "big" or sizeCategory == "behemoth")
            and sounds.worm_roar_alternative_big(0.4, 0.7)
            or sounds.worm_roar_alternative(0.4, 0.6 + tier * 0.02),
        starting_attack_speed = 0.034,
        starting_attack_animation = worm_start_attack_animation(scale, tint),
        starting_attack_sound = (sizeCategory == "big" or sizeCategory == "behemoth")
            and sounds.worm_roars_big(0.4 + tier * 0.02, 0.7 + tier * 0.01)
            or sounds.worm_roars(0.4, 0.6 + tier * 0.02),
        ending_attack_speed = 0.016,
        ending_attack_animation = worm_end_attack_animation(scale, tint),
        folding_speed = 0.015,
        folding_animation = worm_preparing_animation(scale, tint, "backward"),
        folding_sound = sounds.worm_fold(1),
        random_animation_offset = true,
        attack_from_start_frame = true,
        integration = worm_integration(scale, true),
        prepare_range = tierData.range + tierData.prepare_range,
        allow_turning_when_starting_attack = true,
        attack_parameters = {
            type = "stream",
            cooldown = 4,
            range = tierData.range,
            damage_modifier = tierData.damage * damageMultiplier,
            min_range = 0,
            projectile_creation_parameters = worm_shoot_shiftings(scale, scale * 15),
            use_shooter_direction = true,
            lead_target_for_projectile_speed = 0.2 * 0.75 * 1.5 * 1.5,
            ammo_category = "biological",
            ammo_type = {
                action = {
                    type = "direct",
                    action_delivery = {
                        type = "stream",
                        stream = streamName,
                        source_offset = {0.15, -0.5}
                    }
                }
            }
        },
        build_base_evolution_requirement = tierData.evolution,
        -- Use intelligent autoplace: distance_factor from type + tier offset
        -- This makes stronger worm types AND higher tiers spawn farther
        autoplace = enemy_autoplace.enemy_worm_autoplace(SpawnerConfig.buildAutoplaceExpression(typeName, "worm")),
        call_for_help_radius = 40 + (tier * 4),
        spawn_decorations_on_expansion = true,
        spawn_decoration = {
            {
                decorative = "worms-decal",
                spawn_min = math.floor(tier / 4),
                spawn_max = math.floor(tier / 3) + 1,
                spawn_min_radius = 1,
                spawn_max_radius = math.floor(tier / 3) + 2
            },
            {
                decorative = "shroom-decal",
                spawn_min = 1,
                spawn_max = math.floor(tier / 5) + 1,
                spawn_min_radius = 1,
                spawn_max_radius = 2
            },
            {
                decorative = "enemy-decal",
                spawn_min = 1,
                spawn_max = math.floor(tier / 3) + 1,
                spawn_min_radius = 0,
                spawn_max_radius = math.floor(tier / 4) + 1
            },
            {
                decorative = "enemy-decal-transparent",
                spawn_min = 2,
                spawn_max = math.floor(tier / 2) + 2,
                spawn_min_radius = 1,
                spawn_max_radius = math.floor(tier / 3) + 2
            }
        }
    }
    
    -- ==========================================================================
    -- DEATH EFFECTS BY WORM TYPE
    -- ==========================================================================
    
    local deathRadius = 2 + tier * 0.5  -- Scales with tier
    local effectCount = 2 + math.floor(tier / 2)
    
    if wormType.damage_type == "fire" then
        -- Fire worms leave burning area
        worm.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-explosion"
            }
        }
        for i = 1, effectCount + 2 do
            table.insert(worm.dying_trigger_effect, {
                type = "create-fire",
                entity_name = "fire-flame",
                initial_ground_flame_count = 5 + tier * 2,
                offset_deviation = {{-deathRadius, -deathRadius}, {deathRadius, deathRadius}}
            })
        end
        
    elseif wormType.damage_type == "poison" then
        -- Poison worms create poison clouds (optimized)
        -- Select cloud size based on tier
        local cloudName = tier <= 3 and "5d-poison-cloud-small" or tier <= 6 and "5d-poison-cloud-medium" or tier <= 9 and "5d-poison-cloud-big" or "5d-poison-cloud-behemoth"
        local reducedCount = math.max(1, math.floor(effectCount / 2))  -- Reduced for performance
        worm.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-explosion"
            }
        }
        for i = 1, reducedCount do
            table.insert(worm.dying_trigger_effect, {
                type = "create-entity",
                entity_name = cloudName,
                offset_deviation = {{-deathRadius, -deathRadius}, {deathRadius, deathRadius}}
            })
        end
        
    elseif wormType.damage_type == "electric" then
        -- Electric worms create electric discharge
        worm.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-explosion"
            },
            {
                type = "create-entity",
                entity_name = "explosion",
                offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
            }
        }
        for i = 1, effectCount + 3 do
            table.insert(worm.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-deathRadius, -deathRadius}, {deathRadius, deathRadius}}
            })
        end
        table.insert(worm.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = deathRadius + 2,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 10 + tier * 5, type = "electric"}
                        },
                        {
                            type = "create-sticker",
                            sticker = "slowdown-sticker"
                        }
                    }
                }
            }
        })
        
    elseif wormType.damage_type == "laser" then
        -- Laser worms create light explosion
        worm.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-explosion"
            },
            {
                type = "create-entity",
                entity_name = "laser-bubble",
                offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
            }
        }
        for i = 1, effectCount + 2 do
            table.insert(worm.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-deathRadius, -deathRadius}, {deathRadius, deathRadius}}
            })
        end
        table.insert(worm.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = deathRadius,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 8 + tier * 4, type = "laser"}
                        }
                    }
                }
            }
        })
        
    elseif wormType.damage_type == "physical" then
        -- Physical worms create debris/shrapnel
        worm.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-explosion"
            }
        }
        for i = 1, effectCount + 5 do
            table.insert(worm.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 10,
                offset_deviation = {{-deathRadius, -deathRadius}, {deathRadius, deathRadius}}
            })
        end
        table.insert(worm.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = deathRadius,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 15 + tier * 5, type = "physical"}
                        }
                    }
                }
            }
        })
        
    elseif wormType.damage_type == "acid" and wormType.name_prefix ~= "5d-normal" then
        -- Acid worms leave corrosive puddles
        worm.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-explosion"
            }
        }
        for i = 1, effectCount do
            table.insert(worm.dying_trigger_effect, {
                type = "create-entity",
                entity_name = "acid-splash-fire-worm-big",
                offset_deviation = {{-deathRadius, -deathRadius}, {deathRadius, deathRadius}}
            })
        end
    end
    
    -- Create corpse
    local corpse = {
        type = "corpse",
        name = corpseName,
        icon = "__base__/graphics/icons/" .. sizeCategory .. "-worm-corpse.png",
        selection_box = {{-collisionWidth, -collisionHeight}, {collisionWidth, collisionHeight}},
        selectable_in_game = false,
        dying_speed = 0.01,
        time_before_removed = 15 * 60 * 60,
        subgroup = "enemies",
        order = "c[corpse]-b[worm]-" .. string.char(96 + tier),
        final_render_layer = "lower-object-above-shadow",
        animation = worm_die_animation(scale, tint),
        ground_patch = {
            sheet = worm_integration_decay(scale)
        },
        decay_animation = worm_decay_animation(scale, tint),
    }
    
    -- Create burrowed corpse
    local corpseBurrowed = {
        type = "corpse",
        name = corpseNameBurrowed,
        icon = "__base__/graphics/icons/" .. sizeCategory .. "-worm-corpse.png",
        selection_box = {{-collisionWidth, -collisionHeight}, {collisionWidth, collisionHeight}},
        selectable_in_game = false,
        dying_speed = 0.01,
        time_before_removed = 15 * 60 * 60,
        subgroup = "enemies",
        order = "c[corpse]-b[worm]-" .. string.char(96 + tier) .. "-burrowed",
        final_render_layer = "lower-object-above-shadow",
        animation = worm_die_burrowed_animation(scale, tint),
        ground_patch = {
            sheet = worm_integration_decay(scale)
        },
        decay_animation = worm_decay_animation(scale, tint),
    }
    
    return worm, corpse, corpseBurrowed
end

-- =============================================================================
-- GENERATE ALL WORMS
-- =============================================================================

local entitiesToCreate = {}

-- Generate worms for each enabled type (except normal, handled by vanilla modifier)
for typeName, wormType in pairs(WormTypes.getEnabledTypes()) do
    if typeName ~= "normal" then  -- Normal worms handled separately
        for tier = 1, Tiers.COUNT do
            local worm, corpse, corpseBurrowed = generateTieredWorm(wormType, tier, typeName)
            if worm then
                table.insert(entitiesToCreate, worm)
                table.insert(entitiesToCreate, corpse)
                table.insert(entitiesToCreate, corpseBurrowed)
            end
        end
    end
end

-- Register all entities
if #entitiesToCreate > 0 then
    data:extend(entitiesToCreate)
end
