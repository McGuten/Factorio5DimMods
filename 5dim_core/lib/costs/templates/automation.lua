-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Automation)
-- Templates for assembling machines, chemical plants, labs, oil refineries
-------------------------------------------------------------------------------

local Templates = {}

-- Assembling Machine templates
Templates.assemblingMachine = {
    [1] = {
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "iron-plate", amount = 9 }
    },
    [2] = {
        { type = "item", name = "assembling-machine-1", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "steel-plate", amount = 2 }
    },
    [3] = {
        { type = "item", name = "assembling-machine-2", amount = 1 },
        { type = "item", name = "speed-module", amount = 4 },
        { type = "item", name = "steel-plate", amount = 2 }
    },
    [4] = {
        { type = "item", name = "assembling-machine-3", amount = 1 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-assembling-machine-04", amount = 1 },
        { type = "item", name = "battery", amount = 12 }
    },
    [6] = {
        { type = "item", name = "5d-assembling-machine-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 12 }
    },
    [7] = {
        { type = "item", name = "5d-assembling-machine-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 12 }
    },
    [8] = {
        { type = "item", name = "5d-assembling-machine-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 16 }
    },
    [9] = {
        { type = "item", name = "5d-assembling-machine-08", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 6 }
    },
    [10] = {
        { type = "item", name = "5d-assembling-machine-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 8 }
    }
}

-- Chemical Plant templates
Templates.chemicalPlant = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe", amount = 5 }
    },
    [2] = {
        { type = "item", name = "chemical-plant", amount = 1 },
        { type = "item", name = "sulfur", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-chemical-plant-02", amount = 1 },
        { type = "item", name = "plastic-bar", amount = 30 }
    },
    [4] = {
        { type = "item", name = "5d-chemical-plant-03", amount = 1 },
        { type = "fluid", name = "sulfuric-acid", amount = 120 }
    },
    [5] = {
        { type = "item", name = "5d-chemical-plant-04", amount = 1 },
        { type = "fluid", name = "lubricant", amount = 180 }
    },
    [6] = {
        { type = "item", name = "5d-chemical-plant-05", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 24 }
    },
    [7] = {
        { type = "item", name = "5d-chemical-plant-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 12 }
    },
    [8] = {
        { type = "item", name = "5d-chemical-plant-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 12 }
    },
    [9] = {
        { type = "item", name = "5d-chemical-plant-08", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-chemical-plant-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 6 }
    }
}

-- Lab templates
Templates.lab = {
    [1] = {
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "transport-belt", amount = 4 }
    },
    [2] = {
        { type = "item", name = "lab", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 }
    },
    [3] = {
        { type = "item", name = "5d-lab-02", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 12 }
    },
    [4] = {
        { type = "item", name = "5d-lab-03", amount = 1 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-lab-04", amount = 1 },
        { type = "item", name = "battery", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-lab-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 12 }
    },
    [7] = {
        { type = "item", name = "5d-lab-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-lab-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 6 }
    },
    [9] = {
        { type = "item", name = "5d-lab-08", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 6 }
    },
    [10] = {
        { type = "item", name = "5d-lab-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 8 }
    }
}

-- Oil Refinery templates
Templates.oilRefinery = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 15 },
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "stone-brick", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "pipe", amount = 10 }
    },
    [2] = {
        { type = "item", name = "oil-refinery", amount = 1 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-oil-refinery-02", amount = 1 },
        { type = "item", name = "sulfur", amount = 24 }
    },
    [4] = {
        { type = "item", name = "5d-oil-refinery-03", amount = 1 },
        { type = "fluid", name = "lubricant", amount = 160 }
    },
    [5] = {
        { type = "item", name = "5d-oil-refinery-04", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 28 }
    },
    [6] = {
        { type = "item", name = "5d-oil-refinery-05", amount = 1 },
        { type = "item", name = "plastic-bar", amount = 30 }
    },
    [7] = {
        { type = "item", name = "5d-oil-refinery-06", amount = 1 },
        { type = "item", name = "battery", amount = 16 }
    },
    [8] = {
        { type = "item", name = "5d-oil-refinery-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 12 }
    },
    [9] = {
        { type = "item", name = "5d-oil-refinery-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 12 }
    },
    [10] = {
        { type = "item", name = "5d-oil-refinery-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 8 }
    }
}

return Templates
