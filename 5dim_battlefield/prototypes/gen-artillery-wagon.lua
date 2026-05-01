-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Artillery Wagon Generation
-- Requires: 5dim_trains active
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.generation-artillery-wagon")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local baseEntity = data.raw["artillery-wagon"] and data.raw["artillery-wagon"]["artillery-wagon"] or {}
local baseGun = baseEntity.gun and data.raw.gun[baseEntity.gun] or data.raw.gun["artillery-wagon-cannon"] or {}

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseAutomaticRange = baseGun.attack_parameters and baseGun.attack_parameters.range or (7 * 32)
local automaticRangeIncrement = 32 -- 1 chunk per tier
local baseAmmoSlots = baseEntity.inventory_size or 3
local baseMaxSpeed = baseEntity.max_speed or 1.5
local baseRotationSpeed = baseEntity.turret_rotation_speed or 0.001
local baseManualRangeModifier = baseEntity.manual_range_modifier or 2.5
local automatedAmmoCountPerSlot = (baseEntity.automated_ammo_count or baseAmmoSlots) / baseAmmoSlots
local damageScalePerTier = 0.05
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
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "artillery" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-4", "space-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

local currentAutomaticRange = baseAutomaticRange
local currentAmmoSlots = baseAmmoSlots
local currentMaxSpeed = baseMaxSpeed
local currentRotationSpeed = baseRotationSpeed

for tier = 1, 10 do
    local config = tierConfig[tier]
    local number = string.format("%02d", tier)
    
    local techData = nil
    if techConfig[tier] then
        techData = {
            number = tier,
            count = baseTechCount * tier,
            attackModifier = (tier - 1) * damageScalePerTier,
            packs = techConfig[tier].basePacks,
            prerequisites = techConfig[tier].prerequisites
        }
    end

    genArtilleryWagon({
        number = number,
        subgroup = "trains-artillery",
        order = config.order,
        new = not config.isVanilla,
        automaticRange = currentAutomaticRange,
        ammoSlots = currentAmmoSlots,
        maxSpeed = currentMaxSpeed,
        automatedAmmoCount = math.max(1, math.floor((currentAmmoSlots * automatedAmmoCountPerSlot) + 0.5)),
        rotationSpeed = currentRotationSpeed,
        manualRangeModifier = baseManualRangeModifier,
        ingredients = RecipeTemplates.artilleryWagon[tier],
        nextUpdate = tier < 10 and ("5d-artillery-wagon-" .. string.format("%02d", tier + 1)) or nil,
        tech = techData
    })

    currentAutomaticRange = currentAutomaticRange + automaticRangeIncrement
    currentMaxSpeed = currentMaxSpeed * 1.08
    currentRotationSpeed = currentRotationSpeed * 1.1
    if tier % 2 == 0 and currentAmmoSlots < 6 then
        currentAmmoSlots = currentAmmoSlots + 1
    end
end
