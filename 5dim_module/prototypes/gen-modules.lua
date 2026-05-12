-------------------------------------------------------------------------------
-- 5Dim's Module - Module Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.module.generation-module")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseTime = 5
local baseTechCount = 50

local moduleTypes = { "speed", "effectivity", "productivity", "pollution", "quality", "merged" }

local moduleEffectCurves = {
    speed = {
        speed = { 0.20, 0.35, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00, 1.10, 1.20 },
        consumption = { 0.50, 0.60, 0.70, 0.85, 1.00, 1.15, 1.30, 1.45, 1.60, 1.75 }
    },
    effectivity = {
        consumption = { -0.30, -0.40, -0.50, -0.58, -0.64, -0.70, -0.75, -0.80, -0.80, -0.80 }
    },
    productivity = {
        productivity = { 0.04, 0.06, 0.08, 0.10, 0.12, 0.14, 0.16, 0.18, 0.20, 0.22 },
        consumption = { 0.40, 0.60, 0.80, 1.00, 1.20, 1.40, 1.65, 1.90, 2.15, 2.40 },
        pollution = { 0.05, 0.07, 0.09, 0.11, 0.13, 0.15, 0.17, 0.19, 0.21, 0.23 },
        speed = { -0.05, -0.10, -0.15, -0.18, -0.22, -0.26, -0.30, -0.34, -0.38, -0.42 }
    },
    pollution = {
        pollution = { -0.10, -0.16, -0.22, -0.28, -0.34, -0.40, -0.46, -0.52, -0.58, -0.64 }
    },
    quality = {
        quality = { 0.08, 0.16, 0.25, 0.30, 0.34, 0.38, 0.42, 0.46, 0.50, 0.54 }
    }
}

local defaultModuleTechCounts = {
    [1] = 60,
    [2] = 120,
    [3] = 320,
    [4] = 700,
    [5] = 1100,
    [6] = 1600,
    [7] = 2200,
    [8] = 3000,
    [9] = 3900,
    [10] = 5000
}

local mergedModuleTechCounts = {
    [1] = 140,
    [2] = 260,
    [3] = 650,
    [4] = 1300,
    [5] = 2000,
    [6] = 2900,
    [7] = 3900,
    [8] = 5200,
    [9] = 6700,
    [10] = 8500
}

local mergedEffectWeights = {
    speedBonus = 0.4,
    speedConsumption = 0.6,
    effectivityConsumption = 0.4,
    pollution = 0.5
}

local moduleSpaceAgeMaterials = {
    speed = {
        [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 5, category = "electromagnetics" },
        [10] = { name = "quantum-processor", amount = 10, category = "cryogenics" }
    },
    effectivity = {
        [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 5, category = "electromagnetics" },
        [10] = { name = "lithium-plate", amount = 10, category = "cryogenics" }
    },
    productivity = {
        [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 5, category = "electromagnetics" },
        [10] = { name = "quantum-processor", amount = 10, category = "cryogenics" }
    },
    pollution = {
        [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 5, category = "electromagnetics" },
        [10] = { name = "lithium-plate", amount = 10, category = "cryogenics" }
    },
    quality = {
        [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 5, category = "electromagnetics" },
        [10] = { name = "quantum-processor", amount = 10, category = "cryogenics" }
    },
    merged = {
        [8] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 5, category = "electromagnetics" },
        [10] = { name = "quantum-processor", amount = 10, category = "cryogenics" }
    }
}

local moduleSpaceAgeSciencePacks = {
    speed = {
        [8] = { "space-science-pack", "electromagnetic-science-pack" },
        [9] = { "space-science-pack", "electromagnetic-science-pack" },
        [10] = { "space-science-pack", "cryogenic-science-pack" }
    },
    effectivity = {
        [8] = { "space-science-pack", "electromagnetic-science-pack" },
        [9] = { "space-science-pack", "electromagnetic-science-pack" },
        [10] = { "space-science-pack", "cryogenic-science-pack" }
    },
    productivity = {
        [8] = { "space-science-pack", "electromagnetic-science-pack" },
        [9] = { "space-science-pack", "electromagnetic-science-pack" },
        [10] = { "space-science-pack", "cryogenic-science-pack" }
    },
    pollution = {
        [8] = { "space-science-pack", "electromagnetic-science-pack" },
        [9] = { "space-science-pack", "electromagnetic-science-pack" },
        [10] = { "space-science-pack", "cryogenic-science-pack" }
    },
    quality = {
        [8] = { "space-science-pack", "electromagnetic-science-pack" },
        [9] = { "space-science-pack", "electromagnetic-science-pack" },
        [10] = { "space-science-pack", "cryogenic-science-pack" }
    },
    merged = {
        [8] = { "space-science-pack", "electromagnetic-science-pack" },
        [9] = { "space-science-pack", "electromagnetic-science-pack" },
        [10] = { "space-science-pack", "cryogenic-science-pack" }
    }
}

