-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Robot Deployer Turret Generation
-- Turret that deploys combat robots using special robot capsule ammo
-- Uses gun-turret graphics as base with cyan tint
-------------------------------------------------------------------------------

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local TierColors = require("__5dim_core__.lib.tier-colors")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")
local RepairSpeedScaling = require("__5dim_core__.lib.repair-speed-scaling")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (500 → 2500)
-------------------------------------------------------------------------------

local baseName = "5d-robot-deployer"
local baseRange = 30
local baseHealth = 500
local baseCooldown = 120  -- 2 seconds between deployments
local rangeIncrement = 3
local healthIncrement = 222               -- 500 → 2500 (x5)
local baseTechCount = 200

-- Type color: Robot = Cyan
local typeColor = { r = 0.2, g = 0.8, b = 0.9, a = 1 }

local defenderCapsuleAmmoIcons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/defender-capsule.png", 1, 64)
local distractorCapsuleAmmoIcons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/distractor-capsule.png", 1, 64)
local destroyerCapsuleAmmoIcons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/destroyer-capsule.png", 1, 64)

-------------------------------------------------------------------------------
-- AMMO CATEGORY FOR ROBOT DEPLOYER
-------------------------------------------------------------------------------

data:extend({
    {
        type = "ammo-category",
        name = "5d-robot-capsule",
        icon = "__base__/graphics/icons/defender-capsule.png",
        icon_size = 64,
        subgroup = "ammo-category"
    }
})

-------------------------------------------------------------------------------
-- ROBOT DEPLOYMENT PROJECTILES (create actual combat robots)
-------------------------------------------------------------------------------

data:extend({
    -- Defender deployment projectile
    {
        type = "projectile",
        name = "5d-deploy-defender-projectile",
        flags = { "not-on-map" },
        acceleration = 0,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "defender",
                        show_in_tooltip = true
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
            tint = { r = 0.2, g = 0.8, b = 1.0, a = 1 }
        }
    },
    -- Distractor deployment projectile
    {
        type = "projectile",
        name = "5d-deploy-distractor-projectile",
        flags = { "not-on-map" },
        acceleration = 0,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "distractor",
                        show_in_tooltip = true
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
            tint = { r = 0.8, g = 0.4, b = 1.0, a = 1 }
        }
    },
    -- Destroyer deployment projectile
    {
        type = "projectile",
        name = "5d-deploy-destroyer-projectile",
        flags = { "not-on-map" },
        acceleration = 0,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "destroyer",
                        show_in_tooltip = true
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
            tint = { r = 1.0, g = 0.2, b = 0.2, a = 1 }
        }
    }
})

-------------------------------------------------------------------------------
-- ROBOT CAPSULE AMMO (for robot deployer turret)
-------------------------------------------------------------------------------

data:extend({
    -- Defender capsule ammo
    {
        type = "ammo",
        name = "5d-defender-capsule-ammo",
        icons = table.deepcopy(defenderCapsuleAmmoIcons),
        ammo_category = "5d-robot-capsule",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = "5d-deploy-defender-projectile",
                    starting_speed = 0.5
                }
            }
        },
        magazine_size = 5,
        subgroup = "defense-ammo",
        order = "c[robot-capsule]-a[defender]",
        stack_size = 100
    },
    -- Distractor capsule ammo
    {
        type = "ammo",
        name = "5d-distractor-capsule-ammo",
        icons = table.deepcopy(distractorCapsuleAmmoIcons),
        ammo_category = "5d-robot-capsule",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = "5d-deploy-distractor-projectile",
                    starting_speed = 0.5
                }
            }
        },
        magazine_size = 3,
        subgroup = "defense-ammo",
        order = "c[robot-capsule]-b[distractor]",
        stack_size = 100
    },
    -- Destroyer capsule ammo
    {
        type = "ammo",
        name = "5d-destroyer-capsule-ammo",
        icons = table.deepcopy(destroyerCapsuleAmmoIcons),
        ammo_category = "5d-robot-capsule",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = "5d-deploy-destroyer-projectile",
                    starting_speed = 0.5
                }
            }
        },
        magazine_size = 1,
        subgroup = "defense-ammo",
        order = "c[robot-capsule]-c[destroyer]",
        stack_size = 100
    }
})

-------------------------------------------------------------------------------
-- RECIPES FOR ROBOT CAPSULE AMMO
-------------------------------------------------------------------------------

