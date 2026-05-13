require("__5dim_core__.lib.equipment.generation-power-armor")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 250,
    subgroup = "armor-power-armor"
}

local powerArmorSpaceAgeMaterials = {
    [6] = { name = "calcite", amount = 20, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 16, category = "metallurgy" },
    [8] = { name = "carbon-fiber", amount = 12 },
    [9] = { name = "carbon", amount = 8 },
    [10] = { name = "quantum-processor", amount = 2, category = "cryogenics" }
}

local powerArmorSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "agricultural-science-pack" },
    [9] = { "space-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local powerArmorSpaceAgeDeltaPrerequisites = {
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "carbon-fiber",
    [9] = "space-platform",
    [10] = "quantum-processor"
}

local powerArmorDeltaPrerequisites = {
    [3] = "steel-processing",
    [4] = "battery",
    [5] = "advanced-electronics-2",
    [6] = "low-density-structure",
    [7] = "speed-module-2",
    [8] = "productivity-module-2",
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

local function getPowerArmorDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and powerArmorSpaceAgeDeltaPrerequisites[tier] then
        return powerArmorSpaceAgeDeltaPrerequisites[tier]
    end

    return powerArmorDeltaPrerequisites[tier]
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
        prerequisites = { "power-armor-mk2", "production-science-pack" }
    },
    [4] = {
        number = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-power-armor-1" }
    },
    [5] = {
        number = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-power-armor-2", "utility-science-pack" }
    },
    [6] = {
        number = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-power-armor-3" }
    },
    [7] = {
        number = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-power-armor-4" }
    },
    [8] = {
        number = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-power-armor-5" }
    },
    [9] = {
        number = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-power-armor-6" }
    },
    [10] = {
        number = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-power-armor-7" }
    }
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
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-power-armor-7" }
        }
    }
}

local function getPowerArmorProgressionTier(tier)
    if tier <= 2 then
        return 1
    end

    return tier - 1
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------
for i, tier in ipairs(tiers) do
    local progressionTier = getPowerArmorProgressionTier(i)
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.powerArmor[i], i, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        progressionTier = progressionTier,
        spaceAgeMaterialOverrides = powerArmorSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    local techData = nil
    local tc = techConfig[i]
    if tc then
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getPowerArmorDeltaPrerequisite(i))

        techData = {
            number = tc.number,
            count = CostCalculator.calculateMachineTechCount(config.baseTechCount, progressionTier),
            packs = CostCalculator.getTechPacks(tc.basePacks, i, {
                spaceAgePackOverrides = powerArmorSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    genPowerArmors {
        number = tier.number,
        subgroup = config.subgroup,
        inventoryBonus = i <= 2 and tier.inventoryBonus or CostCalculator.calculateMachineWorkValue(tiers[2].inventoryBonus, progressionTier, 9, 0),
        width = tier.width,
        height = tier.height,
        new = tier.new,
        order = tier.order,
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(i, powerArmorSpaceAgeMaterials),
        tech = techData
    }
end
