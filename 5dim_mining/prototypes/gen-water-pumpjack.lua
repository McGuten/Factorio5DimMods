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
local baseEmissions = 10
local baseTechCount = 150

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, module bonus, order
-- Note: Water pumpjack tier 1 is NOT vanilla, all tiers are new
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,  moduleBonus = 0, order = "a" },
    [2]  = { speedBonus = 5,  moduleBonus = 1, order = "b" },
    [3]  = { speedBonus = 10, moduleBonus = 2, order = "c" },
    [4]  = { speedBonus = 15, moduleBonus = 2, order = "d" },
    [5]  = { speedBonus = 20, moduleBonus = 3, order = "e" },
    [6]  = { speedBonus = 25, moduleBonus = 3, order = "f" },
    [7]  = { speedBonus = 30, moduleBonus = 4, order = "g" },
    [8]  = { speedBonus = 35, moduleBonus = 4, order = "h" },
    [9]  = { speedBonus = 40, moduleBonus = 5, order = "i" },
    [10] = { speedBonus = 45, moduleBonus = 6, order = "j" }
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
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-water-pumpjack-5", "production-science-pack" }
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
    -- Pollution decreases with efficiency (vanilla pattern)
    local emissions = CostCalculator.scalePollution(baseEmissions, tier)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.waterPumpjack[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true  -- Templates already have tier-appropriate amounts
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
        tech = {
            number = tier,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier),
            prerequisites = tc.prerequisites
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
        tech = tech
    }
end
