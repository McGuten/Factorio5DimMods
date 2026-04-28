-------------------------------------------------------------------------------
-- 5Dim's Transport - Stack Inserter Generation (Space Age only)
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.transport.generation-stack-inserter")

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

local function getTechConfig(tier)
    local configs = {
        [2] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 }
            },
            prerequisites = { "stack-inserter", "logistics-2", "chemical-science-pack" }
        },
        [3] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-2", "logistics-3" }
        },
        [4] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-3", "production-science-pack", "logistics-4" }
        },
        [5] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-4", "logistics-5" }
        },
        [6] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-5", "logistics-6" }
        },
        [7] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-6", "utility-science-pack", "logistics-7" }
        },
        [8] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-7", "logistics-8" }
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
            -- FIXED: Changed from bulk-inserter-8 to stack-inserter-8
            prerequisites = { "stack-inserter-8", "space-science-pack", "logistics-9" }
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
            prerequisites = { "stack-inserter-9", "logistics-10" }
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
    -- Non-linear energy scaling (vanilla pattern)
    local energy = CostCalculator.scaleEnergy(baseEnergy, tier)
    local drain = baseDrain + tierBonus
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.stackInserter[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-stack-inserter-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
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
    
    -- Generate the stack inserter
    genStackInserters {
        number = tierNum,
        extensionSpeed = extension,
        rotationSpeed = rotation,
        energyMovement = energy,
        energyRotation = energy,
        energyDrain = drain,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech,
        copyName = "stack-inserter"
    }
end
