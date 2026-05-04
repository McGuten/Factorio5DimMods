require("__5dim_core__.lib.equipment.generation-personal-laser-defense-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-- Laser line: longer range, stronger single-target pressure, higher energy draw.
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 200,
    subgroup = "armor-laser"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    {
        number = "01", new = false, order = "a",
        energyConsumption = 50,
        cooldown = 40,
        range = 15,
        damage = 3.0,
        tech = nil
    },
    {
        number = "02", new = true, order = "b",
        energyConsumption = 70,
        cooldown = 38,
        range = 18,
        damage = 4.5,
        tech = {
            number = 2,
            countMultiplier = 2,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 }
            },
            prerequisites = { "personal-laser-defense-equipment" }
        }
    },
    {
        number = "03", new = true, order = "c",
        energyConsumption = 90,
        cooldown = 36,
        range = 21,
        damage = 6.0,
        tech = {
            number = 3,
            countMultiplier = 3,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 }
            },
            prerequisites = { "personal-laser-defense-equipment-2" }
        }
    },
    {
        number = "04", new = true, order = "d",
        energyConsumption = 110,
        cooldown = 34,
        range = 24,
        damage = 7.5,
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
            prerequisites = { "personal-laser-defense-equipment-3", "utility-science-pack" }
        }
    },
    {
        number = "05", new = true, order = "e",
        energyConsumption = 130,
        cooldown = 32,
        range = 28,
        damage = 9.5,
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
            prerequisites = { "personal-laser-defense-equipment-4" }
        }
    },
    {
        number = "06", new = true, order = "f",
        energyConsumption = 150,
        cooldown = 30,
        range = 32,
        damage = 11.5,
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
            prerequisites = { "personal-laser-defense-equipment-5", "space-science-pack" }
        }
    },
    {
        number = "07", new = true, order = "g",
        energyConsumption = 170,
        cooldown = 28,
        range = 36,
        damage = 13.5,
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
            prerequisites = { "personal-laser-defense-equipment-6" }
        }
    },
    {
        number = "08", new = true, order = "h",
        energyConsumption = 190,
        cooldown = 26,
        range = 40,
        damage = 15.5,
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
            prerequisites = { "personal-laser-defense-equipment-7" }
        }
    },
    {
        number = "09", new = true, order = "i",
        energyConsumption = 210,
        cooldown = 24,
        range = 44,
        damage = 17.5,
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
            prerequisites = { "personal-laser-defense-equipment-8" }
        }
    },
    {
        number = "10", new = true, order = "j",
        energyConsumption = 230,
        cooldown = 22,
        range = 48,
        damage = 20.0,
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
            prerequisites = { "personal-laser-defense-equipment-9" }
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

    genPersonalLaserDefenses {
        number = tier.number,
        subgroup = config.subgroup,
        energyConsumption = tier.energyConsumption,
        cooldown = tier.cooldown,
        range = tier.range,
        damage = tier.damage,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.personalLaserDefenseEquipment[i],
        tech = techData
    }
end
