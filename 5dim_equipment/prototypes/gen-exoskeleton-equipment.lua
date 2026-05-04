require("__5dim_core__.lib.equipment.generation-exoskeleton-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 400,
    subgroup = "armor-exoskeleton"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    {
        number = "01", new = false, order = "a",
        energyConsumption = 200,
        movementSpeed = 0.3,
        tech = nil
    },
    {
        number = "02", new = true, order = "b",
        energyConsumption = 275,
        movementSpeed = 0.4,
        tech = {
            number = 2,
            countMultiplier = 2,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 }
            },
            prerequisites = { "exoskeleton-equipment" }
        }
    },
    {
        number = "03", new = true, order = "c",
        energyConsumption = 350,
        movementSpeed = 0.5,
        tech = {
            number = 3,
            countMultiplier = 3,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 }
            },
            prerequisites = { "exoskeleton-equipment-2" }
        }
    },
    {
        number = "04", new = true, order = "d",
        energyConsumption = 425,
        movementSpeed = 0.6,
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
            prerequisites = { "exoskeleton-equipment-3" }
        }
    },
    {
        number = "05", new = true, order = "e",
        energyConsumption = 500,
        movementSpeed = 0.75,
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
            prerequisites = { "exoskeleton-equipment-4" }
        }
    },
    {
        number = "06", new = true, order = "f",
        energyConsumption = 575,
        movementSpeed = 0.9,
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
            prerequisites = { "exoskeleton-equipment-5" }
        }
    },
    {
        number = "07", new = true, order = "g",
        energyConsumption = 650,
        movementSpeed = 1.05,
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
            prerequisites = { "exoskeleton-equipment-6" }
        }
    },
    {
        number = "08", new = true, order = "h",
        energyConsumption = 725,
        movementSpeed = 1.2,
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
            prerequisites = { "exoskeleton-equipment-7" }
        }
    },
    {
        number = "09", new = true, order = "i",
        energyConsumption = 800,
        movementSpeed = 1.35,
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
            prerequisites = { "exoskeleton-equipment-8" }
        }
    },
    {
        number = "10", new = true, order = "j",
        energyConsumption = 875,
        movementSpeed = 1.5,
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
            prerequisites = { "exoskeleton-equipment-9" }
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

    genExoskeletons {
        number = tier.number,
        subgroup = config.subgroup,
        energyConsumption = tier.energyConsumption,
        movementSpeed = tier.movementSpeed,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.exoskeletonEquipment[i],
        tech = techData
    }
end
