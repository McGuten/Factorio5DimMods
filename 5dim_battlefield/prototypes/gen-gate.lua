-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Gate Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.generation-gate")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (350 → 1750)
-------------------------------------------------------------------------------

local baseHealth = 350
local healthIncrement = 220               -- 350 → 2330 (~x6.7)
local baseTechCount = 500

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
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "gate", "stone-wall-2" }
    },
    [3] = {
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "gate-2", "stone-wall-3" }
    },
    [4] = {
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "gate-3", "stone-wall-4" }
    },
    [5] = {
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "gate-4", "stone-wall-5", "production-science-pack" }
    },
    [6] = {
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "gate-5", "stone-wall-6" }
    },
    [7] = {
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "gate-6", "stone-wall-7" }
    },
    [8] = {
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "gate-7", "stone-wall-8", "utility-science-pack" }
    },
    [9] = {
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "gate-8", "stone-wall-9" }
    },
    [10] = {
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "gate-9", "stone-wall-10" }
    }
}

local gateDeltaPrerequisites = {
    [3] = "concrete",
    [4] = "refined-concrete",
    [5] = "steel-processing",
    [6] = "battery",
    [7] = "advanced-circuit",
    [8] = "low-density-structure",
    [9] = "speed-module",
    [10] = "speed-module-2"
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
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)

    -- Calculate stats for this tier
    local health = baseHealth + (tier - 1) * healthIncrement

    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.gate[tier], tier, {
        skipTierScaling = true,
        skipSpaceAgeMaterials = true
    })

    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-gate-" .. string.format("%02d", tier + 1)
    end

    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, gateDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = baseTechCount * tc.countMultiplier,
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                skipSpaceAgePacks = true
            }),
            prerequisites = prerequisites
        }
    end

    -- Generate the gate
    genGates {
        number = tierNum,
        subgroup = "defense-gate",
        order = config.order,
        new = not config.isVanilla,
        health = health,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
