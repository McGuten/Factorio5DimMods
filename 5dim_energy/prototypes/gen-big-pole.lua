-------------------------------------------------------------------------------
-- 5Dim's Energy - Big Electric Pole Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.energy.generation-big-pole")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseWireDistance = 32
local baseSupplyArea = 2
local baseHealth = data.raw["electric-pole"]["big-electric-pole"].max_health
local baseTechCount = 150
local wireDistanceMultiplier = 3
local supplyAreaMultiplier = 5
local maxWireDistance = math.min(64, baseWireDistance * wireDistanceMultiplier)
local maxSupplyArea = math.min(64, baseSupplyArea * supplyAreaMultiplier)

local bigPoleSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 8, category = "electromagnetics" },
    [8] = { name = "supercapacitor", amount = 6, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 4, category = "electromagnetics" },
    [10] = { name = "lithium-plate", amount = 8, category = "cryogenics" }
}

local bigPoleSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local bigPoleSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "lithium-processing"
}

local bigPoleDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "concrete",
    [4] = "battery",
    [5] = "advanced-circuit",
    [6] = "processing-unit",
    [7] = "low-density-structure",
    [8] = "efficiency-module",
    [9] = "speed-module-2",
    [10] = "speed-module-3"
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

local function getBigPoleDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and bigPoleSpaceAgeDeltaPrerequisites[tier] then
        return bigPoleSpaceAgeDeltaPrerequisites[tier]
    end

    return bigPoleDeltaPrerequisites[tier]
end

local function applyTier11Bonus(value, decimals)
    local boostedValue = math.min(value * CostConfig.getMachineWorkFactor(), 64)
    local factor = 10 ^ (decimals or 0)

    return math.floor((boostedValue * factor) + 0.5) / factor
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
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = { "electric-energy-distribution-1" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-substation-1", "5d-medium-electric-pole-1", "5d-big-electric-pole-1", "chemical-science-pack" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-substation-2", "5d-medium-electric-pole-2", "5d-big-electric-pole-2" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-substation-3", "5d-medium-electric-pole-3", "5d-big-electric-pole-3", "production-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-substation-4", "5d-medium-electric-pole-4", "5d-big-electric-pole-4" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-substation-5", "5d-medium-electric-pole-5", "5d-big-electric-pole-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-substation-6", "5d-medium-electric-pole-6", "5d-big-electric-pole-6" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-substation-7", "5d-medium-electric-pole-7", "5d-big-electric-pole-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-substation-8", "5d-medium-electric-pole-8", "5d-big-electric-pole-8" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local wireDistance = CostCalculator.calculateCappedMachineWorkValue(baseWireDistance, tier, 10, maxWireDistance, 0)
    local supplyArea = CostCalculator.calculateCappedMachineWorkValue(baseSupplyArea, tier, 10, maxSupplyArea, 1)
    local health = CostCalculator.calculateMachineWorkValue(baseHealth, tier, 10, 0)

    if tier == 10 then
        wireDistance = applyTier11Bonus(wireDistance, 0)
        supplyArea = applyTier11Bonus(supplyArea, 1)
    end
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.bigElectricPole[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = bigPoleSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getBigPoleDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = bigPoleSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the big electric pole
    genBigPoles {
        number = tierNum,
        subgroup = "energy-big",
        craftingSpeed = wireDistance,
        energyUsage = supplyArea,
        maxHealth = health,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = tier < 10 and ("5d-big-electric-pole-" .. string.format("%02d", tier + 1)) or nil,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, bigPoleSpaceAgeMaterials),
        tech = tech
    }
end
