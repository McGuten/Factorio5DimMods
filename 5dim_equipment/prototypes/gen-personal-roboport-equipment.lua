require("__5dim_core__.lib.equipment.generation-personal-roboport-equipment")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 150,
    subgroup = "armor-roboport"
}

local personalRoboportEquipmentSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 8, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 60, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 4, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 2, category = "cryogenics" }
}

local personalRoboportEquipmentSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local personalRoboportEquipmentSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local personalRoboportEquipmentDeltaPrerequisites = {
    [3] = "advanced-electronics",
    [4] = "electric-engine",
    [5] = "advanced-electronics-2",
    [6] = "low-density-structure",
    [7] = "speed-module",
    [8] = "speed-module-2",
    [9] = "productivity-module-2",
    [10] = "speed-module-3"
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

local function getPersonalRoboportEquipmentDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and personalRoboportEquipmentSpaceAgeDeltaPrerequisites[tier] then
        return personalRoboportEquipmentSpaceAgeDeltaPrerequisites[tier]
    end

    return personalRoboportEquipmentDeltaPrerequisites[tier]
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
        prerequisites = { "personal-roboport-mk2-equipment", "production-science-pack" }
    },
    [4] = {
        number = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-personal-roboport-equipment-1" }
    },
    [5] = {
        number = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-roboport-equipment-2", "utility-science-pack" }
    },
    [6] = {
        number = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-roboport-equipment-3" }
    },
    [7] = {
        number = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-roboport-equipment-4" }
    },
    [8] = {
        number = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-roboport-equipment-5" }
    },
    [9] = {
        number = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-roboport-equipment-6" }
    },
    [10] = {
        number = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-roboport-equipment-7" }
    }
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
                { "utility-science-pack", 1 }
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
                { "utility-science-pack", 1 }
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
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            prerequisites = { "5d-personal-roboport-equipment-7" }
        }
    }
}

local function getPersonalRoboportProgressionTier(tier)
    if tier <= 2 then
        return 1
    end

    return tier - 1
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------
for i, tier in ipairs(tiers) do
    local progressionTier = getPersonalRoboportProgressionTier(i)
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.personalRoboportEquipment[i], i, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        progressionTier = progressionTier,
        spaceAgeMaterialOverrides = personalRoboportEquipmentSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    local techData = nil
    local tc = techConfig[i]
    if tc then
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getPersonalRoboportEquipmentDeltaPrerequisite(i))

        techData = {
            number = tc.number,
            count = CostCalculator.calculateMachineTechCount(config.baseTechCount, progressionTier),
            packs = CostCalculator.getTechPacks(tc.basePacks, i, {
                spaceAgePackOverrides = personalRoboportEquipmentSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    genPersonalRoboports {
        number = tier.number,
        subgroup = config.subgroup,
        capacity = i <= 2 and tier.capacity or CostCalculator.calculateMachineWorkValue(tiers[2].capacity, progressionTier, 9, 0),
        inputFlow = i <= 2 and tier.inputFlow or CostCalculator.calculateMachineWorkValue(tiers[2].inputFlow, progressionTier, 9, 0),
        robotLimit = i <= 2 and tier.robotLimit or CostCalculator.calculateMachineWorkValue(tiers[2].robotLimit, progressionTier, 9, 0),
        constructionRadius = i <= 2 and tier.constructionRadius or CostCalculator.calculateMachineWorkValue(tiers[2].constructionRadius, progressionTier, 9, 0),
        charging = i <= 2 and tier.charging or CostCalculator.calculateMachineWorkValue(tiers[2].charging, progressionTier, 9, 0),
        new = tier.new,
        order = tier.order,
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(i, personalRoboportEquipmentSpaceAgeMaterials),
        tech = techData
    }
end
