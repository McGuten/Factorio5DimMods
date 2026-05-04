-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Mortar Turret Generation
-- Rocket-style turret with mortar shells (arc trajectory, area damage)
-- Uses rocket-turret graphics from Space Age if available, else gun-turret
-------------------------------------------------------------------------------

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local TierColors = require("__5dim_core__.lib.tier-colors")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")
local RepairSpeedScaling = require("__5dim_core__.lib.repair-speed-scaling")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (600 → 3000), Damage +45% by T10
-------------------------------------------------------------------------------

local baseName = "5d-mortar-turret"
local baseRange = 36
local baseMinRange = 15
local baseHealth = 600
local baseCooldown = 120  -- ticks between shots (2 seconds)
local rangeIncrement = 3
local healthIncrement = 267               -- 600 → 3000 (x5)
local damageScalePerTier = 0.05
local baseTechCount = 200

-- Type color: Mortar = Brown/Orange
local typeColor = { r = 0.7, g = 0.4, b = 0.2, a = 1 }

-- Check if Space Age is available
local hasSpaceAge = mods["space-age"] ~= nil

-------------------------------------------------------------------------------
-- AMMO CATEGORY
-------------------------------------------------------------------------------

data:extend({
    {
        type = "ammo-category",
        name = "5d-mortar-shell",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        subgroup = "ammo-category"
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
        techName = "5d-mortar-turret-1",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "military-science-pack" }
    },
    [2] = {
        techName = "5d-mortar-turret-2",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-mortar-turret-1" }
    },
    [3] = {
        techName = "5d-mortar-turret-3",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-mortar-turret-2" }
    },
    [4] = {
        techName = "5d-mortar-turret-4",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-mortar-turret-3", "chemical-science-pack" }
    },
    [5] = {
        techName = "5d-mortar-turret-5",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-mortar-turret-4" }
    },
    [6] = {
        techName = "5d-mortar-turret-6",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-mortar-turret-5", "utility-science-pack" }
    },
    [7] = {
        techName = "5d-mortar-turret-7",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-mortar-turret-6" }
    },
    [8] = {
        techName = "5d-mortar-turret-8",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-mortar-turret-7" }
    },
    [9] = {
        techName = "5d-mortar-turret-9",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-mortar-turret-8", "space-science-pack" }
    },
    [10] = {
        techName = "5d-mortar-turret-10",
        countMultiplier = 10,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-mortar-turret-9" }
    }
}

-------------------------------------------------------------------------------
-- MORTAR SHELL AMMO (Single type for all tiers)
-------------------------------------------------------------------------------

-- Mortar shell projectile
data:extend({
    {
        type = "projectile",
        name = "5d-mortar-shell-projectile",
        flags = { "not-on-map" },
        acceleration = 0,
        height = 3,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "big-explosion"
                    },
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            radius = 4,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    {
                                        type = "damage",
                                        damage = { amount = 100, type = "explosion" }
                                    },
                                    {
                                        type = "damage",
                                        damage = { amount = 50, type = "physical" }
                                    }
                                }
                            }
                        }
                    },
                    {
                        type = "create-entity",
                        entity_name = "small-scorchmark",
                        check_buildability = true
                    }
                }
            }
        },
        animation = {
            filename = "__base__/graphics/entity/rocket/rocket.png",
            priority = "high",
            width = 20,
            height = 60,
            frame_count = 1,
            shift = { 0.015625, -0.25 }
        }
    },
    {
        type = "ammo",
        name = "5d-mortar-shell",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        ammo_category = "5d-mortar-shell",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = "5d-mortar-shell-projectile",
                    starting_speed = 0.5,
                    max_range = 80
                }
            }
        },
        subgroup = "defense-ammo",
        order = "b[special-ammo]-d[mortar-shell]",
        stack_size = 50
    }
})

-- Recipe for mortar shell
data:extend({
    {
        type = "recipe",
        name = "5d-mortar-shell",
        enabled = false,
        energy_required = 4,
        ingredients = {
            { type = "item", name = "explosives", amount = 3 },
            { type = "item", name = "iron-plate", amount = 2 },
            { type = "item", name = "steel-plate", amount = 1 }
        },
        results = { { type = "item", name = "5d-mortar-shell", amount = 1 } }
    }
})

-------------------------------------------------------------------------------
-- GRAPHICS HELPER FUNCTIONS
-------------------------------------------------------------------------------

local util = require("util")
local rocket_turret_shift = -20

