require("__5dim_core__.lib.energy.generation-substation")

local speed = 18
local modules = 2
local energy = 9
local emisions = 30

-- Electric furnace 01
genSubstations {
    number = "01",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-substation-02",
    tech = nil
}

speed = speed + 4
modules = modules + 1
energy = energy + 2
emisions = emisions + 15

-- Electric furnace 02
genSubstations {
    number = "02",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"substation", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-substation-03",
    tech = {
        number = 1,
        count = 200,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-distribution-2"
        }
    }
}

speed = speed + 4
energy = energy + 2
emisions = emisions + 15

-- Electric furnace 03
genSubstations {
    number = "03",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-substation-02", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-substation-04",
    tech = {
        number = 2,
        count = 750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-substation-1",
            "5d-medium-electric-pole-1",
            "5d-big-electric-pole-1"
        }
    }
}

speed = speed + 4
modules = modules + 1
energy = energy + 2
emisions = emisions + 15

-- Electric furnace 04
genSubstations {
    number = "04",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-substation-03", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-substation-05",
    tech = {
        number = 3,
        count = 1000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-substation-2",
            "5d-medium-electric-pole-2",
            "5d-big-electric-pole-2"
        }
    }
}

speed = speed + 4
energy = energy + 2
emisions = emisions + 15

-- Electric furnace 05
genSubstations {
    number = "05",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-substation-04", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-substation-06",
    tech = {
        number = 4,
        count = 1250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-substation-3",
            "5d-medium-electric-pole-3",
            "5d-big-electric-pole-3",
            "production-science-pack"
        }
    }
}

speed = speed + 4
modules = modules + 1
energy = energy + 2
emisions = emisions + 15

-- Electric furnace 06
genSubstations {
    number = "06",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-substation-05", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-substation-07",
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
            "5d-substation-4",
            "5d-medium-electric-pole-4",
            "5d-big-electric-pole-4"
        }
    }
}

speed = speed + 4
energy = energy + 2
emisions = emisions + 15

-- Electric furnace 07
genSubstations {
    number = "07",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-substation-06", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-substation-08",
    tech = {
        number = 6,
        count = 1750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-substation-5",
            "5d-medium-electric-pole-5",
            "5d-big-electric-pole-5",
            "utility-science-pack"
        }
    }
}

speed = speed + 4
modules = modules + 1
energy = energy + 2
emisions = emisions + 15

-- Electric furnace 08
genSubstations {
    number = "08",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-substation-07", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-substation-09",
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
            "5d-substation-6",
            "5d-medium-electric-pole-6",
            "5d-big-electric-pole-6"
        }
    }
}

speed = speed + 4
energy = energy + 2
emisions = emisions + 15

-- Electric furnace 09
genSubstations {
    number = "09",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-substation-08", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-substation-10",
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
            "5d-substation-7",
            "5d-medium-electric-pole-7",
            "5d-big-electric-pole-7"
        }
    }
}

speed = speed + 4
modules = modules + 1
energy = energy + 2
emisions = emisions + 15

-- Electric furnace 10
genSubstations {
    number = "10",
    subgroup = "energy-substation",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-substation-09", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"copper-plate", 5}
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
            "5d-substation-8",
            "5d-medium-electric-pole-8",
            "5d-big-electric-pole-8"
        }
    }
}
