-------------------------------------------------------------------------------
-- 5Dim's Mining - Offshore Pump Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.mining.generation-offshore-pump")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseSpeed = 20
local baseEmissions = 0
local baseTechCount = 100

local offshorePumpTechCounts = {
    [2] = 220,
    [3] = 360,
    [4] = 560,
    [5] = 820,
    [6] = 1150,
    [7] = 1550,
    [8] = 2050,
    [9] = 2650,
    [10] = 3400
}

local offshorePumpSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 6, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 100, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 4, category = "electromagnetics" },
    [10] = { name = "lithium-plate", amount = 4, category = "cryogenics" }
}

local offshorePumpSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local offshorePumpSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "lithium-processing"
}

local offshorePumpDeltaPrerequisites = {
    [2] = "fluid-handling",
    [3] = "steel-processing",
    [4] = "engine",
    [5] = "battery",
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

local function getOffshorePumpDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and offshorePumpSpaceAgeDeltaPrerequisites[tier] then
        return offshorePumpSpaceAgeDeltaPrerequisites[tier]
    end

    return offshorePumpDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: speed bonus, order, vanilla flag
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,  order = "a", isVanilla = true },
    [2]  = { speedBonus = 4,  order = "b" },
    [3]  = { speedBonus = 8, order = "c" },
    [4]  = { speedBonus = 12, order = "d" },
    [5]  = { speedBonus = 16, order = "e" },
    [6]  = { speedBonus = 20, order = "f" },
    [7]  = { speedBonus = 24, order = "g" },
    [8]  = { speedBonus = 28, order = "h" },
    [9]  = { speedBonus = 31, order = "i" },
    [10] = { speedBonus = 34, order = "j" }
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
        prerequisites = { "5d-offshore-pump-1" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-offshore-pump-2", "chemical-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-offshore-pump-3" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-offshore-pump-4", "production-science-pack" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-offshore-pump-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-offshore-pump-6" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-offshore-pump-7", "utility-science-pack" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-offshore-pump-8" }
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
    local emissions = CostCalculator.scalePollution(baseEmissions, baseSpeed, speed)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.offshorePump[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,  -- Templates already have tier-appropriate amounts
        spaceAgeMaterialOverrides = offshorePumpSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-offshore-pump-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getOffshorePumpDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.scaleAbsoluteTechCount(offshorePumpTechCounts[tier]),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = offshorePumpSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the offshore pump
    genOffshorePumps {
        number = tierNum,
        subgroup = "liquid-offshore-pump",
        craftingSpeed = speed,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, offshorePumpSpaceAgeMaterials),
        tech = tech
    }
end
