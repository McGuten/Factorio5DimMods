-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Decoy Structure Generation
-- Creates tiered decoy structures to attract enemy fire
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")
local RepairSpeedScaling = require("__5dim_core__.lib.repair-speed-scaling")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (200 → 1000)
-------------------------------------------------------------------------------

local baseHealth = 200
local healthIncrement = 89                -- 200 → 1000 (x5)
local baseTechCount = 100

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
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "military-2" }
    },
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-1" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-9" }
    }
}

-------------------------------------------------------------------------------
-- SUBGROUP (defined in 5dim_core: defense-decoy)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier, config in pairs(tierConfig) do
    local tierTech = techConfig[tier]
    local health = baseHealth + (tier - 1) * healthIncrement
    local tierColor = tierColors[tier]
    
    local name = "5d-decoy-" .. tier
    
    -- Copy wall graphics
    local wallItem = data.raw.item["stone-wall"]
    
    -- Item
    local item = {
        type = "item",
        name = name,
        icon = "__base__/graphics/icons/wall.png",
        icon_size = 64,
        subgroup = "defense-decoy",
        order = config.order,
        place_result = name,
        stack_size = 100
    }
    
    -- Recipe
    local recipe = {
        type = "recipe",
        name = name,
        enabled = false,
        ingredients = {},
        results = { { type = "item", name = name, amount = 1 } }
    }
    
    if tier == 1 then
        recipe.ingredients = {
            { type = "item", name = "stone-wall", amount = 2 },
            { type = "item", name = "iron-plate", amount = 5 },
            { type = "item", name = "electronic-circuit", amount = 2 }
        }
    else
        recipe.ingredients = {
            { type = "item", name = "5d-decoy-" .. (tier - 1), amount = 1 },
            { type = "item", name = "steel-plate", amount = 2 },
            { type = "item", name = "electronic-circuit", amount = 2 }
        }
    end
    
    -- Entity (simple-entity-with-owner for military target)
    local entity = {
        type = "simple-entity-with-owner",
        name = name,
        icon = "__base__/graphics/icons/wall.png",
        icon_size = 64,
        flags = { "placeable-neutral", "placeable-player", "player-creation" },
        minable = { mining_time = 0.2, result = name },
        max_health = health,
        repair_speed_modifier = RepairSpeedScaling.conservative(baseHealth, health),
        dying_explosion = "wall-explosion",
        is_military_target = true,
        allow_run_time_change_of_is_military_target = false,
        collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } },
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
        render_layer = "lower-object",
        picture = {
            filename = "__base__/graphics/entity/wall/wall-single.png",
            priority = "extra-high",
            width = 64,
            height = 86,
            shift = util.by_pixel(0, -5),
            scale = 0.5
        },
        resistances = {
            {
                type = "physical",
                decrease = 3 + tier,
                percent = 20 + tier * 2
            },
            {
                type = "impact",
                decrease = 45 + tier * 5,
                percent = 60 + tier * 2
            },
            {
                type = "explosion",
                decrease = 10 + tier,
                percent = 30 + tier * 2
            },
            {
                type = "fire",
                percent = 100
            },
            {
                type = "acid",
                percent = 80
            },
            {
                type = "laser",
                percent = 70 + tier
            }
        }
    }
    
    data:extend({ entity, recipe, item })
    
    -- Technology
    if tierTech then
        local tech = {
            type = "technology",
            name = "5d-decoy-" .. tier,
            icon = "__base__/graphics/icons/wall.png",
            icon_size = 64,
            unit = {
                count = baseTechCount * tier,
                ingredients = tierTech.basePacks,
                time = 30
            },
            prerequisites = tierTech.prerequisites,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = name
                }
            }
        }
        data:extend({ tech })
    end
end