data:extend({
    {
        type = "recipe",
        name = "5d-defender-capsule-ammo",
        enabled = false,
        energy_required = 4,
        ingredients = {
            { type = "item", name = "defender-capsule", amount = 1 }
        },
        results = { { type = "item", name = "5d-defender-capsule-ammo", amount = 1 } },
        icons = table.deepcopy(defenderCapsuleAmmoIcons)
    },
    {
        type = "recipe",
        name = "5d-distractor-capsule-ammo",
        enabled = false,
        energy_required = 6,
        ingredients = {
            { type = "item", name = "distractor-capsule", amount = 1 }
        },
        results = { { type = "item", name = "5d-distractor-capsule-ammo", amount = 1 } },
        icons = table.deepcopy(distractorCapsuleAmmoIcons)
    },
    {
        type = "recipe",
        name = "5d-destroyer-capsule-ammo",
        enabled = false,
        energy_required = 8,
        ingredients = {
            { type = "item", name = "destroyer-capsule", amount = 1 }
        },
        results = { { type = "item", name = "5d-destroyer-capsule-ammo", amount = 1 } },
        icons = table.deepcopy(destroyerCapsuleAmmoIcons)
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
        techName = "5d-robot-deployer-1",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "military-science-pack", "defender" }
    },
    [2] = {
        techName = "5d-robot-deployer-2",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-robot-deployer-1" }
    },
    [3] = {
        techName = "5d-robot-deployer-3",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-robot-deployer-2" }
    },
    [4] = {
        techName = "5d-robot-deployer-4",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-robot-deployer-3", "chemical-science-pack" }
    },
    [5] = {
        techName = "5d-robot-deployer-5",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-robot-deployer-4" }
    },
    [6] = {
        techName = "5d-robot-deployer-6",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-robot-deployer-5", "utility-science-pack" }
    },
    [7] = {
        techName = "5d-robot-deployer-7",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-robot-deployer-6" }
    },
    [8] = {
        techName = "5d-robot-deployer-8",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-robot-deployer-7" }
    },
    [9] = {
        techName = "5d-robot-deployer-9",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-robot-deployer-8", "space-science-pack" }
    },
    [10] = {
        techName = "5d-robot-deployer-10",
        countMultiplier = 10,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-robot-deployer-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local entityName = baseName .. "-" .. tier
    local tierColor = TierColors[tier]
    local order = tierConfig[tier].order
    local itemIcons = TierBadgeIcons.buildTieredIconsFromIcons({
        { icon = "__base__/graphics/icons/gun-turret.png", icon_size = 64, tint = tierColor },
        { icon = "__base__/graphics/icons/defender.png", icon_size = 64, scale = 0.3, shift = {10, -10} }
    }, tier)
    local techIcons = TierBadgeIcons.buildTieredIconsFromIcons({
        { icon = "__base__/graphics/technology/gun-turret.png", icon_size = 256 },
        { icon = "__base__/graphics/icons/defender.png", icon_size = 64, scale = 0.3, shift = {10, -10} }
    }, tier)
    
    -- Calculate tier values
    local range = baseRange + (tier - 1) * rangeIncrement
    local health = baseHealth + (tier - 1) * healthIncrement
    local cooldown = math.max(60, baseCooldown - (tier - 1) * 5)
    
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
        repair_speed_modifier = RepairSpeedScaling.conservative(baseHealth, health),
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
            ammo_categories = { "5d-robot-capsule" },
            cooldown = cooldown,
            range = range,
            projectile_creation_distance = 1.39375,
            projectile_center = { 0, -0.0875 },
            sound = {
                filename = "__base__/sound/fight/gun-turret-gunshot-1.ogg",
                volume = 0.3
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
        subgroup = "defense-robot-deployer",
        order = order .. "[" .. entityName .. "]",
        place_result = entityName,
        stack_size = 50
    }
    
    -- Recipe
    local recipe = {
        type = "recipe",
        name = entityName,
        enabled = false,
        energy_required = 10 + tier * 2,
        ingredients = RecipeTemplates.robotDeployer[tier],
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
        
        -- First tier also unlocks robot capsule ammo recipes
        if tier == 1 then
            table.insert(effects, { type = "unlock-recipe", recipe = "5d-defender-capsule-ammo" })
            table.insert(effects, { type = "unlock-recipe", recipe = "5d-distractor-capsule-ammo" })
            table.insert(effects, { type = "unlock-recipe", recipe = "5d-destroyer-capsule-ammo" })
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
