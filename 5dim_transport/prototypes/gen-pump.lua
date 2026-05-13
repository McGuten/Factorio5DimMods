-------------------------------------------------------------------------------
-- 5Dim's Transport - Pump Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.transport.generation-pump")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 200
local baseModules = 2
local baseEnergy = 29
local baseEmissions = 0
local baseTechCount = 100

local pumpTechCounts = {
    [2] = 260,
    [3] = 420,
    [4] = 650,
    [5] = 950,
    [6] = 1300,
    [7] = 1750,
    [8] = 2300,
    [9] = 2950,
    [10] = 3700
}

local pumpSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 8, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-iron", amount = 100, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 6, category = "metallurgy" },
    [8] = { type = "fluid", name = "electrolyte", amount = 80, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 2, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 80, category = "cryogenics" }
}

local pumpSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local pumpSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "cryogenic-plant"
}

local pumpDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "fluid-handling",
    [4] = "engine",
    [5] = "lubricant",
    [6] = "electric-engine",
    [7] = "processing-unit",
    [8] = "low-density-structure",
    [9] = "speed-module-2",
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

local function getPumpDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and pumpSpaceAgeDeltaPrerequisites[tier] then
        return pumpSpaceAgeDeltaPrerequisites[tier]
    end

    return pumpDeltaPrerequisites[tier]
end

local function getPumpRecipeCategory(tier)
    local spaceAgeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, pumpSpaceAgeMaterials)
    if spaceAgeCategory then
        return spaceAgeCategory
    end

    if tier == 5 then
        return "crafting-with-fluid"
    end

    return nil
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, module bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,   moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 40,  moduleBonus = 1, order = "b" },
    [3]  = { speedBonus = 80, moduleBonus = 1, order = "c" },
    [4]  = { speedBonus = 120, moduleBonus = 2, order = "d" },
    [5]  = { speedBonus = 170, moduleBonus = 2, order = "e" },
    [6]  = { speedBonus = 220, moduleBonus = 2, order = "f" },
    [7]  = { speedBonus = 280, moduleBonus = 3, order = "g" },
    [8]  = { speedBonus = 360, moduleBonus = 3, order = "h" },
    [9]  = { speedBonus = 440, moduleBonus = 3, order = "i" },
    [10] = { speedBonus = 520, moduleBonus = 3, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "fluid-handling", "chemical-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-pump-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-pump-3", "production-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-pump-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-pump-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-pump-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-pump-7", "utility-science-pack" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-pump-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-pump-9" }
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
    local emissions = CostCalculator.scalePollution(baseEmissions, baseSpeed, speed)
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.pump[tier], tier, {
        isBulkItem = false,
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = pumpSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-pump-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getPumpDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = pumpSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the pump
    genPumps {
        number = tierNum,
        subgroup = "liquid-small-pump",
        craftingSpeed = speed,
        moduleSlots = modules,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        tech = tech,
        recipeCategory = getPumpRecipeCategory(tier)
    }
end
