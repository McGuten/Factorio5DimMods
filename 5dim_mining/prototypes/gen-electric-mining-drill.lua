-------------------------------------------------------------------------------
-- 5Dim's Mining - Electric Mining Drill Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

local genMiningDrills = require("__5dim_core__.lib.mining.generation-electric-mining-drill")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 0.5
local baseModules = 2
local baseEnergy = 90
local baseEmissions = 10
local baseTechCount = 200

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, module bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,   moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.5, moduleBonus = 1, order = "b" },
    [3]  = { speedBonus = 1.0, moduleBonus = 1, order = "c" },
    [4]  = { speedBonus = 1.5, moduleBonus = 2, order = "d" },
    [5]  = { speedBonus = 2.5, moduleBonus = 2, order = "e" },
    [6]  = { speedBonus = 3.5, moduleBonus = 3, order = "f" },
    [7]  = { speedBonus = 4.5, moduleBonus = 3, order = "g" },
    [8]  = { speedBonus = 6.5, moduleBonus = 4, order = "h" },
    [9]  = { speedBonus = 8.0, moduleBonus = 4, order = "i" },
    [10] = { speedBonus = 9.5, moduleBonus = 5, order = "j" }
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
        prerequisites = { "automation-2", "logistic-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "5d-mining-1" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-mining-2", "chemical-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-mining-3" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-mining-4", "production-science-pack" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-mining-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-mining-6", "utility-science-pack" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-mining-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-mining-8" }
    }
}

local infrastructureSpaceAgePackThresholds = {
    { tier = 8, pack = "metallurgic-science-pack" },
    { tier = 9, pack = "electromagnetic-science-pack" },
    { tier = 10, pack = "cryogenic-science-pack" }
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
    local emissions = CostCalculator.scalePollution(baseEmissions, baseSpeed, speed, 0.6)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.miningDrill[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        skipSpaceAgeMaterials = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-electric-mining-drill-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        tech = {
            number = tier - 1,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackThresholds = infrastructureSpaceAgePackThresholds
            }),
            prerequisites = tc.prerequisites
        }
    end
    
    -- Generate the mining drill
    genMiningDrills {
        number = tierNum,
        subgroup = "mining-speed",
        craftingSpeed = speed,
        moduleSlots = modules,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        tech = tech
    }
end

-- Log configuration at startup
CostConfig.printDebugInfo()
