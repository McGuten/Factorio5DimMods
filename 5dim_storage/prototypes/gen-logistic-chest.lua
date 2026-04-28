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
local baseTechCount = 200

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
        techPrerequisiteBase = "logistic-system",
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
        techPrerequisiteBase = "logistic-system",
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
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
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
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
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
            skipTierScaling = true
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
            
            techSettings = {
                number = tier,
                count = baseTechCount * tier,
                packs = techConfig[tier].basePacks,
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
            tech = techSettings
        }
    end
end
