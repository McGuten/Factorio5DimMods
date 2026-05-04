-------------------------------------------------------------------------------
-- 5Dim's Vehicles - Spidertron Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.vehicles.generation-spidertron")

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
    [2] = 4500,
    [3] = 6300,
    [4] = 8400,
    [5] = 11100,
    [6] = 14400,
    [7] = 18300,
    [8] = 22500,
    [9] = 26700,
    [10] = 30000
}
local baseMovementEnergy = 250        -- kW
local movementEnergyIncrement = 50    -- +50 kW per tier
local baseInventory = 80
local inventoryIncrement = 20         -- +20 slots per tier
local baseTechCount = 500

-------------------------------------------------------------------------------
-- RESISTANCE SCALING
-- Base resistances follow vanilla spidertron and improve per tier.
-------------------------------------------------------------------------------

local function getResistances(tier)
    local bonus = (tier - 1) * 3
    local decreaseBonus = (tier - 1) * 2

    return {
        { type = "fire", decrease = 15 + decreaseBonus, percent = math.min(60 + bonus, 97) },
        { type = "physical", decrease = 15 + decreaseBonus, percent = math.min(60 + bonus, 97) },
        { type = "impact", decrease = 50 + (tier - 1) * 6, percent = math.min(80 + bonus, 99) },
        { type = "explosion", decrease = 20 + decreaseBonus, percent = math.min(75 + bonus, 98) },
        { type = "acid", decrease = 10 + decreaseBonus, percent = math.min(75 + bonus, 97) },
        { type = "laser", decrease = 8 + decreaseBonus, percent = math.min(70 + bonus, 96) },
        { type = "electric", decrease = 10 + decreaseBonus, percent = math.min(75 + bonus, 97) },
        { type = "poison", decrease = 15 + decreaseBonus, percent = math.min(85 + bonus, 99) }
    }
end

local function getLegResistances(tier)
    local resistances = table.deepcopy(getResistances(tier))

    for index, resistance in ipairs(resistances) do
        if resistance.type == "explosion" then
            resistances[index] = { type = "explosion", percent = 100 }
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
    [3] = { width = 11, height = 7 },
    [4] = { width = 11, height = 8 },
    [5] = { width = 12, height = 8 },
    [6] = { width = 12, height = 9 },
    [7] = { width = 13, height = 9 },
    [8] = { width = 13, height = 10 },
    [9] = { width = 14, height = 10 },
    [10] = { width = 14, height = 11 }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-spidertron-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier, config in pairs(tierConfig) do
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
    elseif tier == 2 then
        ingredients = {
            { type = "item", name = "spidertron", amount = 1 },
            { type = "item", name = "low-density-structure", amount = 50 },
            { type = "item", name = "processing-unit", amount = 32 },
            { type = "item", name = "rocket-launcher", amount = 2 }
        }
    else
        ingredients = {
            { type = "item", name = "5d-spidertron-" .. (tier - 1), amount = 1 },
            { type = "item", name = "low-density-structure", amount = 50 + (tier - 2) * 25 },
            { type = "item", name = "processing-unit", amount = 32 + (tier - 2) * 16 },
            { type = "item", name = "rocket-launcher", amount = 2 + (tier - 2) }
        }
    end

    -- Technology configuration
    local tech = nil
    if tierTech then
        tech = {
            number = tier,
            count = baseTechCount * tier,
            packs = tierTech.basePacks,
            prerequisites = tierTech.prerequisites
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
        health = health,
        movementEnergy = movementEnergy .. "kW",
        inventorySize = inventorySize,
        trashInventorySize = trashSize,
        resistances = getResistances(tier),
        legResistances = getLegResistances(tier),
        equipmentGrid = equipmentGrid,
        ingredients = ingredients,
        tint = tierColor,
        nextUpdate = nextUpgrade,
        tech = tech
    })
end
