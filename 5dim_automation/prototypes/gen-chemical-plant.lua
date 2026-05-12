-------------------------------------------------------------------------------
-- 5Dim's Automation - Chemical Plant Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.automation.generation-chemical-plant")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 1
local baseModules = 3
local baseEnergy = 210
local baseEmissions = 4
local baseTechCount = RecipeTemplates.baseTechCounts.chemicalPlant

local chemicalPlantSpaceAgeMaterials = {
    [6] = { type = "fluid", name = "holmium-solution", amount = 160, category = "chemistry" },
    [7] = { name = "holmium-plate", amount = 16, category = "electromagnetics" },
    [8] = { name = "superconductor", amount = 10, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 12, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 160, category = "cryogenics" }
}

local chemicalPlantSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "electromagnetic-science-pack" },
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local chemicalPlantSpaceAgeDeltaPrerequisites = {
    [6] = "holmium-processing",
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "cryogenic-plant"
}

local chemicalPlantBaseRecipeCategories = {
    [4] = "crafting-with-fluid",
    [5] = "crafting-with-fluid"
}

local chemicalPlantDeltaPrerequisites = {
    [2] = "sulfur-processing",
    [3] = "plastics",
    [4] = "sulfur-processing",
    [5] = "lubricant",
    [6] = "concrete",
    [7] = "processing-unit",
    [8] = "low-density-structure",
    [9] = "productivity-module-2",
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

local function getChemicalPlantDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and chemicalPlantSpaceAgeDeltaPrerequisites[tier] then
        return chemicalPlantSpaceAgeDeltaPrerequisites[tier]
    end

    return chemicalPlantDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, module bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0, moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.5, moduleBonus = 0, order = "b" },
    [3]  = { speedBonus = 1.0, moduleBonus = 1, order = "c" },
    [4]  = { speedBonus = 1.6, moduleBonus = 1, order = "d" },
    [5]  = { speedBonus = 2.3, moduleBonus = 2, order = "e" },
    [6]  = { speedBonus = 3.1, moduleBonus = 2, order = "f" },
    [7]  = { speedBonus = 4.0, moduleBonus = 3, order = "g" },
    [8]  = { speedBonus = 5.0, moduleBonus = 3, order = "h" },
    [9]  = { speedBonus = 6.1, moduleBonus = 4, order = "i" },
    [10] = { speedBonus = 7.3, moduleBonus = 5, order = "j" }
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
        prerequisites = { "oil-processing", "logistic-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-chemical-plant-1", "chemical-science-pack" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-chemical-plant-2", "advanced-oil-processing" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-chemical-plant-3", "production-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-chemical-plant-4", "production-science-pack" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-chemical-plant-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-chemical-plant-6", "utility-science-pack" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-chemical-plant-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-chemical-plant-8" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local speed = baseSpeed + config.speedBonus
    local modules = baseModules + config.moduleBonus
    -- Energy scales FASTER than speed (superlinear: 2x speed = 2.83x energy)
    local energy = CostCalculator.scaleEnergyBySpeed(baseEnergy, baseSpeed, speed, 1.5)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseSpeed, speed)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.chemicalPlant[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        spaceAgeMaterialOverrides = chemicalPlantSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-chemical-plant-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getChemicalPlantDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = chemicalPlantSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    local recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, chemicalPlantSpaceAgeMaterials)
        or chemicalPlantBaseRecipeCategories[tier]
    
    -- Generate the chemical plant
    genChemicalPlants {
        number = tierNum,
        subgroup = "liquid-plant",
        craftingSpeed = speed,
        moduleSlots = modules,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        recipeCategory = recipeCategory,
        tech = tech
    }
end

-- Log configuration at startup
CostConfig.printDebugInfo()
