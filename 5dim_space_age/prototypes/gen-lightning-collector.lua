-------------------------------------------------------------------------------
-- 5Dim's Space Age - Lightning Collector Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-lightning-collector")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Lightning Collector base stats from space-age:
-- efficiency = 0.4
-- range_elongation = 25.0
-- buffer_capacity = 1000MJ
-- output_flow_limit = 1000MJ
-- drain = 2.5MJ
-------------------------------------------------------------------------------

local baseEfficiency = 0.4
local baseRangeElongation = 25.0
local baseBufferCapacity = 1000      -- MJ
local baseOutputFlowLimit = 1000     -- MJ
local baseTechCount = 500

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { efficiencyBonus = 0,    rangeBonus = 0,  bufferBonus = 0,    order = "a", isVanilla = true },
    [2]  = { efficiencyBonus = 0.03, rangeBonus = 3,  bufferBonus = 200,  order = "b" },
    [3]  = { efficiencyBonus = 0.06, rangeBonus = 6,  bufferBonus = 400,  order = "c" },
    [4]  = { efficiencyBonus = 0.09, rangeBonus = 9,  bufferBonus = 600,  order = "d" },
    [5]  = { efficiencyBonus = 0.12, rangeBonus = 12, bufferBonus = 800,  order = "e" },
    [6]  = { efficiencyBonus = 0.15, rangeBonus = 15, bufferBonus = 1000, order = "f" },
    [7]  = { efficiencyBonus = 0.18, rangeBonus = 18, bufferBonus = 1200, order = "g" },
    [8]  = { efficiencyBonus = 0.21, rangeBonus = 21, bufferBonus = 1400, order = "h" },
    [9]  = { efficiencyBonus = 0.24, rangeBonus = 24, bufferBonus = 1600, order = "i" },
    [10] = { efficiencyBonus = 0.27, rangeBonus = 27, bufferBonus = 1800, order = "j" }
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
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "lightning-collector" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-collector-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-collector-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-collector-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-collector-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-collector-6", "space-science-pack" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-collector-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-collector-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-collector-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local efficiency = baseEfficiency + config.efficiencyBonus
    local rangeElongation = baseRangeElongation + config.rangeBonus
    local bufferCapacity = baseBufferCapacity + config.bufferBonus
    local outputFlowLimit = baseOutputFlowLimit + config.bufferBonus
    
    -- Get ingredients from template
    local baseIngredients = RecipeTemplates.lightningCollector[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        skipTierScaling = true,
        skipSpaceAgeMaterials = true
    })
    
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
    
    -- Generate the lightning collector
    genLightningCollector {
        number = tierNum,
        subgroup = "fulgora-collector",
        efficiency = efficiency,
        rangeElongation = rangeElongation,
        bufferCapacity = bufferCapacity,
        outputFlowLimit = outputFlowLimit,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = tier < 10 and ("5d-lightning-collector-" .. string.format("%02d", tier + 1)) or nil,
        tech = tech
    }
end
