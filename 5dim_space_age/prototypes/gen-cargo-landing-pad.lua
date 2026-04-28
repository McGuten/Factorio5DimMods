-------------------------------------------------------------------------------
-- 5Dim's Space Age - Cargo Landing Pad Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-cargo-landing-pad")

local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseInventorySize = 80
local baseTechCount = 500

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { inventoryBonus = 0,   order = "a", isVanilla = true },
    [2]  = { inventoryBonus = 20,  order = "b" },
    [3]  = { inventoryBonus = 40,  order = "c" },
    [4]  = { inventoryBonus = 60,  order = "d" },
    [5]  = { inventoryBonus = 80,  order = "e" },
    [6]  = { inventoryBonus = 100, order = "f" },
    [7]  = { inventoryBonus = 120, order = "g" },
    [8]  = { inventoryBonus = 140, order = "h" },
    [9]  = { inventoryBonus = 160, order = "i" },
    [10] = { inventoryBonus = 180, order = "j" }
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
        prerequisites = { "rocket-silo" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-cargo-landing-pad-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-cargo-landing-pad-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-cargo-landing-pad-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-cargo-landing-pad-5" }
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
        prerequisites = { "5d-cargo-landing-pad-6", "metallurgic-science-pack" }
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
        prerequisites = { "5d-cargo-landing-pad-7" }
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
        prerequisites = { "5d-cargo-landing-pad-8" }
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
        prerequisites = { "5d-cargo-landing-pad-9" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local inventorySize = baseInventorySize + config.inventoryBonus
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.cargoLandingPad[tier]
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-cargo-landing-pad-" .. string.format("%02d", tier + 1)
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
    
    -- Generate the cargo landing pad
    genCargoLandingPad {
        number = tierNum,
        subgroup = "orbit-landing-pad",
        inventorySize = inventorySize,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
