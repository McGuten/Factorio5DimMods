require("__5dim_core__.lib.equipment.generation-energy-shield-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-- Scale: Shield capacity x5, Buffer x5
-------------------------------------------------------------------------------
local config = {
    baseBufferCapacity = 120,
    bufferIncrement = 60,
    baseShieldCapacity = 50,
    shieldMultiplier = 2.5,               -- x5 at T10 vs x2 original
    baseInputFlow = 240,
    inputIncrement = 120,
    baseTechCount = 200,
    subgroup = "armor-shield"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    { number = "01", new = false, order = "a", tech = nil },
    { number = "02", new = false, order = "b", tech = nil },
    {
        number = "03", new = true, order = "c",
        tech = {
            number = 1,
            countMultiplier = 2,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "energy-shield-mk2-equipment" }
        }
    },
    {
        number = "04", new = true, order = "d",
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
            prerequisites = { "5d-energy-shield-equipment-1" }
        }
    },
    {
        number = "05", new = true, order = "e",
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
            prerequisites = { "5d-energy-shield-equipment-2" }
        }
    },
    {
        number = "06", new = true, order = "f",
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
            prerequisites = { "5d-energy-shield-equipment-3" }
        }
    },
    {
        number = "07", new = true, order = "g",
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
            prerequisites = { "5d-energy-shield-equipment-4" }
        }
    },
    {
        number = "08", new = true, order = "h",
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
            prerequisites = { "5d-energy-shield-equipment-5" }
        }
    },
    {
        number = "09", new = true, order = "i",
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
            prerequisites = { "5d-energy-shield-equipment-6" }
        }
    },
    {
        number = "10", new = true, order = "j",
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
            prerequisites = { "5d-energy-shield-equipment-7" }
        }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------
local bufferCapacity = config.baseBufferCapacity
local shieldCapacity = config.baseShieldCapacity
local inputFlow = config.baseInputFlow

for i, tier in ipairs(tiers) do
    local techData = nil
    if tier.tech then
        techData = {
            number = tier.tech.number,
            count = config.baseTechCount * tier.tech.countMultiplier,
            packs = tier.tech.packs,
            prerequisites = tier.tech.prerequisites
        }
    end

    genEnergyShields {
        number = tier.number,
        subgroup = config.subgroup,
        capacity = bufferCapacity,
        shieldCapacity = shieldCapacity,
        inputFlow = inputFlow,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.energyShieldEquipment[i],
        tech = techData
    }

    bufferCapacity = bufferCapacity + config.bufferIncrement
    shieldCapacity = shieldCapacity * config.shieldMultiplier
    inputFlow = inputFlow + config.inputIncrement
end
