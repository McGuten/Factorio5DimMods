require("__5dim_core__.lib.equipment.generation-personal-roboport-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseBufferCapacity = 10,
    bufferMultiplier = 1.5,
    baseRobotLimit = 10,
    robotIncrement = 10,
    baseConstructionRadius = 15,
    radiusIncrement = 1,
    baseInputFlow = 2000,
    inputMultiplier = 2,
    baseChargingEnergy = 1000,
    chargingIncrement = 500,
    baseTechCount = 200,
    subgroup = "armor-roboport"
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
            prerequisites = { "personal-roboport-mk2-equipment" }
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
            prerequisites = { "5d-personal-roboport-equipment-1" }
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
            prerequisites = { "5d-personal-roboport-equipment-2" }
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
            prerequisites = { "5d-personal-roboport-equipment-3" }
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
            prerequisites = { "5d-personal-roboport-equipment-4" }
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
            prerequisites = { "5d-personal-roboport-equipment-5" }
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
            prerequisites = { "5d-personal-roboport-equipment-6" }
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
            prerequisites = { "5d-personal-roboport-equipment-7" }
        }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------
local bufferCapacity = config.baseBufferCapacity
local robotLimit = config.baseRobotLimit
local constructionRadius = config.baseConstructionRadius
local inputFlow = config.baseInputFlow
local chargingEnergy = config.baseChargingEnergy

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

    genPersonalRoboports {
        number = tier.number,
        subgroup = config.subgroup,
        capacity = bufferCapacity,
        inputFlow = inputFlow,
        robotLimit = robotLimit,
        constructionRadius = constructionRadius,
        charging = chargingEnergy,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.personalRoboportEquipment[i],
        tech = techData
    }

    bufferCapacity = bufferCapacity * config.bufferMultiplier
    robotLimit = robotLimit + config.robotIncrement
    constructionRadius = constructionRadius + config.radiusIncrement
    inputFlow = inputFlow * config.inputMultiplier
    chargingEnergy = chargingEnergy + config.chargingIncrement
end
