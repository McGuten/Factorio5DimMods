-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Flare Turret Generation
-- Turret that fires flares creating decoy targets to distract enemies
-- Uses gun-turret graphics as base with yellow tint
-------------------------------------------------------------------------------

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local TierColors = require("__5dim_core__.lib.tier-colors")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")
local RepairSpeedScaling = require("__5dim_core__.lib.repair-speed-scaling")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (300 → 1500)
-------------------------------------------------------------------------------

local baseName = "5d-flare-turret"
local baseRange = 35
local baseHealth = 300
local baseCooldown = 90  -- ticks between shots (1.5 seconds)
local rangeIncrement = 3
local healthIncrement = 133               -- 300 → 1500 (x5)
local baseTechCount = 200

-- Type color: Flare = Yellow/Orange
local typeColor = { r = 1.0, g = 0.8, b = 0.2, a = 1 }

-------------------------------------------------------------------------------
-- AMMO CATEGORY
-------------------------------------------------------------------------------

data:extend({
    {
        type = "ammo-category",
        name = "5d-flare-rounds",
        icon = "__base__/graphics/icons/grenade.png",
        icon_size = 64,
        subgroup = "ammo-category"
    }
})

-------------------------------------------------------------------------------
-- DECOY ENTITY (uses smoke with tint to simulate flare)
-- Note: This is a visual decoy, biters will target nearby structures
-------------------------------------------------------------------------------

data:extend({
    {
        type = "smoke-with-trigger",
        name = "5d-flare-decoy",
        icon = "__base__/graphics/icons/small-lamp.png",
        icon_size = 64,
        flags = { "not-on-map" },
        show_when_smoke_off = true,
        animation = {
            filename = "__base__/graphics/entity/small-lamp/lamp-light.png",
            priority = "high",
            width = 90,
            height = 78,
            frame_count = 1,
            animation_speed = 0.5,
            shift = { 0, -0.21875 },
            scale = 0.8,
            tint = { r = 1.0, g = 0.8, b = 0.2, a = 0.9 }
        },
        movement_slow_down_factor = 0,
        affected_by_wind = false,
        cyclic = true,
        duration = 60 * 10,  -- 10 seconds
        spread_duration = 0,
        color = { r = 1.0, g = 0.8, b = 0.2, a = 0.7 }
    }
})

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a" },
    [2]  = { order = "b" },
    [3]  = { order = "c" },
    [4]  = { order = "d" },
    [5]  = { order = "e" },
    [6]  = { order = "f" },
    [7]  = { order = "g" },
    [8]  = { order = "h" },
    [9]  = { order = "i" },
    [10] = { order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [1] = {
        techName = "5d-flare-turret-1",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "military-science-pack" }
    },
    [2] = {
        techName = "5d-flare-turret-2",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-flare-turret-1" }
    },
    [3] = {
        techName = "5d-flare-turret-3",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-flare-turret-2" }
    },
    [4] = {
        techName = "5d-flare-turret-4",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-flare-turret-3", "chemical-science-pack" }
    },
    [5] = {
        techName = "5d-flare-turret-5",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-flare-turret-4" }
    },
    [6] = {
        techName = "5d-flare-turret-6",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-flare-turret-5", "utility-science-pack" }
    },
    [7] = {
        techName = "5d-flare-turret-7",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-flare-turret-6" }
    },
    [8] = {
        techName = "5d-flare-turret-8",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-flare-turret-7" }
    },
    [9] = {
        techName = "5d-flare-turret-9",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-flare-turret-8", "space-science-pack" }
    },
    [10] = {
        techName = "5d-flare-turret-10",
        countMultiplier = 10,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-flare-turret-9" }
    }
}

-------------------------------------------------------------------------------
-- FLARE ROUNDS AMMO
-------------------------------------------------------------------------------

