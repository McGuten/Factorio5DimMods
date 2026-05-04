require("__5dim_core__.lib.equipment.generation-fission-reactor-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    powerMultiplier = 1.45,
    baseTechCount = 800,
    subgroup = "armor-fission-reactor"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    { number = "01", new = false, order = "a", power = 1500, tech = nil },
    {
        number = "02", new = true, order = "b",
        power = 2500,
        tech = {
            number = 2,
            countMultiplier = 2,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "fission-reactor-equipment" }
        }
    },
    {
        number = "03", new = true, order = "c",
        power = 4000,
        tech = {
            number = 3,
            countMultiplier = 3,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "fission-reactor-equipment-2" }
        }
    },
    {
        number = "04", new = true, order = "d",
        power = 6000,
        tech = {
            number = 4,
            countMultiplier = 4,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "fission-reactor-equipment-3" }
        }
    },
    {
        number = "05", new = true, order = "e",
        power = 9000,
        tech = {
            number = 5,
            countMultiplier = 5,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "fission-reactor-equipment-4" }
        }
    },
    {
        number = "06", new = true, order = "f",
        power = 12500,
        tech = {
            number = 6,
            countMultiplier = 6,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "fission-reactor-equipment-5" }
        }
    },
    {
        number = "07", new = true, order = "g",
        power = 16500,
        tech = {
            number = 7,
            countMultiplier = 7,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "fission-reactor-equipment-6" }
        }
    },
    {
        number = "08", new = true, order = "h",
        power = 21000,
        tech = {
            number = 8,
            countMultiplier = 8,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "fission-reactor-equipment-7" }
        }
    },
    {
        number = "09", new = true, order = "i",
        power = 26000,
        tech = {
            number = 9,
            countMultiplier = 9,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "fission-reactor-equipment-8" }
        }
    },
    {
        number = "10", new = true, order = "j",
        power = 32000,
        tech = {
            number = 10,
            countMultiplier = 10,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "fission-reactor-equipment-9" }
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

    genFissionReactors {
        number = tier.number,
        subgroup = config.subgroup,
        power = tier.power,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.fissionReactorEquipment[i],
        tech = techData
    }
end
