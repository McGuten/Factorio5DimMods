-------------------------------------------------------------------------------
-- 5Dim's Space Age - Mech Armor Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-mech-armor")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseGridWidth = 10
local baseGridHeight = 12
local baseInventoryBonus = 50  -- Base game mech armor has 50
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
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "mech-armor" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-mech-armor-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 }
        },
        prerequisites = { "5d-mech-armor-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 },
            { "promethium-science-pack", 1 }
        },
        prerequisites = { "5d-mech-armor-4", "promethium-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 },
            { "promethium-science-pack", 1 }
        },
        prerequisites = { "5d-mech-armor-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 },
            { "promethium-science-pack", 1 }
        },
        prerequisites = { "5d-mech-armor-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 },
            { "promethium-science-pack", 1 }
        },
        prerequisites = { "5d-mech-armor-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 },
            { "promethium-science-pack", 1 }
        },
        prerequisites = { "5d-mech-armor-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "electromagnetic-science-pack", 1 },
            { "cryogenic-science-pack", 1 },
            { "promethium-science-pack", 1 }
        },
        prerequisites = { "5d-mech-armor-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

local currentGridWidth = baseGridWidth
local currentGridHeight = baseGridHeight
local currentInventoryBonus = baseInventoryBonus

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

    genMechArmor({
        number = number,
        subgroup = "armor-mech-armor",
        order = config.order,
        new = not config.isVanilla,
        gridWidth = currentGridWidth,
        gridHeight = currentGridHeight,
        inventoryBonus = currentInventoryBonus,
        ingredients = RecipeTemplates.mechArmor[tier],
        nextUpdate = tier < 10 and ("5d-mech-armor-" .. string.format("%02d", tier + 1)) or nil,
        tech = techData
    })

    -- Increase grid size every 2 tiers
    if tier % 2 == 0 then
        currentGridWidth = currentGridWidth + 1
        currentGridHeight = currentGridHeight + 1
    end
    
    -- Increase inventory bonus
    currentInventoryBonus = currentInventoryBonus + 10
end
