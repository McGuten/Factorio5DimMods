-------------------------------------------------------------------------------
-- 5Dim's Vehicles - Tank Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.vehicles.generation-tank")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Tank base stats:
-- max_health = 2000
-- consumption = 600kW
-- braking_power = 800kW
-- Scale: HP 2000 -> 20000
-------------------------------------------------------------------------------

local healthByTier = {
    [1] = 2000,
    [2] = 2800,
    [3] = 3800,
    [4] = 5000,
    [5] = 6500,
    [6] = 8200,
    [7] = 10000,
    [8] = 12000,
    [9] = 14000,
    [10] = 16000
}
local baseConsumption = 600           -- kW
local consumptionIncrement = 100      -- +100 kW per tier
local baseBrakingPower = 800          -- kW
local brakingPowerIncrement = 200     -- +200 kW per tier
local baseTechCount = 200

local tankTechCounts = {
    [2] = 500,
    [3] = 800,
    [4] = 1200,
    [5] = 1800,
    [6] = 2500,
    [7] = 3300,
    [8] = 4300,
    [9] = 5500,
    [10] = 7000
}

local tankSpaceAgeMaterials = {
    [8] = { name = "holmium-plate", amount = 20 },
    [9] = { name = "supercapacitor", amount = 10 },
    [10] = { name = "fusion-power-cell", amount = 6 }
}

local tankSpaceAgeSciencePacks = {
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local tankSpaceAgeDeltaPrerequisites = {
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local tankRecipeTemplates = {
    [2] = {
        { type = "item", name = "tank", amount = 1 },
        { type = "item", name = "battery", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-tank-2", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 16 }
    },
    [4] = {
        { type = "item", name = "5d-tank-3", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-tank-4", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-tank-5", amount = 1 },
        { type = "item", name = "rocket-fuel", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-tank-6", amount = 1 },
        { type = "item", name = "exoskeleton-equipment", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-tank-7", amount = 1 },
        { type = "item", name = "energy-shield-mk2-equipment", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-tank-8", amount = 1 },
        { type = "item", name = "personal-laser-defense-equipment", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-tank-9", amount = 1 },
        { type = "item", name = "fission-reactor-equipment", amount = 2 }
    }
}

local tankDeltaPrerequisites = {
    [2] = "battery",
    [3] = "electric-engine",
    [4] = "processing-unit",
    [5] = "low-density-structure",
    [6] = "rocket-fuel",
    [7] = "exoskeleton-equipment",
    [8] = "energy-shield-mk2-equipment",
    [9] = "personal-laser-defense-equipment",
    [10] = "fission-reactor-equipment"
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

local function getTankDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and tankSpaceAgeDeltaPrerequisites[tier] then
        return tankSpaceAgeDeltaPrerequisites[tier]
    end

    return tankDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- RESISTANCE SCALING
-- Base resistances: fire 60%, physical 60%, impact 80%, explosion 70%, acid 70%
-------------------------------------------------------------------------------

local function getResistances(tier)
    local bonus = (tier - 1) * 2
    return {
        { type = "fire", decrease = 15 + (tier - 1) * 2, percent = math.min(60 + bonus, 84) },
        { type = "physical", decrease = 15 + (tier - 1) * 2, percent = math.min(60 + bonus, 84) },
        { type = "impact", decrease = 50 + (tier - 1) * 4, percent = math.min(80 + math.floor((tier - 1) * 1.5), 93) },
        { type = "explosion", decrease = 15 + (tier - 1) * 2, percent = math.min(70 + bonus, 88) },
        { type = "acid", decrease = 5 + (tier - 1) * 2, percent = math.min(70 + bonus, 88) },
        { type = "electric", decrease = 5 + (tier - 1), percent = math.min(60 + bonus, 80) },
        { type = "poison", decrease = 8 + (tier - 1) * 2, percent = math.min(70 + bonus, 88) }
    }
end

-------------------------------------------------------------------------------
-- EQUIPMENT GRID DEFINITIONS
-------------------------------------------------------------------------------

local tankGridSizes = {
    [2] = { width = 6, height = 8 },
    [3] = { width = 7, height = 8 },
    [4] = { width = 7, height = 9 },
    [5] = { width = 8, height = 9 },
    [6] = { width = 8, height = 10 },
    [7] = { width = 9, height = 10 },
    [8] = { width = 9, height = 11 },
    [9] = { width = 10, height = 11 },
    [10] = { width = 10, height = 12 }
}

-- Create equipment grids for each tier
for tier = 2, 10 do
    local gridSize = tankGridSizes[tier]
    
    data:extend({
        {
            type = "equipment-grid",
            name = "5d-tank-equipment-grid-" .. tier,
            width = gridSize.width,
            height = gridSize.height,
            equipment_categories = {"armor"}
        }
    })
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
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "tank" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-tank-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-tank-3", "production-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-tank-4" }
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
        prerequisites = { "5d-tank-5", "utility-science-pack" }
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
        prerequisites = { "5d-tank-6" }
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
        prerequisites = { "5d-tank-7" }
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
        prerequisites = { "5d-tank-8" }
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
        prerequisites = { "5d-tank-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local isVanilla = config.isVanilla or false
    local tierTech = techConfig[tier]

    -- Calculate stats for this tier
    local health = healthByTier[tier]
    local consumption = baseConsumption + (tier - 1) * consumptionIncrement
    local brakingPower = baseBrakingPower + (tier - 1) * brakingPowerIncrement
    local equipmentGrid = tier == 1 and "medium-equipment-grid" or "5d-tank-equipment-grid-" .. tier
    
    -- Get tier color
    local tierColor = tierColors[tier]

    -- Calculate ingredients
    local ingredients
    if tier == 1 then
        ingredients = nil  -- Vanilla recipe
    else
        ingredients = CostCalculator.processIngredients(tankRecipeTemplates[tier], tier, {
            skipTierScaling = true,
            spaceAgeMaterialOverrides = tankSpaceAgeMaterials
        })
    end

    -- Technology configuration
    local tech = nil
    if tierTech then
        local prerequisites = copyPrerequisites(tierTech.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getTankDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.scaleAbsoluteTechCount(tankTechCounts[tier]),
            packs = CostCalculator.getTechPacks(tierTech.basePacks, tier, {
                spaceAgePackOverrides = tankSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    -- Next upgrade
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-tank-" .. (tier + 1)
    end

    -- Generate tank
    genTank({
        number = tier,
        new = not isVanilla,
        subgroup = "vehicles-tank",
        order = config.order,
        health = health,
        consumption = consumption .. "kW",
        brakingPower = brakingPower .. "kW",
        resistances = getResistances(tier),
        equipmentGrid = equipmentGrid,
        ingredients = ingredients,
        tint = tierColor,
        nextUpdate = nextUpgrade,
        tech = tech
    })
end
