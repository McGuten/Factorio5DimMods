-------------------------------------------------------------------------------
-- 5Dim's Trains - Fluid Wagon Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.trains.generation-fluid-wagon")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 1.5
local baseCargo = 25000
local baseWeight = 2000
local baseTechCount = 100

local fluidWagonSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 20, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-copper", amount = 200, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 20, category = "metallurgy" },
    [8] = { type = "fluid", name = "electrolyte", amount = 160, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 8, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 120, category = "cryogenics" }
}

local fluidWagonSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local fluidWagonSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "cryogenic-plant"
}

local fluidWagonDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "fluid-handling",
    [4] = "concrete",
    [5] = "engine",
    [6] = "lubricant",
    [7] = "electric-engine",
    [8] = "low-density-structure",
    [9] = "processing-unit",
    [10] = "speed-module-2"
}

local function copyPrerequisites(values)
    local result = {}

    for _, value in ipairs(values) do
        table.insert(result, value)
    end

    return result
end

local function addPrerequisiteIfMissing(prerequisites, prerequisite)
    if not prerequisite then
        return
    end

    for _, current in ipairs(prerequisites) do
        if current == prerequisite then
            return
        end
    end

    table.insert(prerequisites, prerequisite)
end

local function getFluidWagonDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and fluidWagonSpaceAgeDeltaPrerequisites[tier] then
        return fluidWagonSpaceAgeDeltaPrerequisites[tier]
    end

    return fluidWagonDeltaPrerequisites[tier]
end

local function getFluidWagonRecipeCategory(tier)
    local spaceAgeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, fluidWagonSpaceAgeMaterials)
    if spaceAgeCategory then
        return spaceAgeCategory
    end

    if tier == 6 then
        return "crafting-with-fluid"
    end

    return nil
end

-- Increments per tier
local speedIncrement = 0.17
local cargoIncrement = 25000
local weightIncrement = 500

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", isVanilla = true },
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
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "fluid-wagon", "logistic-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "fluid-wagon-2", "chemical-science-pack" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "fluid-wagon-3", "production-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "fluid-wagon-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "fluid-wagon-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fluid-wagon-6", "utility-science-pack" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fluid-wagon-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fluid-wagon-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fluid-wagon-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)

    -- Calculate stats for this tier
    local speed = baseSpeed + (tier - 1) * speedIncrement
    local cargo = baseCargo + (tier - 1) * cargoIncrement
    local weight = baseWeight + (tier - 1) * weightIncrement

    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.fluidWagon[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        spaceAgeMaterialOverrides = fluidWagonSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getFluidWagonDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = fluidWagonSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    -- Generate the fluid wagon
    genFluidWagons {
        number = tierNum,
        subgroup = "trains-liquids",
        maxSpeed = speed,
        cargo = cargo,
        weight = weight,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        tech = tech,
        recipeCategory = getFluidWagonRecipeCategory(tier)
    }
end
