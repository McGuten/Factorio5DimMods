-------------------------------------------------------------------------------
-- 5Dim's Space Age - Fusion Reactor Equipment Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.equipment.generation-fusion-reactor-equipment")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local basePower = 750
local powerMultiplier = 1.75
local baseTechCount = 200

local fusionEquipmentBasePacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "production-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "metallurgic-science-pack", 1 },
    { "agricultural-science-pack", 1 },
    { "electromagnetic-science-pack", 1 },
    { "cryogenic-science-pack", 1 }
}

local fusionReactorEquipmentDeltaPrerequisites = {
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
        basePacks = fusionEquipmentBasePacks,
        prerequisites = { "fusion-reactor-equipment" }
    },
    [3] = {
        basePacks = fusionEquipmentBasePacks,
        prerequisites = { "fusion-reactor-equipment-2" }
    },
    [4] = {
        basePacks = fusionEquipmentBasePacks,
        prerequisites = { "fusion-reactor-equipment-3" }
    },
    [5] = {
        basePacks = fusionEquipmentBasePacks,
        prerequisites = { "fusion-reactor-equipment-4" }
    },
    [6] = {
        basePacks = fusionEquipmentBasePacks,
        prerequisites = { "fusion-reactor-equipment-5" }
    },
    [7] = {
        basePacks = fusionEquipmentBasePacks,
        prerequisites = { "fusion-reactor-equipment-6" }
    },
    [8] = {
        basePacks = fusionEquipmentBasePacks,
        prerequisites = { "fusion-reactor-equipment-7" }
    },
    [9] = {
        basePacks = fusionEquipmentBasePacks,
        prerequisites = { "fusion-reactor-equipment-8" }
    },
    [10] = {
        basePacks = fusionEquipmentBasePacks,
        prerequisites = { "fusion-reactor-equipment-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate power for this tier (exponential growth)
    local power = basePower
    for i = 2, tier do
        power = power * powerMultiplier
    end
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.fusionReactorEquipment[tier], tier, {
        skipTierScaling = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Build tech configuration (tier 1 is vanilla, no tech needed)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, fusionReactorEquipmentDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = baseTechCount * tier,
            packs = tc.basePacks,
            prerequisites = prerequisites
        }
    end
    
    -- Generate the fusion reactor equipment
    genFusionReactors {
        number = tierNum,
        subgroup = "armor-reactor",
        power = power,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        recipeCategory = tier >= 4 and "crafting-with-fluid" or nil,
        tech = tech
    }
end
