-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Big Gun Turret Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.gun-turret.generation-gun-turret")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local TierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (600 → 3000)
-------------------------------------------------------------------------------

local baseRange = 32
local baseAmmo = 5
local baseShootingSpeed = 10
local baseDamageModif = 3
local baseHealth = 600
local rangeIncrement = 2
local healthIncrement = 267               -- 600 → 3000 (x5)
local baseTechCount = 150

-- Type color: Big = Blue
local typeColor = { r = 0.1, g = 0.1, b = 1, a = 1 }

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
        techName = "5d-gun-turret-big-1",
        count = 50,
        basePacks = {
            { "automation-science-pack", 1 }
        },
        prerequisites = { "gun-turret" }
    },
    [2] = {
        techName = "5d-gun-turret-big-2",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 }
        },
        prerequisites = { "5d-gun-turret-big-1" }
    },
    [3] = {
        techName = "5d-gun-turret-big-3",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 }
        },
        prerequisites = { "5d-gun-turret-big-2" }
    },
    [4] = {
        techName = "5d-gun-turret-big-4",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "5d-gun-turret-big-3", "logistic-science-pack" }
    },
    [5] = {
        techName = "5d-gun-turret-big-5",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "5d-gun-turret-big-4" }
    },
    [6] = {
        techName = "5d-gun-turret-big-6",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-gun-turret-big-5", "military-science-pack" }
    },
    [7] = {
        techName = "5d-gun-turret-big-7",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-gun-turret-big-6" }
    },
    [8] = {
        techName = "5d-gun-turret-big-8",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-gun-turret-big-7" }
    },
    [9] = {
        techName = "5d-gun-turret-big-9",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-gun-turret-big-8", "chemical-science-pack" }
    },
    [10] = {
        techName = "5d-gun-turret-big-10",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-gun-turret-big-9" }
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
    local tierNum = "big-" .. string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local range = baseRange + (tier - 1) * rangeIncrement
    local health = baseHealth + (tier - 1) * healthIncrement
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.gunTurretBig[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-gun-turret-big-" .. string.format("%02d", tier + 1)
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
    
    -- Generate the big gun turret
    genGunTurrets {
        number = tierNum,
        subgroup = "defense-gun-turret-big",
        order = config.order,
        new = true,
        ammoCount = baseAmmo,
        attackSpeed = baseShootingSpeed,
        range = range,
        cooldown = baseDamageModif,
        health = health,
        baseTint = TierColors[tier],
        turretTint = typeColor,
        ingredients = ingredients,
        resistances = getResistances(tier),
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
