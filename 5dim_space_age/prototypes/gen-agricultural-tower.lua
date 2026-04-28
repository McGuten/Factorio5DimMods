-------------------------------------------------------------------------------
-- 5Dim's Space Age - Agricultural Tower Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-agricultural-tower")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseRadius = 3
local baseEnergyUsage = 100
local baseTechCount = 500

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { radiusBonus = 0, energyBonus = 0,   order = "a", isVanilla = true },
    [2]  = { radiusBonus = 1, energyBonus = 50,  order = "b" },
    [3]  = { radiusBonus = 2, energyBonus = 100, order = "c" },
    [4]  = { radiusBonus = 3, energyBonus = 150, order = "d" },
    [5]  = { radiusBonus = 4, energyBonus = 200, order = "e" },
    [6]  = { radiusBonus = 5, energyBonus = 250, order = "f" },
    [7]  = { radiusBonus = 6, energyBonus = 300, order = "g" },
    [8]  = { radiusBonus = 7, energyBonus = 350, order = "h" },
    [9]  = { radiusBonus = 8, energyBonus = 400, order = "i" },
    [10] = { radiusBonus = 9, energyBonus = 450, order = "j" }
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
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "agriculture" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-agricultural-tower-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-agricultural-tower-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-agricultural-tower-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-agricultural-tower-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-agricultural-tower-6", "space-science-pack" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-agricultural-tower-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-agricultural-tower-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-agricultural-tower-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local radius = baseRadius + config.radiusBonus
    local energyUsage = baseEnergyUsage + config.energyBonus
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.agriculturalTower[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-agricultural-tower-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla, no tech needed)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        tech = {
            number = tier,
            count = baseTechCount * (tier - 1),
            packs = tc.basePacks,
            prerequisites = tc.prerequisites
        }
    end
    
    -- Generate the agricultural tower
    genAgriculturalTower {
        number = tierNum,
        subgroup = "gleba-agricultural-tower",
        radius = radius,
        energyUsage = energyUsage,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
