-------------------------------------------------------------------------------
-- 5Dim's Energy - Solar Panel Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.energy.generation-solar-panel")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local basePower = 60               -- kW power output
local baseTechCount = 450

local solarPanelSpaceAgeMaterials = {
    [6] = { name = "holmium-plate", amount = 12, category = "electromagnetics" },
    [7] = { name = "supercapacitor", amount = 8, category = "electromagnetics" },
    [8] = { name = "superconductor", amount = 6, category = "electromagnetics" },
    [9] = { name = "lithium-plate", amount = 10, category = "cryogenics" },
    [10] = { name = "quantum-processor", amount = 4, category = "cryogenics" }
}

local solarPanelSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "electromagnetic-science-pack" },
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "cryogenic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local solarPanelSpaceAgeDeltaPrerequisites = {
    [6] = "electromagnetic-plant",
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "lithium-processing",
    [10] = "quantum-processor"
}

local solarPanelDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "battery",
    [4] = "advanced-circuit",
    [5] = "processing-unit",
    [6] = "low-density-structure",
    [7] = "speed-module",
    [8] = "speed-module-2",
    [9] = "efficiency-module-2",
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

local function getSolarPanelDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and solarPanelSpaceAgeDeltaPrerequisites[tier] then
        return solarPanelSpaceAgeDeltaPrerequisites[tier]
    end

    return solarPanelDeltaPrerequisites[tier]
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
        prerequisites = { "solar-energy" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "solar-energy-2", "chemical-science-pack" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "solar-energy-3", "production-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "solar-energy-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "solar-energy-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "solar-energy-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "solar-energy-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "solar-energy-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "solar-energy-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    local power = CostCalculator.calculateMachineWorkValue(basePower, tier, 10, 0)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.solarPanel[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = solarPanelSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getSolarPanelDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = solarPanelSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the solar panel
    genSolarPanels {
        number = tierNum,
        subgroup = "energy-solar-panel",
        craftingSpeed = power,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = tier < 10 and ("5d-solar-panel-" .. string.format("%02d", tier + 1)) or nil,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, solarPanelSpaceAgeMaterials),
        tech = tech
    }
end
