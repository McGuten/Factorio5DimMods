-------------------------------------------------------------------------------
-- 5Dim's Space Age - Crusher Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-crusher")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 1
local baseModuleSlots = 2
local baseEnergy = 540
local baseTechCount = 500

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,   moduleBonus = 0, energyBonus = 0,    order = "a", isVanilla = true },
    [2]  = { speedBonus = 0.5, moduleBonus = 1, energyBonus = 200,  order = "b" },
    [3]  = { speedBonus = 1.0, moduleBonus = 2, energyBonus = 400,  order = "c" },
    [4]  = { speedBonus = 1.5, moduleBonus = 3, energyBonus = 600,  order = "d" },
    [5]  = { speedBonus = 2.0, moduleBonus = 4, energyBonus = 800,  order = "e" },
    [6]  = { speedBonus = 2.5, moduleBonus = 5, energyBonus = 1000, order = "f" },
    [7]  = { speedBonus = 3.0, moduleBonus = 6, energyBonus = 1200, order = "g" },
    [8]  = { speedBonus = 3.5, moduleBonus = 7, energyBonus = 1400, order = "h" },
    [9]  = { speedBonus = 4.0, moduleBonus = 8, energyBonus = 1600, order = "i" },
    [10] = { speedBonus = 4.5, moduleBonus = 9, energyBonus = 1800, order = "j" }
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
        prerequisites = { "space-platform" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-crusher-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-crusher-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-crusher-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-crusher-5" }
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
        prerequisites = { "5d-crusher-6", "metallurgic-science-pack" }
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
        prerequisites = { "5d-crusher-7" }
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
        prerequisites = { "5d-crusher-8" }
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
        prerequisites = { "5d-crusher-9" }
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
    local moduleSlots = baseModuleSlots + config.moduleBonus
    local energyUsage = baseEnergy + config.energyBonus
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.crusher[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-crusher-" .. string.format("%02d", tier + 1)
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
    
    -- Generate the crusher
    genCrusher {
        number = tierNum,
        subgroup = "orbit-crusher",
        craftingSpeed = craftingSpeed,
        moduleSlots = moduleSlots,
        energyUsage = energyUsage,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
