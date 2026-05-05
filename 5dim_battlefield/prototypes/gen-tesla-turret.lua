-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Tesla Turret Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.tesla-turret.generation-tesla-turret")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (1500 → 7500), Damage +45% (35 → 50.75)
-------------------------------------------------------------------------------

-- Rebalanced: reduced base stats to be more in line with laser turrets
-- Original: range 50, damage 50 (too powerful for tier position)
local baseRange = 35                      -- Reduced from 50 (closer to laser T5)
local baseDamage = 35                     -- Reduced from 50
local baseHealth = 1200                   -- Reduced from 1500
local baseEnergyPerShot = 3200
local baseDrain = 96
local rangeIncrement = 5
local damageScalePerTier = 0.05
local healthIncrement = 600               -- 1200 → 6600 (x5.5)
local baseTechCount = 400                 -- Increased from 300
local teslaIconPath = "__5dim_battlefield__/graphics/icon/tesla-turret/tesla-turret-base.png"
local teslaTechIconPath = "__5dim_battlefield__/graphics/icon/tesla-turret/tesla-turret-tech-base.png"

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
        techName = 1,
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        -- Increased prerequisite from laser-turret-5 to laser-turret-8 for better balance
        prerequisites = { "laser-turret-8", "utility-science-pack" }
    },
    [2] = {
        techName = 2,
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-tesla-turrets-1" }
    },
    [3] = {
        techName = 3,
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-tesla-turrets-2" }
    },
    [4] = {
        techName = 4,
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-tesla-turrets-3" }
    },
    [5] = {
        techName = 5,
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-tesla-turrets-4" }
    },
    [6] = {
        techName = 6,
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-tesla-turrets-5" }
    },
    [7] = {
        techName = 7,
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-tesla-turrets-6" }
    },
    [8] = {
        techName = 8,
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-tesla-turrets-7" }
    },
    [9] = {
        techName = 9,
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-tesla-turrets-8" }
    },
    [10] = {
        techName = 10,
        countMultiplier = 10,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-tesla-turrets-9" }
    }
}

-------------------------------------------------------------------------------
-- RESISTANCES BY TIER
-------------------------------------------------------------------------------

local function getResistances(tier)
    local firePercent = 10 + (tier - 1) * 5
    local explosionPercent = 5 + (tier - 1) * 5
    return {
        { type = "fire", percent = firePercent },
        { type = "explosion", percent = explosionPercent }
    }
end

local function getEnergyStats(damage, range)
    local energyPerShot = CostCalculator.scaleEnergyBySpeed(baseEnergyPerShot, baseDamage, damage, 1.15)
    local energyDrain = CostCalculator.scaleEnergyBySpeed(baseDrain, baseRange, range, 0.9)

    return {
        energyPerShot = energyPerShot,
        bufferCapacity = energyPerShot + 1,
        inputFlowLimit = energyPerShot * 12,
        drain = math.max(baseDrain, energyDrain)
    }
end

-------------------------------------------------------------------------------
-- TYPE COLOR (Tesla = Purple)
-------------------------------------------------------------------------------

local typeColor = { r = 0.8, g = 0.1, b = 0.8, a = 1 }

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local range = baseRange + (tier - 1) * rangeIncrement
    local damage = baseDamage * (1 + (tier - 1) * damageScalePerTier)
    local health = baseHealth + (tier - 1) * healthIncrement
    local energy = getEnergyStats(damage, range)
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.teslaTurret[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-tesla-turret-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration
    local tech = nil
    if techConfig[tier] then
        local tc = techConfig[tier]
        tech = {
            number = tc.techName,
            count = baseTechCount * tc.countMultiplier,
            packs = CostCalculator.getTechPacks(tc.basePacks, tier),
            prerequisites = tc.prerequisites
        }
    end
    
    -- Generate the tesla turret
    genTeslaTurrets {
        number = tierNum,
        subgroup = "defense-tesla",
        order = config.order,
        new = true,
        iconPath = teslaIconPath,
        techIconPath = teslaTechIconPath,
        techIconSize = 256,
        range = range,
        damage = damage,
        health = health,
        energyPerShot = energy.energyPerShot,
        bufferCapacity = energy.bufferCapacity,
        inputFlowLimit = energy.inputFlowLimit,
        energyDrain = energy.drain,
        baseTint = tierColors[tier],
        turretTint = typeColor,
        ingredients = ingredients,
        resistances = getResistances(tier),
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
