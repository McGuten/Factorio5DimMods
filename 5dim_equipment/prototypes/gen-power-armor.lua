require("__5dim_core__.lib.equipment.generation-power-armor")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 400,
    subgroup = "armor-power-armor"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    {
        number = "01", new = false, order = "a",
        inventoryBonus = 20,
        width = 10,
        height = 10,
        tech = nil
    },
    {
        number = "02", new = false, order = "b",
        inventoryBonus = 30,
        width = 10,
        height = 10,
        tech = nil
    },
    {
        number = "03", new = true, order = "c",
        inventoryBonus = 40,
        width = 10,
        height = 12,
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
            prerequisites = { "power-armor-mk2" }
        }
    },
    {
        number = "04", new = true, order = "d",
        inventoryBonus = 50,
        width = 11,
        height = 12,
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
            prerequisites = { "5d-power-armor-1" }
        }
    },
    {
        number = "05", new = true, order = "e",
        inventoryBonus = 60,
        width = 11,
        height = 14,
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
            prerequisites = { "5d-power-armor-2" }
        }
    },
    {
        number = "06", new = true, order = "f",
        inventoryBonus = 70,
        width = 11,
        height = 16,
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
            prerequisites = { "5d-power-armor-3", "space-science-pack" }
        }
    },
    {
        number = "07", new = true, order = "g",
        inventoryBonus = 80,
        width = 12,
        height = 18,
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
            prerequisites = { "5d-power-armor-4" }
        }
    },
    {
        number = "08", new = true, order = "h",
        inventoryBonus = 90,
        width = 12,
        height = 20,
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
            prerequisites = { "5d-power-armor-5" }
        }
    },
    {
        number = "09", new = true, order = "i",
        inventoryBonus = 100,
        width = 12,
        height = 22,
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
            prerequisites = { "5d-power-armor-6" }
        }
    },
    {
        number = "10", new = true, order = "j",
        inventoryBonus = 110,
        width = 12,
        height = 24,
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
            prerequisites = { "5d-power-armor-7" }
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

    genPowerArmors {
        number = tier.number,
        subgroup = config.subgroup,
        inventoryBonus = tier.inventoryBonus,
        width = tier.width,
        height = tier.height,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.powerArmor[i],
        tech = techData
    }
end
