-------------------------------------------------------------------------------
-- 5Dim's Automation - Assembling Machine Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.automation.generation-assembling-machine")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 0.5
local baseModuleSlots = 4
local baseEnergy = 75
local baseEmissions = 4
local baseTechCount = 150

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0.0,  moduleSlots = 0, order = "a", isVanilla = true,  copy = { name = "assembling-machine", postName = "-1" } },
    [2]  = { speedBonus = 0.25, moduleSlots = 2, order = "b", isVanilla = true,  copy = { name = "assembling-machine", postName = "-2" } },
    [3]  = { speedBonus = 0.75, moduleSlots = 4, order = "c", isVanilla = true,  copy = nil },
    [4]  = { speedBonus = 1.0,  moduleSlots = 4, order = "d" },
    [5]  = { speedBonus = 1.3,  moduleSlots = 5, order = "e" },
    [6]  = { speedBonus = 1.7,  moduleSlots = 5, order = "f" },
    [7]  = { speedBonus = 2.3,  moduleSlots = 6, order = "g" },
    [8]  = { speedBonus = 3.0,  moduleSlots = 6, order = "h" },
    [9]  = { speedBonus = 3.7,  moduleSlots = 7, order = "i" },
    [10] = { speedBonus = 4.5,  moduleSlots = 8, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "automation-3", "production-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "automation-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "automation-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "automation-6", "utility-science-pack" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "automation-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "automation-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "automation-9" }
    }
}

local assemblingMachineSpaceAgeMaterials = {
    [6] = { name = "calcite", amount = 20, category = "metallurgy" },
    [7] = { name = "holmium-plate", amount = 16, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 140, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 12, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 6, category = "cryogenics" }
}

local assemblingMachineSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local assemblingMachineSpaceAgeDeltaPrerequisites = {
    [6] = "foundry",
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local assemblingMachineDeltaPrerequisites = {
    [4] = "concrete",
    [5] = "battery",
    [6] = "electric-engine",
    [7] = "processing-unit",
    [8] = "low-density-structure",
    [9] = "productivity-module-2",
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

local function getAssemblingMachineDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and assemblingMachineSpaceAgeDeltaPrerequisites[tier] then
        return assemblingMachineSpaceAgeDeltaPrerequisites[tier]
    end

    return assemblingMachineDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local craftingSpeed = baseCraftingSpeed + config.speedBonus
    local moduleSlots = config.moduleSlots
    -- Energy scales FASTER than speed (superlinear: 2x speed = 2.83x energy)
    -- This makes higher tier machines less energy-efficient per craft
    local energy = CostCalculator.scaleEnergyBySpeed(baseEnergy, baseCraftingSpeed, craftingSpeed, 1.5)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed, 0.0)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.assemblingMachine[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,
        spaceAgeMaterialOverrides = assemblingMachineSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade
    local nextUpgrade = nil
    if tier < 10 then
        if tier < 3 then
            nextUpgrade = "assembling-machine-" .. (tier + 1)
        else
            nextUpgrade = "5d-assembling-machine-" .. string.format("%02d", tier + 1)
        end
    end
    
    -- Build tech configuration (tiers 1-3 are vanilla, no tech needed)
    local tech = nil
    if tier > 3 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getAssemblingMachineDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = assemblingMachineSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the assembling machine
    genAssemblingMachines {
        number = tierNum,
        subgroup = "assembling-machine",
        craftingSpeed = craftingSpeed,
        moduleSlots = moduleSlots,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        tech = tech,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, assemblingMachineSpaceAgeMaterials),
        copy = config.copy
    }
end
