-------------------------------------------------------------------------------
-- 5Dim's Vehicles - Spidertron Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.vehicles.generation-spidertron")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Spidertron base stats:
-- max_health = 3000
-- movement_energy_consumption = 250kW
-- inventory_size = 80
-- equipment_grid = 10x6
-- Scale: HP 3000 -> 30000
-------------------------------------------------------------------------------

local healthByTier = {
    [1] = 3000,
    [2] = 4200,
    [3] = 5600,
    [4] = 7200,
    [5] = 9000,
    [6] = 11200,
    [7] = 13600,
    [8] = 16200,
    [9] = 19000,
    [10] = 22000
}
local baseMovementEnergy = 250        -- kW
local movementEnergyIncrement = 50    -- +50 kW per tier
local baseInventory = 80
local inventoryIncrement = 12         -- +12 slots per tier
local baseTechCount = 500

local spidertronTechCounts = {
    [2] = 900,
    [3] = 1300,
    [4] = 1800,
    [5] = 2400,
    [6] = 3200,
    [7] = 4200,
    [8] = 5400,
    [9] = 6800,
    [10] = 8500
}

local spidertronSpaceAgeMaterials = {
    [8] = { name = "carbon-fiber", amount = 25 },
    [9] = { name = "space-platform-foundation", amount = 12 },
    [10] = { name = "quantum-processor", amount = 15 }
}

