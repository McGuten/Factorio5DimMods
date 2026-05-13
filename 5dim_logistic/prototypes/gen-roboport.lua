-------------------------------------------------------------------------------
-- 5Dim's Logistic - Roboport Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.logistic.generation-roboport")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseChargingEnergy = 1000
local baseBufferCapacity = 100
local baseEnergy = 50
local baseInputFlowLimit = 100
-- REBALANCED: Reduced coverage scaling to prevent T10 from trivializing logistics
-- T10 logistics: 97 tiles (was 137.5), construction: 205 (was 280)
local baseLogistic = 25
local baseConstruction = 55
local logisticIncrement = 8      -- Reduced from 12.5
local constructionIncrement = 17 -- Reduced from 25
local baseBotSlot = 7
local baseRecharge = 40
-- Increased recharge slots increment for better bot support
local baseSlots = 4
local slotsIncrement = 3         -- Increased from 2 (better ratio)
local baseTechCount = 250

local roboportSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 120, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 6, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 4, category = "cryogenics" }
}

local roboportSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local roboportSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local roboportDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "battery",
    [4] = "advanced-circuit",
    [5] = "electric-engine",
    [6] = "processing-unit",
    [7] = "low-density-structure",
    [8] = "speed-module-2",
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

local function getRoboportDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and roboportSpaceAgeDeltaPrerequisites[tier] then
        return roboportSpaceAgeDeltaPrerequisites[tier]
    end

    return roboportDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: order, vanilla flag, and stat bonuses
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
    
    -- Every improving utility stat follows the shared work factor; energy usage keeps its own factor.
    local chargingEnergy = CostCalculator.calculateMachineWorkValue(baseChargingEnergy, tier, 10, 0)
    local bufferCapacity = CostCalculator.calculateMachineWorkValue(baseBufferCapacity, tier, 10, 0)
    local energy = CostCalculator.scaleMachineEnergy(baseEnergy, tier)
    local inputFlowLimit = CostCalculator.calculateMachineWorkValue(baseInputFlowLimit, tier, 10, 0)
    local logistic = CostCalculator.calculateMachineWorkValue(baseLogistic, tier, 10, 0)
    local construction = CostCalculator.calculateMachineWorkValue(baseConstruction, tier, 10, 0)
    local botSlot = CostCalculator.calculateMachineWorkValue(baseBotSlot, tier, 10, 0)
    local recharge = CostCalculator.calculateMachineWorkValue(baseRecharge, tier, 10, 0)
    local slots = CostCalculator.calculateMachineWorkValue(baseSlots, tier, 10, 0)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.roboport[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = roboportSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-roboport-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getRoboportDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = roboportSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the roboport
    genRoboports {
        number = tierNum,
        subgroup = "logistic-roboport",
        chargingEnergy = chargingEnergy,
        bufferCapacity = bufferCapacity,
        energyUsage = energy,
        rechargeSlots = slots,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        inputFlowLimit = inputFlowLimit,
        logistics = logistic,
        construction = construction,
        botSlots = botSlot,
        recharge = recharge,
        nextUpdate = nextUpgrade,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, roboportSpaceAgeMaterials),
        tech = tech
    }
end

-- Log configuration at startup
CostConfig.printDebugInfo()
