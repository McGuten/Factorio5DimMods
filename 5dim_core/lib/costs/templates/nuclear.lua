-------------------------------------------------------------------------------
-- 5DIM'S MOD - NUCLEAR TEMPLATES
-- Templates for nuclear entities: centrifuge, heat exchanger, heat pipe, 
-- nuclear reactor, steam turbine
-- Each template defines 10 tiers of ingredient progression
-------------------------------------------------------------------------------

local Templates = {}

local function boilerIngredientName(tier)
    if mods and mods["5dim_energy"] and tier >= 2 then
        return "5d-boiler-" .. string.format("%02d", tier)
    end

    return "pipe"
end

local function steamEngineIngredientName(tier)
    if mods and mods["5dim_energy"] and tier >= 2 then
        return "5d-steam-engine-" .. string.format("%02d", tier)
    end

    return "pipe"
end

-------------------------------------------------------------------------------
-- URANIUM PROCESSING TEMPLATES
-------------------------------------------------------------------------------

-- Centrifuge templates
Templates.centrifuge = {
    [1] = {
        { type = "item", name = "concrete", amount = 100 },
        { type = "item", name = "steel-plate", amount = 50 },
        { type = "item", name = "advanced-circuit", amount = 100 },
        { type = "item", name = "iron-gear-wheel", amount = 100 }
    },
    [2] = {
        { type = "item", name = "centrifuge", amount = 1 },
        { type = "item", name = "steel-plate", amount = 50 }
    },
    [3] = {
        { type = "item", name = "5d-centrifuge-02", amount = 1 },
        { type = "item", name = "concrete", amount = 100 }
    },
    [4] = {
        { type = "item", name = "5d-centrifuge-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 100 }
    },
    [5] = {
        { type = "item", name = "5d-centrifuge-04", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-centrifuge-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [7] = {
        { type = "item", name = "5d-centrifuge-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-centrifuge-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-centrifuge-08", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-centrifuge-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

-------------------------------------------------------------------------------
-- HEAT MANAGEMENT TEMPLATES
-------------------------------------------------------------------------------

-- Heat Exchanger templates
Templates.heatExchanger = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "copper-plate", amount = 100 },
        { type = "item", name = "pipe", amount = 10 }
    },
    [2] = {
        { type = "item", name = "heat-exchanger", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "pipe", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-heat-exchanger-02", amount = 1 },
        { type = "item", name = "pipe-to-ground", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-heat-exchanger-03", amount = 1 },
        { type = "item", name = "concrete", amount = 40 }
    },
    [5] = {
        { type = "item", name = "5d-heat-exchanger-04", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 40 }
    },
    [6] = {
        { type = "item", name = "5d-heat-exchanger-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-heat-exchanger-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-heat-exchanger-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-heat-exchanger-08", amount = 1 },
        { type = "item", name = "battery", amount = 12 }
    },
    [10] = {
        { type = "item", name = "5d-heat-exchanger-09", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    }
}

-- Heat Pipe templates
Templates.heatPipe = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "copper-plate", amount = 20 }
    },
    [2] = {
        { type = "item", name = "heat-pipe", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-heat-pipe-02", amount = 1 },
        { type = "item", name = "copper-plate", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-heat-pipe-03", amount = 1 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-heat-pipe-04", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-heat-pipe-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-heat-pipe-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-heat-pipe-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-heat-pipe-08", amount = 1 },
        { type = "item", name = "battery", amount = 6 }
    },
    [10] = {
        { type = "item", name = "5d-heat-pipe-09", amount = 1 },
        { type = "item", name = "speed-module", amount = 2 }
    }
}

-------------------------------------------------------------------------------
-- NUCLEAR REACTOR TEMPLATES
-------------------------------------------------------------------------------

-- Nuclear Reactor templates
Templates.nuclearReactor = {
    [1] = {
        { type = "item", name = "concrete", amount = 500 },
        { type = "item", name = "steel-plate", amount = 500 },
        { type = "item", name = "advanced-circuit", amount = 500 },
        { type = "item", name = "copper-plate", amount = 500 }
    },
    [2] = {
        { type = "item", name = "nuclear-reactor", amount = 1 },
        { type = "item", name = "concrete", amount = 400 }
    },
    [3] = {
        { type = "item", name = "5d-nuclear-reactor-02", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 400 }
    },
    [4] = {
        { type = "item", name = "5d-nuclear-reactor-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 400 }
    },
    [5] = {
        { type = "item", name = "5d-nuclear-reactor-04", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-nuclear-reactor-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 100 }
    },
    [7] = {
        { type = "item", name = "5d-nuclear-reactor-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [8] = {
        { type = "item", name = "5d-nuclear-reactor-07", amount = 1 },
        { type = "item", name = "battery", amount = 50 }
    },
    [9] = {
        { type = "item", name = "5d-nuclear-reactor-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-nuclear-reactor-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 5 }
    }
}

-------------------------------------------------------------------------------
-- STEAM TURBINE TEMPLATES
-------------------------------------------------------------------------------

-- Steam Turbine templates
Templates.steamTurbine = {
    [1] = {
        { type = "item", name = "iron-gear-wheel", amount = 50 },
        { type = "item", name = "copper-plate", amount = 50 },
        { type = "item", name = "pipe", amount = 20 }
    },
    [2] = {
        { type = "item", name = "steam-turbine", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 }
    },
    [3] = {
        { type = "item", name = "5d-steam-turbine-02", amount = 1 },
        { type = "item", name = "pipe-to-ground", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-steam-turbine-03", amount = 1 },
        { type = "item", name = "engine-unit", amount = 12 }
    },
    [5] = {
        { type = "item", name = "5d-steam-turbine-04", amount = 1 },
        { type = "item", name = "battery", amount = 12 }
    },
    [6] = {
        { type = "item", name = "5d-steam-turbine-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 12 }
    },
    [7] = {
        { type = "item", name = "5d-steam-turbine-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 12 }
    },
    [8] = {
        { type = "item", name = "5d-steam-turbine-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 6 }
    },
    [9] = {
        { type = "item", name = "5d-steam-turbine-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-steam-turbine-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

return Templates
