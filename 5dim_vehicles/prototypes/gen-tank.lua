-------------------------------------------------------------------------------
-- 5Dim's Vehicles - Tank Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.vehicles.generation-tank")

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
    [2] = 3000,
    [3] = 4200,
    [4] = 5600,
    [5] = 7500,
    [6] = 9800,
    [7] = 12400,
    [8] = 15200,
    [9] = 18000,
    [10] = 20000
}
local baseConsumption = 600           -- kW
local consumptionIncrement = 100      -- +100 kW per tier
local baseBrakingPower = 800          -- kW
local brakingPowerIncrement = 200     -- +200 kW per tier
local baseTechCount = 200

-------------------------------------------------------------------------------
-- RESISTANCE SCALING
-- Base resistances: fire 60%, physical 60%, impact 80%, explosion 70%, acid 70%
-------------------------------------------------------------------------------

local function getResistances(tier)
    local bonus = (tier - 1) * 3  -- +3% per tier
    return {
        { type = "fire", decrease = 15 + (tier - 1) * 3, percent = math.min(60 + bonus, 96) },
        { type = "physical", decrease = 15 + (tier - 1) * 3, percent = math.min(60 + bonus, 96) },
        { type = "impact", decrease = 50 + (tier - 1) * 6, percent = math.min(80 + bonus, 98) },
        { type = "explosion", decrease = 15 + (tier - 1) * 3, percent = math.min(70 + bonus, 96) },
        { type = "acid", decrease = 5 + (tier - 1) * 3, percent = math.min(70 + bonus, 96) },
        { type = "electric", decrease = 5 + (tier - 1) * 2, percent = math.min(60 + bonus, 94) },
        { type = "poison", decrease = 8 + (tier - 1) * 3, percent = math.min(70 + bonus, 97) }
    }
end

-------------------------------------------------------------------------------
-- EQUIPMENT GRID DEFINITIONS
-------------------------------------------------------------------------------

local tankGridSizes = {
    [2] = { width = 6, height = 9 },
    [3] = { width = 7, height = 9 },
    [4] = { width = 7, height = 10 },
    [5] = { width = 8, height = 10 },
    [6] = { width = 8, height = 11 },
    [7] = { width = 9, height = 11 },
    [8] = { width = 9, height = 12 },
    [9] = { width = 10, height = 12 },
    [10] = { width = 10, height = 13 }
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
        prerequisites = { "5d-tank-3" }
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
        prerequisites = { "5d-tank-5" }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-tank-9" }
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
    local consumption = baseConsumption + (tier - 1) * consumptionIncrement
    local brakingPower = baseBrakingPower + (tier - 1) * brakingPowerIncrement
    local equipmentGrid = tier == 1 and "medium-equipment-grid" or "5d-tank-equipment-grid-" .. tier
    
    -- Get tier color
    local tierColor = tierColors[tier]

    -- Calculate ingredients
    local ingredients
    if tier == 1 then
        ingredients = nil  -- Vanilla recipe
    elseif tier == 2 then
        ingredients = {
            { type = "item", name = "tank", amount = 1 },
            { type = "item", name = "steel-plate", amount = 50 },
            { type = "item", name = "engine-unit", amount = 16 },
            { type = "item", name = "iron-gear-wheel", amount = 30 }
        }
    else
        ingredients = {
            { type = "item", name = "5d-tank-" .. (tier - 1), amount = 1 },
            { type = "item", name = "steel-plate", amount = 50 + (tier - 2) * 20 },
            { type = "item", name = "engine-unit", amount = 16 + (tier - 2) * 4 },
            { type = "item", name = "iron-gear-wheel", amount = 30 + (tier - 2) * 10 }
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
