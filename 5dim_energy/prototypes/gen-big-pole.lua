require("__5dim_core__.lib.energy.generation-big-pole")

local speed = 30
local modules = 2
local energy = 2
local emisions = 30
local techCount = 150

-- Electric furnace 01
genBigPoles {
    number = "01",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "iron-stick",   amount = 8 },
        { type = "item", name = "steel-plate",  amount = 5 },
        { type = "item", name = "copper-plate", amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-big-electric-pole-02",
    tech = nil
}

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 02
genBigPoles {
    number = "02",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "big-electric-pole", amount = 1 },
        { type = "item", name = "iron-stick",        amount = 8 },
        { type = "item", name = "steel-plate",       amount = 5 },
        { type = "item", name = "copper-plate",      amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-big-electric-pole-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "electric-energy-distribution-1"
        }
    }
}

speed = speed + 3
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 03
genBigPoles {
    number = "03",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-big-electric-pole-02", amount = 1 },
        { type = "item", name = "iron-stick",              amount = 8 },
        { type = "item", name = "steel-plate",             amount = 5 },
        { type = "item", name = "copper-plate",            amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-big-electric-pole-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-substation-1",
            "5d-medium-electric-pole-1",
            "5d-big-electric-pole-1",
            "chemical-science-pack"
        }
    }
}

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 04
genBigPoles {
    number = "04",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-big-electric-pole-03", amount = 1 },
        { type = "item", name = "iron-stick",              amount = 8 },
        { type = "item", name = "steel-plate",             amount = 5 },
        { type = "item", name = "copper-plate",            amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-big-electric-pole-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "5d-substation-2",
            "5d-medium-electric-pole-2",
            "5d-big-electric-pole-2"
        }
    }
}

speed = speed + 3
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 05
genBigPoles {
    number = "05",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-big-electric-pole-04", amount = 1 },
        { type = "item", name = "iron-stick",              amount = 8 },
        { type = "item", name = "steel-plate",             amount = 5 },
        { type = "item", name = "copper-plate",            amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-big-electric-pole-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-substation-3",
            "5d-medium-electric-pole-3",
            "5d-big-electric-pole-3",
            "production-science-pack"
        }
    }
}

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 06
genBigPoles {
    number = "06",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-big-electric-pole-05", amount = 1 },
        { type = "item", name = "iron-stick",              amount = 8 },
        { type = "item", name = "steel-plate",             amount = 5 },
        { type = "item", name = "copper-plate",            amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-big-electric-pole-07",
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
            "5d-substation-4",
            "5d-medium-electric-pole-4",
            "5d-big-electric-pole-4"
        }
    }
}

speed = speed + 3
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 07
genBigPoles {
    number = "07",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-big-electric-pole-06", amount = 1 },
        { type = "item", name = "iron-stick",              amount = 8 },
        { type = "item", name = "steel-plate",             amount = 5 },
        { type = "item", name = "copper-plate",            amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-big-electric-pole-08",
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-substation-5",
            "5d-medium-electric-pole-5",
            "5d-big-electric-pole-5",
            "utility-science-pack"
        }
    }
}

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 08
genBigPoles {
    number = "08",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-big-electric-pole-07", amount = 1 },
        { type = "item", name = "iron-stick",              amount = 8 },
        { type = "item", name = "steel-plate",             amount = 5 },
        { type = "item", name = "electronic-circuit",      amount = 5 },
        { type = "item", name = "low-density-structure",   amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-big-electric-pole-09",
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
            "5d-substation-6",
            "5d-medium-electric-pole-6",
            "5d-big-electric-pole-6"
        }
    }
}

speed = speed + 3
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 09
genBigPoles {
    number = "09",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-big-electric-pole-08", amount = 1 },
        { type = "item", name = "iron-stick",              amount = 8 },
        { type = "item", name = "steel-plate",             amount = 5 },
        { type = "item", name = "electronic-circuit",      amount = 5 },
        { type = "item", name = "low-density-structure",   amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-big-electric-pole-10",
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
            "5d-substation-7",
            "5d-medium-electric-pole-7",
            "5d-big-electric-pole-7"
        }
    }
}

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 10
genBigPoles {
    number = "10",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-big-electric-pole-09", amount = 1 },
        { type = "item", name = "iron-stick",              amount = 8 },
        { type = "item", name = "steel-plate",             amount = 5 },
        { type = "item", name = "electronic-circuit",      amount = 5 },
        { type = "item", name = "low-density-structure",   amount = 1 }
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
            "5d-substation-8",
            "5d-medium-electric-pole-8",
            "5d-big-electric-pole-8"
        }
    }
}
