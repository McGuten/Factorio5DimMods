require("__5dim_core__.lib.automatization.generation-lab")

local speed = 1
local modules = 2
local energy = 60
local techCount = 200

-- Labs 01
genLabs {
    number = "01",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"electronic-circuit", 10},
        {"iron-gear-wheel", 10},
        {"transport-belt", 4}
    },
    nextUpdate = "5d-lab-02",
    tech = nil
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 02
genLabs {
    number = "02",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"lab", 1},
        {"electronic-circuit", 10},
        {"iron-gear-wheel", 10},
        {"transport-belt", 4}
    },
    nextUpdate = "5d-lab-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "engine",
            "logistic-science-pack",
        }
    }
}

speed = speed + 0.2
energy = energy + 30

-- Labs 03
genLabs {
    number = "03",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-lab-02", 1},
        {"electronic-circuit", 10},
        {"steel-plate", 10},
        {"transport-belt", 4}
    },
    nextUpdate = "5d-lab-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-lab-1"
        }
    }
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 04
genLabs {
    number = "04",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-lab-03", 1},
        {"advanced-circuit", 10},
        {"steel-plate", 10},
        {"fast-transport-belt", 4}
    },
    nextUpdate = "5d-lab-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-lab-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.2
energy = energy + 30

-- Labs 05
genLabs {
    number = "05",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-lab-04", 1},
        {"advanced-circuit", 10},
        {"steel-plate", 10},
        {"fast-transport-belt", 4},
        {"speed-module", 1}
    },
    nextUpdate = "5d-lab-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-lab-3"
        }
    }
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 06
genLabs {
    number = "06",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-lab-05", 1},
        {"advanced-circuit", 10},
        {"steel-plate", 10},
        {"fast-transport-belt", 4},
        {"productivity-module", 1}
    },
    nextUpdate = "5d-lab-07",
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
            "5d-lab-4",
            "production-science-pack"
        }
    }
}

speed = speed + 0.2
energy = energy + 30

-- Labs 07
genLabs {
    number = "07",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-lab-06", 1},
        {"advanced-circuit", 10},
        {"steel-plate", 10},
        {"express-transport-belt", 4},
        {"speed-module-2", 1}
    },
    nextUpdate = "5d-lab-08",
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
            "5d-lab-5"
        }
    }
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 08
genLabs {
    number = "08",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-lab-07", 1},
        {"advanced-circuit", 10},
        {"low-density-structure", 3},
        {"express-transport-belt", 4},
        {"productivity-module-2", 1}
    },
    nextUpdate = "5d-lab-09",
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
            "5d-lab-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.2
energy = energy + 30

-- Labs 09
genLabs {
    number = "09",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-lab-08", 1},
        {"advanced-circuit", 10},
        {"low-density-structure", 3},
        {"express-transport-belt", 4},
        {"speed-module-3", 1}
    },
    nextUpdate = "5d-lab-10",
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
            "5d-lab-7"
        }
    }
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 10
genLabs {
    number = "10",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-lab-09", 1},
        {"processing-unit", 2},
        {"low-density-structure", 3},
        {"express-transport-belt", 4},
        {"productivity-module-3", 1}
    },
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
            "5d-lab-8"
        }
    }
}
