-------------------------------------------------------------------------------
-- 5Dim's Mining - Water Pumpjack Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.mining.generation-water-pumpjack")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 20
local baseModules = 2
local baseEnergy = 90
local baseEmissions = 0
local baseTechCount = 150

local waterPumpjackTechCounts = {
    [1] = 180,
    [2] = 320,
    [3] = 500,
    [4] = 800,
    [5] = 1200,
    [6] = 1700,
    [7] = 2300,
    [8] = 3000,
    [9] = 3800,
    [10] = 4700
}

local waterPumpjackSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 12, category = "metallurgy" },
    [6] = { type = "fluid", name = "holmium-solution", amount = 120, category = "electromagnetics" },
    [7] = { type = "fluid", name = "electrolyte", amount = 120, category = "electromagnetics" },
    [8] = { name = "supercapacitor", amount = 6, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 6, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 120, category = "cryogenics" }
}

local waterPumpjackSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "electromagnetic-science-pack" },
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local waterPumpjackSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "holmium-processing",
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "cryogenic-plant"
}

local waterPumpjackDeltaPrerequisites = {
    [1] = "steel-processing",
    [2] = "steel-processing",
    [3] = "fluid-handling",
    [4] = "engine",
    [5] = "battery",
    [6] = "electric-engine",
    [7] = "processing-unit",
    [8] = "low-density-structure",
    [9] = "speed-module-2",
    [10] = "productivity-module-2"
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

local function getWaterPumpjackDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and waterPumpjackSpaceAgeDeltaPrerequisites[tier] then
        return waterPumpjackSpaceAgeDeltaPrerequisites[tier]
    end

    return waterPumpjackDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, module bonus, order
-- Note: Water pumpjack tier 1 is NOT vanilla, all tiers are new
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,  moduleBonus = 0, order = "a" },
    [2]  = { speedBonus = 4,  moduleBonus = 1, order = "b" },
    [3]  = { speedBonus = 8, moduleBonus = 1, order = "c" },
    [4]  = { speedBonus = 12, moduleBonus = 2, order = "d" },
    [5]  = { speedBonus = 16, moduleBonus = 2, order = "e" },
    [6]  = { speedBonus = 20, moduleBonus = 2, order = "f" },
    [7]  = { speedBonus = 24, moduleBonus = 3, order = "g" },
    [8]  = { speedBonus = 28, moduleBonus = 3, order = "h" },
    [9]  = { speedBonus = 31, moduleBonus = 3, order = "i" },
    [10] = { speedBonus = 34, moduleBonus = 3, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-- Note: All tiers have technology since none are vanilla
-------------------------------------------------------------------------------

local techConfig = {
    [1] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "automation-2", "logistic-science-pack" }
    },
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-1" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-3", "chemical-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-4", "production-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-6", "utility-science-pack" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-9" }
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
    -- Non-linear energy scaling (vanilla pattern)
    local energy = CostCalculator.scaleEnergy(baseEnergy, tier)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseSpeed, speed)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.waterPumpjack[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        spaceAgeMaterialOverrides = waterPumpjackSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-water-pumpjack-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (all tiers have tech since none are vanilla)
    local tech = nil
    if techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getWaterPumpjackDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.scaleAbsoluteTechCount(waterPumpjackTechCounts[tier]),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = waterPumpjackSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the water pumpjack
    genWaterPumpjacks {
        number = tierNum,
        subgroup = "liquid-water",
        craftingSpeed = speed,
        moduleSlots = modules,
        energyUsage = energy,
        new = true,  -- All water pumpjacks are new (not vanilla)
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, waterPumpjackSpaceAgeMaterials),
        tech = tech
    }
end
