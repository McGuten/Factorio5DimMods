-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Small Laser Turret Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (800 → 4000), Damage +45% (10 → 14.5)
-------------------------------------------------------------------------------

local baseRange = 18
local baseDamage = 10
local baseHealth = 800
local rangeIncrement = 1
local damageScalePerTier = 0.05
local healthIncrement = 356               -- 800 → 4000 (x5)
local baseTechCount = 50

-- Type color: Small = Yellow
local typeColor = { r = 1, g = 1, b = 0.1, a = 1 }

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a" },
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
    [1] = {
        techName = "5d-laser-turret-small-1",
        count = 50,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "laser-turret" }
    },
    [2] = {
        techName = "5d-laser-turret-small-2",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-small-1" }
    },
    [3] = {
        techName = "5d-laser-turret-small-3",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-small-2" }
    },
    [4] = {
        techName = "5d-laser-turret-small-4",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-small-3" }
    },
    [5] = {
        techName = "5d-laser-turret-small-5",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-small-4" }
    },
    [6] = {
        techName = "5d-laser-turret-small-6",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-small-5", "utility-science-pack" }
    },
    [7] = {
        techName = "5d-laser-turret-small-7",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-small-6" }
    },
    [8] = {
        techName = "5d-laser-turret-small-8",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-small-7" }
    },
    [9] = {
        techName = "5d-laser-turret-small-9",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-small-8" }
    },
    [10] = {
        techName = "5d-laser-turret-small-10",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-small-9" }
    }
}

-------------------------------------------------------------------------------
-- RESISTANCES BY TIER
-------------------------------------------------------------------------------

local function getResistances(tier)
    local firePercent = 5 + (tier - 1) * 5
    local explosionPercent = 2.5 + (tier - 1) * 2.5
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
    local tierNum = "small-" .. string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local range = baseRange + (tier - 1) * rangeIncrement
    local damage = baseDamage * (1 + (tier - 1) * damageScalePerTier)
    local health = baseHealth + (tier - 1) * healthIncrement
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.laserTurretSmall[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-laser-turret-small-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration
    local tech = nil
    if techConfig[tier] then
        local tc = techConfig[tier]
        local count = tc.count or (baseTechCount * tc.countMultiplier)
        tech = {
            number = tc.techName,
            count = count,
            packs = CostCalculator.getTechPacks(tc.basePacks, tier),
            prerequisites = tc.prerequisites
        }
    end
    
    -- Generate the small laser turret
    genLaserTurrets {
        number = tierNum,
        subgroup = "defense-laser-turret-small",
        order = config.order,
        new = true,
        range = range,
        damage = damage,
        health = health,
        baseTint = tierColors[tier],
        turretTint = typeColor,
        ingredients = ingredients,
        resistances = getResistances(tier),
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
