-------------------------------------------------------------------------------
-- 5Dim's Logistic - Logistic Robot Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.logistic.generation-logistic-robot")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 0.05
local baseMaxEnergy = 1.5
local baseTechCount = 200

local logisticRobotSpaceAgeMaterials = {
    [6] = { name = "holmium-plate", amount = 2, category = "electromagnetics" },
    [7] = { name = "supercapacitor", amount = 1, category = "electromagnetics" },
    [8] = { name = "superconductor", amount = 1, category = "electromagnetics" },
    [9] = { name = "lithium-plate", amount = 1, category = "cryogenics" },
    [10] = { name = "quantum-processor", amount = 1, category = "cryogenics" }
}

local logisticRobotSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "electromagnetic-science-pack" },
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "cryogenic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local logisticRobotSpaceAgeDeltaPrerequisites = {
    [6] = "electromagnetic-plant",
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "lithium-processing",
    [10] = "quantum-processor"
}

local logisticRobotDeltaPrerequisites = {
    [3] = "battery",
    [4] = "advanced-circuit",
    [5] = "electric-engine",
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

local function getLogisticRobotDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and logisticRobotSpaceAgeDeltaPrerequisites[tier] then
        return logisticRobotSpaceAgeDeltaPrerequisites[tier]
    end

    return logisticRobotDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: order, vanilla flag
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
        prerequisites = { "logistic-robotics", "construction-robotics" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "5d-construction-robot-1", "5d-logistic-robot-1", "5d-roboport-1" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-construction-robot-2", "5d-logistic-robot-2", "5d-roboport-2", "chemical-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-construction-robot-3", "5d-logistic-robot-3", "5d-roboport-3" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-construction-robot-4", "5d-logistic-robot-4", "5d-roboport-4", "production-science-pack" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-construction-robot-5", "5d-logistic-robot-5", "5d-roboport-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-construction-robot-6", "5d-logistic-robot-6", "5d-roboport-6", "utility-science-pack" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-construction-robot-7", "5d-logistic-robot-7", "5d-roboport-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-construction-robot-8", "5d-logistic-robot-8", "5d-roboport-8" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local speed = baseSpeed + (tier - 1) * 0.025
    local maxEnergy = baseMaxEnergy + (tier - 1) * 0.75
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.logisticRobot[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = true,  -- Robots are bulk items
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        spaceAgeMaterialOverrides = logisticRobotSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getLogisticRobotDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = logisticRobotSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the logistic robot
    genLogisticRobots {
        number = tierNum,
        subgroup = "logistic-robot",
        speed = speed,
        maxEnergy = maxEnergy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, logisticRobotSpaceAgeMaterials),
        tech = tech
    }
end

-- Log configuration at startup
CostConfig.printDebugInfo()
