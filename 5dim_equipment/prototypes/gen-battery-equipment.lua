require("__5dim_core__.lib.equipment.generation-battery-equipment")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 150,
    subgroup = "armor-battery"
}

local batteryEquipmentSpaceAgeMaterials = {
    [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 6, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 2, category = "cryogenics" }
}

local batteryEquipmentSpaceAgeSciencePacks = {
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local batteryEquipmentSpaceAgeDeltaPrerequisites = {
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local batteryEquipmentDeltaPrerequisites = {
    [3] = "advanced-electronics",
    [4] = "advanced-electronics-2",
    [5] = "low-density-structure",
    [6] = "speed-module",
    [7] = "speed-module-2",
    [8] = "efficiency-module-2",
    [9] = "speed-module-3",
    [10] = "efficiency-module-3"
}

local function copyPrerequisites(values)
    local result = {}

    for _, value in ipairs(values) do
        table.insert(result, value)
    end

    return result
end

local function addPrerequisiteIfMissing(prerequisites, prerequisite)
    if not prerequisite then
        return
    end

    for _, current in ipairs(prerequisites) do
        if current == prerequisite then
            return
        end
    end

    table.insert(prerequisites, prerequisite)
end

local function getBatteryEquipmentDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and batteryEquipmentSpaceAgeDeltaPrerequisites[tier] then
        return batteryEquipmentSpaceAgeDeltaPrerequisites[tier]
    end

    return batteryEquipmentDeltaPrerequisites[tier]
end

local techConfig = {
    [3] = {
        number = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "battery-mk2-equipment", "production-science-pack" }
    },
    [4] = {
        number = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = mods["space-age"] and { "battery-mk3-equipment", "production-science-pack" } or { "5d-battery-equipment-1" }
    },
    [5] = {
        number = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-battery-equipment-2", "utility-science-pack" }
    },
    [6] = {
        number = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-battery-equipment-3" }
    },
    [7] = {
        number = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-battery-equipment-4" }
    },
    [8] = {
        number = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-battery-equipment-5" }
    },
    [9] = {
        number = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-battery-equipment-6" }
    },
    [10] = {
        number = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-battery-equipment-7" }
    }
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

-- Tier 03 special handling for Space Age battery-mk3
local tier03Config
if mods["space-age"] then
    -- When Space Age is active, tier 03 uses battery-mk3-equipment as vanilla
    tier03Config = { 
        number = "03", new = false, order = "c",
        capacity = 250,
        tech = nil -- battery-mk3-equipment tech already exists in Space Age
    }
else
    -- Without Space Age, tier 03 is a new item
    tier03Config = {
        number = "03", new = true, order = "c",
        capacity = 250,
        tech = {
            number = 1,
            countMultiplier = 2,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 }
            },
            prerequisites = { "battery-mk2-equipment" }
        }
    }
end

local tiers = {
    { number = "01", new = false, order = "a", capacity = 20, tech = nil },
    { number = "02", new = false, order = "b", capacity = 100, tech = nil },
    tier03Config,
    {
        number = "04", new = true, order = "d",
        capacity = 400,
        tech = {
            number = 2,
            countMultiplier = 3,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = mods["space-age"] and { "battery-mk3-equipment" } or { "5d-battery-equipment-1" }
        }
    },
    {
        number = "05", new = true, order = "e",
        capacity = 600,
        tech = {
            number = 3,
            countMultiplier = 4,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-2" }
        }
    },
    {
        number = "06", new = true, order = "f",
        capacity = 850,
        tech = {
            number = 4,
            countMultiplier = 5,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-3" }
        }
    },
    {
        number = "07", new = true, order = "g",
        capacity = 1150,
        tech = {
            number = 5,
            countMultiplier = 6,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-4" }
        }
    },
    {
        number = "08", new = true, order = "h",
        capacity = 1500,
        tech = {
            number = 6,
            countMultiplier = 7,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-5" }
        }
    },
    {
        number = "09", new = true, order = "i",
        capacity = 1900,
        tech = {
            number = 7,
            countMultiplier = 8,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-6" }
        }
    },
    {
        number = "10", new = true, order = "j",
        capacity = 2400,
        tech = {
            number = 8,
            countMultiplier = 9,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-battery-equipment-7" }
        }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------
for i, tier in ipairs(tiers) do
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.batteryEquipment[i], i, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = batteryEquipmentSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    local techData = nil
    local tc = techConfig[i]
    if tc then
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getBatteryEquipmentDeltaPrerequisite(i))

        techData = {
            number = tc.number,
            count = CostCalculator.calculateTechCount(config.baseTechCount, i - 1),
            packs = CostCalculator.getTechPacks(tc.basePacks, i, {
                spaceAgePackOverrides = batteryEquipmentSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    genBatterys {
        number = tier.number,
        subgroup = config.subgroup,
        capacity = tier.capacity,
        new = tier.new,
        order = tier.order,
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(i, batteryEquipmentSpaceAgeMaterials),
        tech = techData
    }
end
