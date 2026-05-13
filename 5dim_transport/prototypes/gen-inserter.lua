-------------------------------------------------------------------------------
-- 5Dim's Transport - Inserter Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.transport.generation-inserter")

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

local inserterTechCounts = {
    [2] = 320,
    [3] = 520,
    [4] = 780,
    [5] = 1100,
    [6] = 1500,
    [7] = 1950,
    [8] = 2500,
    [9] = 3150,
    [10] = 3900
}

local inserterSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 2, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 40, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 1, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 1, category = "cryogenics" }
}

local inserterSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local inserterSpaceAgeDeltaPrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local inserterDeltaPrerequisites = {
    [3] = "advanced-circuit",
    [4] = "battery",
    [5] = "electric-engine",
    [6] = "processing-unit",
    [7] = "low-density-structure",
    [8] = "speed-module",
    [9] = "speed-module-2",
    [10] = "speed-module-3"
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

local function getInserterDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and inserterSpaceAgeDeltaPrerequisites[tier] then
        return inserterSpaceAgeDeltaPrerequisites[tier]
    end

    return inserterDeltaPrerequisites[tier]
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", isVanilla = true, copyName = "inserter" },
    [2]  = { order = "b", isVanilla = true, copyName = "fast-inserter" },
    [3]  = { order = "c", copyName = "fast-inserter" },
    [4]  = { order = "d", copyName = "fast-inserter" },
    [5]  = { order = "e", copyName = "fast-inserter" },
    [6]  = { order = "f", copyName = "fast-inserter" },
    [7]  = { order = "g", copyName = "fast-inserter" },
    [8]  = { order = "h", copyName = "fast-inserter" },
    [9]  = { order = "i", copyName = "fast-inserter" },
    [10] = { order = "j", copyName = "fast-inserter" }
}

local fastInserterExtension = baseExtension + 0.015
local fastInserterRotation = baseRotation + 0.015
local fastInserterEnergy = CostCalculator.scaleEnergy(baseEnergy, 2)
local fastInserterDrain = baseDrain + 0.015

local function getInserterProgressionTier(tier)
    if tier <= 2 then
        return 1
    end

    return tier - 1
end

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
            prerequisites = { "bulk-inserter", getTransportLogisticsPrerequisite(2), "chemical-science-pack" }
        },
        [3] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-2", getTransportLogisticsPrerequisite(3) }
        },
        [4] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-3", getTransportLogisticsPrerequisite(4) }
        },
        [5] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-4", "production-science-pack", getTransportLogisticsPrerequisite(5) }
        },
        [6] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-5", getTransportLogisticsPrerequisite(6) }
        },
        [7] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-6", getTransportLogisticsPrerequisite(7) }
        },
        [8] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-7", "utility-science-pack", getTransportLogisticsPrerequisite(8) }
        },
        [9] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-8", getTransportLogisticsPrerequisite(9) }
        },
        [10] = {
            basePacks = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "bulk-inserter-9", getTransportLogisticsPrerequisite(10) }
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
    local progressionTier = getInserterProgressionTier(tier)
    
    -- Preserve vanilla tiers and start geometric progression from fast inserter.
    local extension = baseExtension
    local rotation = baseRotation
    local energy = CostCalculator.scaleEnergy(baseEnergy, tier)
    local drain = baseDrain

    if tier == 2 then
        extension = fastInserterExtension
        rotation = fastInserterRotation
        energy = fastInserterEnergy
        drain = fastInserterDrain
    elseif tier > 2 then
        extension = CostCalculator.calculateMachineWorkValue(fastInserterExtension, progressionTier, 9, 3)
        rotation = CostCalculator.calculateMachineWorkValue(fastInserterRotation, progressionTier, 9, 3)
        energy = CostCalculator.scaleMachineEnergy(fastInserterEnergy, progressionTier)
        drain = CostCalculator.scaleMachineEnergy(fastInserterDrain, progressionTier, 3)
    end
    
    -- Get ingredients from templates
    local inserterIngredients = CostCalculator.processIngredients(RecipeTemplates.inserter[tier], tier, {
        isBulkItem = false,
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        progressionTier = progressionTier,
        spaceAgeMaterialOverrides = inserterSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    local bulkIngredients = CostCalculator.processIngredients(RecipeTemplates.bulkInserter[tier], tier, {
        isBulkItem = false,
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        progressionTier = progressionTier,
        spaceAgeMaterialOverrides = inserterSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
    
    -- Determine next upgrades (nil for tier 10)
    local nextUpdate = {}
    if tier < 10 then
        local nextTierNum = string.format("%02d", tier + 1)
        if tier == 1 then
            nextUpdate.inserter = "fast-inserter"
            nextUpdate.bulkInserter = "5d-bulk-inserter-02"
        elseif tier == 2 then
            nextUpdate.inserter = "5d-inserter-03"
            nextUpdate.bulkInserter = "5d-bulk-inserter-03"
        else
            nextUpdate.inserter = "5d-inserter-" .. nextTierNum
            nextUpdate.bulkInserter = "5d-bulk-inserter-" .. nextTierNum
        end
    end
    
    -- Build tech configuration if not vanilla tier 1
    local tech = nil
    if tier > 1 then
        local tc = getTechConfig(tier)
        if tc then
            local prerequisites = copyPrerequisites(tc.prerequisites)

            addPrerequisiteIfMissing(prerequisites, getInserterDeltaPrerequisite(tier))

            tech = {
                number = tier,
                count = CostCalculator.calculateMachineTechCount(baseTechCount, progressionTier),
                packs = CostCalculator.getTechPacks(tc.basePacks, tier, {
                    spaceAgePackOverrides = inserterSpaceAgeSciencePacks,
                    forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
                }),
                prerequisites = prerequisites
            }
        end
    end
    
    -- Generate the inserter
    genInserters {
        number = tierNum,
        extensionSpeed = extension,
        rotationSpeed = rotation,
        energyMovement = energy,
        energyRotation = energy,
        energyDrain = drain,
        new = not config.isVanilla,
        order = config.order,
        ingredients = {
            inserter = inserterIngredients,
            bulkInserter = bulkIngredients
        },
        nextUpdate = nextUpdate,
        tech = tech,
        recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, inserterSpaceAgeMaterials),
        copyName = config.copyName
    }
end