-- Space Age rocket-turret rising animation (uses util.sprite_load for multi-file sprites)
local function rocket_turret_rising_sa(tint, run_mode)
    return {
        layers = {
            util.sprite_load("__space-age__/graphics/entity/rocket-turret/rocket-turret-rising", {
                priority = "medium",
                direction_count = 4,
                shift = util.by_pixel(0, 0 + rocket_turret_shift),
                scale = 0.5,
                frame_count = 18,
                line_length = 18,
                run_mode = run_mode or "forward"
            }),
            util.sprite_load("__space-age__/graphics/entity/rocket-turret/rocket-turret-rising-mask", {
                flags = { "mask" },
                direction_count = 4,
                shift = util.by_pixel(0, 0 + rocket_turret_shift),
                scale = 0.5,
                frame_count = 18,
                line_length = 18,
                apply_runtime_tint = true,
                tint = tint,
                run_mode = run_mode or "forward"
            }),
            util.sprite_load("__space-age__/graphics/entity/rocket-turret/rocket-turret-rising-shadow", {
                direction_count = 4,
                shift = util.by_pixel(0, 0 + rocket_turret_shift),
                scale = 0.5,
                frame_count = 18,
                line_length = 18,
                draw_as_shadow = true,
                run_mode = run_mode or "forward"
            })
        }
    }
end

-- Space Age rocket-turret shooting animation
local function rocket_turret_attack_sa(tint)
    return {
        layers = {
            util.sprite_load("__space-age__/graphics/entity/rocket-turret/rocket-turret-shooting", {
                slice = 1,
                direction_count = 64,
                shift = util.by_pixel(0, 0 + rocket_turret_shift),
                scale = 0.5
            }),
            util.sprite_load("__space-age__/graphics/entity/rocket-turret/rocket-turret-shooting-mask", {
                flags = { "mask" },
                apply_runtime_tint = true,
                tint = tint,
                slice = 1,
                direction_count = 64,
                shift = util.by_pixel(0, 0 + rocket_turret_shift),
                scale = 0.5
            }),
            util.sprite_load("__space-age__/graphics/entity/rocket-turret/rocket-turret-shooting-shadow", {
                draw_as_shadow = true,
                slice = 1,
                direction_count = 64,
                shift = util.by_pixel(0, 0 + rocket_turret_shift),
                scale = 0.5
            })
        }
    }
end

-- Space Age rocket-turret base graphics
local function rocket_turret_base_sa(tint)
    return {
        animation = {
            layers = {
                util.sprite_load("__space-age__/graphics/entity/rocket-turret/rocket-turret-base", {
                    priority = "high",
                    shift = util.by_pixel(0, 0 + rocket_turret_shift),
                    scale = 0.5
                }),
                util.sprite_load("__space-age__/graphics/entity/rocket-turret/rocket-turret-base-mask", {
                    flags = { "mask", "low-object" },
                    apply_runtime_tint = true,
                    tint = tint,
                    shift = util.by_pixel(0, 0 + rocket_turret_shift),
                    scale = 0.5
                }),
                util.sprite_load("__space-age__/graphics/entity/rocket-turret/rocket-turret-base-shadow", {
                    draw_as_shadow = true,
                    shift = util.by_pixel(0, 0 + rocket_turret_shift),
                    scale = 0.5
                })
            }
        }
    }
end

-- Gun turret animations (fallback)
local function gun_turret_folded(tint)
    return {
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
    }
end

local function gun_turret_preparing(tint)
    return {
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
    }
end

