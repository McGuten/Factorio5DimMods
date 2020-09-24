require("__5dim_core__.lib.energy.generation-boiler")

local speed = 1.8
local modules = 2
local energy = 1
local emisions = 30

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
        {"stone-furnace", 1},
        {"pipe", 4}
    },
    pollution = emisions,
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
        {"boiler", 1},
        {"stone", 5},
        {"pipe", 4}
    },
    pollution = emisions,
    nextUpdate = "5d-boiler-03",
    tech = {
        number = 1,
        count = 500,
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
        {"5d-boiler-02", 1},
        {"stone-brick", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-boiler-04",
    tech = {
        number = 2,
        count = 750,
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
        {"5d-boiler-03", 1},
        {"stone-brick", 5},
        {"pipe", 4}
    },
    pollution = emisions,
    nextUpdate = "5d-boiler-05",
    tech = {
        number = 3,
        count = 1000,
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
        {"5d-boiler-04", 1},
        {"stone-brick", 5},
        {"pipe", 4},
        {"effectivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-boiler-06",
    tech = {
        number = 4,
        count = 1250,
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
        {"5d-boiler-05", 1},
        {"steel-plate", 2},
        {"concrete", 5},
        {"pipe", 4},
        {"productivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-boiler-07",
    tech = {
        number = 5,
        count = 1500,
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
        {"5d-boiler-06", 1},
        {"steel-plate", 2},
        {"concrete", 5},
        {"pipe", 4},
        {"effectivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-boiler-08",
    tech = {
        number = 6,
        count = 1750,
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
        {"5d-boiler-07", 1},
        {"steel-plate", 2},
        {"concrete", 5},
        {"pipe", 4},
        {"productivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-boiler-09",
    tech = {
        number = 7,
        count = 2000,
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
        {"5d-boiler-08", 1},
        {"low-density-structure", 2},
        {"refined-concrete", 5},
        {"pipe", 4},
        {"effectivity-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-boiler-10",
    tech = {
        number = 8,
        count = 2250,
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
        {"5d-boiler-09", 1},
        {"low-density-structure", 2},
        {"refined-concrete", 5},
        {"pipe", 4},
        {"productivity-module-3", 1}
    },
    pollution = emisions,
    tech = {
        number = 9,
        count = 2500,
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
