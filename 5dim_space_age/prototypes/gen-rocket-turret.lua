-------------------------------------------------------------------------------
-- 5Dim's Space Age - Rocket Turret Generation
-- Requires: 5dim_battlefield active
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-rocket-turret")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseRange = 36
local rangeIncrement = 2
local baseRotationSpeed = 0.006
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
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "rocket-turret" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-rocket-turret-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 }
        },
        prerequisites = { "5d-rocket-turret-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-rocket-turret-4", "cryogenic-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-rocket-turret-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-rocket-turret-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-rocket-turret-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-rocket-turret-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-rocket-turret-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

local currentRange = baseRange
local currentRotationSpeed = baseRotationSpeed

for tier = 1, 10 do
    local config = tierConfig[tier]
    local number = string.format("%02d", tier)
    
    local techData = nil
    if techConfig[tier] then
        techData = {
            number = tier,
            count = baseTechCount * tier,
            packs = techConfig[tier].basePacks,
            prerequisites = techConfig[tier].prerequisites
        }
    end

    genRocketTurret({
        number = number,
        subgroup = "turrets-rocket",
        order = config.order,
        new = not config.isVanilla,
        range = currentRange,
        rotationSpeed = currentRotationSpeed,
        tint = tierColors[tier],
        ingredients = RecipeTemplates.rocketTurret[tier],
        nextUpdate = tier < 10 and ("5d-rocket-turret-" .. string.format("%02d", tier + 1)) or nil,
        tech = techData
    })

    currentRotationSpeed = currentRotationSpeed * 1.12
    if tier % 2 == 0 then
        currentRange = currentRange + rangeIncrement
    end
end
