require("__5dim_core__.lib.nuclear.generation-steam-turbine")

local speed = 1
local modules = 2
local energy = 1
local emisions = 30

-- Electric furnace 01
genSteamTurbines {
    number = "01",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"iron-gear-wheel", 50},
        {"copper-plate", 50},
        {"pipe", 20}
    },
    pollution = emisions,
    tech = nil
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 02
genSteamTurbines {
    number = "02",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"steam-turbine", 1},
        {"iron-gear-wheel", 50},
        {"copper-plate", 50},
        {"electronic-circuit", 50},
        {"pipe", 20}
    },
    pollution = emisions,
    tech = {
        number = 1,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "nuclear-power",
        }
    }
}

speed = speed + 0.5
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 03
genSteamTurbines {
    number = "03",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-steam-turbine-02", 1},
        {"steel-plate", 15},
        {"copper-plate", 50},
        {"electronic-circuit", 50},
        {"pipe", 20}
    },
    pollution = emisions,
    tech = {
        number = 2,
        count = 750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-nuclear-reactor-1",
            "5d-steam-turbine-1",
            "5d-heat-pipe-1",
            "5d-heat-exchanger-1"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 04
genSteamTurbines {
    number = "04",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-steam-turbine-03", 1},
        {"steel-plate", 15},
        {"copper-plate", 50},
        {"advanced-circuit", 30},
        {"pipe", 20}
    },
    pollution = emisions,
    tech = {
        number = 3,
        count = 1000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-nuclear-reactor-2",
            "5d-steam-turbine-2",
            "5d-heat-pipe-2",
            "5d-heat-exchanger-2",
            "space-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 05
genSteamTurbines {
    number = "05",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-steam-turbine-04", 1},
        {"steel-plate", 15},
        {"copper-plate", 50},
        {"advanced-circuit", 20},
        {"pipe", 20},
        {"speed-module", 1}
    },
    pollution = emisions,
    tech = {
        number = 4,
        count = 1250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-nuclear-reactor-3",
            "5d-steam-turbine-3",
            "5d-heat-pipe-3",
            "5d-heat-exchanger-3"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 06
genSteamTurbines {
    number = "06",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-steam-turbine-05", 1},
        {"steel-plate", 15},
        {"copper-plate", 50},
        {"advanced-circuit", 20},
        {"pipe", 20},
        {"productivity-module", 1}
    },
    pollution = emisions,
    tech = {
        number = 5,
        count = 1500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-nuclear-reactor-4",
            "5d-steam-turbine-4",
            "5d-heat-pipe-4",
            "5d-heat-exchanger-4"
        }
    }
}

speed = speed + 0.5
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 07
genSteamTurbines {
    number = "07",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-steam-turbine-06", 1},
        {"steel-plate", 15},
        {"copper-plate", 50},
        {"advanced-circuit", 20},
        {"pipe", 20},
        {"speed-module-2", 1}
    },
    pollution = emisions,
    tech = {
        number = 6,
        count = 1750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-nuclear-reactor-5",
            "5d-steam-turbine-5",
            "5d-heat-pipe-5",
            "5d-heat-exchanger-5"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 08
genSteamTurbines {
    number = "08",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-steam-turbine-07", 1},
        {"steel-plate", 15},
        {"copper-plate", 50},
        {"advanced-circuit", 20},
        {"pipe", 20},
        {"productivity-module-2", 1}
    },
    pollution = emisions,
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
            "5d-nuclear-reactor-6",
            "5d-steam-turbine-6",
            "5d-heat-pipe-6",
            "5d-heat-exchanger-6"
        }
    }
}

speed = speed + 0.5
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 09
genSteamTurbines {
    number = "09",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-steam-turbine-08", 1},
        {"steel-plate", 15},
        {"copper-plate", 50},
        {"advanced-circuit", 20},
        {"pipe", 20},
        {"speed-module-3", 1}
    },
    pollution = emisions,
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
            "5d-nuclear-reactor-7",
            "5d-steam-turbine-7",
            "5d-heat-pipe-7",
            "5d-heat-exchanger-7"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 10
genSteamTurbines {
    number = "10",
    subgroup = "nuclear-turbine",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-steam-turbine-09", 1},
        {"steel-plate", 15},
        {"copper-plate", 50},
        {"advanced-circuit", 20},
        {"pipe", 20},
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
            "5d-nuclear-reactor-8",
            "5d-steam-turbine-8",
            "5d-heat-pipe-8",
            "5d-heat-exchanger-8"
        }
    }
}
