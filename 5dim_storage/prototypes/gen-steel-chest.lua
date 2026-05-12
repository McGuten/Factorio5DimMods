-------------------------------------------------------------------------------
-- 5Dim's Storage - Steel Chest Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.storage.generation-steel-chest")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseInventorySize = 48
local baseTechCount = 100

local steelChestSpaceAgeMaterials = {
    [8] = { name = "holmium-plate", amount = 4, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 2, category = "electromagnetics" },
    [10] = { name = "lithium-plate", amount = 2, category = "cryogenics" }
}

local steelChestSpaceAgeSciencePacks = {
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local steelChestSpaceAgeDeltaPrerequisites = {
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "lithium-processing"
}

local steelChestDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "concrete",
    [4] = "concrete",
    [5] = "battery",
    [6] = "advanced-circuit",
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

local function getSteelChestDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and steelChestSpaceAgeDeltaPrerequisites[tier] then
        return steelChestSpaceAgeDeltaPrerequisites[tier]
    end

    return steelChestDeltaPrerequisites[tier]
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
        prerequisites = { "steel-processing", "logistic-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "steel-chest-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "steel-chest-3", "chemical-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "steel-chest-4", "production-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "steel-chest-5", "production-science-pack" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "steel-chest-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "steel-chest-7", "utility-science-pack" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "steel-chest-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "steel-chest-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate inventory size for this tier (48 base + 24 per tier)
    local inventorySize = baseInventorySize + (tier - 1) * 24
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.steelChest[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,
        spaceAgeMaterialOverrides = steelChestSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-steel-chest-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla)
    local techSettings = nil
    if tier > 1 and techConfig[tier] then
        local prerequisites = copyPrerequisites(techConfig[tier].prerequisites)

        addPrerequisiteIfMissing(prerequisites, getSteelChestDeltaPrerequisite(tier))

        techSettings = {
            number = tier,
            count = baseTechCount * tier,
            packs = CostCalculator.getTechPacks(techConfig[tier].basePacks, tier, {
                spaceAgePackOverrides = steelChestSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    genSteelChests {
        new = not config.isVanilla,
        number = tierNum,
        subgroup = "store-steel-chest",
        order = config.order,
        inventorySize = inventorySize,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = techSettings,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, steelChestSpaceAgeMaterials)
    }
end
