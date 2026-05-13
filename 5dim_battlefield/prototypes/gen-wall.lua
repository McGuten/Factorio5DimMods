-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Wall Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.generation-wall")

local CostConfig = require("__5dim_core__.lib.costs.config")
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
    [10] = "low-density-structure"
}

local wallSpaceAgeMaterials = {
    [6] = { name = "calcite", amount = 12 },
    [7] = { name = "tungsten-plate", amount = 12 },
    [8] = { name = "holmium-plate", amount = 10 },
    [9] = { name = "supercapacitor", amount = 6 },
    [10] = { name = "lithium-plate", amount = 10 }
}

local wallSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local wallSpaceAgeDeltaPrerequisites = {
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "lithium-processing"
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

local function getWallDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and wallSpaceAgeDeltaPrerequisites[tier] then
        return wallSpaceAgeDeltaPrerequisites[tier]
    end

    return wallDeltaPrerequisites[tier]
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
        spaceAgeMaterialOverrides = wallSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
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

        addPrerequisiteIfMissing(prerequisites, getWallDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = tc.count,
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = wallSpaceAgeSciencePacks
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
