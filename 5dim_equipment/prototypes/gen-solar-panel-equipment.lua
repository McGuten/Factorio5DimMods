require("__5dim_core__.lib.equipment.generation-solar-panel-equipment")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    basePowerProduction = 30,
    powerMultiplier = 1.25,
    baseTechCount = 250,
    subgroup = "armor-solar"
}

local solarPanelEquipmentSpaceAgeMaterials = {
    [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 6, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 2, category = "cryogenics" }
}

local solarPanelEquipmentSpaceAgeSciencePacks = {
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local solarPanelEquipmentSpaceAgeDeltaPrerequisites = {
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local solarPanelEquipmentDeltaPrerequisites = {
    [2] = "battery",
    [3] = "advanced-electronics",
    [4] = "advanced-electronics-2",
    [5] = "low-density-structure",
    [6] = "speed-module",
    [7] = "efficiency-module-2",
    [8] = "speed-module-2",
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

local function getSolarPanelEquipmentDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and solarPanelEquipmentSpaceAgeDeltaPrerequisites[tier] then
        return solarPanelEquipmentSpaceAgeDeltaPrerequisites[tier]
    end

    return solarPanelEquipmentDeltaPrerequisites[tier]
end

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "solar-panel-equipment", "production-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "solar-panel-equipment-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "solar-panel-equipment-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "solar-panel-equipment-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "solar-panel-equipment-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "solar-panel-equipment-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "solar-panel-equipment-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "solar-panel-equipment-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "solar-panel-equipment-9" }
    }
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
            prerequisites = { "solar-panel-equipment" }
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
            prerequisites = { "solar-panel-equipment-2" }
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
                { "utility-science-pack", 1 }
            },
            prerequisites = { "solar-panel-equipment-3" }
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
                { "utility-science-pack", 1 }
            },
            prerequisites = { "solar-panel-equipment-4" }
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
                { "utility-science-pack", 1 }
            },
            prerequisites = { "solar-panel-equipment-5" }
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
                { "utility-science-pack", 1 }
            },
            prerequisites = { "solar-panel-equipment-6" }
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
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "solar-panel-equipment-7" }
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
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "solar-panel-equipment-8" }
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
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "solar-panel-equipment-9" }
        }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------
for i, tier in ipairs(tiers) do
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.solarPanelEquipment[i], i, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = solarPanelEquipmentSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    local techData = nil
    local tc = techConfig[i]
    if tc then
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getSolarPanelEquipmentDeltaPrerequisite(i))

        techData = {
            number = i,
            count = CostCalculator.calculateMachineTechCount(config.baseTechCount, i),
            packs = CostCalculator.getTechPacks(tc.basePacks, i, {
                spaceAgePackOverrides = solarPanelEquipmentSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    genSolarPanels {
        number = tier.number,
        subgroup = config.subgroup,
        power = CostCalculator.calculateMachineWorkValue(config.basePowerProduction, i, 10, 0),
        new = tier.new,
        order = tier.order,
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(i, solarPanelEquipmentSpaceAgeMaterials),
        tech = techData
    }
end
