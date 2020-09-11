require("__5dim_core__.lib.energy.generation-big-pole")

local speed = 30
local modules = 2
local energy = 2
local emisions = 30

-- Electric furnace 01
genBigPoles {
    number = "01",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    tech = nil
}

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 02
genBigPoles {
    number = "02",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"big-electric-pole", 1},
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
    tech = {
        number = 1,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-distribution-1"
        }
    }
}

speed = speed + 3
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 03
genBigPoles {
    number = "03",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-big-electric-pole-02", 1},
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
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
            "5d-big-electric-pole-1",
            "chemical-science-pack"
        }
    }
}

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 04
genBigPoles {
    number = "04",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-big-electric-pole-03", 1},
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
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

speed = speed + 3
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 05
genBigPoles {
    number = "05",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-big-electric-pole-04", 1},
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
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

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 06
genBigPoles {
    number = "06",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-big-electric-pole-05", 1},
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"copper-plate", 5}
    },
    pollution = emisions,
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

speed = speed + 3
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 07
genBigPoles {
    number = "07",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-big-electric-pole-06", 1},
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"copper-plate", 5}
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

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 08
genBigPoles {
    number = "08",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-big-electric-pole-07", 1},
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"low-density-structure", 1}
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
            "5d-substation-6",
            "5d-medium-electric-pole-6",
            "5d-big-electric-pole-6"
        }
    }
}

speed = speed + 3
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 09
genBigPoles {
    number = "09",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-big-electric-pole-08", 1},
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"low-density-structure", 1}
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
            "5d-substation-7",
            "5d-medium-electric-pole-7",
            "5d-big-electric-pole-7"
        }
    }
}

speed = speed + 3
modules = modules + 1
energy = energy + 0.5
emisions = emisions + 15

-- Electric furnace 10
genBigPoles {
    number = "10",
    subgroup = "energy-big",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-big-electric-pole-09", 1},
        {"iron-stick", 8},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"low-density-structure", 1}
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
