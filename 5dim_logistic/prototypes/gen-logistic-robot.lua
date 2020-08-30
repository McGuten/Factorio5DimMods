require("__5dim_core__.lib.logistic.generation-logistic-robot")

speed = 0.05
modules = 5
energy = 1.5
emisions = 100

-- Electric furnace 01
genLogisticRobots {
    number = "01",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    tech = nil
}

modules = modules + 0.025
speed = speed + 0.025
energy = energy + 0.75

-- Electric furnace 02
genLogisticRobots {
    number = "02",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"5d-water-pumpjack-01", 1},
        {"electronic-circuit", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    tech = {
        number = 2,
        count = 150,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-1"
        }
    }
}

modules = modules + 0.025
speed = speed + 0.025
energy = energy + 0.75

-- Electric furnace 03
genLogisticRobots {
    number = "03",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-water-pumpjack-02", 1},
        {"electronic-circuit", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    tech = {
        number = 3,
        count = 300,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-2"
        }
    }
}

modules = modules + 0.025
speed = speed + 0.025
energy = energy + 0.75

-- Electric furnace 04
genLogisticRobots {
    number = "04",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-water-pumpjack-03", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    tech = {
        number = 4,
        count = 450,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-3",
            "chemical-science-pack"
        }
    }
}

modules = modules + 0.025
speed = speed + 0.025
energy = energy + 0.75

-- Electric furnace 05
genLogisticRobots {
    number = "05",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-water-pumpjack-04", 1},
        {"steel-plate", 2},
        {"pipe", 3},
        {"iron-gear-wheel", 1}
    },
    pollution = emisions,
    tech = {
        number = 5,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-4"
        }
    }
}

modules = modules + 0.025
speed = speed + 0.025
energy = energy + 0.75

-- Electric furnace 06
genLogisticRobots {
    number = "06",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-water-pumpjack-05", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 1}
    },
    pollution = emisions,
    tech = {
        number = 6,
        count = 600,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-5",
            "production-science-pack"
        }
    }
}

modules = modules + 0.025
speed = speed + 0.025
energy = energy + 0.75

-- Electric furnace 07
genLogisticRobots {
    number = "07",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-water-pumpjack-06", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    tech = {
        number = 7,
        count = 700,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-6"
        }
    }
}

modules = modules + 0.025
speed = speed + 0.025
energy = energy + 0.75

-- Electric furnace 08
genLogisticRobots {
    number = "08",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-water-pumpjack-07", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    tech = {
        number = 8,
        count = 800,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-7",
            "utility-science-pack"
        }
    }
}

modules = modules + 0.025
speed = speed + 0.025
energy = energy + 0.75

-- Electric furnace 09
genLogisticRobots {
    number = "09",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-water-pumpjack-08", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    tech = {
        number = 9,
        count = 900,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-8"
        }
    }
}

modules = modules + 0.025
speed = speed + 0.025
energy = energy + 0.75

-- Electric furnace 10
genLogisticRobots {
    number = "10",
    subgroup = "logistic-robot",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-water-pumpjack-09", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    tech = {
        number = 10,
        count = 1000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-9"
        }
    }
}
