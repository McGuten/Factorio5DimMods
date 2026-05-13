-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Sniper Laser Turret Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (1400 → 7000), moderate damage boost and long range
-------------------------------------------------------------------------------

local baseRange = 40
local baseDamage = 26
local baseHealth = 1400
local baseEnergyPerShot = 2400
local baseDrain = 72
local rangeIncrement = 3
local damageScalePerTier = 0.05
local healthIncrement = 622               -- 1400 → 7000 (x5)
local baseTechCount = 200
local sniperIconPath = "__5dim_battlefield__/graphics/icon/laser-turret/sniper/laser-turret-sniper-base.png"
local sniperTechIconPath = "__5dim_battlefield__/graphics/icon/laser-turret/sniper/laser-turret-sniper-tech-base.png"

-- Type color: Sniper = Cyan/Teal
local typeColor = { r = 0.1, g = 0.8, b = 0.8, a = 1 }

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
        techName = "5d-laser-turret-sniper-1",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "laser-turret-5" }
    },
    [2] = {
        techName = "5d-laser-turret-sniper-2",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-sniper-1" }
    },
    [3] = {
        techName = "5d-laser-turret-sniper-3",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-sniper-2" }
    },
    [4] = {
        techName = "5d-laser-turret-sniper-4",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-sniper-3" }
    },
    [5] = {
        techName = "5d-laser-turret-sniper-5",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-sniper-4", "production-science-pack" }
    },
    [6] = {
        techName = "5d-laser-turret-sniper-6",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-sniper-5" }
    },
    [7] = {
        techName = "5d-laser-turret-sniper-7",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-sniper-6" }
    },
    [8] = {
        techName = "5d-laser-turret-sniper-8",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-sniper-7", "utility-science-pack" }
    },
    [9] = {
        techName = "5d-laser-turret-sniper-9",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-sniper-8" }
    },
    [10] = {
        techName = "5d-laser-turret-sniper-10",
        countMultiplier = 10,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-laser-turret-sniper-9" }
    }
}

local laserTurretSniperSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 140, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 8, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 4, category = "cryogenics" }
}

local laserTurretSniperSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local laserTurretSniperSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local laserTurretSniperDeltaPrerequisites = {
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

local function getLaserTurretSniperDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and laserTurretSniperSpaceAgeDeltaPrerequisites[tier] then
        return laserTurretSniperSpaceAgeDeltaPrerequisites[tier]
    end

    return laserTurretSniperDeltaPrerequisites[tier]
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
    local tierNum = "sniper-" .. string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local range = CostCalculator.calculateMachineWorkValue(baseRange, tier, 10, 0)
    local damage = CostCalculator.calculateMachineWorkValue(baseDamage, tier, 10, 2)
    local health = CostCalculator.calculateMachineWorkValue(baseHealth, tier, 10, 0)
    local energy = getEnergyStats(tier)
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.laserTurretSniper[tier], tier, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = laserTurretSniperSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-laser-turret-sniper-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration
    local tech = nil
    if techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getLaserTurretSniperDeltaPrerequisite(tier))

        tech = {
            number = tc.techName,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = laserTurretSniperSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the sniper laser turret
    genLaserTurrets {
        number = tierNum,
        subgroup = "defense-laser-turret-sniper",
        order = config.order,
        new = true,
        iconPath = sniperIconPath,
        techIconPath = sniperTechIconPath,
        techIconSize = 256,
        range = range,
        damage = damage,
        health = health,
        energyPerShot = energy.energyPerShot,
        bufferCapacity = energy.bufferCapacity,
        inputFlowLimit = energy.inputFlowLimit,
        energyDrain = energy.drain,
        repairBaseHealth = baseHealth,
        baseTint = tierColors[tier],
        turretTint = typeColor,
        ingredients = ingredients,
        resistances = getResistances(tier),
        nextUpdate = nextUpgrade,
        tech = tech,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, laserTurretSniperSpaceAgeMaterials)
    }
end
