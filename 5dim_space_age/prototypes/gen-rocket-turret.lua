-------------------------------------------------------------------------------
-- 5Dim's Space Age - Rocket Turret Generation
-- Requires: 5dim_battlefield active
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-rocket-turret")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local tierColors = require("__5dim_core__.lib.tier-colors")
local baseEntity = data.raw["ammo-turret"] and data.raw["ammo-turret"]["rocket-turret"] or {}

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseRange = baseEntity.attack_parameters and baseEntity.attack_parameters.range or 36
local rangeIncrement = 3
local baseRotationSpeed = baseEntity.rotation_speed or 0.005
local baseHealth = baseEntity.max_health or 1500
local healthIncrement = math.floor(((baseHealth * 4) / 9) + 0.5)
local baseTechCount = 500

local rocketMetallurgicPacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "military-science-pack", 1 },
    { "space-science-pack", 1 },
    { "agricultural-science-pack", 1 },
    { "metallurgic-science-pack", 1 }
}

local rocketControlPacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "military-science-pack", 1 },
    { "space-science-pack", 1 },
    { "agricultural-science-pack", 1 },
    { "metallurgic-science-pack", 1 },
    { "electromagnetic-science-pack", 1 }
}

local rocketCryogenicPacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "military-science-pack", 1 },
    { "space-science-pack", 1 },
    { "agricultural-science-pack", 1 },
    { "metallurgic-science-pack", 1 },
    { "electromagnetic-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local rocketTurretDeltaPrerequisites = {
    [2] = "tungsten-steel",
    [3] = "tungsten-carbide",
    [4] = "electromagnetic-plant",
    [5] = "holmium-processing",
    [6] = "electromagnetic-plant",
    [7] = "lithium-processing",
    [8] = "cryogenic-plant",
    [9] = "fusion-reactor",
    [10] = "quantum-processor"
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
        basePacks = rocketMetallurgicPacks,
        prerequisites = { "rocket-turret" }
    },
    [3] = {
        basePacks = rocketMetallurgicPacks,
        prerequisites = { "5d-rocket-turret-2" }
    },
    [4] = {
        basePacks = rocketControlPacks,
        prerequisites = { "5d-rocket-turret-3" }
    },
    [5] = {
        basePacks = rocketControlPacks,
        prerequisites = { "5d-rocket-turret-4" }
    },
    [6] = {
        basePacks = rocketControlPacks,
        prerequisites = { "5d-rocket-turret-5" }
    },
    [7] = {
        basePacks = rocketCryogenicPacks,
        prerequisites = { "5d-rocket-turret-6" }
    },
    [8] = {
        basePacks = rocketCryogenicPacks,
        prerequisites = { "5d-rocket-turret-7" }
    },
    [9] = {
        basePacks = rocketCryogenicPacks,
        prerequisites = { "5d-rocket-turret-8" }
    },
    [10] = {
        basePacks = rocketCryogenicPacks,
        prerequisites = { "5d-rocket-turret-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

local currentRange = baseRange
local currentRotationSpeed = baseRotationSpeed

for tier = 1, 10 do
    local config = tierConfig[tier]
    local number = string.format("%02d", tier)
    local currentHealth = baseHealth + ((tier - 1) * healthIncrement)
    
    local techData = nil
    if techConfig[tier] then
        local prerequisites = copyPrerequisites(techConfig[tier].prerequisites)

        addPrerequisiteIfMissing(prerequisites, rocketTurretDeltaPrerequisites[tier])

        techData = {
            number = tier,
            count = baseTechCount * tier,
            packs = techConfig[tier].basePacks,
            prerequisites = prerequisites
        }
    end

    genRocketTurret({
        number = number,
        subgroup = "turrets-rocket",
        order = config.order,
        new = not config.isVanilla,
        range = currentRange,
        rotationSpeed = currentRotationSpeed,
        health = currentHealth,
        tint = tierColors[tier],
        ingredients = CostCalculator.processIngredients(RecipeTemplates.rocketTurret[tier], tier, {
            skipTierScaling = true,
            skipSpaceAgeMaterials = true
        }),
        nextUpdate = tier < 10 and ("5d-rocket-turret-" .. string.format("%02d", tier + 1)) or nil,
        recipeCategory = tier >= 7 and "cryogenics-or-assembling" or (tier >= 4 and "electromagnetics" or (tier >= 2 and "metallurgy-or-assembling" or nil)),
        tech = techData
    })

    currentRotationSpeed = currentRotationSpeed * 1.12
    currentRange = currentRange + rangeIncrement
end
