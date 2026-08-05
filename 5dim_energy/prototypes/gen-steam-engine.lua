-------------------------------------------------------------------------------
-- 5Dim's Energy - Steam Engine Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.energy.generation-steam-engine")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 1        -- Power output multiplier
local baseModuleSlots = 2
local baseFluidUsage = 0.5         -- vapor por tick (30 vapor/s en vanilla)
local baseEmissions = 30
local baseTechCount = 350

local steamEngineSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 20, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-copper", amount = 180, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 12, category = "metallurgy" },
    [8] = { type = "fluid", name = "electrolyte", amount = 120, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 6, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 4, category = "cryogenics" }
}

local steamEngineSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local steamEngineSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local steamEngineDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "fluid-handling",
    [4] = "engine",
    [5] = "battery",
    [6] = "electric-engine",
    [7] = "concrete",
    [8] = "concrete",
    [9] = "low-density-structure",
    [10] = "speed-module-2"
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

local function getSteamEngineDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and steamEngineSpaceAgeDeltaPrerequisites[tier] then
        return steamEngineSpaceAgeDeltaPrerequisites[tier]
    end

    return steamEngineDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", isVanilla = true, moduleSlots = 2 },
    [2]  = { order = "b", moduleSlots = 3 },
    [3]  = { order = "c", moduleSlots = 4 },
    [4]  = { order = "d", moduleSlots = 4 },
    [5]  = { order = "e", moduleSlots = 5 },
    [6]  = { order = "f", moduleSlots = 5 },
    [7]  = { order = "g", moduleSlots = 6 },
    [8]  = { order = "h", moduleSlots = 6 },
    [9]  = { order = "i", moduleSlots = 7 },
    [10] = { order = "j", moduleSlots = 8 }
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
        prerequisites = { "fluid-handling", "logistic-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "5d-boiler-1", "5d-steam-engine-1" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-boiler-2", "5d-steam-engine-2", "chemical-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-boiler-3", "5d-steam-engine-3" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-boiler-4", "5d-steam-engine-4", "production-science-pack" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-boiler-5", "5d-steam-engine-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-boiler-6", "5d-steam-engine-6", "utility-science-pack" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-boiler-7", "5d-steam-engine-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-boiler-8", "5d-steam-engine-8" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    local craftingSpeed = CostCalculator.calculateMachineWorkValue(baseCraftingSpeed, tier, 10, 2)
    -- El vapor que consume es una stat de rendimiento, no de consumo electrico: tiene
    -- que escalar con el mismo factor que la produccion del boiler para que se mantenga
    -- el 1 boiler por cada 2 motores de vanilla en todos los tiers.
    local fluidUsage = CostCalculator.calculateMachineWorkValue(baseFluidUsage, tier, 10, 2)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed, 0.8)
    local previousModuleSlots = nil

    if tier > 1 then
        previousModuleSlots = tierConfig[tier - 1].moduleSlots
    end

    local moduleSlots = CostCalculator.applyT10CapstoneModuleBonus(config.moduleSlots, tier, 10, previousModuleSlots)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.steamEngine[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = steamEngineSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getSteamEngineDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = steamEngineSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the steam engine
    genSteamEngines {
        number = tierNum,
        subgroup = "energy-engine-1",
        craftingSpeed = craftingSpeed,
        moduleSlots = moduleSlots,
        energyUsage = fluidUsage,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = tier < 10 and ("5d-steam-engine-" .. string.format("%02d", tier + 1)) or nil,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, steamEngineSpaceAgeMaterials),
        tech = tech
    }
end
