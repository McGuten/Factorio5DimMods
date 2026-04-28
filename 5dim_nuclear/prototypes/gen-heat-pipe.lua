-------------------------------------------------------------------------------
-- 5Dim's Nuclear - Heat Pipe Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.nuclear.generation-heat-pipe")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseMaxTemperature = 1000  -- Max heat temperature (scales UP)
local baseModuleSlots = 2
local baseMaxTransfer = 1        -- Heat transfer in GW
local baseEmissions = 30         -- Pollution emissions
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
            { "utility-science-pack", 1 }
        },
        prerequisites = { "nuclear-power" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-1", "5d-steam-turbine-1", "5d-heat-pipe-1", "5d-heat-exchanger-1" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-2", "5d-steam-turbine-2", "5d-heat-pipe-2", "5d-heat-exchanger-2", "space-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-3", "5d-steam-turbine-3", "5d-heat-pipe-3", "5d-heat-exchanger-3" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-4", "5d-steam-turbine-4", "5d-heat-pipe-4", "5d-heat-exchanger-4" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-5", "5d-steam-turbine-5", "5d-heat-pipe-5", "5d-heat-exchanger-5" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-6", "5d-steam-turbine-6", "5d-heat-pipe-6", "5d-heat-exchanger-6" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-7", "5d-steam-turbine-7", "5d-heat-pipe-7", "5d-heat-exchanger-7" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-nuclear-reactor-8", "5d-steam-turbine-8", "5d-heat-pipe-8", "5d-heat-exchanger-8" }
    }
}

local nuclearSpaceAgePackThresholds = {
    { tier = 6, pack = "metallurgic-science-pack" },
    { tier = 8, pack = "electromagnetic-science-pack" },
    { tier = 10, pack = "cryogenic-science-pack" }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    -- Temperature scales UP with tier (better pipe = higher temp capacity)
    local maxTemperature = baseMaxTemperature + (tier - 1) * 100
    -- Transfer rate scales linearly
    local maxTransfer = baseMaxTransfer + (tier - 1) * 0.5
    -- Pollution decreases with efficiency (vanilla pattern)
    local emissions = CostCalculator.scalePollution(baseEmissions, tier)
    
    -- Module slots: base + 1 every 2 tiers
    local moduleSlots = baseModuleSlots + math.floor((tier - 1) / 2)
    -- Odd tiers >= 3 get an extra slot
    if tier >= 3 and tier % 2 == 1 then
        moduleSlots = moduleSlots + 1
    end
    
    -- Get ingredients from template
    local ingredients = RecipeTemplates.heatPipe[tier]
    
    -- Determine next upgrade
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-heat-pipe-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        tech = {
            number = tier - 1,
            count = baseTechCount * (tier - 1),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackThresholds = nuclearSpaceAgePackThresholds
            }),
            prerequisites = tc.prerequisites
        }
    end
    
    -- Generate the heat pipe
    genHeatPipes {
        number = tierNum,
        subgroup = "nuclear-pipe",
        maxTemperature = maxTemperature,
        maxTransfer = maxTransfer,
        moduleSlots = moduleSlots,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
