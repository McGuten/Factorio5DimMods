require("__5dim_core__.lib.energy.generation-boiler")

local speed = 1.8
local modules = 2
local energy = 1
local emisions = 30
local techCount = 500

-- Electric furnace 01
genBoilers {
    number = "01",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "stone-furnace", amount = 1 },
        { type = "item", name = "pipe",          amount = 4 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-boiler-02",
    tech = nil
}

speed = speed + 0.9
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 02
genBoilers {
    number = "02",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "boiler", amount = 1 },
        { type = "item", name = "stone",  amount = 5 },
        { type = "item", name = "pipe",   amount = 4 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-boiler-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "fluid-handling",
            "logistic-science-pack"
        }
    }
}

speed = speed + 0.9
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 03
genBoilers {
    number = "03",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-boiler-02", amount = 1 },
        { type = "item", name = "stone-brick",  amount = 5 },
        { type = "item", name = "pipe",         amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-boiler-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "5d-boiler-1",
            "5d-steam-engine-1"
        }
    }
}

speed = speed + 0.9
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 04
genBoilers {
    number = "04",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-boiler-03", amount = 1 },
        { type = "item", name = "stone-brick",  amount = 5 },
        { type = "item", name = "pipe",         amount = 4 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-boiler-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-boiler-2",
            "5d-steam-engine-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.9
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 05
genBoilers {
    number = "05",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-boiler-04",       amount = 1 },
        { type = "item", name = "stone-brick",        amount = 5 },
        { type = "item", name = "pipe",               amount = 4 },
        { type = "item", name = "efficiency-module", amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-boiler-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-boiler-3",
            "5d-steam-engine-3"
        }
    }
}

speed = speed + 0.9
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 06
genBoilers {
    number = "06",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-boiler-05",        amount = 1 },
        { type = "item", name = "steel-plate",         amount = 2 },
        { type = "item", name = "concrete",            amount = 5 },
        { type = "item", name = "pipe",                amount = 4 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-boiler-07",
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "5d-boiler-4",
            "5d-steam-engine-4",
            "production-science-pack"
        }
    }
}

speed = speed + 0.9
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 07
genBoilers {
    number = "07",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-boiler-06",         amount = 1 },
        { type = "item", name = "steel-plate",          amount = 2 },
        { type = "item", name = "concrete",             amount = 5 },
        { type = "item", name = "pipe",                 amount = 4 },
        { type = "item", name = "efficiency-module-2", amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-boiler-08",
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "5d-boiler-5",
            "5d-steam-engine-5"
        }
    }
}

speed = speed + 0.9
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 08
genBoilers {
    number = "08",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-boiler-07",          amount = 1 },
        { type = "item", name = "steel-plate",           amount = 2 },
        { type = "item", name = "concrete",              amount = 5 },
        { type = "item", name = "pipe",                  amount = 4 },
        { type = "item", name = "productivity-module-2", amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-boiler-09",
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-boiler-6",
            "5d-steam-engine-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.9
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 09
genBoilers {
    number = "09",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-boiler-08",          amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "refined-concrete",      amount = 5 },
        { type = "item", name = "pipe",                  amount = 4 },
        { type = "item", name = "efficiency-module-3",  amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-boiler-10",
    tech = {
        number = 8,
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-boiler-7",
            "5d-steam-engine-7"
        }
    }
}

speed = speed + 0.9
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 10
genBoilers {
    number = "10",
    subgroup = "energy-boiler",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-boiler-09",          amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "refined-concrete",      amount = 5 },
        { type = "item", name = "pipe",                  amount = 4 },
        { type = "item", name = "productivity-module-3", amount = 1 }
    },
    pollution = { pollution = emisions },
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-boiler-8",
            "5d-steam-engine-8"
        }
    }
}
