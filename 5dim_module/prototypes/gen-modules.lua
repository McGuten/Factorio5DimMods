-------------------------------------------------------------------------------
-- 5Dim's Module - Module Generation
-- Uses the centralized cost system from 5dim_core
-------------------------------------------------------------------------------

require("__5dim_core__.lib.module.generation-module")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local baseTime = 5
local baseTechCount = 50

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
    local tierNum = string.format("%02d", tier)
    local baseIngredients = RecipeTemplates.moduleBase[tier]
    
    -- Build ingredients for each module type
    local ingredients = {
        speed = {},
        effectivity = {},
        productivity = {},
        pollution = {},
        quality = {},
        merged = RecipeTemplates.moduleMerged[tier]
    }
    
    -- Add previous tier module + base ingredients for each type
    local moduleTypes = { "speed", "effectivity", "productivity", "pollution", "quality" }
    for _, moduleType in ipairs(moduleTypes) do
        local prevModule = RecipeTemplates.modulePreviousTier[moduleType]
        if prevModule and prevModule[tier] then
            table.insert(ingredients[moduleType], { type = "item", name = prevModule[tier], amount = 3 })
        end
        for _, ing in ipairs(baseIngredients) do
            table.insert(ingredients[moduleType], { type = ing.type, name = ing.name, amount = ing.amount })
        end
    end
    
    return ingredients
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
    -- REBALANCED: Speed modules stronger (0.12 vs 0.08), productivity less punishing
    -- Quality improved (0.08 vs 0.05) to match vanilla better
    local effects = {
        speed = {
            speed = 0.12 * tier,          -- Increased from 0.08 (T3=36% vs vanilla 50%)
            consumption = 0.12 * tier     -- Reduced from 0.16 (better efficiency)
        },
        effectivity = {
            consumption = -0.16 * tier    -- Cap at tier 5 (-80%) in game mechanics
        },
        productivity = {
            productivity = 0.025 * tier,  -- Increased from 0.02 (T10=25% vs 20%)
            consumption = 0.25 * tier,    -- Reduced from 0.4 (T10=250% vs 400%)
            pollution = 0.03 * tier,      -- Reduced from 0.04 (T10=30% vs 40%)
            speed = -0.05 * tier          -- Reduced from -0.08 (T10=-50% vs -80%)
        },
        pollution = {
            pollution = -0.08 * tier
        },
        quality = {
            quality = 0.08 * tier         -- Increased from 0.05 (T3=24% vs vanilla 25%)
        }
    }
    
    -- Build tech configuration
    local tech = {
        number = tier,
        count = tc.count,
        packs = CostCalculator.getTechPacks(tc.basePacks, tier),
        prerequisites = tc.prerequisites
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
        tech = tech
    }
end