-- Flare projectile
data:extend({
    {
        type = "projectile",
        name = "5d-flare-projectile",
        flags = { "not-on-map" },
        acceleration = 0,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-smoke",
                        entity_name = "5d-flare-decoy",
                        show_in_tooltip = true,
                        initial_height = 0
                    },
                    {
                        type = "create-entity",
                        entity_name = "medium-explosion"
                    }
                }
            }
        },
        animation = {
            filename = "__base__/graphics/entity/bullet/bullet.png",
            draw_as_glow = true,
            priority = "high",
            width = 3,
            height = 50,
            frame_count = 1,
            tint = { r = 1.0, g = 0.8, b = 0.2, a = 1 }
        },
        light = { intensity = 0.8, size = 8, color = { r = 1.0, g = 0.8, b = 0.4 } }
    },
    {
        type = "ammo",
        name = "5d-flare-rounds",
        icon = "__base__/graphics/icons/grenade.png",
        icon_size = 64,
        ammo_category = "5d-flare-rounds",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = "5d-flare-projectile",
                    starting_speed = 0.8
                }
            }
        },
        magazine_size = 5,
        subgroup = "defense-ammo",
        order = "b[special-ammo]-c[flare-rounds]",
        stack_size = 100
    }
})

-- Recipe for flare rounds
data:extend({
    {
        type = "recipe",
        name = "5d-flare-rounds",
        enabled = false,
        energy_required = 2,
        ingredients = {
            { type = "item", name = "iron-plate", amount = 2 },
            { type = "item", name = "coal", amount = 3 },
            { type = "item", name = "copper-plate", amount = 1 }
        },
        results = { { type = "item", name = "5d-flare-rounds", amount = 1 } }
    }
})

