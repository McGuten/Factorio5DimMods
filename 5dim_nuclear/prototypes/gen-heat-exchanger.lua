require("__5dim_core__.lib.nuclear.generation-heat-exchanger")

local speed = 2
local modules = 2
local energy = 10
local emisions = 1000

-- Electric furnace 01
genHeatExchangers {
    number = "01",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-heat-exchanger-02",
    tech = nil
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 02
genHeatExchangers {
    number = "02",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"heat-exchanger", 1},
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-heat-exchanger-03",
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
            "utility-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 03
genHeatExchangers {
    number = "03",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-heat-exchanger-02", 1},
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 20}
    },
    pollution = emisions,
    nextUpdate = "5d-heat-exchanger-04",
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
genHeatExchangers {
    number = "04",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-heat-exchanger-03", 1},
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 10},
        {"low-density-structure", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-heat-exchanger-05",
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
genHeatExchangers {
    number = "05",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-heat-exchanger-04", 1},
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 10},
        {"low-density-structure", 1},
        {"effectivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-heat-exchanger-06",
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
genHeatExchangers {
    number = "06",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-heat-exchanger-05", 1},
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 10},
        {"low-density-structure", 1},
        {"effectivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-heat-exchanger-07",
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
genHeatExchangers {
    number = "07",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-heat-exchanger-06", 1},
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 10},
        {"low-density-structure", 1},
        {"effectivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-heat-exchanger-08",
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
genHeatExchangers {
    number = "08",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-heat-exchanger-07", 1},
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 10},
        {"low-density-structure", 1},
        {"effectivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-heat-exchanger-09",
    tech = {
        number = 7,
        count = 2000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
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
genHeatExchangers {
    number = "09",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-heat-exchanger-08", 1},
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 10},
        {"low-density-structure", 1},
        {"effectivity-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-heat-exchanger-10",
    tech = {
        number = 8,
        count = 2250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
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
genHeatExchangers {
    number = "10",
    subgroup = "nuclear-heat",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-heat-exchanger-09", 1},
        {"steel-plate", 10},
        {"copper-plate", 100},
        {"pipe", 10},
        {"low-density-structure", 1},
        {"effectivity-module-3", 1}
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
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-nuclear-reactor-8",
            "5d-steam-turbine-8",
            "5d-heat-pipe-8",
            "5d-heat-exchanger-8"
        }
    }
}
