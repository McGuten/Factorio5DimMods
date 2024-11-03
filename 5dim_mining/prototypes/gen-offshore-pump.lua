require("__5dim_core__.lib.mining.generation-offshore-pump")

local speed = 20
local modules = 2
local energy = 90
local emisions = 10
local techCount = 100

-- Offshore Pump 01
genOffshorePumps {
    number = "01",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "pipe",               amount = 1 },
        { type = "item", name = "iron-gear-wheel",    amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-offshore-pump-02",
    tech = nil
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Offshore Pump 02
genOffshorePumps {
    number = "02",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "offshore-pump",      amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe",               amount = 3 },
        { type = "item", name = "iron-gear-wheel",    amount = 2 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-offshore-pump-03",
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

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Offshore Pump 03
genOffshorePumps {
    number = "03",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-offshore-pump-02", amount = 1 },
        { type = "item", name = "electronic-circuit",  amount = 5 },
        { type = "item", name = "pipe",                amount = 3 },
        { type = "item", name = "iron-gear-wheel",     amount = 2 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-offshore-pump-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "5d-offshore-pump-1"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Offshore Pump 04
genOffshorePumps {
    number = "04",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-offshore-pump-03", amount = 1 },
        { type = "item", name = "steel-plate",         amount = 5 },
        { type = "item", name = "pipe",                amount = 3 },
        { type = "item", name = "iron-gear-wheel",     amount = 2 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-offshore-pump-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-offshore-pump-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Offshore Pump 05
genOffshorePumps {
    number = "05",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-offshore-pump-04", amount = 1 },
        { type = "item", name = "steel-plate",         amount = 5 },
        { type = "item", name = "pipe",                amount = 3 },
        { type = "item", name = "iron-gear-wheel",     amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-offshore-pump-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-offshore-pump-3"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Offshore Pump 06
genOffshorePumps {
    number = "06",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-offshore-pump-05", amount = 1 },
        { type = "item", name = "steel-plate",         amount = 5 },
        { type = "item", name = "pipe",                amount = 3 },
        { type = "item", name = "iron-gear-wheel",     amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-offshore-pump-07",
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
            "5d-offshore-pump-4",
            "production-science-pack"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Offshore Pump 07
genOffshorePumps {
    number = "07",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-offshore-pump-06", amount = 1 },
        { type = "item", name = "steel-plate",         amount = 5 },
        { type = "item", name = "pipe",                amount = 3 },
        { type = "item", name = "advanced-circuit",    amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-offshore-pump-08",
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
            "5d-offshore-pump-5"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Offshore Pump 08
genOffshorePumps {
    number = "08",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-offshore-pump-07", amount = 1 },
        { type = "item", name = "steel-plate",         amount = 5 },
        { type = "item", name = "pipe",                amount = 3 },
        { type = "item", name = "advanced-circuit",    amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-offshore-pump-09",
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
            "5d-offshore-pump-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Offshore Pump 09
genOffshorePumps {
    number = "09",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-offshore-pump-08",   amount = 1 },
        { type = "item", name = "steel-plate",           amount = 5 },
        { type = "item", name = "pipe",                  amount = 3 },
        { type = "item", name = "advanced-circuit",      amount = 1 },
        { type = "item", name = "low-density-structure", amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-offshore-pump-10",
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
            "5d-offshore-pump-7"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Offshore Pump 10
genOffshorePumps {
    number = "10",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-offshore-pump-09",   amount = 1 },
        { type = "item", name = "steel-plate",           amount = 5 },
        { type = "item", name = "pipe",                  amount = 3 },
        { type = "item", name = "advanced-circuit",      amount = 1 },
        { type = "item", name = "low-density-structure", amount = 1 }
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
            "5d-offshore-pump-8"
        }
    }
}
