-------------------------------------------------------------------------------
-- 5Dim's Resources - Electric Furnace Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.resources.generation-electric-furnace")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 2
local baseModuleSlots = 2
local baseEnergy = 180
local baseEmissions = 1
local baseTechCount = 250

local electricFurnaceTechCounts = {
    [2] = 450,
    [3] = 800,
    [4] = 1300,
    [5] = 1900,
    [6] = 2600,
    [7] = 3400,
    [8] = 4300,
    [9] = 5300,
    [10] = 6500
}

local electricFurnaceSpaceAgeMaterials = {
    [5] = { name = "calcite", amount = 20, category = "metallurgy" },
    [6] = { type = "fluid", name = "molten-iron", amount = 200, category = "metallurgy" },
    [7] = { name = "tungsten-plate", amount = 10, category = "metallurgy" },
    [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 6, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-hot", amount = 100, category = "cryogenics" }
}

local electricFurnaceSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "metallurgic-science-pack" },
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "metallurgic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local electricFurnaceSpaceAgeDeltaPrerequisites = {
    [5] = "foundry",
    [6] = "foundry",
    [7] = "tungsten-steel",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "cryogenic-plant"
}

local electricFurnaceDeltaPrerequisites = {
    [2] = "steel-processing",
    [4] = "advanced-electronics",
    [5] = "refined-concrete",
    [6] = "processing-unit",
    [7] = "low-density-structure",
    [8] = "productivity-module-2",
    [9] = "speed-module-2",
    [10] = "productivity-module-3"
}

local function copyPrerequisites(values)
    local result = {}

    for _, value in ipairs(values) do
        table.insert(result, value)
    end

    return result
end

local function addPrerequisiteIfMissing(prerequisites, prerequisite)
    if not prerequisite then
        return
    end

    for _, current in ipairs(prerequisites) do
        if current == prerequisite then
            return
        end
    end

    table.insert(prerequisites, prerequisite)
end

local function getElectricFurnaceDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and electricFurnaceSpaceAgeDeltaPrerequisites[tier] then
        return electricFurnaceSpaceAgeDeltaPrerequisites[tier]
    end

    return electricFurnaceDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", isVanilla = true, craftingSpeed = 2.0 },
    [2]  = { order = "b", craftingSpeed = 3.5 },
    [3]  = { order = "c", craftingSpeed = 5.0 },
    [4]  = { order = "d", craftingSpeed = 6.5 },
    [5]  = { order = "e", craftingSpeed = 7.5 },
    [6]  = { order = "f", craftingSpeed = 8.5 },
    [7]  = { order = "g", craftingSpeed = 9.5 },
    [8]  = { order = "h", craftingSpeed = 10.5 },
    [9]  = { order = "i", craftingSpeed = 11.5 },
    [10] = { order = "j", craftingSpeed = 12.5 }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-2" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-3", "production-science-pack" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-4" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-5" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-6" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-7" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-8", "utility-science-pack" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-9" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "advanced-material-processing-10" }
    }
}

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats for this tier
    local craftingSpeed = config.craftingSpeed
    -- Energy scales FASTER than speed (superlinear: 2x speed = 2.83x energy)
    local energy = CostCalculator.scaleEnergyBySpeed(baseEnergy, baseCraftingSpeed, craftingSpeed, 1.5)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed, 0.0)
    
    -- Module slots: base + 1 every 2 tiers (3-4, 5-6, 7-8, 9-10 share each step)
    local moduleSlots = baseModuleSlots + math.floor(tier / 3)
    
    -- Get ingredients from template and process them
    local baseIngredients = RecipeTemplates.electricFurnace[tier]
    local ingredients = CostCalculator.processIngredients(baseIngredients, tier, {
        isBulkItem = false,
        skipTierScaling = true,
        spaceAgeMaterialOverrides = electricFurnaceSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-electric-furnace-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, getElectricFurnaceDeltaPrerequisite(tier))

        tech = {
            number = tier + 1,  -- Tech number offset
            count = CostCalculator.scaleAbsoluteTechCount(electricFurnaceTechCounts[tier]),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = electricFurnaceSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the electric furnace
    genElectricFurnaces {
        number = tierNum,
        subgroup = "furnace-electric",
        craftingSpeed = craftingSpeed,
        moduleSlots = moduleSlots,
        energyUsage = energy,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        pollution = { pollution = emissions },
        nextUpdate = nextUpgrade,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, electricFurnaceSpaceAgeMaterials),
        tech = tech
    }
end
