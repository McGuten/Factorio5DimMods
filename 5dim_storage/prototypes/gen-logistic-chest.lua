-------------------------------------------------------------------------------
-- 5Dim's Storage - Logistic Chests Generation
-- Uses the centralized cost system from 5dim_core
-- Only loads if 5dim_logistic is installed
-------------------------------------------------------------------------------

require("__5dim_core__.lib.storage.generation-logistic-chest")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseInventorySize = 48
local baseTechCount = 125

local logisticChestSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 4, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 80, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 2, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 1, category = "cryogenics" }
}

local logisticChestSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local logisticChestSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local logisticChestDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "advanced-circuit",
    [4] = "battery",
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

local function getLogisticChestDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and logisticChestSpaceAgeDeltaPrerequisites[tier] then
        return logisticChestSpaceAgeDeltaPrerequisites[tier]
    end

    return logisticChestDeltaPrerequisites[tier]
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
-- LOGISTIC CHEST TYPES AND THEIR CONFIGURATIONS
-------------------------------------------------------------------------------

local logisticChestTypes = {
    {
        name = "passive-provider",
        template = "passiveProviderChest",
        techPrerequisiteBase = "logistic-robotics",
        techPrefix = "logistic-chest-passive-provider"
    },
    {
        name = "active-provider",
        template = "activeProviderChest",
        techPrerequisiteBase = "logistic-system",
        techPrefix = "logistic-chest-active-provider"
    },
    {
        name = "storage",
        template = "storageChest",
        techPrerequisiteBase = "logistic-robotics",
        techPrefix = "logistic-chest-storage"
    },
    {
        name = "buffer",
        template = "bufferChest",
        techPrerequisiteBase = "logistic-system",
        techPrefix = "logistic-chest-buffer"
    },
    {
        name = "requester",
        template = "requesterChest",
        techPrerequisiteBase = "logistic-system",
        techPrefix = "logistic-chest-requester"
    }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER (shared for all logistic chest types)
-------------------------------------------------------------------------------

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for _, chestTypeConfig in ipairs(logisticChestTypes) do
    for tier = 1, 10 do
        local config = tierConfig[tier]
        local tierNum = string.format("%02d", tier)
        
        -- Calculate inventory size for this tier (48 base + 24 per tier)
        local inventorySize = baseInventorySize + (tier - 1) * 24
        
        -- Get ingredients from template and process them
        local baseIngredients = RecipeTemplates[chestTypeConfig.template][tier]
        local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
            isBulkItem = false,
            skipTierScaling = true,
            spaceAgeMaterialOverrides = logisticChestSpaceAgeMaterials,
            replaceSpaceAgeDelta = true
        })
        
        -- Determine next upgrade
        local nextUpgrade = nil
        if tier < 10 then
            nextUpgrade = "5d-" .. chestTypeConfig.name .. "-chest-" .. string.format("%02d", tier + 1)
        end
        
        -- Build tech configuration (tier 1 is vanilla)
        local techSettings = nil
        if tier > 1 and techConfig[tier] then
            local prerequisites
            if tier == 2 then
                prerequisites = { chestTypeConfig.techPrerequisiteBase }
            else
                prerequisites = { chestTypeConfig.techPrefix .. "-" .. (tier - 1) }
            end

            addPrerequisiteIfMissing(prerequisites, getLogisticChestDeltaPrerequisite(tier))

            if tier == 2 then
                addPrerequisiteIfMissing(prerequisites, "chemical-science-pack")
            end
            if tier == 5 then
                addPrerequisiteIfMissing(prerequisites, "production-science-pack")
            end
            if tier == 8 then
                addPrerequisiteIfMissing(prerequisites, "utility-science-pack")
            end
            
            techSettings = {
                number = tier,
                count = baseTechCount * tier,
                packs = CostCalculator.getTechPacks(techConfig[tier].basePacks, tier, {
                    spaceAgePackOverrides = logisticChestSpaceAgeSciencePacks,
                    forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
                }),
                prerequisites = prerequisites
            }
        end
        
        genLogisticChests {
            new = not config.isVanilla,
            chestType = chestTypeConfig.name,
            number = tierNum,
            order = config.order,
            inventorySize = inventorySize,
            ingredients = ingredients,
            nextUpdate = nextUpgrade,
            tech = techSettings,
            recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, logisticChestSpaceAgeMaterials)
        }
    end
end
