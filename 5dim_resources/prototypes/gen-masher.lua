require("__5dim_core__.lib.resources.generation-masher")

crafting = 2
modules = 2
energy = 360

-- Electric furnace 01
genMasher {
    number = "01",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "a",
    ingredients = {
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
    tech = {
        number = 1,
        count = 200,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "advanced-material-processing-2"
        }
    }
}

crafting = crafting + 0.5
modules = modules + 1
energy = energy + 180

-- Electric furnace 02
genMasher {
    number = "02",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"electric-furnace", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
    tech = {
        number = 2,
        count = 200,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-masher-1"
        }
    }
}

crafting = crafting + 0.5
energy = energy + 180

-- Electric furnace 03
genMasher {
    number = "03",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-electric-furnace-02", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
    tech = {
        number = 3,
        count = 300,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-masher-2",
            "production-science-pack"
        }
    }
}

crafting = crafting + 0.5
modules = modules + 1
energy = energy + 180

-- Electric furnace 04
genMasher {
    number = "04",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-electric-furnace-03", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
    tech = {
        number = 4,
        count = 400,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-masher-3"
        }
    }
}

crafting = crafting + 0.5
energy = energy + 180

-- Electric furnace 05
genMasher {
    number = "05",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-electric-furnace-04", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
    tech = {
        number = 5,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-masher-4"
        }
    }
}

crafting = crafting + 0.5
modules = modules + 1
energy = energy + 180

-- Electric furnace 06
genMasher {
    number = "06",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-electric-furnace-05", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
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
            "5d-masher-5"
        }
    }
}

crafting = crafting + 0.5
energy = energy + 180

-- Electric furnace 07
genMasher {
    number = "07",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-electric-furnace-06", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
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
            "5d-masher-6"
        }
    }
}

crafting = crafting + 0.5
modules = modules + 1
energy = energy + 180

-- Electric furnace 08
genMasher {
    number = "08",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-electric-furnace-07", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
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
            "5d-masher-7",
            "utility-science-pack"
        }
    }
}

crafting = crafting + 0.5
energy = energy + 180

-- Electric furnace 09
genMasher {
    number = "09",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-electric-furnace-08", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
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
            "5d-masher-8"
        }
    }
}

crafting = crafting + 0.5
modules = modules + 1
energy = energy + 180

-- Electric furnace 10
genMasher {
    number = "10",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-electric-furnace-09", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"stone-brick", 10}
    },
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
            "5d-masher-9"
        }
    }
}
