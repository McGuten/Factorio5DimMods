-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Energy)
-- Templates for power generation and distribution
-------------------------------------------------------------------------------

local Templates = {}

-- Accumulator templates
Templates.accumulator = {
    [1] = {
        { type = "item", name = "iron-plate", amount = 2 },
        { type = "item", name = "battery", amount = 5 }
    },
    [2] = {
        { type = "item", name = "accumulator", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-accumulator-02", amount = 1 },
        { type = "item", name = "battery", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-accumulator-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 7 }
    },
    [5] = {
        { type = "item", name = "5d-accumulator-04", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 4 }
    },
    [6] = {
        { type = "item", name = "5d-accumulator-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-accumulator-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 3 }
    },
    [8] = {
        { type = "item", name = "5d-accumulator-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-accumulator-08", amount = 1 },
        { type = "item", name = "efficiency-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-accumulator-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

-- Boiler templates
Templates.boiler = {
    [1] = {
        { type = "item", name = "stone-furnace", amount = 1 },
        { type = "item", name = "pipe", amount = 4 }
    },
    [2] = {
        { type = "item", name = "boiler", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 }
    },
    [3] = {
        { type = "item", name = "5d-boiler-02", amount = 1 },
        { type = "item", name = "pipe-to-ground", amount = 4 }
    },
    [4] = {
        { type = "item", name = "5d-boiler-03", amount = 1 },
        { type = "item", name = "engine-unit", amount = 8 }
    },
    [5] = {
        { type = "item", name = "5d-boiler-04", amount = 1 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-boiler-05", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-boiler-06", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 8 }
    },
    [8] = {
        { type = "item", name = "5d-boiler-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 8 }
    },
    [9] = {
        { type = "item", name = "5d-boiler-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-boiler-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

-- Steam Engine templates
Templates.steamEngine = {
    [1] = {
        { type = "item", name = "iron-gear-wheel", amount = 8 },
        { type = "item", name = "pipe", amount = 5 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [2] = {
        { type = "item", name = "steam-engine", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-steam-engine-02", amount = 1 },
        { type = "item", name = "pipe-to-ground", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-steam-engine-03", amount = 1 },
        { type = "item", name = "engine-unit", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-steam-engine-04", amount = 1 },
        { type = "item", name = "battery", amount = 12 }
    },
    [6] = {
        { type = "item", name = "5d-steam-engine-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-steam-engine-06", amount = 1 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-steam-engine-07", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 20 }
    },
    [9] = {
        { type = "item", name = "5d-steam-engine-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 8 }
    },
    [10] = {
        { type = "item", name = "5d-steam-engine-09", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    }
}

-- Solar Panel templates
Templates.solarPanel = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 15 },
        { type = "item", name = "copper-plate", amount = 5 }
    },
    [2] = {
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-solar-panel-02", amount = 1 },
        { type = "item", name = "battery", amount = 12 }
    },
    [4] = {
        { type = "item", name = "5d-solar-panel-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 15 }
    },
    [5] = {
        { type = "item", name = "5d-solar-panel-04", amount = 1 },
        { type = "item", name = "processing-unit", amount = 6 }
    },
    [6] = {
        { type = "item", name = "5d-solar-panel-05", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-solar-panel-06", amount = 1 },
        { type = "item", name = "speed-module", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-solar-panel-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-solar-panel-08", amount = 1 },
        { type = "item", name = "efficiency-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-solar-panel-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

-- Lamp templates
Templates.lamp = {
    [1] = {
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable", amount = 3 },
        { type = "item", name = "iron-plate", amount = 1 }
    },
    [2] = {
        { type = "item", name = "small-lamp", amount = 1 },
        { type = "item", name = "steel-plate", amount = 1 }
    },
    [3] = {
        { type = "item", name = "5d-lamp-02", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    [4] = {
        { type = "item", name = "5d-lamp-03", amount = 1 },
        { type = "item", name = "battery", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-lamp-04", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [6] = {
        { type = "item", name = "5d-lamp-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 1 }
    },
    [7] = {
        { type = "item", name = "5d-lamp-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-lamp-07", amount = 1 },
        { type = "item", name = "speed-module", amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-lamp-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-lamp-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 1 }
    }
}

-- Big Electric Pole templates
Templates.bigElectricPole = {
    [1] = {
        { type = "item", name = "iron-stick", amount = 8 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "copper-plate", amount = 5 }
    },
    [2] = {
        { type = "item", name = "big-electric-pole", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-big-electric-pole-02", amount = 1 },
        { type = "item", name = "concrete", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-big-electric-pole-03", amount = 1 },
        { type = "item", name = "battery", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-big-electric-pole-04", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-big-electric-pole-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-big-electric-pole-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-big-electric-pole-07", amount = 1 },
        { type = "item", name = "efficiency-module", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-big-electric-pole-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-big-electric-pole-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

-- Medium Electric Pole templates
Templates.mediumElectricPole = {
    [1] = {
        { type = "item", name = "iron-stick", amount = 4 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "copper-plate", amount = 2 }
    },
    [2] = {
        { type = "item", name = "medium-electric-pole", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-medium-electric-pole-02", amount = 1 },
        { type = "item", name = "concrete", amount = 4 }
    },
    [4] = {
        { type = "item", name = "5d-medium-electric-pole-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-medium-electric-pole-04", amount = 1 },
        { type = "item", name = "battery", amount = 4 }
    },
    [6] = {
        { type = "item", name = "5d-medium-electric-pole-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-medium-electric-pole-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-medium-electric-pole-07", amount = 1 },
        { type = "item", name = "speed-module", amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-medium-electric-pole-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-medium-electric-pole-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 1 }
    }
}

-- Substation templates
Templates.substation = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "copper-plate", amount = 5 }
    },
    [2] = {
        { type = "item", name = "substation", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-substation-02", amount = 1 },
        { type = "item", name = "battery", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-substation-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-substation-04", amount = 1 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-substation-05", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 3 }
    },
    [7] = {
        { type = "item", name = "5d-substation-06", amount = 1 },
        { type = "item", name = "speed-module", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-substation-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-substation-08", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-substation-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

return Templates
