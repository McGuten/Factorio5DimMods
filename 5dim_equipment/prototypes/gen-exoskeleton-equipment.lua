require("__5dim_core__.lib.equipment.generation-exoskeleton-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseEnergyConsumption = 200,
    consumptionIncrement = 100,
    baseMovementSpeed = 0.3,
    speedIncrement = 0.1,
    baseTechCount = 400,
    subgroup = "armor-exoskeleton"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    { number = "01", new = false, order = "a", tech = nil },
    {
        number = "02", new = true, order = "b",
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
local energyConsumption = config.baseEnergyConsumption
local movementSpeed = config.baseMovementSpeed

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

    genExoskeletons {
        number = tier.number,
        subgroup = config.subgroup,
        energyConsumption = energyConsumption,
        movementSpeed = movementSpeed,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.exoskeletonEquipment[i],
        tech = techData
    }

    energyConsumption = energyConsumption + config.consumptionIncrement
    movementSpeed = movementSpeed + config.speedIncrement
end
