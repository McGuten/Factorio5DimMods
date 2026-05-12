-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Wall Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.generation-wall")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (350 → 1750)
-------------------------------------------------------------------------------

local baseHealth = 350
local healthIncrement = 200               -- 350 → 2150 (~x6.1)

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
        count = 500,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "stone-wall" }
    },
    [3] = {
        count = 750,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "stone-wall-2" }
    },
    [4] = {
        count = 1000,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "stone-wall-3" }
    },
    [5] = {
        count = 1250,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "stone-wall-4", "production-science-pack" }
    },
    [6] = {
        count = 1500,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "stone-wall-5" }
    },
    [7] = {
        count = 1750,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "stone-wall-6" }
    },
    [8] = {
        count = 2000,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "stone-wall-7", "utility-science-pack" }
    },
    [9] = {
        count = 2250,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "stone-wall-8" }
    },
    [10] = {
        count = 2500,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "stone-wall-9" }
    }
}

local wallDeltaPrerequisites = {
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
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.wall[tier], tier, {
        skipTierScaling = true,
        skipSpaceAgeMaterials = true
    })

    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-stone-wall-" .. string.format("%02d", tier + 1)
    end

    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, wallDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = tc.count,
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                skipSpaceAgePacks = true
            }),
            prerequisites = prerequisites
        }
    end

    -- Generate the wall
    genStoneWalls {
        number = tierNum,
        subgroup = "defense-wall",
        order = config.order,
        new = not config.isVanilla,
        health = health,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
