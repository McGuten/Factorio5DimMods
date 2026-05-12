-------------------------------------------------------------------------------
-- 5Dim's Space Age - Heating Tower Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-heating-tower")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local CostConfig = require("__5dim_core__.lib.costs.config")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseConsumption = 40
local baseTechCount = 500

local heatingTowerBasePacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local heatingTowerLatePacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local heatingTowerFusionPacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local heatingTowerDeltaPrerequisites = {
    [2] = "lithium-processing",
    [3] = "lithium-processing",
    [4] = "planet-discovery-aquilo",
    [5] = "planet-discovery-aquilo",
    [6] = "planet-discovery-aquilo",
    [7] = "planet-discovery-aquilo",
    [8] = "cryogenic-plant",
    [9] = "cryogenic-plant",
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
    [1]  = { consumptionBonus = 0,  order = "a", isVanilla = true },
    [2]  = { consumptionBonus = 10, order = "b" },
    [3]  = { consumptionBonus = 20, order = "c" },
    [4]  = { consumptionBonus = 30, order = "d" },
    [5]  = { consumptionBonus = 40, order = "e" },
    [6]  = { consumptionBonus = 50, order = "f" },
    [7]  = { consumptionBonus = 60, order = "g" },
    [8]  = { consumptionBonus = 70, order = "h" },
    [9]  = { consumptionBonus = 80, order = "i" },
    [10] = { consumptionBonus = 90, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [2] = {
        basePacks = heatingTowerBasePacks,
        prerequisites = { "heating-tower" }
    },
    [3] = {
        basePacks = heatingTowerBasePacks,
        prerequisites = { "5d-heating-tower-2" }
    },
    [4] = {
        basePacks = heatingTowerBasePacks,
        prerequisites = { "5d-heating-tower-3" }
    },
    [5] = {
        basePacks = heatingTowerBasePacks,
        prerequisites = { "5d-heating-tower-4" }
    },
    [6] = {
        basePacks = heatingTowerBasePacks,
        prerequisites = { "5d-heating-tower-5" }
    },
    [7] = {
        basePacks = heatingTowerBasePacks,
        prerequisites = { "5d-heating-tower-6" }
    },
    [8] = {
        basePacks = heatingTowerLatePacks,
        prerequisites = { "5d-heating-tower-7" }
    },
    [9] = {
        basePacks = heatingTowerLatePacks,
        prerequisites = { "5d-heating-tower-8" }
    },
    [10] = {
        basePacks = heatingTowerFusionPacks,
        prerequisites = { "5d-heating-tower-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local consumption = baseConsumption + config.consumptionBonus
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.heatingTower[tier], tier, {
        skipTierScaling = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-heating-tower-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla, no tech needed)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, heatingTowerDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = baseTechCount * (tier - 1),
            packs = tc.basePacks,
            prerequisites = prerequisites
        }
    end
    
    -- Generate the heating tower
    genHeatingTower {
        number = tierNum,
        subgroup = "aquilo-heating-tower",
        consumption = consumption,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        recipeCategory = "cryogenics-or-assembling",
        tech = tech
    }
end
