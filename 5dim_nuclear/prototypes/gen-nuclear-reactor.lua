require("__5dim_core__.lib.nuclear.generation-nuclear-reactor")

local speed = 1
local modules = 2
local energy = 40
local emisions = 1
local techCount = 500

-- Electric furnace 01
genNuclearReactors {
    number = "01",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"concrete", 500},
        {"steel-plate", 500},
        {"advanced-circuit", 500},
        {"copper-plate", 500}
    },
    pollution = emisions,
    nextUpdate = "5d-nuclear-reactor-02",
    tech = nil
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 02
genNuclearReactors {
    number = "02",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"nuclear-reactor", 1},
        {"concrete", 400},
        {"steel-plate", 400},
        {"advanced-circuit", 400},
        {"copper-plate", 400},
        {"iron-gear-wheel", 100}
    },
    pollution = emisions,
    nextUpdate = "5d-nuclear-reactor-03",
    tech = {
        number = 1,
        count = techCount * 1,
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
genNuclearReactors {
    number = "03",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-nuclear-reactor-02", 1},
        {"refined-concrete", 400},
        {"steel-plate", 400},
        {"processing-unit", 100},
        {"copper-plate", 400},
        {"iron-gear-wheel", 100}
    },
    pollution = emisions,
    nextUpdate = "5d-nuclear-reactor-04",
    tech = {
        number = 2,
        count = techCount * 2,
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
genNuclearReactors {
    number = "04",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-nuclear-reactor-03", 1},
        {"refined-concrete", 400},
        {"steel-plate", 400},
        {"processing-unit", 100},
        {"copper-plate", 400},
        {"iron-gear-wheel", 100}
    },
    pollution = emisions,
    nextUpdate = "5d-nuclear-reactor-05",
    tech = {
        number = 3,
        count = techCount * 3,
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
genNuclearReactors {
    number = "05",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-nuclear-reactor-04", 1},
        {"refined-concrete", 400},
        {"steel-plate", 400},
        {"processing-unit", 100},
        {"copper-plate", 400},
        {"iron-gear-wheel", 100},
        {"speed-module", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-nuclear-reactor-06",
    tech = {
        number = 4,
        count = techCount * 4,
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
genNuclearReactors {
    number = "06",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-nuclear-reactor-05", 1},
        {"refined-concrete", 400},
        {"steel-plate", 400},
        {"processing-unit", 100},
        {"copper-plate", 400},
        {"iron-gear-wheel", 100},
        {"productivity-module", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-nuclear-reactor-07",
    tech = {
        number = 5,
        count = techCount * 5,
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
genNuclearReactors {
    number = "07",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-nuclear-reactor-06", 1},
        {"refined-concrete", 400},
        {"steel-plate", 400},
        {"processing-unit", 100},
        {"copper-plate", 400},
        {"low-density-structure", 50},
        {"speed-module-2", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-nuclear-reactor-08",
    tech = {
        number = 6,
        count = techCount * 6,
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
genNuclearReactors {
    number = "08",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-nuclear-reactor-07", 1},
        {"refined-concrete", 400},
        {"steel-plate", 400},
        {"processing-unit", 100},
        {"copper-plate", 400},
        {"low-density-structure", 50},
        {"productivity-module-2", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-nuclear-reactor-09",
    tech = {
        number = 7,
        count = techCount * 7,
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
genNuclearReactors {
    number = "09",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-nuclear-reactor-08", 1},
        {"refined-concrete", 400},
        {"steel-plate", 400},
        {"processing-unit", 100},
        {"copper-plate", 400},
        {"low-density-structure", 50},
        {"speed-module-3", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-nuclear-reactor-10",
    tech = {
        number = 8,
        count = techCount * 8,
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
genNuclearReactors {
    number = "10",
    subgroup = "nuclear-reactor",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-nuclear-reactor-09", 1},
        {"refined-concrete", 400},
        {"steel-plate", 400},
        {"processing-unit", 100},
        {"copper-plate", 400},
        {"low-density-structure", 50},
        {"productivity-module-3", 5},
            {"space-science-pack", 1}
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
            "5d-nuclear-reactor-8",
            "5d-steam-turbine-8",
            "5d-heat-pipe-8",
            "5d-heat-exchanger-8"
        }
    }
}
