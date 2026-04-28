-- =============================================================================
-- 5dim_enemies - Boss Worms Generator
-- =============================================================================
-- This file creates boss worms (tier 11) for all worm types.
-- These are extremely powerful worms that appear at max evolution.
-- Boss = x3 health and damage from base T10 stats with type multipliers.
-- =============================================================================

local Tiers = require("prototypes.config.tiers")
local WormTypes = require("prototypes.config.worm-types")
local TierUtils = require("prototypes.lib.tier-utils")

-- Only generate if boss enemies are enabled
if not TierUtils.isBossEnabled() then
    return
end

-- Base game animation functions
require("__base__/prototypes/entity/worm-animations")

local sounds = require("__base__/prototypes/entity/sounds")
local hit_effects = require("__base__/prototypes/entity/hit-effects")
local enemy_autoplace = require("__base__/prototypes/entity/enemy-autoplace-utils")

-- =============================================================================
-- BOSS WORM GENERATOR
-- =============================================================================

local function generateBossWorm(wormType)
    -- Get stats using the new system (tier 11 = boss)
    local stats = Tiers.getStats("worm", wormType.name or "normal", 11)
    local wormName = wormType.name_prefix .. "-worm-boss"
    local corpseName = wormName .. "-corpse"
    local corpseNameBurrowed = wormName .. "-corpse-burrowed"
    
    local scale = stats.scale
    local tint = wormType.tint
    local healthMultiplier = wormType.health_multiplier or 1.0
    local damageMultiplier = wormType.damage_multiplier or 1.0
    
    -- Use behemoth stream for boss
    local streamName = "acid-stream-worm-behemoth"
    
    -- Large collision box for boss
    local collisionWidth = 2.2
    local collisionHeight = 1.8
    
    -- Selection box - very large for easy clicking on boss
    local selectionScale = 4.0
    
    -- Strong resistances for boss
    local baseResistances = wormType.resistances or {}
    local resistances = {}
    for _, res in pairs(baseResistances) do
        table.insert(resistances, {
            type = res.type,
            decrease = (res.decrease or 0) * 2,
            percent = math.min((res.percent or 0) * 1.5, 95)
        })
    end
    -- Add base resistances
    table.insert(resistances, {type = "physical", decrease = 20, percent = 40})
    table.insert(resistances, {type = "explosion", decrease = 20, percent = 50})
    table.insert(resistances, {type = "fire", decrease = 10, percent = 80})
    table.insert(resistances, {type = "laser", percent = 70})
    table.insert(resistances, {type = "acid", percent = 90})
    
    -- Create the boss worm
    local worm = {
        type = "turret",
        name = wormName,
        icon = "__base__/graphics/icons/behemoth-worm.png",
        flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
        order = "b-c-z",
        subgroup = "enemies",
        max_health = math.floor(stats.health * healthMultiplier),
        impact_category = "organic",
        resistances = resistances,
        healing_per_tick = stats.healing,
        collision_box = {{-collisionWidth, -collisionHeight}, {collisionWidth, collisionHeight}},
        map_generator_bounding_box = {{-collisionWidth - 2, -collisionHeight - 2}, {collisionWidth + 2, collisionHeight + 2}},
        selection_box = {{-selectionScale, -selectionScale}, {selectionScale, selectionScale}},
        damaged_trigger_effect = hit_effects.biter(),
        shooting_cursor_size = 5,
        rotation_speed = 1,
        corpse = corpseName,
        folded_state_corpse = corpseNameBurrowed,
        dying_explosion = "behemoth-worm-die",
        dying_sound = sounds.worm_dying_behemoth(1.0),
        graphics_set = {},
        folded_speed = 0.008,
        folded_speed_secondary = 0.020,
        folded_animation_is_stateless = true,
        folded_animation = worm_folded_animation(scale, tint),
        preparing_speed = 0.020,
        preparing_animation = worm_preparing_animation(scale, tint, "forward"),
        preparing_sound = sounds.worm_standup(0.9),
        prepared_speed = 0.020,
        prepared_speed_secondary = 0.010,
        prepared_sound = sounds.worm_breath_big(0.8, 1.0),
        prepared_animation = worm_prepared_animation(scale, tint),
        prepared_alternative_speed = 0.012,
        prepared_alternative_speed_secondary = 0.008,
        prepared_alternative_chance = 0.3,
        prepared_alternative_animation = worm_prepared_alternative_animation(scale, tint),
        prepared_alternative_sound = sounds.worm_roar_alternative_big(0.6, 0.9),
        starting_attack_speed = 0.030,
        starting_attack_animation = worm_start_attack_animation(scale, tint),
        starting_attack_sound = sounds.worm_roars_big(0.7, 1.0),
        ending_attack_speed = 0.014,
        ending_attack_animation = worm_end_attack_animation(scale, tint),
        folding_speed = 0.012,
        folding_animation = worm_preparing_animation(scale, tint, "backward"),
        folding_sound = sounds.worm_fold(1.2),
        random_animation_offset = true,
        attack_from_start_frame = true,
        integration = worm_integration(scale, true),
        prepare_range = stats.range + stats.prepare_range,
        allow_turning_when_starting_attack = true,
        attack_parameters = {
            type = "stream",
            cooldown = 3,
            range = stats.range,
            damage_modifier = stats.damage * damageMultiplier,
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
        build_base_evolution_requirement = stats.evolution,
        autoplace = enemy_autoplace.enemy_worm_autoplace("enemy_autoplace_base(10, 8)"),
        call_for_help_radius = 100,
        spawn_decorations_on_expansion = true,
        spawn_decoration = {
            {
                decorative = "worms-decal",
                spawn_min = 2,
                spawn_max = 4,
                spawn_min_radius = 2,
                spawn_max_radius = 6
            },
            {
                decorative = "shroom-decal",
                spawn_min = 2,
                spawn_max = 4,
                spawn_min_radius = 1,
                spawn_max_radius = 4
            },
            {
                decorative = "enemy-decal",
                spawn_min = 2,
                spawn_max = 5,
                spawn_min_radius = 1,
                spawn_max_radius = 5
            },
            {
                decorative = "enemy-decal-transparent",
                spawn_min = 4,
                spawn_max = 8,
                spawn_min_radius = 2,
                spawn_max_radius = 6
            }
        }
    }
    
    -- Create corpse
    local corpse = {
        type = "corpse",
        name = corpseName,
        icon = "__base__/graphics/icons/behemoth-worm-corpse.png",
        selection_box = {{-collisionWidth, -collisionHeight}, {collisionWidth, collisionHeight}},
        selectable_in_game = false,
        dying_speed = 0.008,
        time_before_removed = 20 * 60 * 60,
        subgroup = "enemies",
        order = "c[corpse]-b[worm]-z",
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
        icon = "__base__/graphics/icons/behemoth-worm-corpse.png",
        selection_box = {{-collisionWidth, -collisionHeight}, {collisionWidth, collisionHeight}},
        selectable_in_game = false,
        dying_speed = 0.008,
        time_before_removed = 20 * 60 * 60,
        subgroup = "enemies",
        order = "c[corpse]-b[worm]-z-burrowed",
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
-- GENERATE ALL BOSS WORMS
-- =============================================================================

local entitiesToCreate = {}

-- Generate boss worms for all enabled types
for typeName, wormType in pairs(WormTypes.getEnabledTypes()) do
    local worm, corpse, corpseBurrowed = generateBossWorm(wormType)
    if worm then
        table.insert(entitiesToCreate, worm)
        table.insert(entitiesToCreate, corpse)
        table.insert(entitiesToCreate, corpseBurrowed)
    end
end

-- Register all entities
if #entitiesToCreate > 0 then
    data:extend(entitiesToCreate)
end
