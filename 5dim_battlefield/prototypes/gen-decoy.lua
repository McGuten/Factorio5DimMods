-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Decoy Structure Generation
-- Creates tiered decoy structures to attract enemy fire
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")
local RepairSpeedScaling = require("__5dim_core__.lib.repair-speed-scaling")
local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")

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
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-decoy-9" }
    }
}

local decoyMaterials = {
    [2] = { type = "item", name = "steel-plate", amount = 2 },
    [3] = { type = "item", name = "pipe-to-ground", amount = 1 },
    [4] = { type = "item", name = "sulfur", amount = 2 },
    [5] = { type = "item", name = "plastic-bar", amount = 2 },
    [6] = { type = "fluid", name = "sulfuric-acid", amount = 20 },
    [7] = { type = "item", name = "explosives", amount = 2 },
    [8] = { type = "item", name = "battery", amount = 2 },
    [9] = { type = "item", name = "processing-unit", amount = 1 },
    [10] = { type = "item", name = "low-density-structure", amount = 1 }
}

local decoySpaceAgeMaterials = {
    [6] = { name = "calcite", amount = 6, category = "metallurgy" },
    [7] = { name = "jelly", amount = 8, category = "organic" },
    [8] = { type = "fluid", name = "holmium-solution", amount = 60, category = "chemistry" },
    [9] = { name = "supercapacitor", amount = 2, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 60, category = "cryogenics" }
}

local decoySpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "agricultural-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local decoySpaceAgePrerequisites = {
    [6] = "foundry",
    [7] = "bioflux",
    [8] = "holmium-processing",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local function getDecoyDeltaMaterial(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and decoySpaceAgeMaterials[tier] then
        local override = decoySpaceAgeMaterials[tier]
        return {
            type = override.type or "item",
            name = override.name,
            amount = override.amount
        }
    end

    return decoyMaterials[tier]
end

local function getDecoyRecipeCategory(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and decoySpaceAgeMaterials[tier] then
        return decoySpaceAgeMaterials[tier].category
    end

    local material = decoyMaterials[tier]
    if material and material.type == "fluid" then
        return "crafting-with-fluid"
    end
end

local function getDecoyIngredients(tier)
    if tier == 1 then
        return {
            { type = "item", name = "stone-wall", amount = 2 },
            { type = "item", name = "iron-plate", amount = 5 },
            { type = "item", name = "electronic-circuit", amount = 2 }
        }
    end

    return {
        { type = "item", name = "5d-decoy-" .. (tier - 1), amount = 1 },
        getDecoyDeltaMaterial(tier)
    }
end

local function copyPrerequisites(values)
    local result = {}

    for _, value in ipairs(values) do
        table.insert(result, value)
    end

    return result
end

local function getDecoyPrerequisites(tier, basePrerequisites)
    local prerequisites = copyPrerequisites(basePrerequisites)

    if CostConfig.shouldUseSpaceAgeMaterials() and decoySpaceAgePrerequisites[tier] then
        table.insert(prerequisites, decoySpaceAgePrerequisites[tier])
    end

    return prerequisites
end

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
        ingredients = getDecoyIngredients(tier),
        results = { { type = "item", name = name, amount = 1 } }
    }
    recipe.category = getDecoyRecipeCategory(tier)
    
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
                ingredients = CostCalculator.getTechPacks(tierTech.basePacks, tier, {
                    spaceAgePackOverrides = decoySpaceAgeSciencePacks,
                    forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
                }),
                time = 30
            },
            prerequisites = getDecoyPrerequisites(tier, tierTech.prerequisites),
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
