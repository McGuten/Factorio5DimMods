-------------------------------------------------------------------------------
-- 5Dim's Automation - Oil Refinery Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.automation.generation-oil-refinery")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 1
local baseModules = 3
local baseEnergy = 420
local baseEmissions = 6
local baseTechCount = RecipeTemplates.baseTechCounts.oilRefinery

local oilRefinerySpaceAgeMaterials = {
    [4] = { name = "calcite", amount = 20, category = "metallurgy" },
    [5] = { type = "fluid", name = "molten-iron", amount = 180, category = "metallurgy" },
    [6] = { name = "tungsten-plate", amount = 24, category = "metallurgy" },
    [7] = { type = "fluid", name = "electrolyte", amount = 180, category = "electromagnetics" },
    [8] = { name = "supercapacitor", amount = 12, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 10, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 160, category = "cryogenics" }
}

local oilRefinerySpaceAgeSciencePacks = {
    [4] = { "space-science-pack", "metallurgic-science-pack" },
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local oilRefinerySpaceAgeDeltaPrerequisites = {
    [4] = "foundry",
    [5] = "foundry",
    [6] = "tungsten-steel",
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "cryogenic-plant"
}

local oilRefineryBaseRecipeCategories = {
    [4] = "crafting-with-fluid"
}

local oilRefineryDeltaPrerequisites = {
    [2] = "concrete",
    [3] = "sulfur-processing",
    [4] = "lubricant",
    [5] = "concrete",
    [6] = "plastics",
    [7] = "battery",
    [8] = "processing-unit",
    [9] = "low-density-structure",
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

local function getOilRefineryDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and oilRefinerySpaceAgeDeltaPrerequisites[tier] then
        return oilRefinerySpaceAgeDeltaPrerequisites[tier]
    end

    return oilRefineryDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, module bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0, moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.4, moduleBonus = 0, order = "b" },
    [3]  = { speedBonus = 0.8, moduleBonus = 0, order = "c" },
    [4]  = { speedBonus = 1.2, moduleBonus = 1, order = "d" },
    [5]  = { speedBonus = 1.7, moduleBonus = 1, order = "e" },
    [6]  = { speedBonus = 2.3, moduleBonus = 2, order = "f" },
    [7]  = { speedBonus = 3.0, moduleBonus = 2, order = "g" },
    [8]  = { speedBonus = 3.8, moduleBonus = 3, order = "h" },
    [9]  = { speedBonus = 4.7, moduleBonus = 3, order = "i" },
    [10] = { speedBonus = 5.7, moduleBonus = 4, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "advanced-oil-processing" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-oil-refinery-1" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-oil-refinery-2" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-oil-refinery-3", "production-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-oil-refinery-4", "production-science-pack" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-oil-refinery-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-oil-refinery-6", "utility-science-pack" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-oil-refinery-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-oil-refinery-8" }
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
    local baseIngredients = RecipeTemplates.oilRefinery[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        spaceAgeMaterialOverrides = oilRefinerySpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-oil-refinery-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getOilRefineryDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = oilRefinerySpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    local recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, oilRefinerySpaceAgeMaterials)
        or oilRefineryBaseRecipeCategories[tier]
    
    -- Generate the oil refinery
    genOilRefinery {
        number = tierNum,
        subgroup = "liquid-refinery",
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
