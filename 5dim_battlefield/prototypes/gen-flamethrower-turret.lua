-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Flamethrower Turret Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.flamethrower-turret.generation-flamethrower-turret")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (1400 → 7000), Damage +45% by T10 via fluid modifiers
-------------------------------------------------------------------------------

local baseRange = 30
local baseHealth = 1400
local rangeIncrement = 3
local damageScalePerTier = 0.05
local healthIncrement = 622               -- 1400 → 7000 (x5)
local baseTechCount = 150

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
        techName = 2,
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "flamethrower" }
    },
    [3] = {
        techName = 3,
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "flamethrower-2" }
    },
    [4] = {
        techName = 4,
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "flamethrower-3" }
    },
    [5] = {
        techName = 5,
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "flamethrower-4", "chemical-science-pack" }
    },
    [6] = {
        techName = 6,
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
            ,{ "production-science-pack", 1 }
        },
        prerequisites = { "flamethrower-5" }
    },
    [7] = {
        techName = 7,
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
            ,{ "production-science-pack", 1 }
        },
        prerequisites = { "flamethrower-6" }
    },
    [8] = {
        techName = 8,
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "flamethrower-7", "utility-science-pack" }
    },
    [9] = {
        techName = 9,
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "flamethrower-8" }
    },
    [10] = {
        techName = 10,
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "flamethrower-9" }
    }
}

local flamethrowerTurretSpaceAgeMaterials = {
    [6] = { name = "calcite", amount = 14, category = "metallurgy" },
    [7] = { name = "carbon-fiber", amount = 10, category = "organic" },
    [8] = { type = "fluid", name = "holmium-solution", amount = 140, category = "chemistry" },
    [9] = { name = "supercapacitor", amount = 8, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 140, category = "cryogenics" }
}

local flamethrowerTurretSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "agricultural-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local flamethrowerTurretSpaceAgeDeltaPrerequisites = {
    [6] = "foundry",
    [7] = "carbon-fiber",
    [8] = "holmium-processing",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
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

local function getFlamethrowerTurretPrerequisites(tier, basePrerequisites)
    local prerequisites = copyPrerequisites(basePrerequisites)

    if CostConfig.shouldUseSpaceAgeMaterials() then
        addPrerequisiteIfMissing(prerequisites, flamethrowerTurretSpaceAgeDeltaPrerequisites[tier])
    end

    return prerequisites
end

-------------------------------------------------------------------------------
-- RESISTANCES BY TIER
-------------------------------------------------------------------------------

local function getResistances(tier)
    local firePercent = 100
    local explosionPercent = 5 + (tier - 1) * 5
    return {
        { type = "fire", percent = firePercent },
        { type = "explosion", percent = explosionPercent }
    }
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local range = baseRange + (tier - 1) * rangeIncrement
    local damageMultiplier = 1 + (tier - 1) * damageScalePerTier
    local health = baseHealth + (tier - 1) * healthIncrement
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.flamethrowerTurret[tier], tier, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = flamethrowerTurretSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-flamethrower-turret-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        tech = {
            number = tc.techName,
            count = baseTechCount * tc.countMultiplier,
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = flamethrowerTurretSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = getFlamethrowerTurretPrerequisites(tier, tc.prerequisites)
        }
    end
    
    -- Generate the flamethrower turret
    genFlamethrowerTurrets {
        number = tierNum,
        subgroup = "defense-flame",
        order = config.order,
        new = not config.isVanilla,
        range = range,
        damageMultiplier = damageMultiplier,
        health = health,
        tint = tierColors[tier],
        ingredients = ingredients,
        resistances = getResistances(tier),
        nextUpdate = nextUpgrade,
        tech = tech,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, flamethrowerTurretSpaceAgeMaterials)
    }
end
