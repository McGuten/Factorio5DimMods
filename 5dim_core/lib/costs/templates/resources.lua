-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Resources)
-- Templates for furnaces and processing buildings
-------------------------------------------------------------------------------

local Templates = {}

-- Electric Furnace templates
Templates.electricFurnace = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "stone-brick", amount = 10 }
    },
    [2] = {
        { type = "item", name = "electric-furnace", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-electric-furnace-02", amount = 1 },
        { type = "item", name = "stone-brick", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-electric-furnace-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-electric-furnace-04", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-electric-furnace-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-electric-furnace-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-electric-furnace-07", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-electric-furnace-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-electric-furnace-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 2 }
    }
}

-- Masher templates
Templates.masher = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel", amount = 10 }
    },
    [2] = {
        { type = "item", name = "5d-masher-01", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-masher-02", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-masher-03", amount = 1 },
        { type = "item", name = "engine-unit", amount = 6 }
    },
    [5] = {
        { type = "item", name = "5d-masher-04", amount = 1 },
        { type = "item", name = "concrete", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-masher-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 6 }
    },
    [7] = {
        { type = "item", name = "5d-masher-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 6 }
    },
    [8] = {
        { type = "item", name = "5d-masher-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-masher-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-masher-09", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 2 }
    }
}

return Templates