-------------------------------------------------------------------------------
-- GENERATION
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local entityName = baseName .. "-" .. tier
    local tierColor = TierColors[tier]
    local order = tierConfig[tier].order
    local itemIcons = TierBadgeIcons.buildTieredIconsFromIcons({
        { icon = "__base__/graphics/icons/gun-turret.png", icon_size = 64, tint = tierColor },
        { icon = "__base__/graphics/icons/small-lamp.png", icon_size = 64, scale = 0.3, shift = {10, -10} }
    }, tier)
    local techIcons = TierBadgeIcons.buildTieredIconsFromIcons({
        { icon = "__base__/graphics/technology/gun-turret.png", icon_size = 256 },
        { icon = "__base__/graphics/icons/small-lamp.png", icon_size = 64, scale = 0.3, shift = {10, -10} }
    }, tier)
    
    -- Calculate tier values
    local range = baseRange + (tier - 1) * rangeIncrement
    local health = baseHealth + (tier - 1) * healthIncrement
    local cooldown = math.max(45, baseCooldown - (tier - 1) * 4)
    
    -- Combined tint (type color + tier color)
    local tint = {
        r = (typeColor.r + tierColor.r) / 2,
        g = (typeColor.g + tierColor.g) / 2,
        b = (typeColor.b + tierColor.b) / 2,
        a = 1
    }
    
    -- Entity
    local entity = {
        type = "ammo-turret",
        name = entityName,
        icons = table.deepcopy(itemIcons),
        flags = { "placeable-player", "player-creation" },
        minable = { mining_time = 0.5, result = entityName },
        max_health = health,
        repair_speed_modifier = RepairSpeedScaling.linear(baseHealth, health),
        corpse = "gun-turret-remnants",
        collision_box = {{ -0.7, -0.7 }, { 0.7, 0.7 }},
        selection_box = {{ -1, -1 }, { 1, 1 }},
        rotation_speed = 0.015,
        preparing_speed = 0.08,
        folding_speed = 0.08,
        dying_explosion = "gun-turret-explosion",
        inventory_size = 1,
        automated_ammo_count = 10,
        attacking_speed = 0.5,
        folded_animation = {
            layers = {
                {
                    filename = "__base__/graphics/entity/gun-turret/gun-turret-raising.png",
                    priority = "medium",
                    width = 130,
                    height = 126,
                    direction_count = 4,
                    frame_count = 1,
                    line_length = 1,
                    run_mode = "forward",
                    shift = { 0, -0.828125 },
                    scale = 0.5
                },
                {
                    filename = "__base__/graphics/entity/gun-turret/gun-turret-raising-mask.png",
                    flags = { "mask" },
                    width = 48,
                    height = 62,
                    direction_count = 4,
                    frame_count = 1,
                    line_length = 1,
                    run_mode = "forward",
                    shift = { 0, -0.875 },
                    apply_runtime_tint = true,
                    tint = tint,
                    scale = 0.5
                },
                {
                    filename = "__base__/graphics/entity/gun-turret/gun-turret-raising-shadow.png",
                    width = 250,
                    height = 124,
                    direction_count = 4,
                    frame_count = 1,
                    line_length = 1,
                    run_mode = "forward",
                    shift = { 0.59375, 0.078125 },
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        preparing_animation = {
            layers = {
                {
                    filename = "__base__/graphics/entity/gun-turret/gun-turret-raising.png",
                    priority = "medium",
                    width = 130,
                    height = 126,
                    direction_count = 4,
                    frame_count = 5,
                    line_length = 0,
                    run_mode = "forward",
                    shift = { 0, -0.828125 },
                    scale = 0.5
                },
                {
                    filename = "__base__/graphics/entity/gun-turret/gun-turret-raising-mask.png",
                    flags = { "mask" },
                    width = 48,
                    height = 62,
                    direction_count = 4,
                    frame_count = 5,
                    line_length = 0,
                    run_mode = "forward",
                    shift = { 0, -0.875 },
                    apply_runtime_tint = true,
                    tint = tint,
                    scale = 0.5
                },
                {
                    filename = "__base__/graphics/entity/gun-turret/gun-turret-raising-shadow.png",
                    width = 250,
                    height = 124,
                    direction_count = 4,
                    frame_count = 5,
                    line_length = 0,
                    run_mode = "forward",
                    shift = { 0.59375, 0.078125 },
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        prepared_animation = {
            layers = {
                {
                    width = 132,
                    height = 130,
                    frame_count = 1,
                    direction_count = 64,
                    shift = { 0, -0.859375 },
                    stripes = {
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-1.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-2.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-3.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-4.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        }
                    },
                    scale = 0.5
                },
                {
                    flags = { "mask" },
                    width = 58,
                    height = 54,
                    frame_count = 1,
                    direction_count = 64,
                    shift = { 0, -1.015625 },
                    apply_runtime_tint = true,
                    tint = tint,
                    stripes = {
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-1.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-2.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-3.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-4.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        }
                    },
                    scale = 0.5
                }
            }
        },
        attack_parameters = {
            type = "projectile",
            ammo_categories = { "5d-flare-rounds" },
            cooldown = cooldown,
            range = range,
            projectile_creation_distance = 1.39375,
            projectile_center = { 0, -0.0875 },
            sound = {
                filename = "__base__/sound/fight/rocket-launcher.ogg",
                volume = 0.4
            }
        },
        call_for_help_radius = 40,
        graphics_set = {
            base_visualisation = {
                animation = {
                    layers = {
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-base.png",
                            priority = "high",
                            width = 150,
                            height = 118,
                            shift = { 0.015625, -0.03125 },
                            scale = 0.5
                        },
                        {
                            filename = "__base__/graphics/entity/gun-turret/gun-turret-base-mask.png",
                            flags = { "mask", "low-object" },
                            width = 122,
                            height = 102,
                            shift = { 0, -0.140625 },
                            tint = tint,
                            scale = 0.5
                        }
                    }
                }
            }
        }
    }
    
    -- Item
    local item = {
        type = "item",
        name = entityName,
        icons = table.deepcopy(itemIcons),
        subgroup = "defense-flare-turret",
        order = order .. "[" .. entityName .. "]",
        place_result = entityName,
        stack_size = 50
    }
    
    -- Recipe
    local recipe = {
        type = "recipe",
        name = entityName,
        enabled = false,
        energy_required = 8 + tier * 2,
        ingredients = RecipeTemplates.flareTurret[tier],
        results = { { type = "item", name = entityName, amount = 1 } },
        icons = table.deepcopy(itemIcons)
    }
    
    -- Technology
    local tech = nil
    if techConfig[tier] then
        local tc = techConfig[tier]
        local effects = {
            {
                type = "unlock-recipe",
                recipe = entityName
            }
        }
        
        -- First tier also unlocks flare rounds recipe
        if tier == 1 then
            table.insert(effects, {
                type = "unlock-recipe",
                recipe = "5d-flare-rounds"
            })
        end
        
        tech = {
            type = "technology",
            name = tc.techName,
            icons = table.deepcopy(techIcons),
            effects = effects,
            unit = {
                count = baseTechCount * tc.countMultiplier,
                ingredients = tc.basePacks,
                time = 30
            },
            prerequisites = tc.prerequisites
        }
    end
    
    -- Extend data
    data:extend({ entity, item, recipe })
    if tech then
        data:extend({ tech })
    end
end
