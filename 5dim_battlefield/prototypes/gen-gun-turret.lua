-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Gun Turret Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.gun-turret.generation-gun-turret")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local TierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (480 → 2400 at T10)
-------------------------------------------------------------------------------

local baseRange = 22
local baseAmmo = 10
local baseShootingSpeed = 6
local baseDamageModif = 1
local baseHealth = 480
local rangeIncrement = 2
local healthIncrement = 213               -- 480 → 2400 (x5)
local baseTechCount = 100

-- Type color: Medium/Normal = Red
local typeColor = { r = 1, g = 0.1, b = 0.1, a = 1 }

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
        techName = "gun-turret-2",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 }
        },
        prerequisites = { "gun-turret" }
    },
    [3] = {
        techName = "gun-turret-3",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 }
        },
        prerequisites = { "gun-turret-2" }
    },
    [4] = {
        techName = "gun-turret-4",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "gun-turret-3", "logistic-science-pack" }
    },
    [5] = {
        techName = "gun-turret-5",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "gun-turret-4" }
    },
    [6] = {
        techName = "gun-turret-6",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "gun-turret-5", "military-science-pack" }
    },
    [7] = {
        techName = "gun-turret-7",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "gun-turret-6" }
    },
    [8] = {
        techName = "gun-turret-8",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "gun-turret-7" }
    },
    [9] = {
        techName = "gun-turret-9",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "gun-turret-8", "chemical-science-pack" }
    },
    [10] = {
        techName = "gun-turret-10",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "gun-turret-9" }
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
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local range = baseRange + (tier - 1) * rangeIncrement
    local health = baseHealth + (tier - 1) * healthIncrement
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.gunTurret[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-gun-turret-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        tech = {
            number = tc.techName,
            count = baseTechCount * tc.countMultiplier,
            packs = CostCalculator.getTechPacks(tc.basePacks, tier),
            prerequisites = tc.prerequisites
        }
    end
    
    -- Generate the gun turret
    genGunTurrets {
        number = tierNum,
        subgroup = "defense-gun-turret",
        order = config.order,
        new = not config.isVanilla,
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
