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
-- Scale: HP x5 (3000 → 15000)
-------------------------------------------------------------------------------

local baseHealth = 3000
local healthIncrement = 1333          -- +1333 HP per tier → 3000 → 15000 (x5)
local baseMovementEnergy = 250        -- kW
local movementEnergyIncrement = 50    -- +50 kW per tier
local baseInventory = 80
local inventoryIncrement = 20         -- +20 slots per tier
local baseTechCount = 500

-------------------------------------------------------------------------------
-- EQUIPMENT GRID DEFINITIONS
-- Base grid: 10x6 (60 slots)
-- Each tier adds more space
-------------------------------------------------------------------------------

for tier = 2, 10 do
    local gridWidth = 10 + (tier - 1)      -- 10, 11, 12, 13, 14, 15, 16, 17, 18
    local gridHeight = 6 + math.floor((tier - 1) / 2)  -- 6, 6, 7, 7, 8, 8, 9, 9, 10
    
    data:extend({
        {
            type = "equipment-grid",
            name = "5d-spidertron-equipment-grid-" .. tier,
            width = gridWidth,
            height = gridHeight,
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
    local health = baseHealth + (tier - 1) * healthIncrement
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
        equipmentGrid = equipmentGrid,
        ingredients = ingredients,
        tint = tierColor,
        nextUpdate = nextUpgrade,
        tech = tech
    })
end
