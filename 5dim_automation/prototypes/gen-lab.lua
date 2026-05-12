-------------------------------------------------------------------------------
-- 5Dim's Automation - Lab Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.automation.generation-lab")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 1
local baseModules = 2
local baseEnergy = 60
local baseEmissions = 1
local baseTechCount = RecipeTemplates.baseTechCounts.lab

local labSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 18, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 160, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 10, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 4, category = "cryogenics" }
}

local labSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local labSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local labDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "advanced-circuit",
    [4] = "concrete",
    [5] = "battery",
    [6] = "processing-unit",
    [7] = "low-density-structure",
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

local function getLabDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and labSpaceAgeDeltaPrerequisites[tier] then
        return labSpaceAgeDeltaPrerequisites[tier]
    end

    return labDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, module bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,    moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.15, moduleBonus = 0, order = "b" },
    [3]  = { speedBonus = 0.3,  moduleBonus = 1, order = "c" },
    [4]  = { speedBonus = 0.5,  moduleBonus = 1, order = "d" },
    [5]  = { speedBonus = 0.75, moduleBonus = 2, order = "e" },
    [6]  = { speedBonus = 1.05, moduleBonus = 2, order = "f" },
    [7]  = { speedBonus = 1.4,  moduleBonus = 3, order = "g" },
    [8]  = { speedBonus = 1.8,  moduleBonus = 3, order = "h" },
    [9]  = { speedBonus = 2.25, moduleBonus = 4, order = "i" },
    [10] = { speedBonus = 2.75, moduleBonus = 5, order = "j" }
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
        prerequisites = { "engine", "logistic-science-pack", "research-speed-1" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "5d-lab-1" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-lab-2", "chemical-science-pack", "research-speed-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-lab-3" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-lab-4", "production-science-pack", "research-speed-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-lab-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-lab-6", "utility-science-pack", "research-speed-6" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-lab-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-lab-8" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local speed = baseSpeed + config.speedBonus
    local modules = baseModules + config.moduleBonus
    -- Energy scales FASTER than speed (superlinear: 2x speed = 2.83x energy)
    local energy = CostCalculator.scaleEnergyBySpeed(baseEnergy, baseSpeed, speed, 1.5)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseSpeed, speed, 0.0)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.lab[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        spaceAgeMaterialOverrides = labSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-lab-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getLabDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = labSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the lab
    genLabs {
        number = tierNum,
        subgroup = "lab",
        craftingSpeed = speed,
        moduleSlots = modules,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, labSpaceAgeMaterials),
        tech = tech
    }
end

-- Log configuration at startup
CostConfig.printDebugInfo()
