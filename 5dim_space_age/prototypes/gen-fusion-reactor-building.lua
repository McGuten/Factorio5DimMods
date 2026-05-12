-------------------------------------------------------------------------------
-- 5Dim's Space Age - Fusion Reactor (Building) Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-fusion-reactor-building")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local basePower = 500 -- MW
local powerMultiplier = 1.5
local baseModuleSlots = 4
local baseTechCount = 500

local fusionBasePacks = {
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

local fusionReactorBuildingDeltaPrerequisites = {
    [2] = "lithium-processing",
    [3] = "lithium-processing",
    [4] = "planet-discovery-aquilo",
    [5] = "planet-discovery-aquilo",
    [6] = "planet-discovery-aquilo",
    [7] = "cryogenic-plant",
    [8] = "cryogenic-plant",
    [9] = "fusion-reactor",
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
        basePacks = fusionBasePacks,
        prerequisites = { "fusion-reactor" }
    },
    [3] = {
        basePacks = fusionBasePacks,
        prerequisites = { "5d-fusion-reactor-building-2" }
    },
    [4] = {
        basePacks = fusionBasePacks,
        prerequisites = { "5d-fusion-reactor-building-3" }
    },
    [5] = {
        basePacks = fusionBasePacks,
        prerequisites = { "5d-fusion-reactor-building-4" }
    },
    [6] = {
        basePacks = fusionBasePacks,
        prerequisites = { "5d-fusion-reactor-building-5" }
    },
    [7] = {
        basePacks = fusionBasePacks,
        prerequisites = { "5d-fusion-reactor-building-6" }
    },
    [8] = {
        basePacks = fusionBasePacks,
        prerequisites = { "5d-fusion-reactor-building-7" }
    },
    [9] = {
        basePacks = fusionBasePacks,
        prerequisites = { "5d-fusion-reactor-building-8" }
    },
    [10] = {
        basePacks = fusionBasePacks,
        prerequisites = { "5d-fusion-reactor-building-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

local currentPower = basePower
local currentModules = baseModuleSlots

for tier = 1, 10 do
    local config = tierConfig[tier]
    local number = string.format("%02d", tier)
    
    local techData = nil
    if techConfig[tier] then
        local prerequisites = copyPrerequisites(techConfig[tier].prerequisites)

        addPrerequisiteIfMissing(prerequisites, fusionReactorBuildingDeltaPrerequisites[tier])

        techData = {
            number = tier,
            count = baseTechCount * tier,
            packs = techConfig[tier].basePacks,
            prerequisites = prerequisites
        }
    end

    genFusionReactorBuilding({
        number = number,
        subgroup = "space-fusion-reactor",
        order = config.order,
        new = not config.isVanilla,
        power = currentPower,
        moduleSlots = currentModules,
        ingredients = CostCalculator.processIngredients(RecipeTemplates.fusionReactor[tier], tier, {
            skipTierScaling = true,
            skipSpaceAgeMaterials = true
        }),
        nextUpdate = tier < 10 and ("5d-fusion-reactor-building-" .. string.format("%02d", tier + 1)) or nil,
        tech = techData
    })

    currentPower = currentPower * powerMultiplier
    if tier % 2 == 0 and currentModules < 8 then
        currentModules = currentModules + 1
    end
end
