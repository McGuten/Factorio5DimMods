-------------------------------------------------------------------------------
-- 5DIM'S MOD - MODULE TEMPLATES
-- Templates for beacons and modules: speed, efficiency, productivity, 
-- pollution, quality, and merged modules
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
-- Modules have multiple types: speed, efficiency, productivity, pollution, quality, merged
-------------------------------------------------------------------------------

-- Base module ingredients (same for all module types at tier 1)
Templates.moduleBase = {
    [1] = {
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "electronic-circuit", amount = 3 }
    },
    [2] = {
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "electronic-circuit", amount = 4 }
    },
    [3] = {
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 }
    },
    [4] = {
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [5] = {
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [6] = {
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [7] = {
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [8] = {
        { type = "item", name = "low-density-structure", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [9] = {
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [10] = {
        { type = "item", name = "low-density-structure", amount = 6 },
        { type = "item", name = "advanced-circuit", amount = 6 },
        { type = "item", name = "processing-unit", amount = 6 }
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
    pollution = {
        [1] = nil,
        [2] = "5d-pollution-module-01",
        [3] = "5d-pollution-module-02",
        [4] = "5d-pollution-module-03",
        [5] = "5d-pollution-module-04",
        [6] = "5d-pollution-module-05",
        [7] = "5d-pollution-module-06",
        [8] = "5d-pollution-module-07",
        [9] = "5d-pollution-module-08",
        [10] = "5d-pollution-module-09"
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
    merged = 1
}

Templates.moduleVisibleDeltas = {
    speed = {
        [4] = {
            { type = "item", name = "processing-unit", amount = 3 }
        },
        [5] = {
            { type = "item", name = "battery", amount = 4 }
        },
        [6] = {
            { type = "item", name = "low-density-structure", amount = 5 }
        },
        [7] = {
            { type = "item", name = "speed-module-3", amount = 1 }
        },
        [8] = {
            { type = "item", name = "5d-speed-module-04", amount = 1 }
        },
        [9] = {
            { type = "item", name = "5d-speed-module-05", amount = 1 }
        },
        [10] = {
            { type = "item", name = "5d-speed-module-06", amount = 1 }
        }
    },
    effectivity = {
        [4] = {
            { type = "item", name = "processing-unit", amount = 3 }
        },
        [5] = {
            { type = "item", name = "battery", amount = 4 }
        },
        [6] = {
            { type = "item", name = "low-density-structure", amount = 5 }
        },
        [7] = {
            { type = "item", name = "efficiency-module-3", amount = 1 }
        },
        [8] = {
            { type = "item", name = "5d-efficiency-module-04", amount = 1 }
        },
        [9] = {
            { type = "item", name = "5d-efficiency-module-05", amount = 1 }
        },
        [10] = {
            { type = "item", name = "5d-efficiency-module-06", amount = 1 }
        }
    },
    productivity = {
        [4] = {
            { type = "item", name = "processing-unit", amount = 3 }
        },
        [5] = {
            { type = "item", name = "battery", amount = 4 }
        },
        [6] = {
            { type = "item", name = "low-density-structure", amount = 5 }
        },
        [7] = {
            { type = "item", name = "productivity-module-3", amount = 1 }
        },
        [8] = {
            { type = "item", name = "5d-productivity-module-04", amount = 1 }
        },
        [9] = {
            { type = "item", name = "5d-productivity-module-05", amount = 1 }
        },
        [10] = {
            { type = "item", name = "5d-productivity-module-06", amount = 1 }
        }
    },
    pollution = {
        [1] = {
            { type = "item", name = "electronic-circuit", amount = 3 }
        },
        [2] = {
            { type = "item", name = "advanced-circuit", amount = 4 }
        },
        [3] = {
            { type = "item", name = "battery", amount = 5 }
        },
        [4] = {
            { type = "item", name = "processing-unit", amount = 3 }
        },
        [5] = {
            { type = "item", name = "low-density-structure", amount = 4 }
        },
        [6] = {
            { type = "item", name = "efficiency-module-2", amount = 1 }
        },
        [7] = {
            { type = "item", name = "efficiency-module-3", amount = 1 }
        },
        [8] = {
            { type = "item", name = "5d-pollution-module-04", amount = 1 }
        },
        [9] = {
            { type = "item", name = "5d-pollution-module-05", amount = 1 }
        },
        [10] = {
            { type = "item", name = "5d-pollution-module-06", amount = 1 }
        }
    },
    quality = {
        [4] = {
            { type = "item", name = "processing-unit", amount = 3 }
        },
        [5] = {
            { type = "item", name = "battery", amount = 4 }
        },
        [6] = {
            { type = "item", name = "low-density-structure", amount = 5 }
        },
        [7] = {
            { type = "item", name = "quality-module-3", amount = 1 }
        },
        [8] = {
            { type = "item", name = "5d-quality-module-04", amount = 1 }
        },
        [9] = {
            { type = "item", name = "5d-quality-module-05", amount = 1 }
        },
        [10] = {
            { type = "item", name = "5d-quality-module-06", amount = 1 }
        }
    },
    merged = {
        [1] = {
            { type = "item", name = "advanced-circuit", amount = 3 }
        },
        [2] = {
            { type = "item", name = "processing-unit", amount = 3 }
        },
        [3] = {
            { type = "item", name = "battery", amount = 4 }
        },
        [4] = {
            { type = "item", name = "low-density-structure", amount = 4 }
        },
        [5] = {
            { type = "item", name = "speed-module-3", amount = 1 }
        },
        [6] = {
            { type = "item", name = "efficiency-module-3", amount = 1 }
        },
        [7] = {
            { type = "item", name = "productivity-module-3", amount = 1 }
        },
        [8] = {
            { type = "item", name = "5d-merged-module-07", amount = 1 }
        },
        [9] = {
            { type = "item", name = "5d-merged-module-08", amount = 1 }
        },
        [10] = {
            { type = "item", name = "5d-merged-module-09", amount = 1 }
        }
    }
}

-- Merged module ingredients (combines 4 module types)
Templates.moduleMerged = {
    [1] = {
        { type = "item", name = "speed-module", amount = 2 },
        { type = "item", name = "efficiency-module", amount = 2 },
        { type = "item", name = "productivity-module", amount = 2 },
        { type = "item", name = "5d-pollution-module-01", amount = 2 }
    },
    [2] = {
        { type = "item", name = "speed-module-2", amount = 2 },
        { type = "item", name = "efficiency-module-2", amount = 2 },
        { type = "item", name = "productivity-module-2", amount = 2 },
        { type = "item", name = "5d-pollution-module-02", amount = 2 }
    },
    [3] = {
        { type = "item", name = "speed-module-3", amount = 2 },
        { type = "item", name = "efficiency-module-3", amount = 2 },
        { type = "item", name = "productivity-module-3", amount = 2 },
        { type = "item", name = "5d-pollution-module-03", amount = 2 }
    },
    [4] = {
        { type = "item", name = "5d-speed-module-04", amount = 2 },
        { type = "item", name = "5d-efficiency-module-04", amount = 2 },
        { type = "item", name = "5d-productivity-module-04", amount = 2 },
        { type = "item", name = "5d-pollution-module-04", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-speed-module-05", amount = 2 },
        { type = "item", name = "5d-efficiency-module-05", amount = 2 },
        { type = "item", name = "5d-productivity-module-05", amount = 2 },
        { type = "item", name = "5d-pollution-module-05", amount = 2 }
    },
    [6] = {
        { type = "item", name = "5d-speed-module-06", amount = 3 },
        { type = "item", name = "5d-efficiency-module-06", amount = 3 },
        { type = "item", name = "5d-productivity-module-06", amount = 3 },
        { type = "item", name = "5d-pollution-module-06", amount = 3 }
    },
    [7] = {
        { type = "item", name = "5d-speed-module-07", amount = 3 },
        { type = "item", name = "5d-efficiency-module-07", amount = 3 },
        { type = "item", name = "5d-productivity-module-07", amount = 3 },
        { type = "item", name = "5d-pollution-module-07", amount = 3 }
    },
    [8] = {
        { type = "item", name = "5d-speed-module-08", amount = 3 },
        { type = "item", name = "5d-efficiency-module-08", amount = 3 },
        { type = "item", name = "5d-productivity-module-08", amount = 3 },
        { type = "item", name = "5d-pollution-module-08", amount = 3 }
    },
    [9] = {
        { type = "item", name = "5d-speed-module-09", amount = 3 },
        { type = "item", name = "5d-efficiency-module-09", amount = 3 },
        { type = "item", name = "5d-productivity-module-09", amount = 3 },
        { type = "item", name = "5d-pollution-module-09", amount = 3 }
    },
    [10] = {
        { type = "item", name = "5d-speed-module-10", amount = 3 },
        { type = "item", name = "5d-efficiency-module-10", amount = 3 },
        { type = "item", name = "5d-productivity-module-10", amount = 3 },
        { type = "item", name = "5d-pollution-module-10", amount = 3 }
    }
}

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
            amount = Templates.modulePreviousTierAmount[moduleType] or 3
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
    for _, ing in ipairs(Templates.moduleBase[tier]) do
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
