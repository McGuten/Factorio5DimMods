require("__5dim_core__.lib.mining.generation-offshore-pump")

local speed = 20
local modules = 2
local energy = 90
local emisions = 10
local techCount = 100

-- Electric furnace 01
genOffshorePumps {
    number = "01",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"electronic-circuit", 2},
        {"pipe", 1},
        {"iron-gear-wheel", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-offshore-pump-02",
    tech = nil
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 02
genOffshorePumps {
    number = "02",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"offshore-pump", 1},
        {"electronic-circuit", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    nextUpdate = "5d-offshore-pump-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
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

-- Electric furnace 03
genOffshorePumps {
    number = "03",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-offshore-pump-02", 1},
        {"electronic-circuit", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    nextUpdate = "5d-offshore-pump-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-offshore-pump-1",
            "5d-boiler-1",
            "5d-steam-engine-1"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 04
genOffshorePumps {
    number = "04",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-offshore-pump-03", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    nextUpdate = "5d-offshore-pump-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-offshore-pump-2",
            "5d-boiler-2",
            "5d-steam-engine-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 05
genOffshorePumps {
    number = "05",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-offshore-pump-04", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-offshore-pump-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-offshore-pump-3",
            "5d-boiler-3",
            "5d-steam-engine-3"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 06
genOffshorePumps {
    number = "06",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-offshore-pump-05", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-offshore-pump-07",
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-offshore-pump-4",
            "5d-boiler-4",
            "5d-steam-engine-4",
            "production-science-pack"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 07
genOffshorePumps {
    number = "07",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-offshore-pump-06", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-offshore-pump-08",
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-offshore-pump-5",
            "5d-boiler-5",
            "5d-steam-engine-5"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 08
genOffshorePumps {
    number = "08",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-offshore-pump-07", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-offshore-pump-09",
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-offshore-pump-6",
            "5d-boiler-6",
            "5d-steam-engine-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 09
genOffshorePumps {
    number = "09",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-offshore-pump-08", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1},
        {"low-density-structure", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-offshore-pump-10",
    tech = {
        number = 8,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-offshore-pump-7",
            "5d-boiler-7",
            "5d-steam-engine-7"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 10
genOffshorePumps {
    number = "10",
    subgroup = "liquid-offshore-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-offshore-pump-09", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1},
        {"low-density-structure", 1}
    },
    pollution = emisions,
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-offshore-pump-8",
            "5d-boiler-8",
            "5d-steam-engine-8"
        }
    }
}
