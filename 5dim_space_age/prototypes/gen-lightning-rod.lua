-------------------------------------------------------------------------------
-- 5Dim's Space Age - Lightning Rod Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-lightning-rod")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Lightning Rod base stats from space-age:
-- efficiency = 0.2
-- range_elongation = 15.0
-- buffer_capacity = 500MJ
-- output_flow_limit = 500MJ
-- drain = 2.5MJ
-------------------------------------------------------------------------------

local baseEfficiency = 0.2
local baseRangeElongation = 15.0
local baseBufferCapacity = 500       -- MJ
local baseOutputFlowLimit = 500      -- MJ
local baseTechCount = 400

local lightningRodSpaceAgeSciencePacks = {
    [7] = { "cryogenic-science-pack" },
    [8] = { "cryogenic-science-pack" },
    [9] = { "cryogenic-science-pack" },
    [10] = { "cryogenic-science-pack" }
}

local lightningRodDeltaPrerequisites = {
    [2] = "holmium-processing",
    [3] = "holmium-processing",
    [4] = "electromagnetic-plant",
    [5] = "electromagnetic-plant",
    [6] = "electromagnetic-plant",
    [7] = "lithium-processing",
    [8] = "cryogenic-plant",
    [9] = "cryogenic-plant",
    [10] = "quantum-processor"
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

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { efficiencyBonus = 0,    rangeBonus = 0,  bufferBonus = 0,   order = "a", isVanilla = true },
    [2]  = { efficiencyBonus = 0.02, rangeBonus = 2,  bufferBonus = 100, order = "b" },
    [3]  = { efficiencyBonus = 0.04, rangeBonus = 4,  bufferBonus = 200, order = "c" },
    [4]  = { efficiencyBonus = 0.06, rangeBonus = 6,  bufferBonus = 300, order = "d" },
    [5]  = { efficiencyBonus = 0.08, rangeBonus = 8,  bufferBonus = 400, order = "e" },
    [6]  = { efficiencyBonus = 0.10, rangeBonus = 10, bufferBonus = 500, order = "f" },
    [7]  = { efficiencyBonus = 0.12, rangeBonus = 12, bufferBonus = 600, order = "g" },
    [8]  = { efficiencyBonus = 0.14, rangeBonus = 14, bufferBonus = 700, order = "h" },
    [9]  = { efficiencyBonus = 0.16, rangeBonus = 16, bufferBonus = 800, order = "i" },
    [10] = { efficiencyBonus = 0.18, rangeBonus = 18, bufferBonus = 900, order = "j" }
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
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "planet-discovery-fulgora" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-rod-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-lightning-rod-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
        },
        prerequisites = { "5d-lightning-rod-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
        },
        prerequisites = { "5d-lightning-rod-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
        },
        prerequisites = { "5d-lightning-rod-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
        },
        prerequisites = { "5d-lightning-rod-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
        },
        prerequisites = { "5d-lightning-rod-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
        },
        prerequisites = { "5d-lightning-rod-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local efficiency = CostCalculator.calculateMachineWorkValue(baseEfficiency, tier, 10, 3)
    local rangeElongation = CostCalculator.calculateMachineWorkValue(baseRangeElongation, tier, 10, 1)
    local bufferCapacity = CostCalculator.calculateMachineWorkValue(baseBufferCapacity, tier, 10, 0)
    local outputFlowLimit = CostCalculator.calculateMachineWorkValue(baseOutputFlowLimit, tier, 10, 0)
    
    -- Get ingredients from template
    local baseIngredients = RecipeTemplates.lightningRod[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, lightningRodDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = lightningRodSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = true
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the lightning rod
    genLightningRod {
        number = tierNum,
        subgroup = "fulgora-rod",
        efficiency = efficiency,
        rangeElongation = rangeElongation,
        bufferCapacity = bufferCapacity,
        outputFlowLimit = outputFlowLimit,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = tier < 10 and ("5d-lightning-rod-" .. string.format("%02d", tier + 1)) or nil,
        recipeCategory = tier >= 4 and "electromagnetics" or "electronics",
        tech = tech
    }
end
