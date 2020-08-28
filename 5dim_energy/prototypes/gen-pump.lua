require("__5dim_core__.lib.energy.generation-pump")

speed = 200
modules = 2
energy = 29
emisions = 10

-- Electric furnace 01
genPumps {
    number = "01",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"engine-unit", 1},
        {"steel-plate", 1},
        {"pipe", 1}
    },
    pollution = emisions,
    tech = nil
}

speed = speed + 50
modules = modules + 1
energy = energy + 15
emisions = emisions + 5

-- Electric furnace 02
genPumps {
    number = "02",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"accumulator", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 5},
        {"copper-plate", 3}
    },
    pollution = emisions,
    tech = {
        number = 2,
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

speed = speed + 50
energy = energy + 15
emisions = emisions + 5

-- Electric furnace 03
genPumps {
    number = "03",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-accumulator-02", 1},
        {"iron-gear-wheel", 3},
        {"steel-plate", 10},
        {"productivity-module", 1}
    },
    pollution = emisions,
    tech = {
        number = 3,
        count = 750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "solar-energy-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 50
modules = modules + 1
energy = energy + 15
emisions = emisions + 5

-- Electric furnace 04
genPumps {
    number = "04",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-accumulator-03", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 2},
        {"effectivity-module-2", 1}
    },
    pollution = emisions,
    tech = {
        number = 4,
        count = 1000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "solar-energy-3"
        }
    }
}

speed = speed + 50
energy = energy + 15
emisions = emisions + 5

-- Electric furnace 05
genPumps {
    number = "05",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-accumulator-04", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 2},
        {"productivity-module-2", 1}
    },
    pollution = emisions,
    tech = {
        number = 5,
        count = 1250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "solar-energy-4",
            "production-science-pack"
        }
    }
}

speed = speed + 50
modules = modules + 1
energy = energy + 15
emisions = emisions + 5

-- Electric furnace 06
genPumps {
    number = "06",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-accumulator-05", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 3},
        {"effectivity-module-3", 1}
    },
    pollution = emisions,
    tech = {
        number = 6,
        count = 1500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "solar-energy-5"
        }
    }
}

speed = speed + 50
energy = energy + 15
emisions = emisions + 5

-- Electric furnace 07
genPumps {
    number = "07",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-accumulator-06", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 3},
        {"productivity-module-3", 1}
    },
    pollution = emisions,
    tech = {
        number = 7,
        count = 1750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "solar-energy-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 50
modules = modules + 1
energy = energy + 15
emisions = emisions + 5

-- Electric furnace 08
genPumps {
    number = "08",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-accumulator-07", 1},
        {"advanced-circuit", 2},
        {"low-density-structure", 1},
        {"effectivity-module-3", 1}
    },
    pollution = emisions,
    tech = {
        number = 8,
        count = 2000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "solar-energy-7"
        }
    }
}

speed = speed + 50
energy = energy + 15
emisions = emisions + 5

-- Electric furnace 09
genPumps {
    number = "09",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-accumulator-08", 1},
        {"advanced-circuit", 2},
        {"low-density-structure", 1},
        {"productivity-module-3", 1}
    },
    pollution = emisions,
    tech = {
        number = 9,
        count = 2250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "solar-energy-8"
        }
    }
}

speed = speed + 50
modules = modules + 1
energy = energy + 15
emisions = emisions + 5

-- Electric furnace 10
genPumps {
    number = "10",
    subgroup = "energy-small-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-accumulator-09", 1},
        {"steel-plate", 30},
        {"low-density-structure", 5},
        {"processing-unit", 1},
        {"productivity-module-3", 1}
    },
    pollution = emisions,
    tech = {
        number = 10,
        count = 2500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "solar-energy-9"
        }
    }
}
