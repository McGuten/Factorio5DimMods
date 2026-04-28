require("__5dim_core__.lib.equipment.generation-power-armor")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseInventoryBonus = 20,
    inventoryIncrement = 10,
    baseArmorWidth = 10,
    baseArmorHeight = 10,
    heightIncrement = 2,
    baseTechCount = 400,
    subgroup = "armor-power-armor"
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    { number = "01", new = false, order = "a", tech = nil, heightBonus = 0 },
    { number = "02", new = false, order = "b", tech = nil, heightBonus = 0 },
    {
        -- FIXED: Added heightBonus = 2 for T03 (was 0, no grid improvement)
        number = "03", new = true, order = "c", heightBonus = 2,
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
        number = "04", new = true, order = "d", heightBonus = 2,
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
        number = "05", new = true, order = "e", heightBonus = 4,
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
        number = "06", new = true, order = "f", heightBonus = 6,
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
        number = "07", new = true, order = "g", heightBonus = 8,
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
        number = "08", new = true, order = "h", heightBonus = 10,
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
        number = "09", new = true, order = "i", heightBonus = 12,
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
        number = "10", new = true, order = "j", heightBonus = 14,
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
local inventoryBonus = config.baseInventoryBonus

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

    genPowerArmors {
        number = tier.number,
        subgroup = config.subgroup,
        inventoryBonus = inventoryBonus,
        width = config.baseArmorWidth,
        height = config.baseArmorHeight + tier.heightBonus,
        new = tier.new,
        order = tier.order,
        ingredients = RecipeTemplates.powerArmor[i],
        tech = techData
    }

    inventoryBonus = inventoryBonus + config.inventoryIncrement
end
