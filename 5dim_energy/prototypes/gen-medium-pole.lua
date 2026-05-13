-------------------------------------------------------------------------------
-- 5Dim's Energy - Medium Electric Pole Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.energy.generation-medium-pole")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseWireDistance = 9
local baseSupplyArea = 3.5
local baseTechCount = 150

local mediumPoleSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 6, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 100, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 4, category = "electromagnetics" },
    [10] = { name = "lithium-plate", amount = 6, category = "cryogenics" }
}

local mediumPoleSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local mediumPoleSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "lithium-processing"
}

local mediumPoleDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "concrete",
    [4] = "advanced-circuit",
    [5] = "battery",
    [6] = "processing-unit",
    [7] = "low-density-structure",
    [8] = "speed-module",
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

local function getMediumPoleDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and mediumPoleSpaceAgeDeltaPrerequisites[tier] then
        return mediumPoleSpaceAgeDeltaPrerequisites[tier]
    end

    return mediumPoleDeltaPrerequisites[tier]
end

local function clampPoleDistance(value)
    return math.min(value, 64)
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
        prerequisites = { "electric-energy-distribution-1" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-substation-1", "5d-medium-electric-pole-1", "5d-big-electric-pole-1", "chemical-science-pack" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-substation-2", "5d-medium-electric-pole-2", "5d-big-electric-pole-2" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-substation-3", "5d-medium-electric-pole-3", "5d-big-electric-pole-3", "production-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-substation-4", "5d-medium-electric-pole-4", "5d-big-electric-pole-4" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-substation-5", "5d-medium-electric-pole-5", "5d-big-electric-pole-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-substation-6", "5d-medium-electric-pole-6", "5d-big-electric-pole-6" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-substation-7", "5d-medium-electric-pole-7", "5d-big-electric-pole-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-substation-8", "5d-medium-electric-pole-8", "5d-big-electric-pole-8" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local wireDistance = clampPoleDistance(CostCalculator.calculateMachineWorkValue(baseWireDistance, tier, 10, 0))
    local supplyArea = clampPoleDistance(CostCalculator.calculateMachineWorkValue(baseSupplyArea, tier, 10, 1))
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.mediumElectricPole[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = mediumPoleSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getMediumPoleDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = mediumPoleSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the medium electric pole
    genMediumPoles {
        number = tierNum,
        subgroup = "energy-medium",
        craftingSpeed = wireDistance,
        energyUsage = supplyArea,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = tier < 10 and ("5d-medium-electric-pole-" .. string.format("%02d", tier + 1)) or nil,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, mediumPoleSpaceAgeMaterials),
        tech = tech
    }
end
