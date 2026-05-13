require("__5dim_core__.lib.equipment.generation-energy-shield-equipment")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- CONFIGURATION
-- Explicit per-tier tuning keeps late shields usable without turning them into
-- infinite HP pools against the more aggressive 5dim_enemies roster.
-------------------------------------------------------------------------------
local config = {
    baseTechCount = 200,
    subgroup = "armor-shield"
}

local energyShieldEquipmentSpaceAgeMaterials = {
    [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 6, category = "electromagnetics" },
    [10] = { name = "lithium-plate", amount = 10, category = "cryogenics" }
}

local energyShieldEquipmentSpaceAgeSciencePacks = {
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local energyShieldEquipmentSpaceAgeDeltaPrerequisites = {
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "cryogenic-plant"
}

local energyShieldEquipmentDeltaPrerequisites = {
    [3] = "advanced-electronics",
    [4] = "advanced-electronics-2",
    [5] = "low-density-structure",
    [6] = "efficiency-module",
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

local function getEnergyShieldEquipmentDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and energyShieldEquipmentSpaceAgeDeltaPrerequisites[tier] then
        return energyShieldEquipmentSpaceAgeDeltaPrerequisites[tier]
    end

    return energyShieldEquipmentDeltaPrerequisites[tier]
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
        prerequisites = { "energy-shield-mk2-equipment", "production-science-pack" }
    },
    [4] = {
        number = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-energy-shield-equipment-1" }
    },
    [5] = {
        number = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-energy-shield-equipment-2", "utility-science-pack" }
    },
    [6] = {
        number = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-energy-shield-equipment-3" }
    },
    [7] = {
        number = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-energy-shield-equipment-4" }
    },
    [8] = {
        number = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-energy-shield-equipment-5" }
    },
    [9] = {
        number = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-energy-shield-equipment-6" }
    },
    [10] = {
        number = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-energy-shield-equipment-7" }
    }
}

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------
local tiers = {
    {
        number = "01", new = false, order = "a", tech = nil,
        shieldCapacity = 50,
        bufferCapacity = 120,
        inputFlow = 240
    },
    {
        number = "02", new = false, order = "b", tech = nil,
        shieldCapacity = 300,
        bufferCapacity = 360,
        inputFlow = 720
    },
    {
        number = "03", new = true, order = "c",
        shieldCapacity = 975,
        bufferCapacity = 2160,
        inputFlow = 2160,
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
            prerequisites = { "energy-shield-mk2-equipment" }
        }
    },
    {
        number = "04", new = true, order = "d",
        shieldCapacity = 2100,
        bufferCapacity = 4320,
        inputFlow = 3600,
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
            prerequisites = { "5d-energy-shield-equipment-1" }
        }
    },
    {
        number = "05", new = true, order = "e",
        shieldCapacity = 4125,
        bufferCapacity = 8100,
        inputFlow = 6000,
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
            prerequisites = { "5d-energy-shield-equipment-2" }
        }
    },
    {
        number = "06", new = true, order = "f",
        shieldCapacity = 7500,
        bufferCapacity = 13500,
        inputFlow = 9000,
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
            prerequisites = { "5d-energy-shield-equipment-3" }
        }
    },
    {
        number = "07", new = true, order = "g",
        shieldCapacity = 12950,
        bufferCapacity = 22050,
        inputFlow = 13500,
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
            prerequisites = { "5d-energy-shield-equipment-4" }
        }
    },
    {
        number = "08", new = true, order = "h",
        shieldCapacity = 21600,
        bufferCapacity = 36000,
        inputFlow = 19500,
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
            prerequisites = { "5d-energy-shield-equipment-5" }
        }
    },
    {
        number = "09", new = true, order = "i",
        shieldCapacity = 35100,
        bufferCapacity = 56700,
        inputFlow = 27000,
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
            prerequisites = { "5d-energy-shield-equipment-6" }
        }
    },
    {
        number = "10", new = true, order = "j",
        shieldCapacity = 56000,
        bufferCapacity = 90000,
        inputFlow = 36000,
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
            prerequisites = { "5d-energy-shield-equipment-7" }
        }
    }
}

local function getEnergyShieldProgressionTier(tier)
    if tier <= 2 then
        return 1
    end

    return tier - 1
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------
for i, tier in ipairs(tiers) do
    local progressionTier = getEnergyShieldProgressionTier(i)
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.energyShieldEquipment[i], i, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        progressionTier = progressionTier,
        spaceAgeMaterialOverrides = energyShieldEquipmentSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    local techData = nil
    local tc = techConfig[i]
    if tc then
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getEnergyShieldEquipmentDeltaPrerequisite(i))

        techData = {
            number = tc.number,
            count = CostCalculator.calculateMachineTechCount(config.baseTechCount, progressionTier),
            packs = CostCalculator.getTechPacks(tc.basePacks, i, {
                spaceAgePackOverrides = energyShieldEquipmentSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end

    genEnergyShields {
        number = tier.number,
        subgroup = config.subgroup,
        capacity = i <= 2 and tier.bufferCapacity or CostCalculator.calculateMachineWorkValue(tiers[2].bufferCapacity, progressionTier, 9, 0),
        shieldCapacity = i <= 2 and tier.shieldCapacity or CostCalculator.calculateMachineWorkValue(tiers[2].shieldCapacity, progressionTier, 9, 0),
        inputFlow = i <= 2 and tier.inputFlow or CostCalculator.calculateMachineWorkValue(tiers[2].inputFlow, progressionTier, 9, 0),
        new = tier.new,
        order = tier.order,
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(i, energyShieldEquipmentSpaceAgeMaterials),
        tech = techData
    }
end
