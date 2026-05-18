-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Gun Turret Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.gun-turret.generation-gun-turret")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local TierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Scale: HP x5 (480 → 2400 at T10), Damage +45% at T10
-------------------------------------------------------------------------------

local baseRange = 18
local baseAmmo = 10
local baseShootingSpeed = 6
local baseDamageModif = 1
local baseHealth = 480
local rangeIncrement = 3
local damageScalePerTier = 0.05
local healthIncrement = 213               -- 480 → 2400 (x5)
local baseTechCount = 100
local lateTierHealthBonus = {
    [8] = 500,
    [9] = 900,
    [10] = 1300
}

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
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "gun-turret", "military-science-pack" }
    },
    [3] = {
        techName = "gun-turret-3",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "gun-turret-2" }
    },
    [4] = {
        techName = "gun-turret-4",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "gun-turret-3", "chemical-science-pack" }
    },
    [5] = {
        techName = "gun-turret-5",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "gun-turret-4", "production-science-pack" }
    },
    [6] = {
        techName = "gun-turret-6",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "gun-turret-5" }
    },
    [7] = {
        techName = "gun-turret-7",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "gun-turret-6" }
    },
    [8] = {
        techName = "gun-turret-8",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "gun-turret-7", "utility-science-pack" }
    },
    [9] = {
        techName = "gun-turret-9",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "gun-turret-8" }
    },
    [10] = {
        techName = "gun-turret-10",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "gun-turret-9" }
    }
}

local gunTurretSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 12, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-iron", amount = 120, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 12, category = "metallurgy" },
    [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 6, category = "electromagnetics" },
    [10] = { name = "lithium-plate", amount = 10, category = "cryogenics" }
}

local gunTurretSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local gunTurretSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "lithium-processing"
}

local gunTurretDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "concrete",
    [4] = "advanced-circuit",
    [5] = "battery",
    [6] = "engine",
    [7] = "electric-engine",
    [8] = "processing-unit",
    [9] = "low-density-structure",
    [10] = "speed-module-2"
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

local function getGunTurretDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and gunTurretSpaceAgeDeltaPrerequisites[tier] then
        return gunTurretSpaceAgeDeltaPrerequisites[tier]
    end

    return gunTurretDeltaPrerequisites[tier]
end
-------------------------------------------------------------------------------
-- RESISTANCES BY TIER
-------------------------------------------------------------------------------

local function getResistances(tier)
    local firePercent = 5 + (tier - 1) * 5
    local explosionPercent = 2.5 + (tier - 1) * 2.5
    local resistances = {
        { type = "fire", percent = firePercent },
        { type = "explosion", percent = explosionPercent }
    }

    if tier >= 8 then
        local lateStep = tier - 8
        table.insert(resistances, { type = "physical", decrease = 3 + lateStep, percent = 20 + (lateStep * 5) })
        table.insert(resistances, { type = "acid", percent = 10 + (lateStep * 5) })
        table.insert(resistances, { type = "laser", percent = 10 + (lateStep * 5) })
    end

    return resistances
end

local function getHealth(tier)
    return baseHealth + ((tier - 1) * healthIncrement) + (lateTierHealthBonus[tier] or 0)
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local range = baseRange + (tier - 1) * rangeIncrement
    local damageModifier = baseDamageModif * (1 + (tier - 1) * damageScalePerTier)
    local health = getHealth(tier)
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.gunTurret[tier], tier, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = gunTurretSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-gun-turret-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getGunTurretDeltaPrerequisite(tier))

        tech = {
            number = tc.techName,
            count = baseTechCount * tc.countMultiplier,
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = gunTurretSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
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
        damageModifier = damageModifier,
        health = health,
        baseTint = TierColors[tier],
        turretTint = typeColor,
        ingredients = ingredients,
        resistances = getResistances(tier),
        nextUpdate = nextUpgrade,
        tech = tech,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, gunTurretSpaceAgeMaterials)
    }
end
