require("__5dim_core__.lib.equipment.generation-personal-tesla-defense-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-- Tesla line: shorter range, faster cadence, chain utility and crowd control.
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 400,
    subgroup = "armor-tesla"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    {
        number = "01", new = true, order = "a",
        energyConsumption = 45,
        cooldown = 34,
        range = 12,
        damage = 2.5,
        tech = {
            number = 1,
            countMultiplier = 1,
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
        number = "02", new = true, order = "b",
        energyConsumption = 55,
        cooldown = 32,
        range = 13,
        damage = 3.5,
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
            prerequisites = { "5d-personal-tesla-defense-equipment-1", "personal-laser-defense-equipment-2", "utility-science-pack" }
        }
    },
    {
        number = "03", new = true, order = "c",
        energyConsumption = 65,
        cooldown = 30,
        range = 14,
        damage = 4.5,
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
            prerequisites = { "5d-personal-tesla-defense-equipment-2", "personal-laser-defense-equipment-3" }
        }
    },
    {
        number = "04", new = true, order = "d",
        energyConsumption = 75,
        cooldown = 28,
        range = 15,
        damage = 5.5,
        tech = {
            number = 4,
            countMultiplier = 4,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-personal-tesla-defense-equipment-3", "personal-laser-defense-equipment-4", "space-science-pack" }
        }
    },
    {
        number = "05", new = true, order = "e",
        energyConsumption = 85,
        cooldown = 26,
        range = 16,
        damage = 6.5,
        tech = {
            number = 5,
            countMultiplier = 5,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-personal-tesla-defense-equipment-4", "personal-laser-defense-equipment-5" }
        }
    },
    {
        number = "06", new = true, order = "f",
        energyConsumption = 95,
        cooldown = 24,
        range = 17,
        damage = 7.5,
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
            prerequisites = { "5d-personal-tesla-defense-equipment-5", "personal-laser-defense-equipment-6" }
        }
    },
    {
        number = "07", new = true, order = "g",
        energyConsumption = 105,
        cooldown = 22,
        range = 18,
        damage = 8.5,
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
            prerequisites = { "5d-personal-tesla-defense-equipment-6", "personal-laser-defense-equipment-7" }
        }
    },
    {
        number = "08", new = true, order = "h",
        energyConsumption = 115,
        cooldown = 20,
        range = 19,
        damage = 9.5,
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
            prerequisites = { "5d-personal-tesla-defense-equipment-7", "personal-laser-defense-equipment-8" }
        }
    },
    {
        number = "09", new = true, order = "i",
        energyConsumption = 125,
        cooldown = 18,
        range = 20,
        damage = 10.5,
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
            prerequisites = { "5d-personal-tesla-defense-equipment-8", "personal-laser-defense-equipment-9" }
        }
    },
    {
        number = "10", new = true, order = "j",
        energyConsumption = 135,
        cooldown = 16,
        range = 22,
        damage = 11.5,
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
            prerequisites = { "5d-personal-tesla-defense-equipment-9", "personal-laser-defense-equipment-10" }
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
        ingredients = RecipeTemplates.personalTeslaDefenseEquipment[i],
        tech = techData
    }
end