local function gun_turret_prepared(tint)
    return {
        layers = {
            {
                width = 132,
                height = 130,
                frame_count = 1,
                direction_count = 64,
                shift = { 0, -0.859375 },
                stripes = {
                    { filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-1.png", width_in_frames = 1, height_in_frames = 16 },
                    { filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-2.png", width_in_frames = 1, height_in_frames = 16 },
                    { filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-3.png", width_in_frames = 1, height_in_frames = 16 },
                    { filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-4.png", width_in_frames = 1, height_in_frames = 16 }
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
                    { filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-1.png", width_in_frames = 1, height_in_frames = 16 },
                    { filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-2.png", width_in_frames = 1, height_in_frames = 16 },
                    { filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-3.png", width_in_frames = 1, height_in_frames = 16 },
                    { filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-4.png", width_in_frames = 1, height_in_frames = 16 }
                },
                scale = 0.5
            }
        }
    }
end

-------------------------------------------------------------------------------
-- GENERATION
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local entityName = baseName .. "-" .. tier
    local tierColor = TierColors[tier]
    local order = tierConfig[tier].order
    local baseItemIcon = hasSpaceAge and "__space-age__/graphics/icons/rocket-turret.png" or "__base__/graphics/icons/gun-turret.png"
    local baseTechIcon = hasSpaceAge and "__space-age__/graphics/technology/rocket-turret.png" or "__base__/graphics/technology/gun-turret.png"
    local itemIcons = TierBadgeIcons.buildTieredIconsFromIcons({
        { icon = baseItemIcon, icon_size = 64, tint = tierColor },
        { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64, scale = 0.3, shift = {10, -10} }
    }, tier)
    local techIcons = TierBadgeIcons.buildTieredIconsFromIcons({
        { icon = baseTechIcon, icon_size = 256 },
        { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64, scale = 0.3, shift = {10, -10} }
    }, tier)
    
    -- Calculate tier values
    local range = baseRange + (tier - 1) * rangeIncrement
    local minRange = baseMinRange
    local health = baseHealth + (tier - 1) * healthIncrement
    local cooldown = math.max(60, baseCooldown - (tier - 1) * 6)  -- Faster at higher tiers
    local damageModifier = 1 + (tier - 1) * damageScalePerTier
    
    -- Combined tint (type color + tier color)
    local tint = {
        r = (typeColor.r + tierColor.r) / 2,
        g = (typeColor.g + tierColor.g) / 2,
        b = (typeColor.b + tierColor.b) / 2,
        a = 1
    }
    
    -- Entity (ammo-turret with mortar ammo)
    local entity
    
    if hasSpaceAge then
        -- Use Space Age rocket-turret graphics (3x3 size)
        entity = {
            type = "ammo-turret",
            name = entityName,
            icons = table.deepcopy(itemIcons),
            flags = { "placeable-player", "player-creation" },
            minable = { mining_time = 0.5, result = entityName },
            max_health = health,
            repair_speed_modifier = RepairSpeedScaling.linear(baseHealth, health),
            corpse = "rocket-turret-remnants",
            collision_box = {{ -1.2, -1.2 }, { 1.2, 1.2 }},
            selection_box = {{ -1.5, -1.5 }, { 1.5, 1.5 }},
            rotation_speed = 0.005,
            preparing_speed = 0.08,
            folding_speed = 0.08,
            dying_explosion = "gun-turret-explosion",
            inventory_size = 1,
            automated_ammo_count = 10,
            attacking_speed = 0.5,
            folded_animation = rocket_turret_rising_sa(tint),
            preparing_animation = rocket_turret_rising_sa(tint),
            prepared_animation = rocket_turret_attack_sa(tint),
            attacking_animation = rocket_turret_attack_sa(tint),
            folding_animation = rocket_turret_rising_sa(tint, "backward"),
            attack_parameters = {
                type = "projectile",
                ammo_categories = { "5d-mortar-shell" },
                cooldown = cooldown,
                range = range,
                min_range = minRange,
                damage_modifier = damageModifier,
                projectile_creation_distance = 1,
                projectile_center = { 0, 0 },
                projectile_creation_offsets = {
                    { 1.0625, -0.21875 },
                    { -1.0625, -0.21875 },
                    { 0.96875, -0.0625 },
                    { -0.96875, -0.0625 },
                    { 0.84375, 0.09375 },
                    { -0.84375, 0.09375 }
                },
                sound = {
                    filename = "__base__/sound/fight/rocket-launcher.ogg",
                    volume = 0.7
                }
            },
            call_for_help_radius = 40,
            graphics_set = {
                base_visualisation = rocket_turret_base_sa(tint)
            }
        }
    else
        -- Use gun-turret graphics (2x2 size) - fallback
        entity = {
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
            rotation_speed = 0.008,
            preparing_speed = 0.04,
            folding_speed = 0.04,
            dying_explosion = "gun-turret-explosion",
            inventory_size = 1,
            automated_ammo_count = 10,
            attacking_speed = 0.3,
            folded_animation = gun_turret_folded(tint),
            preparing_animation = gun_turret_preparing(tint),
            prepared_animation = gun_turret_prepared(tint),
            attack_parameters = {
                type = "projectile",
                ammo_categories = { "5d-mortar-shell" },
                cooldown = cooldown,
                range = range,
                min_range = minRange,
                damage_modifier = damageModifier,
                projectile_creation_distance = 1.39375,
                projectile_center = { 0, -0.0875 },
                sound = {
                    filename = "__base__/sound/fight/rocket-launcher.ogg",
                    volume = 0.7
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
    end
    
    -- Item
    local item = {
        type = "item",
        name = entityName,
        icons = table.deepcopy(itemIcons),
        subgroup = "defense-mortar-turret",
        order = order .. "[" .. entityName .. "]",
        place_result = entityName,
        stack_size = 50
    }
    
    -- Recipe
    local recipe = {
        type = "recipe",
        name = entityName,
        enabled = false,
        energy_required = 12 + tier * 2,
        ingredients = RecipeTemplates.mortarTurret[tier],
        results = { { type = "item", name = entityName, amount = 1 } },
        icons = table.deepcopy(itemIcons)
    }
    
    -- Technology (includes mortar shell recipe on tier 1)
    local tech = nil
    if techConfig[tier] then
        local tc = techConfig[tier]
        local effects = {
            {
                type = "unlock-recipe",
                recipe = entityName
            }
        }
        
        -- First tier also unlocks mortar shell recipe
        if tier == 1 then
            table.insert(effects, {
                type = "unlock-recipe",
                recipe = "5d-mortar-shell"
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
