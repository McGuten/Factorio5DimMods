-------------------------------------------------------------------------------
-- 5DIM'S MOD - MODULE TEMPLATES
-- Templates for beacons and modules: speed, efficiency, productivity,
-- quality, and merged modules
-- Each template defines 10 tiers of ingredient progression
-------------------------------------------------------------------------------

local Templates = {}

-------------------------------------------------------------------------------
-- BEACON TEMPLATES
-------------------------------------------------------------------------------

-- Beacon templates
Templates.beacon = {
    [1] = {
        { type = "item", name = "electronic-circuit", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 20 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "copper-cable", amount = 10 }
    },
    [2] = {
        { type = "item", name = "beacon", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-beacon-02", amount = 1 },
        { type = "item", name = "battery", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-beacon-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-beacon-04", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 8 }
    },
    [6] = {
        { type = "item", name = "5d-beacon-05", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 3 }
    },
    [7] = {
        { type = "item", name = "5d-beacon-06", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 3 }
    },
    [8] = {
        { type = "item", name = "5d-beacon-07", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-beacon-08", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-beacon-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 10 }
    }
}

-------------------------------------------------------------------------------
-- MODULE TEMPLATES
-- Modules have multiple types: speed, efficiency, productivity, quality, merged
-------------------------------------------------------------------------------

-- Base module ingredients (same for all standard module types at tier 1)
Templates.moduleBase = {
    [1] = {
        { type = "item", name = "electronic-circuit", amount = 8 },
        { type = "item", name = "advanced-circuit", amount = 4 }
    }
}

-- Previous tier module names for each module type
Templates.modulePreviousTier = {
    speed = {
        [1] = nil,
        [2] = "speed-module",
        [3] = "speed-module-2",
        [4] = "speed-module-3",
        [5] = "5d-speed-module-04",
        [6] = "5d-speed-module-05",
        [7] = "5d-speed-module-06",
        [8] = "5d-speed-module-07",
        [9] = "5d-speed-module-08",
        [10] = "5d-speed-module-09"
    },
    effectivity = {
        [1] = nil,
        [2] = "efficiency-module",
        [3] = "efficiency-module-2",
        [4] = "efficiency-module-3",
        [5] = "5d-efficiency-module-04",
        [6] = "5d-efficiency-module-05",
        [7] = "5d-efficiency-module-06",
        [8] = "5d-efficiency-module-07",
        [9] = "5d-efficiency-module-08",
        [10] = "5d-efficiency-module-09"
    },
    productivity = {
        [1] = nil,
        [2] = "productivity-module",
        [3] = "productivity-module-2",
        [4] = "productivity-module-3",
        [5] = "5d-productivity-module-04",
        [6] = "5d-productivity-module-05",
        [7] = "5d-productivity-module-06",
        [8] = "5d-productivity-module-07",
        [9] = "5d-productivity-module-08",
        [10] = "5d-productivity-module-09"
    },
    quality = {
        [1] = nil,
        [2] = "quality-module",
        [3] = "quality-module-2",
        [4] = "quality-module-3",
        [5] = "5d-quality-module-04",
        [6] = "5d-quality-module-05",
        [7] = "5d-quality-module-06",
        [8] = "5d-quality-module-07",
        [9] = "5d-quality-module-08",
        [10] = "5d-quality-module-09"
    },
    merged = {
        [1] = nil,
        [2] = "5d-merged-module-01",
        [3] = "5d-merged-module-02",
        [4] = "5d-merged-module-03",
        [5] = "5d-merged-module-04",
        [6] = "5d-merged-module-05",
        [7] = "5d-merged-module-06",
        [8] = "5d-merged-module-07",
        [9] = "5d-merged-module-08",
        [10] = "5d-merged-module-09"
    }
}

Templates.modulePreviousTierAmount = {
    merged = 2
}

local standardModuleVisibleDeltas = {
    [2] = {
        { type = "item", name = "advanced-circuit", amount = 4 }
    },
    [3] = {
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [4] = {
        { type = "item", name = "battery", amount = 6 }
    },
    [5] = {
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [6] = {
        { type = "item", name = "electric-engine-unit", amount = 4 }
    },
    [7] = {
        { type = "item", name = "flying-robot-frame", amount = 2 }
    },
    [8] = {
        { type = "item", name = "rocket-fuel", amount = 4 }
    },
    [9] = {
        { type = "item", name = "nuclear-fuel", amount = 2 }
    },
    [10] = {
        { type = "item", name = "satellite", amount = 1 }
    }
}

Templates.moduleVisibleDeltas = {
    speed = standardModuleVisibleDeltas,
    effectivity = standardModuleVisibleDeltas,
    productivity = standardModuleVisibleDeltas,
    quality = standardModuleVisibleDeltas
}

-- Merged module ingredients (combines the 3 standard module families).
-- Each tier already consumes one of each standard module of that tier plus 2 of
-- the previous merged module, so it is the most expensive module by construction.
-- On top of that a fixed premium delta per band is added so the merged module
-- always reads as a clear premium over crafting the trio separately, even without
-- Space Age. Only base-game items are used here so the template loads in both SA
-- and non-SA; in SA the generator still adds the global planetary material on top.
local mergedPremiumDelta = {
    [1]  = { type = "item", name = "advanced-circuit", amount = 4 },
    [2]  = { type = "item", name = "advanced-circuit", amount = 4 },
    [3]  = { type = "item", name = "advanced-circuit", amount = 4 },
    [4]  = { type = "item", name = "processing-unit", amount = 4 },
    [5]  = { type = "item", name = "processing-unit", amount = 4 },
    [6]  = { type = "item", name = "low-density-structure", amount = 4 },
    [7]  = { type = "item", name = "low-density-structure", amount = 4 },
    [8]  = { type = "item", name = "rocket-fuel", amount = 4 },
    [9]  = { type = "item", name = "nuclear-fuel", amount = 2 },
    -- satellite is removed by Space Age, so it cannot be used here (this template
    -- loads in both SA and non-SA). nuclear-fuel exists in both and escalates T9.
    [10] = { type = "item", name = "nuclear-fuel", amount = 4 }
}

Templates.moduleMerged = {
    [1] = {
        { type = "item", name = "speed-module", amount = 1 },
        { type = "item", name = "efficiency-module", amount = 1 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    [2] = {
        { type = "item", name = "5d-merged-module-01", amount = 2 },
        { type = "item", name = "speed-module-2", amount = 1 },
        { type = "item", name = "efficiency-module-2", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 1 }
    },
    [3] = {
        { type = "item", name = "5d-merged-module-02", amount = 2 },
        { type = "item", name = "speed-module-3", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 1 }
    },
    [4] = {
        { type = "item", name = "5d-merged-module-03", amount = 2 },
        { type = "item", name = "5d-speed-module-04", amount = 1 },
        { type = "item", name = "5d-efficiency-module-04", amount = 1 },
        { type = "item", name = "5d-productivity-module-04", amount = 1 }
    },
    [5] = {
        { type = "item", name = "5d-merged-module-04", amount = 2 },
        { type = "item", name = "5d-speed-module-05", amount = 1 },
        { type = "item", name = "5d-efficiency-module-05", amount = 1 },
        { type = "item", name = "5d-productivity-module-05", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-merged-module-05", amount = 2 },
        { type = "item", name = "5d-speed-module-06", amount = 1 },
        { type = "item", name = "5d-efficiency-module-06", amount = 1 },
        { type = "item", name = "5d-productivity-module-06", amount = 1 }
    },
    [7] = {
        { type = "item", name = "5d-merged-module-06", amount = 2 },
        { type = "item", name = "5d-speed-module-07", amount = 1 },
        { type = "item", name = "5d-efficiency-module-07", amount = 1 },
        { type = "item", name = "5d-productivity-module-07", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-merged-module-07", amount = 2 },
        { type = "item", name = "5d-speed-module-08", amount = 1 },
        { type = "item", name = "5d-efficiency-module-08", amount = 1 },
        { type = "item", name = "5d-productivity-module-08", amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-merged-module-08", amount = 2 },
        { type = "item", name = "5d-speed-module-09", amount = 1 },
        { type = "item", name = "5d-efficiency-module-09", amount = 1 },
        { type = "item", name = "5d-productivity-module-09", amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-merged-module-09", amount = 2 },
        { type = "item", name = "5d-speed-module-10", amount = 1 },
        { type = "item", name = "5d-efficiency-module-10", amount = 1 },
        { type = "item", name = "5d-productivity-module-10", amount = 1 }
    }
}

-- Append the premium delta to every merged tier.
for tier, ingredients in pairs(Templates.moduleMerged) do
    local premium = mergedPremiumDelta[tier]
    if premium then
        table.insert(ingredients, { type = premium.type, name = premium.name, amount = premium.amount })
    end
end

-------------------------------------------------------------------------------
-- HELPER FUNCTIONS
-------------------------------------------------------------------------------

-- Helper function to get module ingredients for a specific type and tier
function Templates.getModuleIngredients(moduleType, tier)
    local ingredients = {}
    
    -- Add previous tier module if exists
    local prevModule = Templates.modulePreviousTier[moduleType]
    if prevModule and prevModule[tier] then
        table.insert(ingredients, {
            type = "item",
            name = prevModule[tier],
            amount = Templates.modulePreviousTierAmount[moduleType] or 4
        })
    end

    local deltas = Templates.moduleVisibleDeltas[moduleType]
    if deltas and deltas[tier] then
        for _, ing in ipairs(deltas[tier]) do
            table.insert(ingredients, {
                type = ing.type,
                name = ing.name,
                amount = ing.amount
            })
        end

        return ingredients
    end
    
    -- Add base ingredients
    for _, ing in ipairs(Templates.moduleBase[tier] or {}) do
        table.insert(ingredients, {
            type = ing.type,
            name = ing.name,
            amount = ing.amount
        })
    end
    
    return ingredients
end

function Templates.getMergedModuleIngredients(tier)
    local ingredients = {}

    for _, ing in ipairs(Templates.moduleMerged[tier] or {}) do
        table.insert(ingredients, {
            type = ing.type,
            name = ing.name,
            amount = ing.amount
        })
    end

    return ingredients
end

return Templates
