-------------------------------------------------------------------------------
-- 5Dim's Space Age - Thruster Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-thruster")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseEffectivity = 0.51
local effectivityBonus = 0.1
local baseTechCount = 500

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { effectivityBonus = 0,   order = "a", isVanilla = true },
    [2]  = { effectivityBonus = 0.1, order = "b" },
    [3]  = { effectivityBonus = 0.2, order = "c" },
    [4]  = { effectivityBonus = 0.3, order = "d" },
    [5]  = { effectivityBonus = 0.4, order = "e" },
    [6]  = { effectivityBonus = 0.5, order = "f" },
    [7]  = { effectivityBonus = 0.6, order = "g" },
    [8]  = { effectivityBonus = 0.7, order = "h" },
    [9]  = { effectivityBonus = 0.8, order = "i" },
    [10] = { effectivityBonus = 0.9, order = "j" }
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
            { "space-science-pack", 1 }
        },
        prerequisites = { "space-platform-thruster" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-thruster-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-thruster-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-thruster-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-thruster-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-thruster-6", "metallurgic-science-pack" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-thruster-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-thruster-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "metallurgic-science-pack", 1 }
        },
        prerequisites = { "5d-thruster-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate effectivity for this tier
    local effectivity = baseEffectivity + config.effectivityBonus
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.thruster[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-thruster-" .. string.format("%02d", tier + 1)
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
    
    -- Generate the thruster
    genThruster {
        number = tierNum,
        subgroup = "orbit-thruster",
        effectivity = effectivity,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
