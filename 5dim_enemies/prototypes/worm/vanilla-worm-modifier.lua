-- =============================================================================
-- 5dim_enemies - Vanilla Worm Modifier
-- =============================================================================
-- This file creates normal tiered worms (T1-T10) using vanilla streams.
-- =============================================================================

local Tiers = require("prototypes.config.tiers")

-- Base game animation functions
require("__base__/prototypes/entity/worm-animations")

local sounds = require("__base__/prototypes/entity/sounds")
local hit_effects = require("__base__/prototypes/entity/hit-effects")
local enemy_autoplace = require("__base__/prototypes/entity/enemy-autoplace-utils")

-- =============================================================================
-- WORM TINTS (Normal/Acid type)
-- =============================================================================

local function getWormTint(tier)
    local tints = {
        [1]  = {0.7, 1.0, 0.3, 0.5},    -- Light green (small)
        [2]  = {0.75, 0.9, 0.35, 0.55},
        [3]  = {0.8, 0.6, 0.4, 0.7},
        [4]  = {0.9, 0.15, 0.3, 1.0},   -- Reddish (medium)
        [5]  = {0.85, 0.25, 0.35, 0.9},
        [6]  = {0.6, 0.5, 0.7, 0.85},
        [7]  = {0.34, 0.68, 0.90, 0.8}, -- Blueish (big)
        [8]  = {0.4, 0.6, 0.85, 0.85},
        [9]  = {0.35, 0.9, 0.2, 0.85},
        [10] = {0.3, 1.0, 0.0, 0.8},    -- Bright green (behemoth)
    }
    return tints[tier] or tints[1]
end

-- Map tier to vanilla stream name (use existing streams)
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

-- =============================================================================
-- WORM GENERATOR
-- =============================================================================

local function generateNormalWorm(tier)
    local tierData = Tiers.worm[tier]
    if not tierData then return nil end
    
    local wormName = "5d-normal-worm-t" .. tier
    local corpseName = wormName .. "-corpse"
    local corpseNameBurrowed = wormName .. "-corpse-burrowed"
    
    local scale = tierData.scale
    local tint = getWormTint(tier)
    local sizeCategory = getSizeCategory(tier)
    local streamName = getStreamName(tier)
    
    -- Collision box scales with tier
    local collisionWidth = 0.9 + (tier * 0.06)
    local collisionHeight = 0.8 + (tier * 0.05)
    
    -- Selection box larger than collision for easier clicking
    local selectionScale = 1.2 + (tier * 0.15)  -- Selection is larger
    
    -- Basic resistances that scale with tier
    local resistances = {}
    if tier >= 4 then
        table.insert(resistances, {type = "physical", decrease = math.floor(tier / 2)})
    end
    if tier >= 5 then
        table.insert(resistances, {type = "explosion", decrease = math.floor(tier / 2), percent = tier * 3})
    end
    if tier >= 6 then
        table.insert(resistances, {type = "fire", decrease = math.floor(tier / 3), percent = tier * 7})
    end
    if tier >= 7 then
        table.insert(resistances, {type = "laser", percent = tier * 5})
    end
    
    -- Get size category for sounds
    local iconSize = sizeCategory
    
    -- Create the worm turret
    local worm = {
        type = "turret",
        name = wormName,
        icon = "__base__/graphics/icons/" .. iconSize .. "-worm.png",
        flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
        order = "b-c-" .. string.char(96 + tier),
        subgroup = "enemies",
        max_health = tierData.health,
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
        dying_explosion = iconSize .. "-worm-die",
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
            damage_modifier = tierData.damage,
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
        autoplace = enemy_autoplace.enemy_worm_autoplace("enemy_autoplace_base(" .. tier .. ", " .. math.floor(tier / 2 + 1) .. ")"),
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
    
    -- Create corpse
    local corpse = {
        type = "corpse",
        name = corpseName,
        icon = "__base__/graphics/icons/" .. iconSize .. "-worm-corpse.png",
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
        icon = "__base__/graphics/icons/" .. iconSize .. "-worm-corpse.png",
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
-- GENERATE ALL NORMAL WORMS (T1-T10)
-- =============================================================================

local entitiesToCreate = {}

for tier = 1, Tiers.COUNT do
    local worm, corpse, corpseBurrowed = generateNormalWorm(tier)
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

-- =============================================================================
-- DISABLE VANILLA WORM AUTOPLACE
-- =============================================================================
-- Remove autoplace from vanilla worms so only tiered worms spawn naturally

if data.raw["turret"]["small-worm-turret"] then
    data.raw["turret"]["small-worm-turret"].autoplace = nil
end
if data.raw["turret"]["medium-worm-turret"] then
    data.raw["turret"]["medium-worm-turret"].autoplace = nil
end
if data.raw["turret"]["big-worm-turret"] then
    data.raw["turret"]["big-worm-turret"].autoplace = nil
end
if data.raw["turret"]["behemoth-worm-turret"] then
    data.raw["turret"]["behemoth-worm-turret"].autoplace = nil
end
