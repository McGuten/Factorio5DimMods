-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Artillery Turret Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.generation-artillery-turret")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local baseEntity = data.raw["artillery-turret"] and data.raw["artillery-turret"]["artillery-turret"] or {}
local baseGun = baseEntity.gun and data.raw.gun[baseEntity.gun] or data.raw.gun["artillery-wagon-cannon"] or {}

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseAutomaticRange = baseGun.attack_parameters and baseGun.attack_parameters.range or (7 * 32)
local automaticRangeScalePerTier = 0.05
local baseRotationSpeed = baseEntity.turret_rotation_speed or 0.001
local baseManualRangeModifier = baseEntity.manual_range_modifier or 2.5
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
        prerequisites = { "5d-artillery-turret-2" }
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
        prerequisites = { "5d-artillery-turret-3" }
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
        prerequisites = { "5d-artillery-turret-4", "space-science-pack" }
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
        prerequisites = { "5d-artillery-turret-5" }
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
        prerequisites = { "5d-artillery-turret-6" }
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
        prerequisites = { "5d-artillery-turret-7" }
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
        prerequisites = { "5d-artillery-turret-8" }
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
        prerequisites = { "5d-artillery-turret-9" }
    }
}

local artilleryTurretSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 40, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-iron", amount = 240, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 30, category = "metallurgy" },
    [8] = { name = "holmium-plate", amount = 20, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 12, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 6, category = "cryogenics" }
}

local artilleryTurretSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local artilleryTurretSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local artilleryTurretDeltaPrerequisites = {
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

local function getArtilleryTurretDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and artilleryTurretSpaceAgeDeltaPrerequisites[tier] then
        return artilleryTurretSpaceAgeDeltaPrerequisites[tier]
    end

    return artilleryTurretDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

local currentRotationSpeed = baseRotationSpeed

for tier = 1, 10 do
    local config = tierConfig[tier]
    local number = string.format("%02d", tier)
    local currentAutomaticRange = math.floor((baseAutomaticRange * (1 + ((tier - 1) * automaticRangeScalePerTier))) + 0.5)
    
    local techData = nil
    if techConfig[tier] then
        local prerequisites = copyPrerequisites(techConfig[tier].prerequisites)

        addPrerequisiteIfMissing(prerequisites, getArtilleryTurretDeltaPrerequisite(tier))

        techData = {
            number = tier,
            count = baseTechCount * tier,
            attackModifier = (tier - 1) * damageScalePerTier,
            packs = CostCalculator.getTechPacks(techConfig[tier].basePacks, tier, {
                spaceAgePackOverrides = artilleryTurretSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    genArtilleryTurret({
        number = number,
        subgroup = "defense-artillery",
        order = config.order,
        new = not config.isVanilla,
        automaticRange = currentAutomaticRange,
        rotationSpeed = currentRotationSpeed,
        manualRangeModifier = baseManualRangeModifier,
        ingredients = CostCalculator.processIngredients(RecipeTemplates.artilleryTurret[tier], tier, {
            skipTierScaling = true,
            spaceAgeMaterialOverrides = artilleryTurretSpaceAgeMaterials,
            replaceSpaceAgeDelta = true
        }),
        nextUpdate = tier < 10 and ("5d-artillery-turret-" .. string.format("%02d", tier + 1)) or nil,
        tech = techData,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, artilleryTurretSpaceAgeMaterials)
    })

    currentRotationSpeed = currentRotationSpeed * 1.1
end
