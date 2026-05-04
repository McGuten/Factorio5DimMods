-------------------------------------------------------------------------------
-- 5Dim's Automation - Assembling Machine Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.automation.generation-assembling-machine")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 0.5
local baseModuleSlots = 4
local baseEnergy = 75
local baseEmissions = 4
local baseTechCount = 150

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0,   order = "a", isVanilla = true,  copy = { name = "assembling-machine", postName = "-1" } },
    [2]  = { speedBonus = 0.5, order = "b", isVanilla = true,  copy = { name = "assembling-machine", postName = "-2" } },
    [3]  = { speedBonus = 1.0, order = "c", isVanilla = true,  copy = nil },
    [4]  = { speedBonus = 1.5, order = "d" },
    [5]  = { speedBonus = 2.0, order = "e" },
    [6]  = { speedBonus = 2.5, order = "f" },
    [7]  = { speedBonus = 3.0, order = "g" },
    [8]  = { speedBonus = 3.5, order = "h" },
    [9]  = { speedBonus = 4.0, order = "i" },
    [10] = { speedBonus = 4.5, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "automation-3", "production-science-pack" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "automation-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "automation-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "automation-6", "utility-science-pack" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "automation-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "automation-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "automation-9" }
    }
}

local infrastructureSpaceAgePackThresholds = {
    { tier = 8, pack = "metallurgic-science-pack" },
    { tier = 9, pack = "electromagnetic-science-pack" },
    { tier = 10, pack = "cryogenic-science-pack" }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local craftingSpeed = baseCraftingSpeed + config.speedBonus
    local moduleSlots = 0
    if tier == 2 then
        moduleSlots = 2
    elseif tier >= 3 then
        moduleSlots = baseModuleSlots + math.floor((tier - 2) / 2)
    end
    -- Energy scales FASTER than speed (superlinear: 2x speed = 2.83x energy)
    -- This makes higher tier machines less energy-efficient per craft
    local energy = CostCalculator.scaleEnergyBySpeed(baseEnergy, baseCraftingSpeed, craftingSpeed, 1.5)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed, 0.0)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.assemblingMachine[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Determine next upgrade
    local nextUpgrade = nil
    if tier < 10 then
        if tier < 3 then
            nextUpgrade = "assembling-machine-" .. (tier + 1)
        else
            nextUpgrade = "5d-assembling-machine-" .. string.format("%02d", tier + 1)
        end
    end
    
    -- Build tech configuration (tiers 1-3 are vanilla, no tech needed)
    local tech = nil
    if tier > 3 and techConfig[tier] then
        local tc = techConfig[tier]
        tech = {
            number = tier,
            count = CostCalculator.calculateTechCount(baseTechCount, tier),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackThresholds = infrastructureSpaceAgePackThresholds
            }),
            prerequisites = tc.prerequisites
        }
    end
    
    -- Generate the assembling machine
    genAssemblingMachines {
        number = tierNum,
        subgroup = "assembling-machine",
        craftingSpeed = craftingSpeed,
        moduleSlots = moduleSlots,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        tech = tech,
        copy = config.copy
    }
end
