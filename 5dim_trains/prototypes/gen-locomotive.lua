-------------------------------------------------------------------------------
-- 5Dim's Trains - Locomotive Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.trains.generation-locomotive")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 1.2
local baseEnergy = 600
local baseWeight = 2000
local baseHealth = 1000
local baseTechCount = 100

local locomotiveSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 30, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-iron", amount = 240, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 24, category = "metallurgy" },
    [8] = { name = "holmium-plate", amount = 16, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 10, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 6, category = "cryogenics" }
}

local locomotiveSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local locomotiveSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local locomotiveDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "engine",
    [4] = "concrete",
    [5] = "battery",
    [6] = "electric-engine",
    [7] = "processing-unit",
    [8] = "low-density-structure",
    [9] = "speed-module-2",
    [10] = "productivity-module-3"
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

local function getLocomotiveDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and locomotiveSpaceAgeDeltaPrerequisites[tier] then
        return locomotiveSpaceAgeDeltaPrerequisites[tier]
    end

    return locomotiveDeltaPrerequisites[tier]
end

-- Increments per tier
-- REBALANCED: Increase power faster than weight so late locomotives actually
-- pull high-tier wagons better instead of just preserving roughly the same ratio.
local speedIncrement = 0.15
local energyIncrement = 250
local weightIncrement = 500
local healthIncrement = 250

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
        prerequisites = { "railway" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-locomotive-2", "chemical-science-pack" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-locomotive-3", "production-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-locomotive-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-locomotive-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-locomotive-6", "utility-science-pack" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-locomotive-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-locomotive-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-locomotive-9" }
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
    local energy = baseEnergy + (tier - 1) * energyIncrement
    local weight = baseWeight + (tier - 1) * weightIncrement
    local health = baseHealth + (tier - 1) * healthIncrement

    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.locomotive[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        spaceAgeMaterialOverrides = locomotiveSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getLocomotiveDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = locomotiveSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    -- Generate the locomotive
    genLocomotives {
        number = tierNum,
        subgroup = "trains-locomotive",
        maxSpeed = speed,
        maxPower = energy,
        weight = weight,
        health = health,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        tech = tech,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, locomotiveSpaceAgeMaterials)
    }
end
