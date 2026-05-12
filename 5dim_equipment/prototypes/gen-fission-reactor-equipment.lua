require("__5dim_core__.lib.equipment.generation-fission-reactor-equipment")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    powerMultiplier = 1.45,
    baseTechCount = 500,
    subgroup = "armor-fission-reactor"
}

local fissionReactorEquipmentSpaceAgeMaterials = {
    [6] = { name = "calcite", amount = 24, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 20, category = "metallurgy" },
    [8] = { name = "holmium-plate", amount = 16, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 10, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 4, category = "cryogenics" }
}

local fissionReactorEquipmentSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local fissionReactorEquipmentSpaceAgeDeltaPrerequisites = {
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local fissionReactorEquipmentDeltaPrerequisites = {
    [2] = "battery",
    [3] = "advanced-electronics",
    [4] = "advanced-electronics-2",
    [5] = "low-density-structure",
    [6] = "productivity-module-2",
    [7] = "speed-module-2",
    [8] = "speed-module-3",
    [9] = "productivity-module-3",
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

local function getFissionReactorEquipmentDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and fissionReactorEquipmentSpaceAgeDeltaPrerequisites[tier] then
        return fissionReactorEquipmentSpaceAgeDeltaPrerequisites[tier]
    end

    return fissionReactorEquipmentDeltaPrerequisites[tier]
end

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "fission-reactor-equipment", "production-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "fission-reactor-equipment-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "fission-reactor-equipment-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fission-reactor-equipment-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fission-reactor-equipment-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fission-reactor-equipment-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fission-reactor-equipment-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fission-reactor-equipment-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "fission-reactor-equipment-9" }
    }
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
                { "utility-science-pack", 1 }
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
                { "utility-science-pack", 1 }
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
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.fissionReactorEquipment[i], i, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = fissionReactorEquipmentSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    local techData = nil
    local tc = techConfig[i]
    if tc then
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getFissionReactorEquipmentDeltaPrerequisite(i))

        techData = {
            number = i,
            count = CostCalculator.calculateTechCount(config.baseTechCount, i),
            packs = CostCalculator.getTechPacks(tc.basePacks, i, {
                spaceAgePackOverrides = fissionReactorEquipmentSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    genFissionReactors {
        number = tier.number,
        subgroup = config.subgroup,
        power = tier.power,
        new = tier.new,
        order = tier.order,
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(i, fissionReactorEquipmentSpaceAgeMaterials),
        tech = techData
    }
end
