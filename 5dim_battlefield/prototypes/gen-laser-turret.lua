-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Laser Turret Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (1000 → 5000), Damage +45% (20 → 29)
-------------------------------------------------------------------------------

local baseRange = 26
local baseDamage = 20
local baseHealth = 1000
local baseEnergyPerShot = 800
local baseDrain = 24
local rangeIncrement = 3
local damageScalePerTier = 0.05
local healthIncrement = 444               -- 1000 → 5000 (x5)
local baseTechCount = 150
local vanillaRange = 24

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
        techName = "laser-turret-2",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "laser-turret" }
    },
    [3] = {
        techName = "laser-turret-3",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "laser-turret-2" }
    },
    [4] = {
        techName = "laser-turret-4",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "laser-turret-3" }
    },
    [5] = {
        techName = "laser-turret-5",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "laser-turret-4", "production-science-pack" }
    },
    [6] = {
        techName = "laser-turret-6",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "laser-turret-5" }
    },
    [7] = {
        techName = "laser-turret-7",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "laser-turret-6" }
    },
    [8] = {
        techName = "laser-turret-8",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "laser-turret-7", "utility-science-pack" }
    },
    [9] = {
        techName = "laser-turret-9",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "laser-turret-8" }
    },
    [10] = {
        techName = "laser-turret-10",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "laser-turret-9" }
    }
}

local laserTurretSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 140, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 8, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 4, category = "cryogenics" }
}

local laserTurretSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local laserTurretSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local laserTurretDeltaPrerequisites = {
    [2] = "battery",
    [3] = "advanced-circuit",
    [4] = "processing-unit",
    [5] = "low-density-structure",
    [6] = "speed-module",
    [7] = "speed-module-2",
    [8] = "productivity-module-2",
    [9] = "speed-module-3",
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

local function getLaserTurretDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and laserTurretSpaceAgeDeltaPrerequisites[tier] then
        return laserTurretSpaceAgeDeltaPrerequisites[tier]
    end

    return laserTurretDeltaPrerequisites[tier]
end

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

local function getEnergyStats(tier)
    local energyPerShot = CostCalculator.scaleMachineEnergy(baseEnergyPerShot, tier)
    local energyDrain = CostCalculator.scaleMachineEnergy(baseDrain, tier)

    return {
        energyPerShot = energyPerShot,
        bufferCapacity = CostCalculator.scaleMachineEnergy(baseEnergyPerShot + 1, tier),
        inputFlowLimit = energyPerShot * 12,
        drain = energyDrain
    }
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local range = CostCalculator.calculateMachineWorkValue(baseRange, tier, 10, 0)
    local damage = CostCalculator.calculateMachineWorkValue(baseDamage, tier, 10, 2)
    local health = CostCalculator.calculateMachineWorkValue(baseHealth, tier, 10, 0)
    local energy = getEnergyStats(tier)
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.laserTurret[tier], tier, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = laserTurretSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-laser-turret-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getLaserTurretDeltaPrerequisite(tier))

        tech = {
            number = tc.techName,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = laserTurretSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the laser turret
    genLaserTurrets {
        number = tierNum,
        subgroup = "defense-laser-turret",
        order = config.order,
        new = not config.isVanilla,
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
        tech = tech,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, laserTurretSpaceAgeMaterials)
    }
end
