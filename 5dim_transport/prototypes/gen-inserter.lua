-------------------------------------------------------------------------------
-- 5Dim's Transport - Inserter Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.transport.generation-inserter")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseExtension = 0.03
local baseRotation = 0.014
local baseEnergy = 5
local baseDrain = 0.4
local baseTechCount = 200

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", isVanilla = true, copyName = "inserter" },
    [2]  = { order = "b", isVanilla = true, copyName = "fast-inserter" },
    [3]  = { order = "c", copyName = "fast-inserter" },
    [4]  = { order = "d", copyName = "fast-inserter" },
    [5]  = { order = "e", copyName = "fast-inserter" },
    [6]  = { order = "f", copyName = "fast-inserter" },
    [7]  = { order = "g", copyName = "fast-inserter" },
    [8]  = { order = "h", copyName = "fast-inserter" },
    [9]  = { order = "i", copyName = "fast-inserter" },
    [10] = { order = "j", copyName = "fast-inserter" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local function getTechConfig(tier)
    local configs = {
        [2] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter", "logistics-2", "chemical-science-pack" }
        },
        [3] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-2", "logistics-3" }
        },
        [4] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-3", "production-science-pack", "logistics-4" }
        },
        [5] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-4", "logistics-5" }
        },
        [6] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-5", "logistics-6" }
        },
        [7] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-6", "utility-science-pack", "logistics-7" }
        },
        [8] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-7", "logistics-8" }
        },
        [9] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-8", "space-science-pack", "logistics-9" }
        },
        [10] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-9", "logistics-10" }
        }
    }
    return configs[tier]
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats with incremental bonuses
    local tierBonus = (tier - 1) * 0.02
    local extension = baseExtension + tierBonus
    local rotation = baseRotation + tierBonus
    -- Non-linear energy scaling (vanilla pattern: 5->7 kJ for inserter->fast-inserter)
    local energy = CostCalculator.scaleEnergy(baseEnergy, tier)
    local drain = baseDrain + tierBonus
    
    -- Get ingredients from templates
    local inserterIngredients = RecipeTemplates.inserter[tier]
    local bulkIngredients = RecipeTemplates.bulkInserter[tier]
    
    -- Determine next upgrades (nil for tier 10)
    local nextUpdate = {}
    if tier < 10 then
        local nextTierNum = string.format("%02d", tier + 1)
        if tier == 1 then
            nextUpdate.inserter = "fast-inserter"
            nextUpdate.bulkInserter = "5d-bulk-inserter-02"
        elseif tier == 2 then
            nextUpdate.inserter = "5d-inserter-03"
            nextUpdate.bulkInserter = "5d-bulk-inserter-03"
        else
            nextUpdate.inserter = "5d-inserter-" .. nextTierNum
            nextUpdate.bulkInserter = "5d-bulk-inserter-" .. nextTierNum
        end
    end
    
    -- Build tech configuration if not vanilla tier 1
    local tech = nil
    if tier > 1 then
        local tc = getTechConfig(tier)
        if tc then
            tech = {
                number = tier,
                count = baseTechCount * tier,
                packs = CostCalculator.getTechPacks(tc.basePacks, tier),
                prerequisites = tc.prerequisites
            }
        end
    end
    
    -- Generate the inserter
    genInserters {
        number = tierNum,
        extensionSpeed = extension,
        rotationSpeed = rotation,
        energyMovement = energy,
        energyRotation = energy,
        energyDrain = drain,
        new = not config.isVanilla,
        order = config.order,
        ingredients = {
            inserter = inserterIngredients,
            bulkInserter = bulkIngredients
        },
        nextUpdate = nextUpdate,
        tech = tech,
        copyName = config.copyName
    }
end
