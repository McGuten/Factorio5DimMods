-------------------------------------------------------------------------------
-- 5Dim's Space Age - Tesla Turret (Space Age version) Generation
-- Requires: 5dim_battlefield active
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-tesla-turret-sa")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local tierColors = require("__5dim_core__.lib.tier-colors")
local baseEntity = data.raw["electric-turret"] and data.raw["electric-turret"]["tesla-turret"] or {}

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseDamage = 50
local damageMultiplier = 1.4
local baseRange = baseEntity.attack_parameters and baseEntity.attack_parameters.range or 30
local rangeIncrement = 2
local baseEnergyPerShot = 12000 -- kJ, matches vanilla tesla-turret
local baseInputFlowLimit = 7000 -- kW
local baseBufferCapacity = 15000 -- kJ
local baseDrain = 1000 -- kW
local baseHealth = baseEntity.max_health or 1000
local healthIncrement = math.floor(((baseHealth * 4) / 9) + 0.5)
local baseTechCount = 500

local teslaBasePacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "military-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "electromagnetic-science-pack", 1 }
}

local teslaCryogenicPacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "military-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "electromagnetic-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local teslaTurretDeltaPrerequisites = {
    [2] = "holmium-processing",
    [3] = "holmium-processing",
    [4] = "quantum-processor",
    [5] = "lithium-processing",
    [6] = "planet-discovery-aquilo",
    [7] = "planet-discovery-aquilo",
    [8] = "cryogenic-plant",
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
        basePacks = teslaBasePacks,
        prerequisites = { "tesla-weapons" }
    },
    [3] = {
        basePacks = teslaBasePacks,
        prerequisites = { "5d-tesla-turret-sa-2" }
    },
    [4] = {
        basePacks = teslaBasePacks,
        prerequisites = { "5d-tesla-turret-sa-3" }
    },
    [5] = {
        basePacks = teslaCryogenicPacks,
        prerequisites = { "5d-tesla-turret-sa-4" }
    },
    [6] = {
        basePacks = teslaCryogenicPacks,
        prerequisites = { "5d-tesla-turret-sa-5" }
    },
    [7] = {
        basePacks = teslaCryogenicPacks,
        prerequisites = { "5d-tesla-turret-sa-6" }
    },
    [8] = {
        basePacks = teslaCryogenicPacks,
        prerequisites = { "5d-tesla-turret-sa-7" }
    },
    [9] = {
        basePacks = teslaCryogenicPacks,
        prerequisites = { "5d-tesla-turret-sa-8" }
    },
    [10] = {
        basePacks = teslaCryogenicPacks,
        prerequisites = { "5d-tesla-turret-sa-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

local currentDamage = baseDamage
local currentRange = baseRange
local currentEnergy = baseEnergyPerShot

for tier = 1, 10 do
    local config = tierConfig[tier]
    local number = string.format("%02d", tier)
    local currentHealth = baseHealth + ((tier - 1) * healthIncrement)
    
    local techData = nil
    if techConfig[tier] then
        local prerequisites = copyPrerequisites(techConfig[tier].prerequisites)

        addPrerequisiteIfMissing(prerequisites, teslaTurretDeltaPrerequisites[tier])

        techData = {
            number = tier,
            count = baseTechCount * tier,
            packs = techConfig[tier].basePacks,
            prerequisites = prerequisites
        }
    end

    local inputFlowLimit = CostCalculator.scaleEnergyBySpeed(baseInputFlowLimit, baseEnergyPerShot, currentEnergy, 1)
    local bufferCapacity = CostCalculator.scaleEnergyBySpeed(baseBufferCapacity, baseEnergyPerShot, currentEnergy, 1)
    local energyDrain = CostCalculator.scaleEnergyBySpeed(baseDrain, baseEnergyPerShot, currentEnergy, 0.5)

    genTeslaTurretSA({
        number = number,
        subgroup = "turrets-tesla-sa",
        order = config.order,
        new = not config.isVanilla,
        damage = currentDamage,
        range = currentRange,
        health = currentHealth,
        energyPerShot = currentEnergy,
        inputFlowLimit = inputFlowLimit,
        bufferCapacity = bufferCapacity,
        energyDrain = energyDrain,
        tint = tierColors[tier],
        ingredients = CostCalculator.processIngredients(RecipeTemplates.teslaTurretSA[tier], tier, {
            skipTierScaling = true,
            skipSpaceAgeMaterials = true
        }),
        nextUpdate = tier < 10 and ("5d-tesla-turret-sa-" .. string.format("%02d", tier + 1)) or nil,
        recipeCategory = tier >= 6 and "cryogenics-or-assembling" or nil,
        tech = techData
    })

    currentDamage = currentDamage * damageMultiplier
    currentEnergy = currentEnergy * 1.2
    currentRange = currentRange + rangeIncrement
end
