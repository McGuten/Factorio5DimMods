-------------------------------------------------------------------------------
-- 5Dim's Energy - Substation Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.energy.generation-substation")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseWireDistance = 18
local baseSupplyArea = 9
local baseTechCount = 250

local substationSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 120, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 8, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 3, category = "cryogenics" }
}

local substationSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local substationSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local substationDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "battery",
    [4] = "advanced-circuit",
    [5] = "processing-unit",
    [6] = "low-density-structure",
    [7] = "speed-module",
    [8] = "speed-module-2",
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

local function getSubstationDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and substationSpaceAgeDeltaPrerequisites[tier] then
        return substationSpaceAgeDeltaPrerequisites[tier]
    end

    return substationDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", isVanilla = true },
    [2]  = { order = "b" },
    [3]  = { order = "c" },
    [4]  = { order = "d" },
    [5]  = { order = "e" },
    [6]  = { order = "f" },
    [7]  = { order = "g" },
    [8]  = { order = "h" },
    [9]  = { order = "i" },
    [10] = { order = "j" }
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
        prerequisites = { "electric-energy-distribution-2" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-substation-1", "5d-medium-electric-pole-2", "5d-big-electric-pole-2", "chemical-science-pack" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-substation-2", "5d-medium-electric-pole-3", "5d-big-electric-pole-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-substation-3", "5d-medium-electric-pole-4", "5d-big-electric-pole-4", "production-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-substation-4", "5d-medium-electric-pole-5", "5d-big-electric-pole-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-substation-5", "5d-medium-electric-pole-6", "5d-big-electric-pole-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-substation-6", "5d-medium-electric-pole-7", "5d-big-electric-pole-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-substation-7", "5d-medium-electric-pole-8", "5d-big-electric-pole-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-substation-8", "5d-medium-electric-pole-9", "5d-big-electric-pole-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local wireDistance = CostCalculator.calculateCappedMachineWorkValue(baseWireDistance, tier, 10, 64, 0)
    local supplyArea = CostCalculator.calculateCappedMachineWorkValue(baseSupplyArea, tier, 10, 64, 0)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.substation[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = substationSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getSubstationDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = substationSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the substation
    genSubstations {
        number = tierNum,
        subgroup = "energy-substation",
        craftingSpeed = wireDistance,
        energyUsage = supplyArea,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = tier < 10 and ("5d-substation-" .. string.format("%02d", tier + 1)) or nil,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, substationSpaceAgeMaterials),
        tech = tech
    }
end
