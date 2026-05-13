-------------------------------------------------------------------------------
-- 5Dim's Space Age - Big Mining Drill Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-big-mining-drill")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseMiningSpeed = 2.5
local baseModuleSlots = 4
local baseEnergy = 300
local baseEmissions = 40
local baseTechCount = 500

local bigMiningDrillSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "electromagnetic-science-pack" },
    [6] = { "space-science-pack", "electromagnetic-science-pack" },
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "cryogenic-science-pack" },
    [9] = { "space-science-pack", "cryogenic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local bigMiningDrillDeltaPrerequisites = {
    [2] = "calcite-processing",
    [3] = "foundry",
    [4] = "tungsten-steel",
    [5] = "electromagnetic-plant",
    [6] = "electromagnetic-plant",
    [7] = "electromagnetic-plant",
    [8] = "lithium-processing",
    [9] = "cryogenic-plant",
    [10] = "fusion-reactor"
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
    [1]  = { speedBonus = 0,   moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.5, moduleBonus = 1, order = "b" },
    [3]  = { speedBonus = 1.0, moduleBonus = 2, order = "c" },
    [4]  = { speedBonus = 1.5, moduleBonus = 3, order = "d" },
    [5]  = { speedBonus = 2.0, moduleBonus = 4, order = "e" },
    [6]  = { speedBonus = 2.5, moduleBonus = 5, order = "f" },
    [7]  = { speedBonus = 3.0, moduleBonus = 6, order = "g" },
    [8]  = { speedBonus = 3.5, moduleBonus = 7, order = "h" },
    [9]  = { speedBonus = 4.0, moduleBonus = 8, order = "i" },
    [10] = { speedBonus = 4.5, moduleBonus = 9, order = "j" }
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
            { "production-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "big-mining-drill" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-big-mining-drill-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-big-mining-drill-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-big-mining-drill-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-big-mining-drill-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-big-mining-drill-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-big-mining-drill-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-big-mining-drill-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-big-mining-drill-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local miningSpeed = CostCalculator.calculateMachineWorkValue(baseMiningSpeed, tier, 10, 2)
    local moduleSlots = baseModuleSlots + config.moduleBonus
    local previousModuleSlots = nil

    if tier > 1 then
        previousModuleSlots = baseModuleSlots + tierConfig[tier - 1].moduleBonus
    end

    local adjustedModuleSlots = CostCalculator.applyT10CapstoneModuleBonus(moduleSlots, tier, 10, previousModuleSlots)
    local energy = CostCalculator.scaleMachineEnergy(baseEnergy, tier)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseMiningSpeed, miningSpeed, 0.6)
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.bigMiningDrill[tier], tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-big-mining-drill-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla, no tech needed)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, bigMiningDrillDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = bigMiningDrillSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = true
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the big mining drill
    genBigMiningDrill {
        number = tierNum,
        subgroup = "vulcanus-mining-big",
        miningSpeed = miningSpeed,
        moduleSlots = adjustedModuleSlots,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
