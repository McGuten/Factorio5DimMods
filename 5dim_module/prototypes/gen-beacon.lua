-------------------------------------------------------------------------------
-- 5Dim's Module - Beacon Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.module.generation-beacon")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local beaconTechCounts = {
    [2] = 400,
    [3] = 900,
    [4] = 1500,
    [5] = 2200,
    [6] = 3000,
    [7] = 3900,
    [8] = 4900,
    [9] = 6100,
    [10] = 7500
}

local beaconSpaceAgeMaterials = {
    [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 5, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 5, category = "cryogenics" }
}

local beaconSpaceAgeSciencePacks = {
    [7] = { "space-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local beaconSpaceAgeDeltaPrerequisites = {
    [7] = "space-science-pack",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local beaconDeltaPrerequisites = {
    [2] = "advanced-circuit",
    [3] = "battery",
    [4] = "processing-unit",
    [5] = "low-density-structure",
    [6] = "speed-module-2",
    [7] = "productivity-module-2",
    [8] = "speed-module-3",
    [9] = "productivity-module-3",
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

local function addBeaconDeltaPrerequisites(prerequisites, tier)
    addPrerequisiteIfMissing(prerequisites, beaconDeltaPrerequisites[tier])

    if CostConfig.shouldUseSpaceAgeMaterials() then
        addPrerequisiteIfMissing(prerequisites, beaconSpaceAgeDeltaPrerequisites[tier])
    end
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines its stats directly: module slots, distribution effectivity,
-- supply area distance, energy usage in kW, order, vanilla flag.
--
-- The beacon does NOT use the exponential machine work multiplier. Slots and
-- effectivity multiply each other, so an exponential curve on both turns
-- quadratic: it reached 82 slots and a 64 tile supply area on MK10. The family
-- follows the same restrained linear shape as the modules it broadcasts
-- (gen-modules.lua: speed goes +15% to +150% across the same ten tiers), which
-- keeps the beacon readable as electronic infrastructure and not as a giant
-- module. See docs/design-modules.md.
--
-- Growth per tier: +1 slot every two tiers, +0.15 effectivity (+0.30 on the MK10
-- capstone), area up on most tiers. MK10 lands on 6 x 3.0 = 18 module
-- equivalents, 6x the vanilla beacon's 2 x 1.5 = 3.0.
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { moduleSlots = 2, efficiency = 1.50, area = 3,  energy = 480,   order = "a", isVanilla = true },
    [2]  = { moduleSlots = 2, efficiency = 1.65, area = 4,  energy = 680,   order = "b" },
    [3]  = { moduleSlots = 3, efficiency = 1.80, area = 5,  energy = 960,   order = "c" },
    [4]  = { moduleSlots = 3, efficiency = 1.95, area = 5,  energy = 1400,  order = "d" },
    [5]  = { moduleSlots = 4, efficiency = 2.10, area = 6,  energy = 1950,  order = "e" },
    [6]  = { moduleSlots = 4, efficiency = 2.25, area = 7,  energy = 2750,  order = "f" },
    [7]  = { moduleSlots = 5, efficiency = 2.40, area = 7,  energy = 3900,  order = "g" },
    [8]  = { moduleSlots = 5, efficiency = 2.55, area = 8,  energy = 5500,  order = "h" },
    [9]  = { moduleSlots = 6, efficiency = 2.70, area = 9,  energy = 7800,  order = "i" },
    [10] = { moduleSlots = 6, efficiency = 3.00, area = 10, energy = 11000, order = "j" }
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
        prerequisites = { "effect-transmission" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "effect-transmission-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Prototype stats come straight from the tier table above; only recipe and
    -- technology costs go through the shared cost system.
    local modules = config.moduleSlots
    local energy = config.energy
    local areaEffect = config.area
    local efficiency = config.efficiency
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.beacon[tier], tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = beaconSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-beacon-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addBeaconDeltaPrerequisites(prerequisites, tier)

        tech = {
            number = tier,
            count = CostCalculator.calculateMachineTechCount(beaconTechCounts[2], tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = beaconSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the beacon
    genBeacons {
        number = tierNum,
        subgroup = "beacon",
        area = areaEffect,
        moduleSlots = modules,
        energyUsage = energy,
        efficiency = efficiency,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, beaconSpaceAgeMaterials),
        tech = tech
    }
end

