-------------------------------------------------------------------------------
-- 5Dim's Transport - Stack Inserter Generation (Space Age only)
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.transport.generation-stack-inserter")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseExtension = 0.03
local baseRotation = 0.014
local baseEnergy = 5
local baseDrain = 0.4
local baseTechCount = 200

local stackInserterTechCounts = {
    [2] = 420,
    [3] = 650,
    [4] = 950,
    [5] = 1300,
    [6] = 1750,
    [7] = 2300,
    [8] = 2950,
    [9] = 3700,
    [10] = 4550
}

local stackInserterSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 2, category = "electromagnetics" },
    [8] = { name = "supercapacitor", amount = 1, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 1, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 1, category = "cryogenics" }
}

local stackInserterSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local stackInserterSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local stackInserterDeltaPrerequisites = {
    [2] = "advanced-circuit",
    [3] = "battery",
    [4] = "electric-engine",
    [5] = "processing-unit",
    [6] = "low-density-structure",
    [7] = "speed-module-2",
    [8] = "productivity-module-2",
    [9] = "speed-module-3",
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

local function getTransportLogisticsPrerequisite(tier)
    if tier == 4 and mods["space-age"] then
        return "turbo-transport-belt"
    end

    if mods["space-age"] and tier >= 5 then
        return "logistics-" .. (tier - 1)
    end

    return "logistics-" .. tier
end

local function getStackInserterDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and stackInserterSpaceAgeDeltaPrerequisites[tier] then
        return stackInserterSpaceAgeDeltaPrerequisites[tier]
    end

    return stackInserterDeltaPrerequisites[tier]
end

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

local function getTechConfig(tier)
    local configs = {
        [2] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 }
            },
            prerequisites = { "stack-inserter", getTransportLogisticsPrerequisite(2), "chemical-science-pack" }
        },
        [3] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-2", getTransportLogisticsPrerequisite(3) }
        },
        [4] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-3", getTransportLogisticsPrerequisite(4) }
        },
        [5] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-4", "production-science-pack", getTransportLogisticsPrerequisite(5) }
        },
        [6] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-5", getTransportLogisticsPrerequisite(6) }
        },
        [7] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-6", getTransportLogisticsPrerequisite(7) }
        },
        [8] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-7", "utility-science-pack", getTransportLogisticsPrerequisite(8) }
        },
        [9] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-8", getTransportLogisticsPrerequisite(9) }
        },
        [10] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "stack-inserter-9", getTransportLogisticsPrerequisite(10) }
        }
    }
    return configs[tier]
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    
    -- Calculate stats with incremental bonuses
    local tierBonus = (tier - 1) * 0.015
    local extension = baseExtension + tierBonus
    local rotation = baseRotation + tierBonus
    -- Non-linear energy scaling (vanilla pattern)
    local energy = CostCalculator.scaleEnergy(baseEnergy, tier)
    local drain = baseDrain + tierBonus
    
    -- Get ingredients from template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.stackInserter[tier], tier, {
        isBulkItem = false,
        skipTierScaling = true,
        spaceAgeMaterialOverrides = stackInserterSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrade (nil for tier 10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-stack-inserter-" .. string.format("%02d", tier + 1)
    end
    
    -- Build tech configuration if not vanilla (tier 1)
    local tech = nil
    if tier > 1 then
        local tc = getTechConfig(tier)
        if tc then
            local prerequisites = copyPrerequisites(tc.prerequisites)

            addPrerequisiteIfMissing(prerequisites, getStackInserterDeltaPrerequisite(tier))

            tech = {
                number = tier,
                count = CostCalculator.scaleAbsoluteTechCount(stackInserterTechCounts[tier]),
                packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                    spaceAgePackOverrides = stackInserterSpaceAgeSciencePacks,
                    forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
                }),
                prerequisites = prerequisites
            }
        end
    end
    
    -- Generate the stack inserter
    genStackInserters {
        number = tierNum,
        extensionSpeed = extension,
        rotationSpeed = rotation,
        energyMovement = energy,
        energyRotation = energy,
        energyDrain = drain,
        new = not config.isVanilla,
        order = config.order,
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, stackInserterSpaceAgeMaterials),
        copyName = "stack-inserter"
    }
end
