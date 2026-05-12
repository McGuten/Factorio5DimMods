-------------------------------------------------------------------------------
-- 5Dim's Mining - Pumpjack Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.mining.generation-pumpjack")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 1
local baseModules = 2
local baseEnergy = 90
local baseEmissions = 10
local baseTechCount = 200

local pumpjackTechCounts = {
    [2] = 400,
    [3] = 650,
    [4] = 1000,
    [5] = 1450,
    [6] = 2000,
    [7] = 2650,
    [8] = 3400,
    [9] = 4250,
    [10] = 5200
}

local pumpjackSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 12, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-iron", amount = 160, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 10, category = "metallurgy" },
    [8] = { type = "fluid", name = "electrolyte", amount = 120, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 6, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 120, category = "cryogenics" }
}

local pumpjackSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local pumpjackSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "cryogenic-plant"
}

local pumpjackDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "fluid-handling",
    [4] = "engine",
    [5] = "lubricant",
    [6] = "electric-engine",
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

local function getPumpjackDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and pumpjackSpaceAgeDeltaPrerequisites[tier] then
        return pumpjackSpaceAgeDeltaPrerequisites[tier]
    end

    return pumpjackDeltaPrerequisites[tier]
end

local function getPumpjackRecipeCategory(tier)
    local spaceAgeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, pumpjackSpaceAgeMaterials)
    if spaceAgeCategory then
        return spaceAgeCategory
    end

    if tier == 5 then
        return "crafting-with-fluid"
    end

    return nil
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, module bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,   moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.4, moduleBonus = 1, order = "b" },
    [3]  = { speedBonus = 0.8, moduleBonus = 1, order = "c" },
    [4]  = { speedBonus = 1.2, moduleBonus = 2, order = "d" },
    [5]  = { speedBonus = 1.6, moduleBonus = 2, order = "e" },
    [6]  = { speedBonus = 2.0, moduleBonus = 2, order = "f" },
    [7]  = { speedBonus = 2.4, moduleBonus = 3, order = "g" },
    [8]  = { speedBonus = 2.8, moduleBonus = 3, order = "h" },
    [9]  = { speedBonus = 3.1, moduleBonus = 3, order = "i" },
    [10] = { speedBonus = 3.4, moduleBonus = 3, order = "j" }
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
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "5d-pumpjack-1" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-pumpjack-2", "chemical-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-pumpjack-3", "production-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-pumpjack-4", "production-science-pack" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-pumpjack-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-pumpjack-6", "utility-science-pack" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-pumpjack-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-pumpjack-8" }
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
    -- Energy scaling by speed (consistent with mining drill)
    -- Uses exponent 1.5 for superlinear scaling
    local energy = CostCalculator.scaleEnergyBySpeed(baseEnergy, baseSpeed, speed, 1.5)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseSpeed, speed, 0.6)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.pumpjack[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        spaceAgeMaterialOverrides = pumpjackSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-pumpjack-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getPumpjackDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.scaleAbsoluteTechCount(pumpjackTechCounts[tier]),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = pumpjackSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the pumpjack
    genPumpjacks {
        number = tierNum,
        subgroup = "liquid-pump",
        craftingSpeed = speed,
        moduleSlots = modules,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        recipeCategory = getPumpjackRecipeCategory(tier),
        tech = tech
    }
end
