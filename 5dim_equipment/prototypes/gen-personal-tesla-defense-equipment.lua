require("__5dim_core__.lib.equipment.generation-personal-tesla-defense-equipment")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-- Tesla line: shorter range, faster cadence, chain utility and crowd control.
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 400,
    subgroup = "armor-tesla"
}

local personalTeslaDefenseSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 8, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 80, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 4, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 2, category = "cryogenics" }
}

local personalTeslaDefenseSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local personalTeslaDefenseSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local personalTeslaDefenseDeltaPrerequisites = {
    [2] = "battery",
    [3] = "advanced-electronics",
    [4] = "advanced-electronics-2",
    [5] = "low-density-structure",
    [6] = "speed-module",
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

local function getPersonalTeslaDefenseDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and personalTeslaDefenseSpaceAgeDeltaPrerequisites[tier] then
        return personalTeslaDefenseSpaceAgeDeltaPrerequisites[tier]
    end

    return personalTeslaDefenseDeltaPrerequisites[tier]
end

local techConfig = {
    [1] = {
        number = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "personal-laser-defense-equipment", "utility-science-pack" }
    },
    [2] = {
        number = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-tesla-defense-equipment-1" }
    },
    [3] = {
        number = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-tesla-defense-equipment-2" }
    },
    [4] = {
        number = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-tesla-defense-equipment-3" }
    },
    [5] = {
        number = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-tesla-defense-equipment-4" }
    },
    [6] = {
        number = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-tesla-defense-equipment-5" }
    },
    [7] = {
        number = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-tesla-defense-equipment-6" }
    },
    [8] = {
        number = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-tesla-defense-equipment-7" }
    },
    [9] = {
        number = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-tesla-defense-equipment-8" }
    },
    [10] = {
        number = 10,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-personal-tesla-defense-equipment-9" }
    }
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
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.personalTeslaDefenseEquipment[i], i, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = personalTeslaDefenseSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    local techData = nil
    local tc = techConfig[i]
    if tc then
        local prerequisites = copyPrerequisites(tc.prerequisites)

        if tc.number == 1 and mods["5dim_battlefield"] then
            table.insert(prerequisites, "5d-tesla-turrets-1")
        end

        addPrerequisiteIfMissing(prerequisites, getPersonalTeslaDefenseDeltaPrerequisite(i))

        techData = {
            number = tc.number,
            count = CostCalculator.calculateTechCount(config.baseTechCount, i),
            packs = CostCalculator.getTechPacks(tc.basePacks, i, {
                spaceAgePackOverrides = personalTeslaDefenseSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
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
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(i, personalTeslaDefenseSpaceAgeMaterials),
        tech = techData
    }
end
