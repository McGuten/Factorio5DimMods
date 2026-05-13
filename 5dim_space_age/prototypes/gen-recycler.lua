-------------------------------------------------------------------------------
-- 5Dim's Space Age - Recycler Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-recycler")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 0.5
local baseModuleSlots = 4
local baseEnergy = 180
local baseEmissions = 2
local baseTechCount = 500

local recyclerSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "cryogenic-science-pack" },
    [8] = { "space-science-pack", "cryogenic-science-pack" },
    [9] = { "space-science-pack", "cryogenic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local recyclerDeltaPrerequisites = {
    [2] = "holmium-processing",
    [3] = "holmium-processing",
    [4] = "electromagnetic-plant",
    [5] = "electromagnetic-plant",
    [6] = "electromagnetic-plant",
    [7] = "lithium-processing",
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
    [1]  = { speedBonus = 0,    moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.25, moduleBonus = 1, order = "b" },
    [3]  = { speedBonus = 0.50, moduleBonus = 2, order = "c" },
    [4]  = { speedBonus = 0.75, moduleBonus = 3, order = "d" },
    [5]  = { speedBonus = 1.00, moduleBonus = 4, order = "e" },
    [6]  = { speedBonus = 1.25, moduleBonus = 5, order = "f" },
    [7]  = { speedBonus = 1.50, moduleBonus = 6, order = "g" },
    [8]  = { speedBonus = 1.75, moduleBonus = 7, order = "h" },
    [9]  = { speedBonus = 2.00, moduleBonus = 8, order = "i" },
    [10] = { speedBonus = 2.25, moduleBonus = 9, order = "j" }
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
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "recycling" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-recycler-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-recycler-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-recycler-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-recycler-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-recycler-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-recycler-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-recycler-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-recycler-9" }
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
    local energy = CostCalculator.scaleMachineEnergy(baseEnergy, tier)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed, 0.0)
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.recycler[tier], tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-recycler-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla, no tech needed)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, recyclerDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = recyclerSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = true
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the recycler
    genRecycler {
        number = tierNum,
        subgroup = "fulgora-recycler",
        craftingSpeed = craftingSpeed,
        moduleSlots = adjustedModuleSlots,
        energyUsage = energy,
        pollution = { pollution = emissions },
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        recipeCategory = "electromagnetics",
        tech = tech
    }
end
