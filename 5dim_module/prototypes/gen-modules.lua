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

local moduleTypes = { "speed", "effectivity", "productivity", "quality", "merged" }

local moduleEffectCurves = {
    speed = {
        speed = { 0.15, 0.30, 0.45, 0.60, 0.75, 0.90, 1.05, 1.20, 1.35, 1.50 },
        consumption = { 0.25, 0.50, 0.75, 1.00, 1.25, 1.50, 1.75, 2.00, 2.25, 2.50 }
    },
    effectivity = {
        consumption = { -0.15, -0.30, -0.45, -0.60, -0.75, -0.90, -1.05, -1.20, -1.35, -1.50 }
    },
    productivity = {
        productivity = { 0.02, 0.04, 0.06, 0.08, 0.10, 0.12, 0.14, 0.16, 0.18, 0.20 },
        consumption = { 0.18, 0.36, 0.54, 0.72, 0.90, 1.08, 1.26, 1.44, 1.62, 1.80 },
        pollution = { 0.02, 0.04, 0.06, 0.08, 0.10, 0.12, 0.14, 0.16, 0.18, 0.20 },
        speed = { -0.03, -0.06, -0.09, -0.12, -0.15, -0.18, -0.21, -0.24, -0.27, -0.30 }
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

local moduleSpaceAgeMaterials = {
    speed = {
        [6] = { name = "calcite", amount = 8 },
        [7] = { name = "tungsten-plate", amount = 6 },
        [8] = { name = "holmium-plate", amount = 8, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 4, category = "electromagnetics" },
        [10] = { name = "quantum-processor", amount = 4, category = "cryogenics" }
    },
    effectivity = {
        [6] = { name = "calcite", amount = 8 },
        [7] = { name = "tungsten-plate", amount = 6 },
        [8] = { name = "holmium-plate", amount = 8, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 4, category = "electromagnetics" },
        [10] = { name = "quantum-processor", amount = 4, category = "cryogenics" }
    },
    productivity = {
        [6] = { name = "calcite", amount = 8 },
        [7] = { name = "tungsten-plate", amount = 6 },
        [8] = { name = "holmium-plate", amount = 8, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 4, category = "electromagnetics" },
        [10] = { name = "quantum-processor", amount = 4, category = "cryogenics" }
    },
    quality = {
        [6] = { name = "calcite", amount = 8 },
        [7] = { name = "tungsten-plate", amount = 6 },
        [8] = { name = "holmium-plate", amount = 8, category = "electromagnetics" },
        [9] = { name = "supercapacitor", amount = 4, category = "electromagnetics" },
        [10] = { name = "quantum-processor", amount = 4, category = "cryogenics" }
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
        [4] = "battery",
        [5] = "low-density-structure",
        [6] = "electric-engine",
        [7] = "robotics",
        [8] = "rocket-fuel",
        [9] = "nuclear-power",
        [10] = "rocket-silo"
    },
    effectivity = {
        [4] = "battery",
        [5] = "low-density-structure",
        [6] = "electric-engine",
        [7] = "robotics",
        [8] = "rocket-fuel",
        [9] = "nuclear-power",
        [10] = "rocket-silo"
    },
    productivity = {
        [4] = "battery",
        [5] = "low-density-structure",
        [6] = "electric-engine",
        [7] = "robotics",
        [8] = "rocket-fuel",
        [9] = "nuclear-power",
        [10] = "rocket-silo"
    },
    quality = {
        [4] = "battery",
        [5] = "low-density-structure",
        [6] = "electric-engine",
        [7] = "robotics",
        [8] = "rocket-fuel",
        [9] = "nuclear-power",
        [10] = "rocket-silo"
    },
    merged = {
        [4] = "battery",
        [5] = "low-density-structure",
        [6] = "electric-engine",
        [7] = "robotics",
        [8] = "rocket-fuel",
        [9] = "nuclear-power",
        [10] = "rocket-silo"
    }
}

local moduleSpaceAgeDeltaPrerequisites = {
    speed = {
        [6] = "calcite-processing",
        [7] = "tungsten-steel",
        [8] = "holmium-processing",
        [9] = "electromagnetic-plant",
        [10] = "quantum-processor"
    },
    effectivity = {
        [6] = "calcite-processing",
        [7] = "tungsten-steel",
        [8] = "holmium-processing",
        [9] = "electromagnetic-plant",
        [10] = "quantum-processor"
    },
    productivity = {
        [6] = "calcite-processing",
        [7] = "tungsten-steel",
        [8] = "holmium-processing",
        [9] = "electromagnetic-plant",
        [10] = "quantum-processor"
    },
    quality = {
        [6] = "calcite-processing",
        [7] = "tungsten-steel",
        [8] = "holmium-processing",
        [9] = "electromagnetic-plant",
        [10] = "quantum-processor"
    }
}

local moduleReplaceableDeltaTypes = {
    speed = true,
    effectivity = true,
    productivity = true,
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
            merged = { "speed-module", "efficiency-module", "productivity-module" }
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
            merged = { "5d-merged-module-1", "speed-module-2", "efficiency-module-2", "productivity-module-2" }
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
            merged = { "5d-merged-module-2", "speed-module-3", "efficiency-module-3", "productivity-module-3" }
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
            quality = { "quality-module-3" },
            merged = { "5d-merged-module-3", "speed-module-4", "efficiency-module-4", "productivity-module-4" }
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
            quality = { "quality-module-4" },
            merged = { "5d-merged-module-4", "speed-module-5", "efficiency-module-5", "productivity-module-5" }
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
            quality = { "quality-module-5" },
            merged = { "5d-merged-module-5", "speed-module-6", "efficiency-module-6", "productivity-module-6" }
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
            quality = { "quality-module-6" },
            merged = { "5d-merged-module-6", "speed-module-7", "efficiency-module-7", "productivity-module-7" }
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
            quality = { "quality-module-7" },
            merged = { "5d-merged-module-7", "speed-module-8", "efficiency-module-8", "productivity-module-8" }
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
            quality = { "quality-module-8" },
            merged = { "5d-merged-module-8", "speed-module-9", "efficiency-module-9", "productivity-module-9" }
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
            quality = { "quality-module-9" },
            merged = { "5d-merged-module-9", "speed-module-10", "efficiency-module-10", "productivity-module-10" }
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
        quality = {},
        merged = {}
    }

    for _, moduleType in ipairs(moduleTypes) do
        local baseIngredients

        if moduleType == "quality" and not mods["quality"] then
            baseIngredients = {}
        elseif moduleType == "merged" then
            baseIngredients = RecipeTemplates.getMergedModuleIngredients(tier)
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
        tech = tech
    }
end

-------------------------------------------------------------------------------
-- STANDALONE POLLUTION MODULE
-------------------------------------------------------------------------------

local itemPollution = table.deepcopy(data.raw.module["speed-module"])
local recipePollution = table.deepcopy(data.raw.recipe["speed-module"])
local techPollution = table.deepcopy(data.raw.technology["speed-module"])

itemPollution.name = "5d-pollution-module"
itemPollution.icon = "__5dim_module__/graphics/icons/pollution-module/pollution-module-01.png"
itemPollution.subgroup = "pollution"
itemPollution.order = "a"
itemPollution.effect = {
    pollution = -0.08
}
itemPollution.tier = 1
itemPollution.localised_description = nil

recipePollution.name = itemPollution.name
recipePollution.icon = itemPollution.icon
recipePollution.icon_size = 64
recipePollution.enabled = false
recipePollution.ingredients = {
    { type = "item", name = "electronic-circuit", amount = 5 }
}
recipePollution.results = {
    { type = "item", name = itemPollution.name, amount = 1 }
}
recipePollution.energy_required = 5
recipePollution.category = nil

techPollution.name = "5d-pollution-module"
techPollution.icon = itemPollution.icon
techPollution.icon_size = 64
techPollution.icons = nil
techPollution.unit.count = 20
techPollution.unit.ingredients = {
    { "automation-science-pack", 1 }
}
techPollution.prerequisites = { "electronics" }
techPollution.effects = {
    {
        type = "unlock-recipe",
        recipe = itemPollution.name
    }
}

data:extend({ itemPollution, recipePollution, techPollution })

