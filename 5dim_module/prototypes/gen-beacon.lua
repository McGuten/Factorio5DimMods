-------------------------------------------------------------------------------
-- 5Dim's Module - Beacon Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.module.generation-beacon")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseModules = 2
local baseEnergy = 480
local baseAreaEffect = 3
local baseEfficiency = 1.5
local baseTechCount = 400

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: module slots bonus, area bonus, efficiency bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { moduleBonus = 0, areaBonus = 0, efficiencyBonus = 0,    order = "a", isVanilla = true },
    [2]  = { moduleBonus = 1, areaBonus = 0, efficiencyBonus = 0,    order = "b" },
    [3]  = { moduleBonus = 2, areaBonus = 0, efficiencyBonus = 0.05, order = "c" },
    [4]  = { moduleBonus = 3, areaBonus = 0, efficiencyBonus = 0.05, order = "d" },
    [5]  = { moduleBonus = 3, areaBonus = 1, efficiencyBonus = 0.10, order = "e" },
    [6]  = { moduleBonus = 4, areaBonus = 1, efficiencyBonus = 0.10, order = "f" },
    [7]  = { moduleBonus = 4, areaBonus = 2, efficiencyBonus = 0.15, order = "g" },
    [8]  = { moduleBonus = 5, areaBonus = 2, efficiencyBonus = 0.15, order = "h" },
    [9]  = { moduleBonus = 5, areaBonus = 3, efficiencyBonus = 0.20, order = "i" },
    [10] = { moduleBonus = 6, areaBonus = 3, efficiencyBonus = 0.20, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "effect-transmission" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier (exponential scaling like vanilla)
    local modules = baseModules + config.moduleBonus
    local energy = CostCalculator.scaleEnergy(baseEnergy, tier)
    local areaEffect = baseAreaEffect + config.areaBonus
    local efficiency = baseEfficiency + config.efficiencyBonus
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.beacon[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-beacon-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        tech = {
            number = tier,
            count = CostCalculator.calculateTechCount(baseTechCount, tier - 1),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier),
            prerequisites = tc.prerequisites
        }
    end
    
    -- Generate the beacon
    genBeacons {
        number = tierNum,
        subgroup = "beacon",
        area = areaEffect,
        moduleSlots = modules,
        energyUsage = energy,
        efficiency = efficiency,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end

