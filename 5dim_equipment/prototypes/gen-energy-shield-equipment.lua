require("__5dim_core__.lib.equipment.generation-energy-shield-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-- Explicit per-tier tuning keeps late shields usable without turning them into
-- infinite HP pools against the more aggressive 5dim_enemies roster.
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 200,
    subgroup = "armor-shield"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    {
        number = "01", new = false, order = "a", tech = nil,
        shieldCapacity = 50,
        bufferCapacity = 120,
        inputFlow = 240
    },
    {
        number = "02", new = false, order = "b", tech = nil,
        shieldCapacity = 300,
        bufferCapacity = 360,
        inputFlow = 720
    },
    {
        number = "03", new = true, order = "c",
        shieldCapacity = 975,
        bufferCapacity = 2160,
        inputFlow = 2160,
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
        shieldCapacity = 2100,
        bufferCapacity = 4320,
        inputFlow = 4320,
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
        shieldCapacity = 4125,
        bufferCapacity = 8100,
        inputFlow = 8100,
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
        shieldCapacity = 7500,
        bufferCapacity = 13500,
        inputFlow = 13500,
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
        shieldCapacity = 12950,
        bufferCapacity = 22050,
        inputFlow = 22050,
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
        shieldCapacity = 21600,
        bufferCapacity = 36000,
        inputFlow = 36000,
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
        shieldCapacity = 35100,
        bufferCapacity = 56700,
        inputFlow = 56700,
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
        shieldCapacity = 56000,
        bufferCapacity = 90000,
        inputFlow = 90000,
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

    genEnergyShields {
        number = tier.number,
        subgroup = config.subgroup,
        capacity = tier.bufferCapacity,
        shieldCapacity = tier.shieldCapacity,
        inputFlow = tier.inputFlow,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.energyShieldEquipment[i],
        tech = techData
    }
end