local moduleDeltaPrerequisites = {
    speed = {
        [4] = "processing-unit",
        [5] = "battery",
        [6] = "low-density-structure",
        [7] = "speed-module-3",
        [8] = "speed-module-4",
        [9] = "speed-module-5",
        [10] = "speed-module-6"
    },
    effectivity = {
        [4] = "processing-unit",
        [5] = "battery",
        [6] = "low-density-structure",
        [7] = "efficiency-module-3",
        [8] = "efficiency-module-4",
        [9] = "efficiency-module-5",
        [10] = "efficiency-module-6"
    },
    productivity = {
        [4] = "processing-unit",
        [5] = "battery",
        [6] = "low-density-structure",
        [7] = "productivity-module-3",
        [8] = "productivity-module-4",
        [9] = "productivity-module-5",
        [10] = "productivity-module-6"
    },
    pollution = {
        [1] = "electronics",
        [2] = "advanced-circuit",
        [3] = "battery",
        [4] = "processing-unit",
        [5] = "low-density-structure",
        [6] = "efficiency-module-2",
        [7] = "efficiency-module-3",
        [8] = "5d-pollution-module-7",
        [9] = "5d-pollution-module-8",
        [10] = "5d-pollution-module-9"
    },
    quality = {
        [4] = "processing-unit",
        [5] = "battery",
        [6] = "low-density-structure",
        [7] = "quality-module-3",
        [8] = "quality-module-4",
        [9] = "quality-module-5",
        [10] = "quality-module-6"
    },
    merged = {
        [1] = "advanced-circuit",
        [2] = "processing-unit",
        [3] = "battery",
        [4] = "low-density-structure",
        [5] = "speed-module-3",
        [6] = "efficiency-module-3",
        [7] = "productivity-module-3",
        [8] = "5d-merged-module-7",
        [9] = "5d-merged-module-8",
        [10] = "5d-merged-module-9"
    }
}

local moduleSpaceAgeDeltaPrerequisites = {
    speed = {
        [8] = "electromagnetic-plant",
        [9] = "electromagnetic-plant",
        [10] = "quantum-processor"
    },
    effectivity = {
        [8] = "electromagnetic-plant",
        [9] = "electromagnetic-plant",
        [10] = "lithium-processing"
    },
    productivity = {
        [8] = "electromagnetic-plant",
        [9] = "electromagnetic-plant",
        [10] = "quantum-processor"
    },
    pollution = {
        [8] = "electromagnetic-plant",
        [9] = "electromagnetic-plant",
        [10] = "lithium-processing"
    },
    quality = {
        [8] = "electromagnetic-plant",
        [9] = "electromagnetic-plant",
        [10] = "quantum-processor"
    },
    merged = {
        [8] = "electromagnetic-plant",
        [9] = "electromagnetic-plant",
        [10] = "quantum-processor"
    }
}

local vanillaModuleRecipeNames = {
    speed = {
        [1] = "speed-module",
        [2] = "speed-module-2",
        [3] = "speed-module-3"
    },
    effectivity = {
        [1] = "efficiency-module",
        [2] = "efficiency-module-2",
        [3] = "efficiency-module-3"
    },
    productivity = {
        [1] = "productivity-module",
        [2] = "productivity-module-2",
        [3] = "productivity-module-3"
    },
    quality = {
        [1] = "quality-module",
        [2] = "quality-module-2",
        [3] = "quality-module-3"
    }
}

local moduleReplaceableDeltaTypes = {
    speed = true,
    effectivity = true,
    productivity = true,
    pollution = true,
    quality = true,
    merged = false
}

local function copyPrerequisites(values)
    local result = {}

    if not values then
        return result
    end

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

