-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Automation)
-- Templates for assembling machines, chemical plants, labs, oil refineries
-------------------------------------------------------------------------------

local Templates = {}

local function speedModuleIngredientName(tier)
    if tier <= 1 then
        return "speed-module"
    end

    if tier <= 3 then
        return "speed-module-" .. tier
    end

    if mods and mods["5dim_module"] then
        return "5d-speed-module-" .. string.format("%02d", tier)
    end

    return "speed-module-3"
end

local function productivityModuleIngredientName(tier)
    if tier <= 1 then
        return "productivity-module"
    end

    if tier <= 3 then
        return "productivity-module-" .. tier
    end

    if mods and mods["5dim_module"] then
        return "5d-productivity-module-" .. string.format("%02d", tier)
    end

    return "productivity-module-3"
end

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
        { type = "item", name = "advanced-circuit", amount = 8 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "speed-module", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-assembling-machine-04", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 10 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "productivity-module", amount = 2 }
    },
    [6] = {
        { type = "item", name = "5d-assembling-machine-05", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 14 },
        { type = "item", name = "steel-plate", amount = 14 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-assembling-machine-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 6 },
        { type = "item", name = "low-density-structure", amount = 8 },
        { type = "item", name = "productivity-module-2", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-assembling-machine-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "low-density-structure", amount = 12 },
        { type = "item", name = speedModuleIngredientName(4), amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-assembling-machine-08", amount = 1 },
        { type = "item", name = "processing-unit", amount = 14 },
        { type = "item", name = "low-density-structure", amount = 18 },
        { type = "item", name = productivityModuleIngredientName(4), amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-assembling-machine-09", amount = 1 },
        { type = "item", name = "processing-unit", amount = 18 },
        { type = "item", name = "low-density-structure", amount = 24 },
        { type = "item", name = productivityModuleIngredientName(5), amount = 4 }
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
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-chemical-plant-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "pipe", amount = 8 }
    },
    [4] = {
        { type = "item", name = "5d-chemical-plant-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "iron-gear-wheel", amount = 8 },
        { type = "item", name = "advanced-circuit", amount = 8 },
        { type = "item", name = "pipe", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-chemical-plant-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 12 },
        { type = "item", name = "iron-gear-wheel", amount = 8 },
        { type = "item", name = "advanced-circuit", amount = 12 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "speed-module", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-chemical-plant-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 12 },
        { type = "item", name = "advanced-circuit", amount = 12 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    [7] = {
        { type = "item", name = "5d-chemical-plant-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 14 },
        { type = "item", name = "advanced-circuit", amount = 14 },
        { type = "item", name = "speed-module-2", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-chemical-plant-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 8 },
        { type = "item", name = "processing-unit", amount = 8 },
        { type = "item", name = productivityModuleIngredientName(4), amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-chemical-plant-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 12 },
        { type = "item", name = "processing-unit", amount = 12 },
        { type = "item", name = speedModuleIngredientName(4), amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-chemical-plant-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 16 },
        { type = "item", name = "processing-unit", amount = 16 },
        { type = "item", name = productivityModuleIngredientName(5), amount = 2 }
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
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "transport-belt", amount = 4 }
    },
    [3] = {
        { type = "item", name = "5d-lab-02", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 12 },
        { type = "item", name = "steel-plate", amount = 12 },
        { type = "item", name = "transport-belt", amount = 4 }
    },
    [4] = {
        { type = "item", name = "5d-lab-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 12 },
        { type = "item", name = "steel-plate", amount = 12 },
        { type = "item", name = "fast-transport-belt", amount = 6 }
    },
    [5] = {
        { type = "item", name = "5d-lab-04", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 14 },
        { type = "item", name = "steel-plate", amount = 14 },
        { type = "item", name = "fast-transport-belt", amount = 6 },
        { type = "item", name = "speed-module", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-lab-05", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 14 },
        { type = "item", name = "steel-plate", amount = 14 },
        { type = "item", name = "fast-transport-belt", amount = 6 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    [7] = {
        { type = "item", name = "5d-lab-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 12 },
        { type = "item", name = "low-density-structure", amount = 6 },
        { type = "item", name = "express-transport-belt", amount = 6 },
        { type = "item", name = "speed-module-2", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-lab-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 14 },
        { type = "item", name = "low-density-structure", amount = 10 },
        { type = "item", name = "express-transport-belt", amount = 6 },
        { type = "item", name = productivityModuleIngredientName(4), amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-lab-08", amount = 1 },
        { type = "item", name = "processing-unit", amount = 18 },
        { type = "item", name = "low-density-structure", amount = 12 },
        { type = "item", name = "express-transport-belt", amount = 6 },
        { type = "item", name = speedModuleIngredientName(4), amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-lab-09", amount = 1 },
        { type = "item", name = "processing-unit", amount = 24 },
        { type = "item", name = "low-density-structure", amount = 18 },
        { type = "item", name = "express-transport-belt", amount = 6 },
        { type = "item", name = productivityModuleIngredientName(5), amount = 2 }
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
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "iron-gear-wheel", amount = 12 },
        { type = "item", name = "concrete", amount = 12 },
        { type = "item", name = "electronic-circuit", amount = 12 },
        { type = "item", name = "pipe", amount = 12 }
    },
    [3] = {
        { type = "item", name = "5d-oil-refinery-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "iron-gear-wheel", amount = 12 },
        { type = "item", name = "concrete", amount = 12 },
        { type = "item", name = "advanced-circuit", amount = 6 },
        { type = "item", name = "pipe", amount = 12 }
    },
    [4] = {
        { type = "item", name = "5d-oil-refinery-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 24 },
        { type = "item", name = "iron-gear-wheel", amount = 14 },
        { type = "item", name = "concrete", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 10 },
        { type = "item", name = "pipe", amount = 12 }
    },
    [5] = {
        { type = "item", name = "5d-oil-refinery-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 24 },
        { type = "item", name = "iron-gear-wheel", amount = 14 },
        { type = "item", name = "refined-concrete", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 12 },
        { type = "item", name = "pipe", amount = 12 },
        { type = "item", name = "speed-module", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-oil-refinery-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 24 },
        { type = "item", name = "iron-gear-wheel", amount = 14 },
        { type = "item", name = "refined-concrete", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 12 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    [7] = {
        { type = "item", name = "5d-oil-refinery-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 12 },
        { type = "item", name = "iron-gear-wheel", amount = 20 },
        { type = "item", name = "refined-concrete", amount = 18 },
        { type = "item", name = "processing-unit", amount = 12 },
        { type = "item", name = "speed-module-2", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-oil-refinery-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 16 },
        { type = "item", name = "iron-gear-wheel", amount = 20 },
        { type = "item", name = "refined-concrete", amount = 20 },
        { type = "item", name = "processing-unit", amount = 16 },
        { type = "item", name = productivityModuleIngredientName(4), amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-oil-refinery-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 20 },
        { type = "item", name = "iron-gear-wheel", amount = 24 },
        { type = "item", name = "refined-concrete", amount = 24 },
        { type = "item", name = "processing-unit", amount = 18 },
        { type = "item", name = speedModuleIngredientName(4), amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-oil-refinery-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 24 },
        { type = "item", name = "iron-gear-wheel", amount = 28 },
        { type = "item", name = "refined-concrete", amount = 28 },
        { type = "item", name = "processing-unit", amount = 24 },
        { type = "item", name = productivityModuleIngredientName(5), amount = 2 }
    }
}

return Templates
