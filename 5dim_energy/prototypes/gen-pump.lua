require("__5dim_core__.lib.energy.generation-pump")

local speed = 200
local modules = 2
local energy = 29
local emisions = 10
local techCount = 100

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
    nextUpdate = "",
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
        {"pump", 1},
        {"engine-unit", 1},
        {"steel-plate", 5},
        {"pipe", 2}
    },
    pollution = emisions,
    nextUpdate = "",
    tech = {
        number = 2,
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
        {"5d-pump-02", 1},
        {"engine-unit", 1},
        {"steel-plate", 2},
        {"iron-gear-wheel", 3},
        {"pipe", 1}
    },
    pollution = emisions,
    nextUpdate = "",
    tech = {
        number = 3,
        count = techCount * 2,
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
        {"5d-pump-03", 1},
        {"engine-unit", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 2},
        {"pipe", 1}
    },
    pollution = emisions,
    nextUpdate = "",
    tech = {
        number = 4,
        count = techCount * 3,
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
        {"5d-pump-04", 1},
        {"engine-unit", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 2},
        {"pipe", 1}
    },
    pollution = emisions,
    nextUpdate = "",
    tech = {
        number = 5,
        count = techCount * 4,
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
        {"5d-pump-05", 1},
        {"electric-engine-unit", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 2},
        {"pipe", 1}
    },
    pollution = emisions,
    nextUpdate = "",
    tech = {
        number = 6,
        count = techCount * 5,
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
        {"5d-pump-06", 1},
        {"electric-engine-unit", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 2},
        {"pipe", 1}
    },
    pollution = emisions,
    nextUpdate = "",
    tech = {
        number = 7,
        count = techCount * 6,
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
        {"5d-pump-07", 1},
        {"electric-engine-unit", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 2},
        {"pipe", 1}
    },
    pollution = emisions,
    nextUpdate = "",
    tech = {
        number = 8,
        count = techCount * 7,
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
        {"5d-pump-08", 1},
        {"electric-engine-unit", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 2},
        {"pipe", 1}
    },
    pollution = emisions,
    nextUpdate = "",
    tech = {
        number = 9,
        count = techCount * 8,
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
        {"5d-pump-09", 1},
        {"electric-engine-unit", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 2},
        {"low-density-structure", 1},
        {"pipe", 1}
    },
    pollution = emisions,
    nextUpdate = "",
    tech = {
        number = 10,
        count = techCount * 9,
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
