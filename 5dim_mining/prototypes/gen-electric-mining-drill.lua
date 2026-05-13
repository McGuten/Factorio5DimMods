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

local miningDrillTechCounts = {
    [2] = 450,
    [3] = 700,
    [4] = 1050,
    [5] = 1500,
    [6] = 2100,
    [7] = 2800,
    [8] = 3600,
    [9] = 4500,
    [10] = 5500
}

local miningDrillSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 12, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-iron", amount = 140, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 10, category = "metallurgy" },
    [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 6, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 4, category = "cryogenics" }
}

local miningDrillSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local miningDrillSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local miningDrillDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "concrete",
    [4] = "engine",
    [5] = "electric-engine",
    [6] = "advanced-circuit",
    [7] = "processing-unit",
    [8] = "low-density-structure",
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

local function getMiningDrillDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and miningDrillSpaceAgeDeltaPrerequisites[tier] then
        return miningDrillSpaceAgeDeltaPrerequisites[tier]
    end

    return miningDrillDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, module bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,   moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.4, moduleBonus = 1, order = "b" },
    [3]  = { speedBonus = 0.8, moduleBonus = 1, order = "c" },
    [4]  = { speedBonus = 1.3, moduleBonus = 2, order = "d" },
    [5]  = { speedBonus = 1.8, moduleBonus = 2, order = "e" },
    [6]  = { speedBonus = 2.3, moduleBonus = 2, order = "f" },
    [7]  = { speedBonus = 2.9, moduleBonus = 3, order = "g" },
    [8]  = { speedBonus = 3.5, moduleBonus = 3, order = "h" },
    [9]  = { speedBonus = 4.1, moduleBonus = 3, order = "i" },
    [10] = { speedBonus = 4.7, moduleBonus = 3, order = "j" }
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
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-mining-3", "production-science-pack" }
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

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local speed = CostCalculator.calculateMachineWorkValue(baseSpeed, tier, 10, 2)
    local modules = baseModules + config.moduleBonus
    local previousModules = nil

    if tier > 1 then
        previousModules = baseModules + tierConfig[tier - 1].moduleBonus
    end

    modules = CostCalculator.applyT10CapstoneModuleBonus(modules, tier, 10, previousModules)
    local energy = CostCalculator.scaleMachineEnergy(baseEnergy, tier)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseSpeed, speed, 0.6)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.miningDrill[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = miningDrillSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
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
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getMiningDrillDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = miningDrillSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
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
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, miningDrillSpaceAgeMaterials),
        tech = tech
    }
end

-- Log configuration at startup
CostConfig.printDebugInfo()
