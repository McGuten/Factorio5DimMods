-------------------------------------------------------------------------------
-- 5Dim's Nuclear - Nuclear Reactor Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.nuclear.generation-nuclear-reactor")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 1
local baseModuleSlots = 2
local baseEnergy = 40
local baseEmissions = 10
local baseTechCount = 300

local nuclearReactorSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 60, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-iron", amount = 300, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 30, category = "metallurgy" },
    [8] = { name = "holmium-plate", amount = 20, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 12, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 8, category = "cryogenics" }
}

local nuclearReactorSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local nuclearReactorSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local nuclearReactorDeltaPrerequisites = {
    [2] = "concrete",
    [3] = "concrete",
    [4] = "steel-processing",
    [5] = "electric-engine",
    [6] = "processing-unit",
    [7] = "low-density-structure",
    [8] = "battery",
    [9] = "speed-module-2",
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

local function getNuclearReactorDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and nuclearReactorSpaceAgeDeltaPrerequisites[tier] then
        return nuclearReactorSpaceAgeDeltaPrerequisites[tier]
    end

    return nuclearReactorDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", isVanilla = true },
    [2]  = { order = "b" },
    [3]  = { order = "c" },
    [4]  = { order = "d" },
    [5]  = { order = "e" },
    [6]  = { order = "f" },
    [7]  = { order = "g" },
    [8]  = { order = "h" },
    [9]  = { order = "i" },
    [10] = { order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "nuclear-power", "production-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-1", "5d-steam-turbine-1", "5d-heat-pipe-1", "5d-heat-exchanger-1" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-2", "5d-steam-turbine-2", "5d-heat-pipe-2", "5d-heat-exchanger-2" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-3", "5d-steam-turbine-3", "5d-heat-pipe-3", "5d-heat-exchanger-3", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-4", "5d-steam-turbine-4", "5d-heat-pipe-4", "5d-heat-exchanger-4" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-5", "5d-steam-turbine-5", "5d-heat-pipe-5", "5d-heat-exchanger-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-6", "5d-steam-turbine-6", "5d-heat-pipe-6", "5d-heat-exchanger-6" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-7", "5d-steam-turbine-7", "5d-heat-pipe-7", "5d-heat-exchanger-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-8", "5d-steam-turbine-8", "5d-heat-pipe-8", "5d-heat-exchanger-8" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local craftingSpeed = baseCraftingSpeed + (tier - 1) * 0.5
    -- More conservative energy scaling (factor 1.35 instead of 1.58 for better balance)
    -- T10 will be ~72MW instead of ~2462MW
    local energyFactor = 1.35
    local energy = math.floor(baseEnergy * (energyFactor ^ (tier - 1)))
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed)
    
    -- Module slots: base + 1 every 2 tiers
    local moduleSlots = baseModuleSlots + math.floor((tier - 1) / 2)
    -- Odd tiers >= 3 get an extra slot
    if tier >= 3 and tier % 2 == 1 then
        moduleSlots = moduleSlots + 1
    end
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.nuclearReactor[tier], tier, {
        isBulkItem = false,
        skipTierScaling = true,
        spaceAgeMaterialOverrides = nuclearReactorSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-nuclear-reactor-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getNuclearReactorDeltaPrerequisite(tier))

        tech = {
            number = tier - 1,
            count = baseTechCount * (tier - 1),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = nuclearReactorSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the nuclear reactor
    genNuclearReactors {
        number = tierNum,
        subgroup = "nuclear-reactor",
        craftingSpeed = craftingSpeed,
        moduleSlots = moduleSlots,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, nuclearReactorSpaceAgeMaterials),
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
