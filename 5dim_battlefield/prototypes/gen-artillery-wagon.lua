-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Artillery Wagon Generation
-- Requires: 5dim_trains active
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.generation-artillery-wagon")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local baseEntity = data.raw["artillery-wagon"] and data.raw["artillery-wagon"]["artillery-wagon"] or {}
local baseGun = baseEntity.gun and data.raw.gun[baseEntity.gun] or data.raw.gun["artillery-wagon-cannon"] or {}

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseAutomaticRange = baseGun.attack_parameters and baseGun.attack_parameters.range or (7 * 32)
local automaticRangeScalePerTier = 0.05
local baseAmmoSlots = baseEntity.inventory_size or 3
local baseMaxSpeed = baseEntity.max_speed or 1.5
local baseRotationSpeed = baseEntity.turret_rotation_speed or 0.001
local baseManualRangeModifier = baseEntity.manual_range_modifier or 2.5
local automatedAmmoCountPerSlot = (baseEntity.automated_ammo_count or baseAmmoSlots) / baseAmmoSlots
local damageScalePerTier = 0.03
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
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
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
            { "utility-science-pack", 1 }
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
            { "utility-science-pack", 1 }
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
            { "utility-science-pack", 1 }
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
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-artillery-wagon-9" }
    }
}

local artilleryWagonSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 24, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-iron", amount = 180, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 20, category = "metallurgy" },
    [8] = { name = "holmium-plate", amount = 12, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 8, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 4, category = "cryogenics" }
}

local artilleryWagonSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local artilleryWagonSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local artilleryWagonDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "concrete",
    [4] = "explosives",
    [5] = "engine",
    [6] = "electric-engine",
    [7] = "processing-unit",
    [8] = "low-density-structure",
    [9] = "speed-module-2",
    [10] = "productivity-module-3"
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

local function getArtilleryWagonDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and artilleryWagonSpaceAgeDeltaPrerequisites[tier] then
        return artilleryWagonSpaceAgeDeltaPrerequisites[tier]
    end

    return artilleryWagonDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

local currentAmmoSlots = baseAmmoSlots
local currentMaxSpeed = baseMaxSpeed
local currentRotationSpeed = baseRotationSpeed

for tier = 1, 10 do
    local config = tierConfig[tier]
    local number = string.format("%02d", tier)
    local currentAutomaticRange = math.floor((baseAutomaticRange * (1 + ((tier - 1) * automaticRangeScalePerTier))) + 0.5)
    
    local techData = nil
    if techConfig[tier] then
        local prerequisites = copyPrerequisites(techConfig[tier].prerequisites)

        addPrerequisiteIfMissing(prerequisites, getArtilleryWagonDeltaPrerequisite(tier))

        techData = {
            number = tier,
            count = baseTechCount * tier,
            attackModifier = (tier - 1) * damageScalePerTier,
            packs = CostCalculator.getTechPacks(techConfig[tier].basePacks, tier, {
                spaceAgePackOverrides = artilleryWagonSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
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
        ingredients = CostCalculator.processIngredients(RecipeTemplates.artilleryWagon[tier], tier, {
            skipTierScaling = true,
            spaceAgeMaterialOverrides = artilleryWagonSpaceAgeMaterials,
            replaceSpaceAgeDelta = true
        }),
        nextUpdate = tier < 10 and ("5d-artillery-wagon-" .. string.format("%02d", tier + 1)) or nil,
        tech = techData,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, artilleryWagonSpaceAgeMaterials)
    })

    currentMaxSpeed = currentMaxSpeed * 1.08
    currentRotationSpeed = currentRotationSpeed * 1.1
    if tier % 2 == 0 and currentAmmoSlots < 6 then
        currentAmmoSlots = currentAmmoSlots + 1
    end
end
