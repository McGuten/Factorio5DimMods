-------------------------------------------------------------------------------
-- 5Dim's Energy - Lamp Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.energy.generation-lamp")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseLightSize = 40
local baseEnergy = 5               -- kW
local baseTechCount = 100

local lampSpaceAgeMaterials = {
    [8] = { name = "holmium-plate", amount = 4, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 2, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 1, category = "cryogenics" }
}

local lampSpaceAgeSciencePacks = {
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local lampSpaceAgeDeltaPrerequisites = {
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local lampDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "electronics",
    [4] = "battery",
    [5] = "advanced-circuit",
    [6] = "processing-unit",
    [7] = "low-density-structure",
    [8] = "speed-module",
    [9] = "speed-module-2",
    [10] = "speed-module-3"
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

local function getLampDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and lampSpaceAgeDeltaPrerequisites[tier] then
        return lampSpaceAgeDeltaPrerequisites[tier]
    end

    return lampDeltaPrerequisites[tier]
end

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
        prerequisites = { "lamp", "logistic-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "lamp-2", "chemical-science-pack" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "lamp-3", "production-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "lamp-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "lamp-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "lamp-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "lamp-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "lamp-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "lamp-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    -- REBALANCED: Linear energy scaling instead of exponential
    -- T10: 50 kW (was ~300 kW) for 220 light (5.5x light, 10x energy vs 60x energy)
    local lightSize = baseLightSize + (tier - 1) * 20
    local energy = baseEnergy + (tier - 1) * 5  -- Linear: 5, 10, 15... 50 kW
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.lamp[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = lampSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getLampDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.calculateTechCount(baseTechCount, tier - 1),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = lampSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the lamp
    genLamps {
        number = tierNum,
        subgroup = "energy-lamp",
        lightSize = lightSize,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = tier < 10 and ("5d-lamp-" .. string.format("%02d", tier + 1)) or nil,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, lampSpaceAgeMaterials),
        tech = tech
    }
end
