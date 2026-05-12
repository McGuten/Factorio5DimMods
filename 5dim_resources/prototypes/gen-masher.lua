-------------------------------------------------------------------------------
-- 5Dim's Resources - Masher Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.resources.generation-masher")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 2
local baseModuleSlots = 2
local baseEnergy = 360
local baseEmissions = 1
local baseTechCount = 250

local masherTechCounts = {
    [1] = 300,
    [2] = 550,
    [3] = 850,
    [4] = 1250,
    [5] = 1800,
    [6] = 2450,
    [7] = 3200,
    [8] = 4050,
    [9] = 5000,
    [10] = 6100
}

local masherSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 20, category = "metallurgy" },
    [6] = { name = "tungsten-plate", amount = 12, category = "metallurgy" },
    [7] = { name = "carbon-fiber", amount = 8, category = "organic" },
    [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 6, category = "electromagnetics" },
    [10] = { name = "lithium-plate", amount = 10, category = "cryogenics" }
}

local masherSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "agricultural-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local masherSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "tungsten-steel",
    [7] = "carbon-fiber",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "cryogenic-plant"
}

local masherDeltaPrerequisites = {
    [2] = "steel-processing",
    [4] = "engine",
    [5] = "concrete",
    [6] = "electric-engine",
    [7] = "processing-unit",
    [8] = "low-density-structure",
    [9] = "speed-module-2",
    [10] = "productivity-module-2"
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

local function getMasherDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and masherSpaceAgeDeltaPrerequisites[tier] then
        return masherSpaceAgeDeltaPrerequisites[tier]
    end

    return masherDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", craftingSpeed = 2.0 },
    [2]  = { order = "b", craftingSpeed = 3.5 },
    [3]  = { order = "c", craftingSpeed = 5.0 },
    [4]  = { order = "d", craftingSpeed = 6.5 },
    [5]  = { order = "e", craftingSpeed = 7.5 },
    [6]  = { order = "f", craftingSpeed = 8.5 },
    [7]  = { order = "g", craftingSpeed = 9.5 },
    [8]  = { order = "h", craftingSpeed = 10.5 },
    [9]  = { order = "i", craftingSpeed = 11.5 },
    [10] = { order = "j", craftingSpeed = 12.5 }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [1] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-2" }
    },
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-masher-1", "advanced-material-processing-3" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-masher-2", "advanced-material-processing-4" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-masher-3", "advanced-material-processing-5" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-masher-4", "advanced-material-processing-6", "production-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-masher-5", "advanced-material-processing-7" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-masher-6", "advanced-material-processing-8" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-masher-7", "utility-science-pack", "advanced-material-processing-9" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-masher-8", "advanced-material-processing-10" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-masher-9", "advanced-material-processing-11" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local craftingSpeed = config.craftingSpeed
    -- Energy scales FASTER than speed (superlinear: 2x speed = 2.83x energy)
    local energy = CostCalculator.scaleEnergyBySpeed(baseEnergy, baseCraftingSpeed, craftingSpeed, 1.5)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed)
    
    -- Module slots: base + 1 every 2 tiers (1-2, 3-4, 5-6, 7-8, 9-10 share each step)
    local moduleSlots = baseModuleSlots + math.floor(tier / 3)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.masher[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,
        spaceAgeMaterialOverrides = masherSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-masher-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (all tiers need tech for masher)
    local tech = nil
    if techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getMasherDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.scaleAbsoluteTechCount(masherTechCounts[tier]),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = masherSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the masher
    genMasher {
        number = tierNum,
        subgroup = "masher",
        craftingSpeed = craftingSpeed,
        moduleSlots = moduleSlots,
        energyUsage = energy,
        new = true,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, masherSpaceAgeMaterials),
        tech = tech
    }
end
