require("__5dim_core__.lib.equipment.generation-battery-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 200,
    subgroup = "armor-battery"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

-- Tier 03 special handling for Space Age battery-mk3
local tier03Config
if mods["space-age"] then
    -- When Space Age is active, tier 03 uses battery-mk3-equipment as vanilla
    tier03Config = { 
        number = "03", new = false, order = "c",
        capacity = 250,
        tech = nil -- battery-mk3-equipment tech already exists in Space Age
    }
else
    -- Without Space Age, tier 03 is a new item
    tier03Config = {
        number = "03", new = true, order = "c",
        capacity = 250,
        tech = {
            number = 1,
            countMultiplier = 2,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 }
            },
            prerequisites = { "battery-mk2-equipment" }
        }
    }
end

local tiers = {
    { number = "01", new = false, order = "a", capacity = 20, tech = nil },
    { number = "02", new = false, order = "b", capacity = 100, tech = nil },
    tier03Config,
    {
        number = "04", new = true, order = "d",
        capacity = 400,
        tech = {
            number = 2,
            countMultiplier = 3,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = mods["space-age"] and { "battery-mk3-equipment" } or { "5d-battery-equipment-1" }
        }
    },
    {
        number = "05", new = true, order = "e",
        capacity = 600,
        tech = {
            number = 3,
            countMultiplier = 4,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-2" }
        }
    },
    {
        number = "06", new = true, order = "f",
        capacity = 850,
        tech = {
            number = 4,
            countMultiplier = 5,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-3" }
        }
    },
    {
        number = "07", new = true, order = "g",
        capacity = 1150,
        tech = {
            number = 5,
            countMultiplier = 6,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-4" }
        }
    },
    {
        number = "08", new = true, order = "h",
        capacity = 1500,
        tech = {
            number = 6,
            countMultiplier = 7,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-5" }
        }
    },
    {
        number = "09", new = true, order = "i",
        capacity = 1900,
        tech = {
            number = 7,
            countMultiplier = 8,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-6" }
        }
    },
    {
        number = "10", new = true, order = "j",
        capacity = 2400,
        tech = {
            number = 8,
            countMultiplier = 9,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-7" }
        }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------
for i, tier in ipairs(tiers) do
    local techData = nil
    local tierTech = tier.tech
    if tierTech then
        techData = {
            number = tierTech.number,
            count = config.baseTechCount * tierTech.countMultiplier,
            packs = tierTech.packs,
            prerequisites = tierTech.prerequisites
        }
    end

    genBatterys {
        number = tier.number,
        subgroup = config.subgroup,
        capacity = tier.capacity,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.batteryEquipment[i],
        tech = techData
    }
end