local spidertronSpaceAgeSciencePacks = {
    [8] = { "space-science-pack", "agricultural-science-pack" },
    [9] = { "space-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local spidertronSpaceAgeDeltaPrerequisites = {
    [8] = "carbon-fiber",
    [9] = "space-science-pack",
    [10] = "fusion-reactor"
}

local spidertronRecipeTemplates = {
    [2] = {
        { type = "item", name = "spidertron", amount = 1 },
        { type = "item", name = "battery-mk2-equipment", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-spidertron-2", amount = 1 },
        { type = "item", name = "energy-shield-mk2-equipment", amount = 2 }
    },
    [4] = {
        { type = "item", name = "5d-spidertron-3", amount = 1 },
        { type = "item", name = "personal-laser-defense-equipment", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-spidertron-4", amount = 1 },
        { type = "item", name = "discharge-defense-equipment", amount = 2 }
    },
    [6] = {
        { type = "item", name = "5d-spidertron-5", amount = 1 },
        { type = "item", name = "personal-roboport-mk2-equipment", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-spidertron-6", amount = 1 },
        { type = "item", name = "power-armor-mk2", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-spidertron-7", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-spidertron-8", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-spidertron-9", amount = 1 },
        { type = "item", name = "atomic-bomb", amount = 1 }
    }
}

local spidertronDeltaPrerequisites = {
    [2] = "battery-mk2-equipment",
    [3] = "energy-shield-mk2-equipment",
    [4] = "personal-laser-defense-equipment",
    [5] = "discharge-defense-equipment",
    [6] = "personal-roboport-mk2-equipment",
    [7] = "power-armor-mk2",
    [8] = "speed-module-3",
    [9] = "productivity-module-3",
    [10] = "atomic-bomb"
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

local function getSpidertronDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and spidertronSpaceAgeDeltaPrerequisites[tier] then
        return spidertronSpaceAgeDeltaPrerequisites[tier]
    end

    return spidertronDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- RESISTANCE SCALING
-- Base resistances follow vanilla spidertron and improve per tier.
-------------------------------------------------------------------------------

local function getResistances(tier)
    local bonus = (tier - 1) * 2
    local decreaseBonus = tier - 1

    return {
        { type = "fire", decrease = 15 + decreaseBonus, percent = math.min(60 + bonus, 85) },
        { type = "physical", decrease = 15 + decreaseBonus, percent = math.min(60 + bonus, 85) },
        { type = "impact", decrease = 50 + (tier - 1) * 4, percent = math.min(80 + math.floor((tier - 1) * 1.5), 94) },
        { type = "explosion", decrease = 20 + decreaseBonus, percent = math.min(75 + bonus, 91) },
        { type = "acid", decrease = 10 + decreaseBonus, percent = math.min(75 + bonus, 91) },
        { type = "laser", decrease = 8 + decreaseBonus, percent = math.min(70 + bonus, 88) },
        { type = "electric", decrease = 10 + decreaseBonus, percent = math.min(75 + bonus, 91) },
        { type = "poison", decrease = 15 + decreaseBonus, percent = math.min(85 + (tier - 1), 94) }
    }
end

local function getLegResistances(tier)
    local resistances = table.deepcopy(getResistances(tier))

    for index, resistance in ipairs(resistances) do
        if resistance.type == "explosion" then
            resistances[index] = { type = "explosion", percent = 90 }
            break
        end
    end

    return resistances
end

-------------------------------------------------------------------------------
-- EQUIPMENT GRID DEFINITIONS
-- Base grid: 10x6 (60 slots)
-- Each tier adds more space
-------------------------------------------------------------------------------

local spidertronGridSizes = {
    [2] = { width = 10, height = 7 },
    [3] = { width = 10, height = 7 },
    [4] = { width = 11, height = 7 },
    [5] = { width = 11, height = 8 },
    [6] = { width = 12, height = 8 },
    [7] = { width = 12, height = 9 },
    [8] = { width = 13, height = 9 },
    [9] = { width = 13, height = 10 },
    [10] = { width = 14, height = 10 }
}

for tier = 2, 10 do
    local gridSize = spidertronGridSizes[tier]
    
    data:extend({
        {
            type = "equipment-grid",
            name = "5d-spidertron-equipment-grid-" .. tier,
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
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "spidertron" }
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
        prerequisites = { "5d-spidertron-2" }
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
        prerequisites = { "5d-spidertron-3" }
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
        prerequisites = { "5d-spidertron-4" }
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
        prerequisites = { "5d-spidertron-5" }
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
        prerequisites = { "5d-spidertron-6" }
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
        prerequisites = { "5d-spidertron-7" }
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
        prerequisites = { "5d-spidertron-8" }
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
        prerequisites = { "5d-spidertron-9" }
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
    local movementEnergy = baseMovementEnergy + (tier - 1) * movementEnergyIncrement
    local inventorySize = baseInventory + (tier - 1) * inventoryIncrement
    local trashSize = 20 + (tier - 1) * 5
    local equipmentGrid = tier == 1 and "spidertron-equipment-grid" or "5d-spidertron-equipment-grid-" .. tier
    
    -- Get tier color
    local tierColor = tierColors[tier]

    -- Calculate ingredients
    local ingredients
    if tier == 1 then
        ingredients = nil  -- Vanilla recipe
    else
        ingredients = CostCalculator.processIngredients(spidertronRecipeTemplates[tier], tier, {
            skipTierScaling = true,
            applyMachineRecipeProgression = true,
            spaceAgeMaterialOverrides = spidertronSpaceAgeMaterials
        })
    end

    -- Technology configuration
    local tech = nil
    if tierTech then
        local prerequisites = copyPrerequisites(tierTech.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getSpidertronDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tierTech.basePacks, tier, {
                spaceAgePackOverrides = spidertronSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    -- Next upgrade
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-spidertron-" .. (tier + 1)
    end

    -- Generate spidertron
    genSpidertron({
        number = tier,
        new = not isVanilla,
        subgroup = "vehicles-spider",
        order = config.order,
        health = CostCalculator.calculateMachineWorkValue(healthByTier[1], tier, 10, 0),
        movementEnergy = CostCalculator.scaleMachineEnergy(baseMovementEnergy, tier) .. "kW",
        inventorySize = CostCalculator.calculateMachineWorkValue(baseInventory, tier, 10, 0),
        trashInventorySize = CostCalculator.calculateMachineWorkValue(20, tier, 10, 0),
        resistances = getResistances(tier),
        legResistances = getLegResistances(tier),
        equipmentGrid = equipmentGrid,
        ingredients = ingredients,
        tint = tierColor,
        nextUpdate = nextUpgrade,
        tech = tech
    })
end
