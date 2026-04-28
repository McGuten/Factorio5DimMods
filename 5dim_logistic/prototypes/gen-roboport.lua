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
local baseBufferCapacity = 5
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
local baseTechCount = 500

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
    
    -- Calculate stats for this tier (using rebalanced increments)
    local chargingEnergy = baseChargingEnergy + (tier - 1) * 500
    local bufferCapacity = baseBufferCapacity + (tier - 1) * 13
    -- Adjust for odd tiers 3, 5, 7, 9 (had +1 in original)
    if tier % 2 == 1 and tier > 1 then
        bufferCapacity = bufferCapacity + 1
    end
    local energy = CostCalculator.scaleEnergy(baseEnergy, tier)
    local inputFlowLimit = baseInputFlowLimit + (tier - 1) * 50
    -- Use rebalanced coverage increments
    local logistic = baseLogistic + (tier - 1) * logisticIncrement
    local construction = baseConstruction + (tier - 1) * constructionIncrement
    local botSlot = baseBotSlot + (tier - 1) * 7
    local recharge = baseRecharge + (tier - 1) * 20
    local slots = baseSlots + (tier - 1) * slotsIncrement
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.roboport[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true  -- Templates already have tier-appropriate amounts
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
        tech = {
            number = tier - 1,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier),
            prerequisites = tc.prerequisites
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
        tech = tech
    }
end

-- Log configuration at startup
CostConfig.printDebugInfo()
