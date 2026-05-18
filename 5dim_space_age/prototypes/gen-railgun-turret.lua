-------------------------------------------------------------------------------
-- 5Dim's Space Age - Railgun Turret Generation
-- Requires: 5dim_battlefield active
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-railgun-turret")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local tierColors = require("__5dim_core__.lib.tier-colors")
local baseEntity = data.raw["ammo-turret"] and data.raw["ammo-turret"]["railgun-turret"] or {}

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseRange = baseEntity.attack_parameters and baseEntity.attack_parameters.range or 40
local rangeIncrement = 3
local baseCooldown = baseEntity.attack_parameters and baseEntity.attack_parameters.cooldown or 170
local cooldownReductionPerTier = 4
local baseRotationSpeed = 0.004
local baseHealth = baseEntity.max_health or 1000
local healthIncrement = math.floor(((baseHealth * 4) / 9) + 0.5)
local baseTechCount = 500

local railgunBasePacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "military-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "metallurgic-science-pack", 1 },
    { "agricultural-science-pack", 1 },
    { "electromagnetic-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local railgunTurretDeltaPrerequisites = {
    [2] = "tungsten-carbide",
    [3] = "electromagnetic-plant",
    [4] = "holmium-processing",
    [5] = "planet-discovery-aquilo",
    [6] = "planet-discovery-aquilo",
    [7] = "cryogenic-plant",
    [8] = "lithium-processing",
    [9] = "fusion-reactor",
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
        basePacks = railgunBasePacks,
        prerequisites = { "railgun" }
    },
    [3] = {
        basePacks = railgunBasePacks,
        prerequisites = { "5d-railgun-turret-2" }
    },
    [4] = {
        basePacks = railgunBasePacks,
        prerequisites = { "5d-railgun-turret-3" }
    },
    [5] = {
        basePacks = railgunBasePacks,
        prerequisites = { "5d-railgun-turret-4" }
    },
    [6] = {
        basePacks = railgunBasePacks,
        prerequisites = { "5d-railgun-turret-5" }
    },
    [7] = {
        basePacks = railgunBasePacks,
        prerequisites = { "5d-railgun-turret-6" }
    },
    [8] = {
        basePacks = railgunBasePacks,
        prerequisites = { "5d-railgun-turret-7" }
    },
    [9] = {
        basePacks = railgunBasePacks,
        prerequisites = { "5d-railgun-turret-8" }
    },
    [10] = {
        basePacks = railgunBasePacks,
        prerequisites = { "5d-railgun-turret-9" }
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
    local currentCooldown = math.max(134, baseCooldown - ((tier - 1) * cooldownReductionPerTier))
    
    local techData = nil
    if techConfig[tier] then
        local prerequisites = copyPrerequisites(techConfig[tier].prerequisites)

        addPrerequisiteIfMissing(prerequisites, railgunTurretDeltaPrerequisites[tier])

        techData = {
            number = tier,
            count = baseTechCount * tier,
            packs = techConfig[tier].basePacks,
            prerequisites = prerequisites
        }
    end

    genRailgunTurret({
        number = number,
        subgroup = "turrets-railgun",
        order = config.order,
        new = not config.isVanilla,
        range = currentRange,
        cooldown = currentCooldown,
        rotationSpeed = currentRotationSpeed,
        health = currentHealth,
        tint = tierColors[tier],
        ingredients = CostCalculator.processIngredients(RecipeTemplates.railgunTurret[tier], tier, {
            skipTierScaling = true,
            skipSpaceAgeMaterials = true
        }),
        nextUpdate = tier < 10 and ("5d-railgun-turret-" .. string.format("%02d", tier + 1)) or nil,
        tech = techData
    })

    currentRotationSpeed = currentRotationSpeed * 1.15
    currentRange = currentRange + rangeIncrement
end
