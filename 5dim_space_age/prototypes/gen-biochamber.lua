-------------------------------------------------------------------------------
-- 5Dim's Space Age - Biochamber Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-biochamber")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseCraftingSpeed = 2
local baseModuleSlots = 4
local baseEnergy = 500
local baseEmissions = -1
local baseTechCount = 400

local biochamberSpaceAgeSciencePacks = {
    [5] = { "space-science-pack", "electromagnetic-science-pack" },
    [6] = { "space-science-pack", "electromagnetic-science-pack" },
    [7] = { "space-science-pack", "cryogenic-science-pack" },
    [8] = { "space-science-pack", "cryogenic-science-pack" },
    [9] = { "space-science-pack", "cryogenic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local biochamberDeltaPrerequisites = {
    [2] = "jellynut",
    [3] = "bioflux",
    [4] = "carbon-fiber",
    [5] = "holmium-processing",
    [6] = "electromagnetic-plant",
    [7] = "lithium-processing",
    [8] = "cryogenic-plant",
    [9] = "cryogenic-plant",
    [10] = "quantum-processor"
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

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { speedBonus = 0, moduleBonus = 0, order = "a", isVanilla = true },
    [2]  = { speedBonus = 1, moduleBonus = 1, order = "b" },
    [3]  = { speedBonus = 2, moduleBonus = 2, order = "c" },
    [4]  = { speedBonus = 3, moduleBonus = 3, order = "d" },
    [5]  = { speedBonus = 4, moduleBonus = 4, order = "e" },
    [6]  = { speedBonus = 5, moduleBonus = 5, order = "f" },
    [7]  = { speedBonus = 6, moduleBonus = 6, order = "g" },
    [8]  = { speedBonus = 7, moduleBonus = 7, order = "h" },
    [9]  = { speedBonus = 8, moduleBonus = 8, order = "i" },
    [10] = { speedBonus = 9, moduleBonus = 9, order = "j" }
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
        prerequisites = { "biochamber" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biochamber-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biochamber-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biochamber-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biochamber-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biochamber-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biochamber-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biochamber-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "agricultural-science-pack", 1 }
        },
        prerequisites = { "5d-biochamber-9" }
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
    -- Energy scales FASTER than speed (superlinear: 2x speed = 2.83x energy)
    local energy = CostCalculator.scaleEnergyBySpeed(baseEnergy, baseCraftingSpeed, craftingSpeed, 1.5)
    local emissions = CostCalculator.scalePollution(baseEmissions, baseCraftingSpeed, craftingSpeed)
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.biochamber[tier], tier, {
        skipTierScaling = true,
        skipSpaceAgeMaterials = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-biochamber-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration (tier 1 is vanilla, no tech needed)
    local tech = nil
    if tier > 1 and techConfig[tier] then
        local tc = techConfig[tier]
        local prerequisites = copyPrerequisites(tc.prerequisites)

        addPrerequisiteIfMissing(prerequisites, biochamberDeltaPrerequisites[tier])

        tech = {
            number = tier,
            count = baseTechCount * (tier - 1),
            packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                spaceAgePackOverrides = biochamberSpaceAgeSciencePacks,
                forceSpaceAgePackOverrides = true
            }),
            prerequisites = prerequisites
        }
    end
    
    -- Generate the biochamber
    genBiochamber {
        number = tierNum,
        subgroup = "gleba-biochamber",
        craftingSpeed = craftingSpeed,
        moduleSlots = moduleSlots,
        energyUsage = energy,
        pollution = { pollution = emissions },
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
