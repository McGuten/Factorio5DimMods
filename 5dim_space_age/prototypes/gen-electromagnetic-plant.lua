-------------------------------------------------------------------------------
-- 5Dim's Space Age - Electromagnetic Plant Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-electromagnetic-plant")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 2
local baseModuleSlots = 5
local baseEnergy = 1500
local baseEmissions = 4
local baseTechCount = 500

local electromagneticPlantSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "cryogenic-science-pack" },
    [6] = { "space-science-pack", "cryogenic-science-pack" },
    [7] = { "space-science-pack", "cryogenic-science-pack" },
    [8] = { "space-science-pack", "cryogenic-science-pack" },
    [9] = { "space-science-pack", "cryogenic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local electromagneticPlantDeltaPrerequisites = {
    [2] = "electromagnetic-plant",
    [3] = "electromagnetic-plant",
    [4] = "electromagnetic-plant",
    [5] = "lithium-processing",
    [6] = "cryogenic-plant",
    [7] = "cryogenic-plant",
    [8] = "cryogenic-plant",
    [9] = "cryogenic-plant",
    [10] = "quantum-processor"
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

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0, moduleBonus = 0, energyBonus = 0,    order = "a", isVanilla = true },
    [2]  = { speedBonus = 1, moduleBonus = 1, energyBonus = 300,  order = "b" },
    [3]  = { speedBonus = 2, moduleBonus = 2, energyBonus = 600,  order = "c" },
    [4]  = { speedBonus = 3, moduleBonus = 3, energyBonus = 900,  order = "d" },
    [5]  = { speedBonus = 4, moduleBonus = 4, energyBonus = 1200, order = "e" },
    [6]  = { speedBonus = 5, moduleBonus = 5, energyBonus = 1500, order = "f" },
    [7]  = { speedBonus = 6, moduleBonus = 6, energyBonus = 1800, order = "g" },
    [8]  = { speedBonus = 7, moduleBonus = 7, energyBonus = 2100, order = "h" },
    [9]  = { speedBonus = 8, moduleBonus = 8, energyBonus = 2400, order = "i" },
    [10] = { speedBonus = 9, moduleBonus = 9, energyBonus = 2700, order = "j" }
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
            { "production-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "electromagnetic-plant" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-electromagnetic-plant-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-electromagnetic-plant-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-electromagnetic-plant-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-electromagnetic-plant-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-electromagnetic-plant-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-electromagnetic-plant-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-electromagnetic-plant-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-electromagnetic-plant-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local craftingSpeed = CostCalculator.calculateMachineWorkValue(baseCraftingSpeed, tier, 10, 2)
    local moduleSlots = baseModuleSlots + config.moduleBonus
    local previousModuleSlots = nil

    if tier > 1 then
        previousModuleSlots = baseModuleSlots + tierConfig[tier - 1].moduleBonus
    end

    local adjustedModuleSlots = CostCalculator.applyT10CapstoneModuleBonus(moduleSlots, tier, 10, previousModuleSlots)
    local energyUsage = CostCalculator.scaleMachineEnergy(baseEnergy, tier)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed)
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.electromagneticPlant[tier], tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-electromagnetic-plant-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla, no tech needed)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, electromagneticPlantDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = electromagneticPlantSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = true
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the electromagnetic plant
    genElectromagneticPlant {
        number = tierNum,
        subgroup = "fulgora-electromagnetic",
        craftingSpeed = craftingSpeed,
        moduleSlots = adjustedModuleSlots,
        energyUsage = energyUsage,
        pollution = { pollution = emissions },
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
