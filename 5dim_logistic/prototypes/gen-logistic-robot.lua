require("__5dim_core__.lib.logistic.generation-logistic-robot")

local speed = 0.05
local modules = 5
local energy = 1.5
local emisions = 100
local techCount = 400

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
        {"flying-robot-frame", 1},
        {"advanced-circuit", 2}
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
        {"logistic-robot", 1},
        {"electric-engine-unit", 1},
        {"advanced-circuit", 1},
        {"battery", 1}
    },
    pollution = emisions,
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "logistic-robotics",
            "construction-robotics"
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
        {"5d-logistic-robot-02", 1},
        {"electric-engine-unit", 1},
        {"advanced-circuit", 1},
        {"battery", 1}
    },
    pollution = emisions,
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-1",
            "5d-logistic-robot-1",
            "5d-roboport-2"
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
        {"5d-logistic-robot-03", 1},
        {"electric-engine-unit", 1},
        {"advanced-circuit", 1},
        {"battery", 1}
    },
    pollution = emisions,
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-2",
            "5d-logistic-robot-2",
            "5d-roboport-3",
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
        {"5d-logistic-robot-04", 1},
        {"electric-engine-unit", 1},
        {"processing-unit", 1},
        {"battery", 1}
    },
    pollution = emisions,
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-3",
            "5d-logistic-robot-3",
            "5d-roboport-4"
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
        {"5d-logistic-robot-05", 1},
        {"electric-engine-unit", 1},
        {"processing-unit", 1},
        {"battery", 1}
    },
    pollution = emisions,
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
            "5d-construction-robot-4",
            "5d-logistic-robot-4",
            "5d-roboport-5",
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
        {"5d-logistic-robot-06", 1},
        {"electric-engine-unit", 1},
        {"processing-unit", 1},
        {"battery", 1}
    },
    pollution = emisions,
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
            "5d-construction-robot-5",
            "5d-logistic-robot-5",
            "5d-roboport-6"
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
        {"5d-logistic-robot-07", 1},
        {"electric-engine-unit", 1},
        {"processing-unit", 1},
        {"battery", 1}
    },
    pollution = emisions,
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
            "5d-construction-robot-6",
            "5d-logistic-robot-6",
            "5d-roboport-7",
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
        {"5d-logistic-robot-08", 1},
        {"electric-engine-unit", 1},
        {"processing-unit", 1},
        {"battery", 1}
    },
    pollution = emisions,
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
            "5d-construction-robot-7",
            "5d-logistic-robot-7",
            "5d-roboport-8"
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
        {"5d-logistic-robot-09", 1},
        {"electric-engine-unit", 1},
        {"processing-unit", 1},
        {"battery", 1}
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
            "5d-construction-robot-8",
            "5d-logistic-robot-8",
            "5d-roboport-9"
        }
    }
}
