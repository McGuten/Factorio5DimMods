-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Trains)
-- Templates for locomotives and wagons
-------------------------------------------------------------------------------

local Templates = {}

-- Locomotive templates
Templates.locomotive = {
    [1] = {
        { type = "item", name = "engine-unit", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "steel-plate", amount = 30 }
    },
    [2] = {
        { type = "item", name = "locomotive", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 }
    },
    [3] = {
        { type = "item", name = "5d-locomotive-02", amount = 1 },
        { type = "item", name = "engine-unit", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-locomotive-03", amount = 1 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-locomotive-04", amount = 1 },
        { type = "item", name = "battery", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-locomotive-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-locomotive-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 8 }
    },
    [8] = {
        { type = "item", name = "5d-locomotive-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 8 }
    },
    [9] = {
        { type = "item", name = "5d-locomotive-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 6 }
    },
    [10] = {
        { type = "item", name = "5d-locomotive-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 6 }
    }
}

-- Cargo Wagon templates
Templates.cargoWagon = {
    [1] = {
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "iron-plate", amount = 20 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [2] = {
        { type = "item", name = "cargo-wagon", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-cargo-wagon-02", amount = 1 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-cargo-wagon-03", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-cargo-wagon-04", amount = 1 },
        { type = "item", name = "battery", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-cargo-wagon-05", amount = 1 },
        { type = "item", name = "engine-unit", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-cargo-wagon-06", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 8 }
    },
    [8] = {
        { type = "item", name = "5d-cargo-wagon-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 6 }
    },
    [9] = {
        { type = "item", name = "5d-cargo-wagon-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-cargo-wagon-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 4 }
    }
}

-- Fluid Wagon templates
Templates.fluidWagon = {
    [1] = {
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "steel-plate", amount = 16 },
        { type = "item", name = "pipe", amount = 8 },
        { type = "item", name = "storage-tank", amount = 1 }
    },
    [2] = {
        { type = "item", name = "fluid-wagon", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-fluid-wagon-02", amount = 1 },
        { type = "item", name = "pipe-to-ground", amount = 6 }
    },
    [4] = {
        { type = "item", name = "5d-fluid-wagon-03", amount = 1 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-fluid-wagon-04", amount = 1 },
        { type = "item", name = "engine-unit", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-fluid-wagon-05", amount = 1 },
        { type = "fluid", name = "lubricant", amount = 80 }
    },
    [7] = {
        { type = "item", name = "5d-fluid-wagon-06", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 8 }
    },
    [8] = {
        { type = "item", name = "5d-fluid-wagon-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 6 }
    },
    [9] = {
        { type = "item", name = "5d-fluid-wagon-08", amount = 1 },
        { type = "item", name = "processing-unit", amount = 6 }
    },
    [10] = {
        { type = "item", name = "5d-fluid-wagon-09", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 4 }
    }
}

return Templates