local function getModuleDeltaPrerequisite(moduleType, tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and moduleSpaceAgeDeltaPrerequisites[moduleType] and moduleSpaceAgeDeltaPrerequisites[moduleType][tier] then
        return moduleSpaceAgeDeltaPrerequisites[moduleType][tier]
    end

    if moduleDeltaPrerequisites[moduleType] then
        return moduleDeltaPrerequisites[moduleType][tier]
    end

    return nil
end

local function getVanillaModuleIngredients(moduleType, tier)
    local recipeMap = vanillaModuleRecipeNames[moduleType]
    if not recipeMap then
        return nil
    end

    local recipeName = recipeMap[tier]
    local recipe = recipeName and data.raw.recipe[recipeName]
    if not recipe then
        return nil
    end

    if recipe.ingredients then
        return table.deepcopy(recipe.ingredients)
    end

    local normalRecipe = rawget(recipe, "normal")
    if normalRecipe and normalRecipe.ingredients then
        return table.deepcopy(normalRecipe.ingredients)
    end

    return nil
end

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-- Each tier defines: order, vanilla flag, time craft
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", isVanilla = true,  timeCraft = 5 },
    [2]  = { order = "b", isVanilla = true,  timeCraft = 10 },
    [3]  = { order = "c", isVanilla = true,  timeCraft = 15 },
    [4]  = { order = "d", isVanilla = false, timeCraft = 20 },
    [5]  = { order = "e", isVanilla = false, timeCraft = 25 },
    [6]  = { order = "f", isVanilla = false, timeCraft = 30 },
    [7]  = { order = "g", isVanilla = false, timeCraft = 35 },
    [8]  = { order = "h", isVanilla = false, timeCraft = 40 },
    [9]  = { order = "i", isVanilla = false, timeCraft = 45 },
    [10] = { order = "j", isVanilla = false, timeCraft = 50 }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [1] = {
        count = baseTechCount * 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        prerequisites = {
            pollution = { "modules" },
            merged = { "speed-module", "efficiency-module", "productivity-module", "5d-pollution-module-1" }
        }
    },
    [2] = {
        count = baseTechCount * 1.5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = {
            pollution = { "5d-pollution-module-1" },
            merged = { "5d-merged-module-1", "speed-module-2", "efficiency-module-2", "productivity-module-2", "5d-pollution-module-2" }
        }
    },
    [3] = {
        count = baseTechCount * 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            pollution = { "5d-pollution-module-2" },
            merged = { "5d-merged-module-2", "speed-module-3", "efficiency-module-3", "productivity-module-3", "5d-pollution-module-3" }
        }
    },
    [4] = {
        count = baseTechCount * 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            speed = { "speed-module-3" },
            effectivity = { "efficiency-module-3" },
            productivity = { "productivity-module-3" },
            pollution = { "5d-pollution-module-3" },
            quality = { "quality-module-3" },
            merged = { "5d-merged-module-3", "speed-module-4", "efficiency-module-4", "productivity-module-4", "5d-pollution-module-4" }
        }
    },
    [5] = {
        count = baseTechCount * 12,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = {
            speed = { "speed-module-4" },
            effectivity = { "efficiency-module-4" },
            productivity = { "productivity-module-4" },
            pollution = { "5d-pollution-module-4" },
            quality = { "quality-module-4" },
            merged = { "5d-merged-module-4", "speed-module-5", "efficiency-module-5", "productivity-module-5", "5d-pollution-module-5" }
        }
    },
    [6] = {
        count = baseTechCount * 15,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = {
            speed = { "speed-module-5" },
            effectivity = { "efficiency-module-5" },
            productivity = { "productivity-module-5" },
            pollution = { "5d-pollution-module-5" },
            quality = { "quality-module-5" },
            merged = { "5d-merged-module-5", "speed-module-6", "efficiency-module-6", "productivity-module-6", "5d-pollution-module-6" }
        }
    },
    [7] = {
        count = baseTechCount * 18,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = {
            speed = { "speed-module-6" },
            effectivity = { "efficiency-module-6" },
            productivity = { "productivity-module-6" },
            pollution = { "5d-pollution-module-6" },
            quality = { "quality-module-6" },
            merged = { "5d-merged-module-6", "speed-module-7", "efficiency-module-7", "productivity-module-7", "5d-pollution-module-7" }
        }
    },
    [8] = {
        count = baseTechCount * 21,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = {
            speed = { "speed-module-7" },
            effectivity = { "efficiency-module-7" },
            productivity = { "productivity-module-7" },
            pollution = { "5d-pollution-module-7" },
            quality = { "quality-module-7" },
            merged = { "5d-merged-module-7", "speed-module-8", "efficiency-module-8", "productivity-module-8", "5d-pollution-module-8" }
        }
    },
    [9] = {
        count = baseTechCount * 24,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = {
            speed = { "speed-module-8" },
            effectivity = { "efficiency-module-8" },
            productivity = { "productivity-module-8" },
            pollution = { "5d-pollution-module-8" },
            quality = { "quality-module-8" },
            merged = { "5d-merged-module-8", "speed-module-9", "efficiency-module-9", "productivity-module-9", "5d-pollution-module-9" }
        }
    },
    [10] = {
        count = baseTechCount * 27,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = {
            speed = { "speed-module-9" },
            effectivity = { "efficiency-module-9" },
            productivity = { "productivity-module-9" },
            pollution = { "5d-pollution-module-9" },
            quality = { "quality-module-9" },
            merged = { "5d-merged-module-9", "speed-module-10", "efficiency-module-10", "productivity-module-10", "5d-pollution-module-10" }
        }
    }
}

