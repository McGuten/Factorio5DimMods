-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Radar Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.battlefield.generation-radar")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseScan = 14
local baseReveal = 3
local baseEnergy = 300
local scanIncrement = 2
local revealStepTiers = 2
local energyIncrement = 300
local baseTechCount = 125

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
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "radar", "military" }
    },
    [3] = {
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "radar-2" }
    },
    [4] = {
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "radar-3" }
    },
    [5] = {
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "radar-4", "production-science-pack" }
    },
    [6] = {
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "radar-5" }
    },
    [7] = {
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "radar-6" }
    },
    [8] = {
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "radar-7", "utility-science-pack" }
    },
    [9] = {
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "radar-8" }
    },
    [10] = {
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "radar-9" }
    }
}

local radarSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 12, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 140, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 8, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 4, category = "cryogenics" }
}

local radarSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local radarSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local radarDeltaPrerequisites = {
    [2] = "advanced-circuit",
    [3] = "battery",
    [4] = "processing-unit",
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

local function getRadarDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and radarSpaceAgeDeltaPrerequisites[tier] then
        return radarSpaceAgeDeltaPrerequisites[tier]
    end

    return radarDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local scan = baseScan + (tier - 1) * scanIncrement
    local reveal = baseReveal + math.floor((tier - 1) / revealStepTiers)
    local energy = baseEnergy + (tier - 1) * energyIncrement
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.radar[tier], tier, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = radarSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-radar-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getRadarDeltaPrerequisite(tier))

        tech = {
            number = tier,
            count = baseTechCount * tc.countMultiplier,
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = radarSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the radar
    genRadars {
        number = tierNum,
        subgroup = "defense-radar",
        order = config.order,
        new = not config.isVanilla,
        reveal = reveal,
        scan = scan,
        energy = energy,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, radarSpaceAgeMaterials)
    }
end
