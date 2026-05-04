-------------------------------------------------------------------------------
-- 5Dim's Space Age - Biolab Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-biolab")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseResearchSpeed = 2
local speedMultiplier = 1.5
local baseModuleSlots = 4
local baseEnergyUsage = 300
local baseEmissions = 8
local baseTechCount = 500

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
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "biolab" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biolab-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biolab-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-biolab-4", "cryogenic-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-biolab-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-biolab-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-biolab-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-biolab-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-biolab-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

local currentSpeed = baseResearchSpeed
local currentModules = baseModuleSlots

for tier = 1, 10 do
    local config = tierConfig[tier]
    local number = string.format("%02d", tier)
    local currentEnergy = CostCalculator.scaleEnergyBySpeed(baseEnergyUsage, baseResearchSpeed, currentSpeed, 1.5)
    local currentEmissions = CostCalculator.scalePollution(baseEmissions, baseResearchSpeed, currentSpeed)
    
    local techData = nil
    if techConfig[tier] then
        techData = {
            number = tier,
            count = baseTechCount * tier,
            packs = techConfig[tier].basePacks,
            prerequisites = techConfig[tier].prerequisites
        }
    end

    genBiolab({
        number = number,
        subgroup = "biolab",
        order = config.order,
        new = not config.isVanilla,
        researchSpeed = currentSpeed,
        moduleSlots = currentModules,
        energyUsage = currentEnergy,
        pollution = { pollution = currentEmissions },
        ingredients = RecipeTemplates.biolab[tier],
        nextUpdate = tier < 10 and ("5d-biolab-" .. string.format("%02d", tier + 1)) or nil,
        tech = techData
    })

    currentSpeed = currentSpeed * speedMultiplier
    if tier % 2 == 0 and currentModules < 8 then
        currentModules = currentModules + 1
    end
end
