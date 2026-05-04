require("__5dim_core__.lib.equipment.generation-personal-roboport-equipment")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 200,
    subgroup = "armor-roboport"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    {
        number = "01", new = false, order = "a",
        capacity = 35,
        inputFlow = 3500,
        robotLimit = 10,
        constructionRadius = 15,
        charging = 1000,
        tech = nil
    },
    {
        number = "02", new = false, order = "b",
        capacity = 35,
        inputFlow = 22500,
        robotLimit = 25,
        constructionRadius = 20,
        charging = 1000,
        tech = nil
    },
    {
        number = "03", new = true, order = "c",
        capacity = 45,
        inputFlow = 25000,
        robotLimit = 35,
        constructionRadius = 22,
        charging = 1500,
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
        capacity = 55,
        inputFlow = 28000,
        robotLimit = 45,
        constructionRadius = 24,
        charging = 2000,
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
        capacity = 70,
        inputFlow = 32000,
        robotLimit = 55,
        constructionRadius = 26,
        charging = 2500,
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
        capacity = 85,
        inputFlow = 36000,
        robotLimit = 65,
        constructionRadius = 28,
        charging = 3000,
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
        capacity = 100,
        inputFlow = 40000,
        robotLimit = 75,
        constructionRadius = 30,
        charging = 3500,
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
        capacity = 120,
        inputFlow = 45000,
        robotLimit = 85,
        constructionRadius = 32,
        charging = 4000,
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
        capacity = 145,
        inputFlow = 50000,
        robotLimit = 95,
        constructionRadius = 34,
        charging = 4500,
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
        capacity = 170,
        inputFlow = 56000,
        robotLimit = 110,
        constructionRadius = 36,
        charging = 5000,
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

    genPersonalRoboports {
        number = tier.number,
        subgroup = config.subgroup,
        capacity = tier.capacity,
        inputFlow = tier.inputFlow,
        robotLimit = tier.robotLimit,
        constructionRadius = tier.constructionRadius,
        charging = tier.charging,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.personalRoboportEquipment[i],
        tech = techData
    }
end
