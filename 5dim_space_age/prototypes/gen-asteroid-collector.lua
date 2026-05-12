-------------------------------------------------------------------------------
-- 5Dim's Space Age - Asteroid Collector Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-asteroid-collector")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseArmSpeed = 0.2
local baseInventorySize = 39
local baseTechCount = 500

local zeroGravitySurfaceConditions = {
    {
        property = "gravity",
        min = 0,
        max = 0
    }
}

local orbitBasePacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 }
}

local orbitFusionPacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local orbitQuantumPacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "electromagnetic-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local asteroidCollectorDeltaPrerequisites = {
    [7] = "space-platform-thruster",
    [8] = "space-platform-thruster",
    [9] = "fusion-reactor",
    [10] = "quantum-processor"
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
    [1]  = { armSpeedBonus = 0,    inventoryBonus = 0,  order = "a", isVanilla = true },
    [2]  = { armSpeedBonus = 0.05, inventoryBonus = 10, order = "b" },
    [3]  = { armSpeedBonus = 0.10, inventoryBonus = 20, order = "c" },
    [4]  = { armSpeedBonus = 0.15, inventoryBonus = 30, order = "d" },
    [5]  = { armSpeedBonus = 0.20, inventoryBonus = 40, order = "e" },
    [6]  = { armSpeedBonus = 0.25, inventoryBonus = 50, order = "f" },
    [7]  = { armSpeedBonus = 0.30, inventoryBonus = 60, order = "g" },
    [8]  = { armSpeedBonus = 0.35, inventoryBonus = 70, order = "h" },
    [9]  = { armSpeedBonus = 0.40, inventoryBonus = 80, order = "i" },
    [10] = { armSpeedBonus = 0.45, inventoryBonus = 90, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [2] = {
        basePacks = orbitBasePacks,
        prerequisites = { "space-platform" }
    },
    [3] = {
        basePacks = orbitBasePacks,
        prerequisites = { "5d-asteroid-collector-2" }
    },
    [4] = {
        basePacks = orbitBasePacks,
        prerequisites = { "5d-asteroid-collector-3" }
    },
    [5] = {
        basePacks = orbitBasePacks,
        prerequisites = { "5d-asteroid-collector-4" }
    },
    [6] = {
        basePacks = orbitBasePacks,
        prerequisites = { "5d-asteroid-collector-5" }
    },
    [7] = {
        basePacks = orbitBasePacks,
        prerequisites = { "5d-asteroid-collector-6" }
    },
    [8] = {
        basePacks = orbitBasePacks,
        prerequisites = { "5d-asteroid-collector-7" }
    },
    [9] = {
        basePacks = orbitFusionPacks,
        prerequisites = { "5d-asteroid-collector-8" }
    },
    [10] = {
        basePacks = orbitQuantumPacks,
        prerequisites = { "5d-asteroid-collector-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local armSpeed = baseArmSpeed + config.armSpeedBonus
    local inventorySize = baseInventorySize + config.inventoryBonus
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.asteroidCollector[tier], tier, {
        skipTierScaling = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-asteroid-collector-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla, no tech needed)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, asteroidCollectorDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = baseTechCount * (tier - 1),
            packs = tc.basePacks,
            prerequisites = prerequisites
        }
    end
    
    -- Generate the asteroid collector
    genAsteroidCollector {
        number = tierNum,
        subgroup = "orbit-asteroid-collector",
        armSpeed = armSpeed,
        inventorySize = inventorySize,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        recipeCategory = tier >= 7 and "crafting-with-fluid" or nil,
        surfaceConditions = tier > 1 and zeroGravitySurfaceConditions or nil,
        tech = tech
    }
end
