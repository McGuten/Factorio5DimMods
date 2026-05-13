require("__5dim_core__.lib.equipment.generation-exoskeleton-equipment")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 250,
    subgroup = "armor-exoskeleton"
}

local exoskeletonSpaceAgeMaterials = {
    [6] = { name = "calcite", amount = 20, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 16, category = "metallurgy" },
    [8] = { name = "carbon-fiber", amount = 12 },
    [9] = { name = "metallic-asteroid-chunk", amount = 8 },
    [10] = { name = "lithium-plate", amount = 10, category = "cryogenics" }
}

local exoskeletonSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "agricultural-science-pack" },
    [9] = { "space-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local exoskeletonSpaceAgeDeltaPrerequisites = {
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "carbon-fiber",
    [9] = "space-platform",
    [10] = "cryogenic-plant"
}

local exoskeletonDeltaPrerequisites = {
    [2] = "steel-processing",
    [3] = "battery",
    [4] = "engine",
    [5] = "electric-engine",
    [6] = "low-density-structure",
    [7] = "speed-module",
    [8] = "speed-module-2",
    [9] = "speed-module-3",
    [10] = "productivity-module-3"
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

local function getExoskeletonDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and exoskeletonSpaceAgeDeltaPrerequisites[tier] then
        return exoskeletonSpaceAgeDeltaPrerequisites[tier]
    end

    return exoskeletonDeltaPrerequisites[tier]
end

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "exoskeleton-equipment", "production-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "exoskeleton-equipment-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "exoskeleton-equipment-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "exoskeleton-equipment-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "exoskeleton-equipment-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "exoskeleton-equipment-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "exoskeleton-equipment-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "exoskeleton-equipment-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "exoskeleton-equipment-9" }
    }
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    {
        number = "01", new = false, order = "a",
        energyConsumption = 200,
        movementSpeed = 0.3,
        tech = nil
    },
    {
        number = "02", new = true, order = "b",
        energyConsumption = 275,
        movementSpeed = 0.4,
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
        energyConsumption = 350,
        movementSpeed = 0.5,
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
        energyConsumption = 425,
        movementSpeed = 0.6,
        tech = {
            number = 4,
            countMultiplier = 4,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "exoskeleton-equipment-3" }
        }
    },
    {
        number = "05", new = true, order = "e",
        energyConsumption = 500,
        movementSpeed = 0.75,
        tech = {
            number = 5,
            countMultiplier = 5,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "exoskeleton-equipment-4" }
        }
    },
    {
        number = "06", new = true, order = "f",
        energyConsumption = 575,
        movementSpeed = 0.9,
        tech = {
            number = 6,
            countMultiplier = 6,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "exoskeleton-equipment-5" }
        }
    },
    {
        number = "07", new = true, order = "g",
        energyConsumption = 650,
        movementSpeed = 1.05,
        tech = {
            number = 7,
            countMultiplier = 7,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "exoskeleton-equipment-6" }
        }
    },
    {
        number = "08", new = true, order = "h",
        energyConsumption = 725,
        movementSpeed = 1.2,
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
            prerequisites = { "exoskeleton-equipment-7" }
        }
    },
    {
        number = "09", new = true, order = "i",
        energyConsumption = 800,
        movementSpeed = 1.35,
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
            prerequisites = { "exoskeleton-equipment-8" }
        }
    },
    {
        number = "10", new = true, order = "j",
        energyConsumption = 875,
        movementSpeed = 1.5,
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
            prerequisites = { "exoskeleton-equipment-9" }
        }
    }
}

local function calculateCooldown(baseCooldown, tier)
    return math.max(1, math.floor((baseCooldown / CostCalculator.getMachineWorkMultiplier(tier)) + 0.5))
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------
for i, tier in ipairs(tiers) do
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.exoskeletonEquipment[i], i, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = exoskeletonSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    local techData = nil
    local tc = techConfig[i]
    if tc then
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getExoskeletonDeltaPrerequisite(i))

        techData = {
            number = i,
            count = CostCalculator.calculateMachineTechCount(config.baseTechCount, i),
            packs = CostCalculator.getTechPacks(tc.basePacks, i, {
                spaceAgePackOverrides = exoskeletonSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    genExoskeletons {
        number = tier.number,
        subgroup = config.subgroup,
        energyConsumption = CostCalculator.scaleMachineEnergy(tiers[1].energyConsumption, i),
        movementSpeed = CostCalculator.calculateMachineWorkValue(tiers[1].movementSpeed, i, 10, 2),
        new = tier.new,
        order = tier.order,
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(i, exoskeletonSpaceAgeMaterials),
        tech = techData
    }
end
