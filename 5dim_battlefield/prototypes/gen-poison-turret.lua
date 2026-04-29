-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Poison Turret Generation
-- Turret that fires poison rounds creating toxic clouds
-- Uses gun-turret graphics as base with green tint
-------------------------------------------------------------------------------

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local TierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (400 → 2000), Damage +45% by T10
-------------------------------------------------------------------------------

local baseName = "5d-poison-turret"
local baseRange = 24
local baseHealth = 400
local baseCooldown = 45  -- ticks between shots
local rangeIncrement = 2
local healthIncrement = 178               -- 400 → 2000 (x5)
local damageScalePerTier = 0.05
local baseTechCount = 200

-- Type color: Poison = Green
local typeColor = { r = 0.2, g = 0.8, b = 0.2, a = 1 }

-------------------------------------------------------------------------------
-- AMMO CATEGORY
-------------------------------------------------------------------------------

data:extend({
    {
        type = "ammo-category",
        name = "5d-poison-rounds",
        icon = "__base__/graphics/icons/poison-capsule.png",
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
        techName = "5d-poison-turret-1",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "military-science-pack" }
    },
    [2] = {
        techName = "5d-poison-turret-2",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-poison-turret-1" }
    },
    [3] = {
        techName = "5d-poison-turret-3",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-poison-turret-2" }
    },
    [4] = {
        techName = "5d-poison-turret-4",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-poison-turret-3", "chemical-science-pack" }
    },
    [5] = {
        techName = "5d-poison-turret-5",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-poison-turret-4" }
    },
    [6] = {
        techName = "5d-poison-turret-6",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-poison-turret-5", "utility-science-pack" }
    },
    [7] = {
        techName = "5d-poison-turret-7",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-poison-turret-6" }
    },
    [8] = {
        techName = "5d-poison-turret-8",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-poison-turret-7" }
    },
    [9] = {
        techName = "5d-poison-turret-9",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-poison-turret-8", "space-science-pack" }
    },
    [10] = {
        techName = "5d-poison-turret-10",
        countMultiplier = 10,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-poison-turret-9" }
    }
}

-------------------------------------------------------------------------------
-- POISON ROUNDS AMMO
-------------------------------------------------------------------------------

-- Poison round projectile
data:extend({
    {
        type = "projectile",
        name = "5d-poison-round-projectile",
        flags = { "not-on-map" },
        acceleration = 0,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        damage = { amount = 15, type = "poison" }
                    },
                    {
                        type = "create-smoke",
                        show_in_tooltip = true,
                        entity_name = "poison-cloud",
                        initial_height = 0
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
            tint = { r = 0.2, g = 1, b = 0.2, a = 1 }
        }
    },
    {
        type = "ammo",
        name = "5d-poison-rounds",
        icon = "__base__/graphics/icons/poison-capsule.png",
        icon_size = 64,
        ammo_category = "5d-poison-rounds",
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = "5d-poison-round-projectile",
                    starting_speed = 1
                }
            }
        },
        magazine_size = 10,
        subgroup = "defense-ammo",
        order = "b[special-ammo]-a[poison-rounds]",
        stack_size = 200
    }
})

-- Recipe for poison rounds
data:extend({
    {
        type = "recipe",
        name = "5d-poison-rounds",
        enabled = false,
        energy_required = 3,
        ingredients = {
            { type = "item", name = "firearm-magazine", amount = 1 },
            { type = "item", name = "coal", amount = 5 },
            { type = "item", name = "copper-plate", amount = 2 }
        },
        results = { { type = "item", name = "5d-poison-rounds", amount = 1 } }
    }
})

-------------------------------------------------------------------------------
-- GENERATION
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local entityName = baseName .. "-" .. tier
    local tierColor = TierColors[tier]
    local order = tierConfig[tier].order
    
    -- Calculate tier values
    local range = baseRange + (tier - 1) * rangeIncrement
    local health = baseHealth + (tier - 1) * healthIncrement
    local cooldown = math.max(20, baseCooldown - (tier - 1) * 2)
    local damageModifier = 1 + (tier - 1) * damageScalePerTier
    
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
        icon = "__base__/graphics/icons/gun-turret.png",
        icon_size = 64,
        flags = { "placeable-player", "player-creation" },
        minable = { mining_time = 0.5, result = entityName },
        max_health = health,
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
            ammo_categories = { "5d-poison-rounds" },
            cooldown = cooldown,
            damage_modifier = damageModifier,
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
        icons = {
            { icon = "__base__/graphics/icons/gun-turret.png", icon_size = 64, tint = tierColor },
            { icon = "__base__/graphics/icons/poison-capsule.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        subgroup = "defense-poison-turret",
        order = order .. "[" .. entityName .. "]",
        place_result = entityName,
        stack_size = 50
    }
    
    -- Recipe
    local ingredients = {}
    for _, ing in ipairs(RecipeTemplates.gunTurret[tier]) do
        table.insert(ingredients, { type = ing.type, name = ing.name, amount = ing.amount })
    end
    -- Add coal (for poison effect)
    table.insert(ingredients, { type = "item", name = "coal", amount = 5 + tier * 2 })
    
    local recipe = {
        type = "recipe",
        name = entityName,
        enabled = false,
        energy_required = 10 + tier * 2,
        ingredients = ingredients,
        results = { { type = "item", name = entityName, amount = 1 } }
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
        
        -- First tier also unlocks poison rounds recipe
        if tier == 1 then
            table.insert(effects, {
                type = "unlock-recipe",
                recipe = "5d-poison-rounds"
            })
        end
        
        tech = {
            type = "technology",
            name = tc.techName,
            icon = "__base__/graphics/technology/gun-turret.png",
            icon_size = 256,
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
