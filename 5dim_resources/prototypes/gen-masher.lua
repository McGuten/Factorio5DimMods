require("__5dim_core__.lib.resources.generation-masher")

local crafting = 2
local modules = 2
local energy = 360
local emisions = 1

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
        {"electronic-circuit", 7},
        {"iron-gear-wheel", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-masher-02",
    tech = {
        number = 1,
        count = 100,
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
emisions = emisions + 0.75

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
        {"5d-masher-01", 1},
        {"iron-plate", 10},
        {"electronic-circuit", 5},
        {"iron-gear-wheel", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-masher-03",
    tech = {
        number = 2,
        count = 200,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-masher-1",
            "advanced-material-processing-3"
        }
    }
}

crafting = crafting + 0.5
energy = energy + 180
emisions = emisions + 0.75

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
        {"5d-masher-02", 1},
        {"iron-plate", 10},
        {"advanced-circuit", 3},
        {"iron-gear-wheel", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-masher-04",
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
            "production-science-pack",
            "advanced-material-processing-4"
        }
    }
}

crafting = crafting + 0.5
modules = modules + 1
energy = energy + 180
emisions = emisions + 0.75

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
        {"5d-masher-03", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 3},
        {"iron-gear-wheel", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-masher-05",
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
            "5d-masher-3",
            "advanced-material-processing-5"
        }
    }
}

crafting = crafting + 0.5
energy = energy + 180
emisions = emisions + 0.75

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
        {"5d-masher-04", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 3},
        {"iron-gear-wheel", 10},
        {"speed-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-masher-06",
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
            "5d-masher-4",
            "advanced-material-processing-6"
        }
    }
}

crafting = crafting + 0.5
modules = modules + 1
energy = energy + 180
emisions = emisions + 0.75

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
        {"5d-masher-05", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 3},
        {"iron-gear-wheel", 10},
        {"productivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-masher-07",
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
            "5d-masher-5",
            "advanced-material-processing-7"
        }
    }
}

crafting = crafting + 0.5
energy = energy + 180
emisions = emisions + 0.75

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
        {"5d-masher-06", 1},
        {"steel-plate", 10},
        {"processing-unit", 5},
        {"iron-gear-wheel", 10},
        {"speed-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-masher-08",
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
            "5d-masher-6",
            "advanced-material-processing-8"
        }
    }
}

crafting = crafting + 0.5
modules = modules + 1
energy = energy + 180
emisions = emisions + 0.75

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
        {"5d-masher-07", 1},
        {"steel-plate", 10},
        {"processing-unit", 5},
        {"iron-gear-wheel", 10},
        {"productivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-masher-09",
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
            "utility-science-pack",
            "advanced-material-processing-9"
        }
    }
}

crafting = crafting + 0.5
energy = energy + 180
emisions = emisions + 0.75

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
        {"5d-masher-08", 1},
        {"steel-plate", 10},
        {"low-density-structure", 2},
        {"iron-gear-wheel", 10},
        {"speed-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-masher-10",
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
            "5d-masher-8",
            "advanced-material-processing-10"
        }
    }
}

crafting = crafting + 0.5
modules = modules + 1
energy = energy + 180
emisions = emisions + 0.75

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
        {"5d-masher-09", 1},
        {"steel-plate", 10},
        {"low-density-structure", 2},
        {"iron-gear-wheel", 10},
        {"productivity-module-3", 1}
    },
    pollution = emisions,
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
            "5d-masher-9",
            "advanced-material-processing-11"
        }
    }
}