-------------------------------------------------------------------------------
-- HELPER FUNCTION: Build module ingredients
-------------------------------------------------------------------------------

local function buildModuleIngredients(tier)
    local ingredients = {
        speed = {},
        effectivity = {},
        productivity = {},
        pollution = {},
        quality = {},
        merged = {}
    }

    for _, moduleType in ipairs(moduleTypes) do
        local baseIngredients

        if moduleType == "quality" and not mods["quality"] then
            baseIngredients = {}
        elseif moduleType == "merged" then
            baseIngredients = RecipeTemplates.getMergedModuleIngredients(tier)
        elseif tier <= 3 and moduleType ~= "pollution" and moduleType ~= "merged" then
            baseIngredients = getVanillaModuleIngredients(moduleType, tier) or RecipeTemplates.getModuleIngredients(moduleType, tier)
        else
            baseIngredients = RecipeTemplates.getModuleIngredients(moduleType, tier)
        end

        ingredients[moduleType] = CostCalculator.processIngredients(baseIngredients, tier, {
            skipTierScaling = true,
            spaceAgeMaterialOverrides = moduleSpaceAgeMaterials[moduleType],
            replaceSpaceAgeDelta = moduleReplaceableDeltaTypes[moduleType] or false
        })
    end
    
    return ingredients
end

local function buildPacksByType(basePacks, tier)
    local packsByType = {}

    for _, moduleType in ipairs(moduleTypes) do
        packsByType[moduleType] = CostCalculator.getTechPacks(basePacks, tier, {
            spaceAgePackOverrides = moduleSpaceAgeSciencePacks[moduleType],
            forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
        })
    end

    return packsByType
end

local function buildRecipeCategories(tier)
    local categories = {}

    for _, moduleType in ipairs(moduleTypes) do
        categories[moduleType] = CostCalculator.getSpaceAgeRecipeCategory(tier, moduleSpaceAgeMaterials[moduleType])
    end

    return categories
end

local function buildTechCountsByType(tier)
    local counts = {}

    for _, moduleType in ipairs(moduleTypes) do
        if moduleType == "merged" then
            counts[moduleType] = CostCalculator.scaleAbsoluteTechCount(mergedModuleTechCounts[tier])
        else
            counts[moduleType] = CostCalculator.scaleAbsoluteTechCount(defaultModuleTechCounts[tier])
        end
    end

    return counts
end

local function buildPrerequisitesByType(prerequisitesByType, tier)
    local result = {}

    for _, moduleType in ipairs(moduleTypes) do
        result[moduleType] = copyPrerequisites(prerequisitesByType[moduleType])
        addPrerequisiteIfMissing(result[moduleType], getModuleDeltaPrerequisite(moduleType, tier))
    end

    return result
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    local tc = techConfig[tier]
    
    -- Build ingredients
    local ingredients = buildModuleIngredients(tier)
    
    -- Build effects based on tier
    local effects = {
        speed = {
            speed = moduleEffectCurves.speed.speed[tier],
            consumption = moduleEffectCurves.speed.consumption[tier]
        },
        effectivity = {
            consumption = moduleEffectCurves.effectivity.consumption[tier]
        },
        productivity = {
            productivity = moduleEffectCurves.productivity.productivity[tier],
            consumption = moduleEffectCurves.productivity.consumption[tier],
            pollution = moduleEffectCurves.productivity.pollution[tier],
            speed = moduleEffectCurves.productivity.speed[tier]
        },
        pollution = {
            pollution = moduleEffectCurves.pollution.pollution[tier]
        },
        quality = {
            quality = moduleEffectCurves.quality.quality[tier]
        }
    }
    
    -- Build tech configuration
    local tech = {
        number = tier,
        count = CostCalculator.scaleAbsoluteTechCount(defaultModuleTechCounts[tier]),
        countsByType = buildTechCountsByType(tier),
        packs = CostCalculator.getTechPacks(tc.basePacks, tier, { skipSpaceAgePacks = true }),
        packsByType = buildPacksByType(tc.basePacks, tier),
        prerequisites = buildPrerequisitesByType(tc.prerequisites, tier)
    }
    
    -- Generate the modules
    genModules {
        number = tierNum,
        order = config.order,
        effects = effects,
        tier = tier,
        timeCraft = config.timeCraft,
        new = not config.isVanilla,
        ingredients = ingredients,
        recipeCategories = buildRecipeCategories(tier),
        mergedEffectWeights = mergedEffectWeights,
        tech = tech
    }
end

