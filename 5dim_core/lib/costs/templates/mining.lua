-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Mining)
-- Templates for mining-related entities
-------------------------------------------------------------------------------

local Templates = {}

-- Mining Drill templates
Templates.miningDrill = {
    [1] = {
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [2] = {
        { type = "item", name = "electric-mining-drill", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-electric-mining-drill-02", amount = 1 },
        { type = "item", name = "concrete", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-electric-mining-drill-03", amount = 1 },
        { type = "item", name = "engine-unit", amount = 6 }
    },
    [5] = {
        { type = "item", name = "5d-electric-mining-drill-04", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 4 }
    },
    [6] = {
        { type = "item", name = "5d-electric-mining-drill-05", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 6 }
    },
    [7] = {
        { type = "item", name = "5d-electric-mining-drill-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-electric-mining-drill-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-electric-mining-drill-08", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-electric-mining-drill-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

-- Offshore Pump templates
Templates.offshorePump = {
    [1] = {
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "iron-gear-wheel", amount = 1 },
        { type = "item", name = "pipe", amount = 1 }
    },
    [2] = {
        { type = "item", name = "offshore-pump", amount = 1 },
        { type = "item", name = "pipe-to-ground", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-offshore-pump-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 }
    },
    [4] = {
        { type = "item", name = "5d-offshore-pump-03", amount = 1 },
        { type = "item", name = "engine-unit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-offshore-pump-04", amount = 1 },
        { type = "item", name = "battery", amount = 4 }
    },
    [6] = {
        { type = "item", name = "5d-offshore-pump-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-offshore-pump-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [8] = {
        { type = "item", name = "5d-offshore-pump-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 3 }
    },
    [9] = {
        { type = "item", name = "5d-offshore-pump-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-offshore-pump-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

-- Pumpjack templates
Templates.pumpjack = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe", amount = 10 }
    },
    [2] = {
        { type = "item", name = "pumpjack", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 }
    },
    [3] = {
        { type = "item", name = "5d-pumpjack-02", amount = 1 },
        { type = "item", name = "pipe-to-ground", amount = 4 }
    },
    [4] = {
        { type = "item", name = "5d-pumpjack-03", amount = 1 },
        { type = "item", name = "engine-unit", amount = 6 }
    },
    [5] = {
        { type = "item", name = "5d-pumpjack-04", amount = 1 },
        { type = "fluid", name = "lubricant", amount = 80 }
    },
    [6] = {
        { type = "item", name = "5d-pumpjack-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 6 }
    },
    [7] = {
        { type = "item", name = "5d-pumpjack-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-pumpjack-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-pumpjack-08", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-pumpjack-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    }
}

-- Water Pumpjack templates (land-based water extraction)
Templates.waterPumpjack = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe", amount = 10 }
    },
    [2] = {
        { type = "item", name = "5d-water-pumpjack-01", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 }
    },
    [3] = {
        { type = "item", name = "5d-water-pumpjack-02", amount = 1 },
        { type = "item", name = "pipe-to-ground", amount = 4 }
    },
    [4] = {
        { type = "item", name = "5d-water-pumpjack-03", amount = 1 },
        { type = "item", name = "engine-unit", amount = 6 }
    },
    [5] = {
        { type = "item", name = "5d-water-pumpjack-04", amount = 1 },
        { type = "item", name = "battery", amount = 6 }
    },
    [6] = {
        { type = "item", name = "5d-water-pumpjack-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 6 }
    },
    [7] = {
        { type = "item", name = "5d-water-pumpjack-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-water-pumpjack-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-water-pumpjack-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-water-pumpjack-09", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 2 }
    }
}

return Templates
