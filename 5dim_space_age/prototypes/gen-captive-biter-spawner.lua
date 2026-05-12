-------------------------------------------------------------------------------
-- 5Dim's Space Age - Captive Biter Spawner Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-captive-biter-spawner")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 1
local baseEmissions = -1
local baseTechCount = 500

local captiveBiterSpawnerBasePacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "military-science-pack", 1 },
    { "production-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "metallurgic-science-pack", 1 },
    { "agricultural-science-pack", 1 },
    { "electromagnetic-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local captiveBiterSpawnerDeltaPrerequisites = {
    [2] = "bioflux",
    [3] = "carbon-fiber",
    [4] = "holmium-processing",
    [5] = "electromagnetic-plant",
    [6] = "electromagnetic-plant",
    [7] = "lithium-processing",
    [8] = "cryogenic-plant",
    [9] = "quantum-processor",
    [10] = "fusion-reactor"
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

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,    order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.25, order = "b" },
    [3]  = { speedBonus = 0.50, order = "c" },
    [4]  = { speedBonus = 0.75, order = "d" },
    [5]  = { speedBonus = 1.00, order = "e" },
    [6]  = { speedBonus = 1.25, order = "f" },
    [7]  = { speedBonus = 1.50, order = "g" },
    [8]  = { speedBonus = 1.75, order = "h" },
    [9]  = { speedBonus = 2.00, order = "i" },
    [10] = { speedBonus = 2.25, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [2] = {
        basePacks = captiveBiterSpawnerBasePacks,
        prerequisites = { "captive-biter-spawner" }
    },
    [3] = {
        basePacks = captiveBiterSpawnerBasePacks,
        prerequisites = { "5d-captive-biter-spawner-2" }
    },
    [4] = {
        basePacks = captiveBiterSpawnerBasePacks,
        prerequisites = { "5d-captive-biter-spawner-3" }
    },
    [5] = {
        basePacks = captiveBiterSpawnerBasePacks,
        prerequisites = { "5d-captive-biter-spawner-4" }
    },
    [6] = {
        basePacks = captiveBiterSpawnerBasePacks,
        prerequisites = { "5d-captive-biter-spawner-5" }
    },
    [7] = {
        basePacks = captiveBiterSpawnerBasePacks,
        prerequisites = { "5d-captive-biter-spawner-6" }
    },
    [8] = {
        basePacks = captiveBiterSpawnerBasePacks,
        prerequisites = { "5d-captive-biter-spawner-7" }
    },
    [9] = {
        basePacks = captiveBiterSpawnerBasePacks,
        prerequisites = { "5d-captive-biter-spawner-8" }
    },
    [10] = {
        basePacks = captiveBiterSpawnerBasePacks,
        prerequisites = { "5d-captive-biter-spawner-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local craftingSpeed = baseCraftingSpeed + config.speedBonus
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed)
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.captiveBiterSpawner[tier], tier, {
        skipTierScaling = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-captive-biter-spawner-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla, no tech needed)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, captiveBiterSpawnerDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = baseTechCount * (tier - 1),
            packs = tc.basePacks,
            prerequisites = prerequisites
        }
    end
    
    -- Generate the captive biter spawner
    genCaptiveBiterSpawner {
        number = tierNum,
        subgroup = "gleba-captive",
        craftingSpeed = craftingSpeed,
        pollution = { pollution = emissions },
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
