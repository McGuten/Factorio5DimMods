require("__5dim_core__.lib.mining.generation-electric-mining-drill")

local speed = 0.5
local modules = 2
local energy = 90
local emisions = 10

-- Electric furnace 01
genMiningDrills {
    number = "01",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"electronic-circuit", 3},
        {"iron-gear-wheel", 5},
        {"iron-plate", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-mining-drill-02",
    tech = nil
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 02
genMiningDrills {
    number = "02",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"electric-mining-drill", 1},
        {"electronic-circuit", 3},
        {"iron-gear-wheel", 5},
        {"iron-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-mining-drill-03",
    tech = {
        number = 1,
        count = 150,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "automation-2",
            "logistic-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 03
genMiningDrills {
    number = "03",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-electric-mining-drill-02", 1},
        {"electronic-circuit", 3},
        {"iron-gear-wheel", 5},
        {"steel-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-mining-drill-04",
    tech = {
        number = 2,
        count = 300,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-mining-1"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 04
genMiningDrills {
    number = "04",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-electric-mining-drill-03", 1},
        {"electronic-circuit", 3},
        {"iron-gear-wheel", 5},
        {"steel-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-mining-drill-05",
    tech = {
        number = 3,
        count = 450,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-mining-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 05
genMiningDrills {
    number = "05",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-electric-mining-drill-04", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"speed-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-mining-drill-06",
    tech = {
        number = 4,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-mining-3"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 06
genMiningDrills {
    number = "06",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-electric-mining-drill-05", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"productivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-mining-drill-07",
    tech = {
        number = 5,
        count = 600,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-mining-4",
            "production-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 07
genMiningDrills {
    number = "07",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-electric-mining-drill-06", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"speed-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-mining-drill-08",
    tech = {
        number = 6,
        count = 700,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-mining-5"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 08
genMiningDrills {
    number = "08",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-electric-mining-drill-07", 1},
        {"advanced-circuit", 3},
        {"low-density-structure", 2},
        {"productivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-mining-drill-09",
    tech = {
        number = 7,
        count = 800,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-mining-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 09
genMiningDrills {
    number = "09",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-electric-mining-drill-08", 1},
        {"advanced-circuit", 3},
        {"low-density-structure", 2},
        {"speed-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-mining-drill-10",
    tech = {
        number = 8,
        count = 900,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-mining-7"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 10
genMiningDrills {
    number = "10",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-electric-mining-drill-09", 1},
        {"steel-plate", 5},
        {"low-density-structure", 5},
        {"processing-unit", 2},
        {"productivity-module-3", 1}
    },
    pollution = emisions,
    tech = {
        number = 9,
        count = 1000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-mining-8"
        }
    }
}
