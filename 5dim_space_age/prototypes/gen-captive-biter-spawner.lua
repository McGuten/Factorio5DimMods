-------------------------------------------------------------------------------
-- 5Dim's Space Age - Captive Biter Spawner Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-captive-biter-spawner")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 1
local baseTechCount = 500

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
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "captive-biter-spawner" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-captive-biter-spawner-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-captive-biter-spawner-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-captive-biter-spawner-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-captive-biter-spawner-5" }
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
        prerequisites = { "5d-captive-biter-spawner-6", "space-science-pack" }
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
        prerequisites = { "5d-captive-biter-spawner-7" }
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
        prerequisites = { "5d-captive-biter-spawner-8" }
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
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.captiveBiterSpawner[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-captive-biter-spawner-" .. string.format("%02d", tier + 1)
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
    
    -- Generate the captive biter spawner
    genCaptiveBiterSpawner {
        number = tierNum,
        subgroup = "gleba-captive",
        craftingSpeed = craftingSpeed,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
