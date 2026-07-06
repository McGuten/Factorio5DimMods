-------------------------------------------------------------------------------
-- 5Dim's Module - Beacon Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.module.generation-beacon")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseModules = 2
local baseEnergy = 480
local baseAreaEffect = 3
local baseEfficiency = 1.5

local beaconTechCounts = {
    [2] = 400,
    [3] = 900,
    [4] = 1500,
    [5] = 2200,
    [6] = 3000,
    [7] = 3900,
    [8] = 4900,
    [9] = 6100,
    [10] = 7500
}

local beaconSpaceAgeMaterials = {
    [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 5, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 5, category = "cryogenics" }
}

local beaconSpaceAgeSciencePacks = {
    [7] = { "space-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local beaconSpaceAgeDeltaPrerequisites = {
    [7] = "space-science-pack",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local beaconDeltaPrerequisites = {
    [2] = "advanced-circuit",
    [3] = "battery",
    [4] = "processing-unit",
    [5] = "low-density-structure",
    [6] = "speed-module-2",
    [7] = "productivity-module-2",
    [8] = "speed-module-3",
    [9] = "productivity-module-3",
    [10] = "productivity-module-3"
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

local function addBeaconDeltaPrerequisites(prerequisites, tier)
    addPrerequisiteIfMissing(prerequisites, beaconDeltaPrerequisites[tier])

    if CostConfig.shouldUseSpaceAgeMaterials() then
        addPrerequisiteIfMissing(prerequisites, beaconSpaceAgeDeltaPrerequisites[tier])
    end
end

local function clampBeaconDistance(value)
    return math.min(value, 64)
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: module slots bonus, area bonus, efficiency bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { moduleBonus = 0, areaBonus = 0, efficiencyBonus = 0,    order = "a", isVanilla = true },
    [2]  = { moduleBonus = 1, areaBonus = 0, efficiencyBonus = 0.02, order = "b" },
    [3]  = { moduleBonus = 2, areaBonus = 0, efficiencyBonus = 0.04, order = "c" },
    [4]  = { moduleBonus = 2, areaBonus = 0, efficiencyBonus = 0.06, order = "d" },
    [5]  = { moduleBonus = 3, areaBonus = 1, efficiencyBonus = 0.08, order = "e" },
    [6]  = { moduleBonus = 3, areaBonus = 1, efficiencyBonus = 0.10, order = "f" },
    [7]  = { moduleBonus = 4, areaBonus = 1, efficiencyBonus = 0.12, order = "g" },
    [8]  = { moduleBonus = 4, areaBonus = 2, efficiencyBonus = 0.14, order = "h" },
    [9]  = { moduleBonus = 5, areaBonus = 2, efficiencyBonus = 0.16, order = "i" },
    [10] = { moduleBonus = 5, areaBonus = 2, efficiencyBonus = 0.18, order = "j" }
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
    
    -- Calculate stats for this tier from the shared balance policy.
    local modules = CostCalculator.calculateMachineWorkValue(baseModules, tier, 10, 0)
    local energy = CostCalculator.scaleMachineEnergy(baseEnergy, tier)
    local areaEffect = clampBeaconDistance(CostCalculator.calculateMachineWorkValue(baseAreaEffect, tier, 10, 0))
    local efficiency = baseEfficiency + config.efficiencyBonus
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.beacon[tier], tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = beaconSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-beacon-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addBeaconDeltaPrerequisites(prerequisites, tier)

        tech = {
            number = tier,
            count = CostCalculator.calculateMachineTechCount(beaconTechCounts[2], tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = beaconSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
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
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, beaconSpaceAgeMaterials),
        tech = tech
    }
end

