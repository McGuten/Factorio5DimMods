require("__5dim_core__.lib.energy.generation-steam-engine")

local speed = 1
local modules = 2
local energy = 0.5
local emisions = 30
local techCount = 500

-- Electric furnace 01
genSteamEngines {
    number = "01",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"iron-gear-wheel", 8},
        {"pipe", 5},
        {"iron-plate", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-steam-engine-02",
    tech = nil
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.25
emisions = emisions + 15

-- Electric furnace 02
genSteamEngines {
    number = "02",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"steam-engine", 1},
        {"iron-gear-wheel", 8},
        {"electronic-circuit", 5},
        {"pipe", 5},
        {"iron-plate", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-steam-engine-03",
    tech = {
        number = 1,
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

speed = speed + 0.5
energy = energy + 0.25
emisions = emisions + 15

-- Electric furnace 03
genSteamEngines {
    number = "03",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-steam-engine-02", 1},
        {"iron-gear-wheel", 8},
        {"electronic-circuit", 5},
        {"pipe", 5},
        {"steel-plate", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-steam-engine-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-boiler-1",
            "5d-steam-engine-1"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.25
emisions = emisions + 15

-- Electric furnace 04
genSteamEngines {
    number = "04",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-steam-engine-03", 1},
        {"iron-gear-wheel", 8},
        {"electronic-circuit", 5},
        {"pipe", 5},
        {"steel-plate", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-steam-engine-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-boiler-2",
            "5d-steam-engine-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 0.25
emisions = emisions + 15

-- Electric furnace 05
genSteamEngines {
    number = "05",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-steam-engine-04", 1},
        {"iron-gear-wheel", 8},
        {"advanced-circuit", 2},
        {"pipe", 5},
        {"steel-plate", 10},
        {"effectivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-steam-engine-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-boiler-3",
            "5d-steam-engine-3"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.25
emisions = emisions + 15

-- Electric furnace 06
genSteamEngines {
    number = "06",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-steam-engine-05", 1},
        {"iron-gear-wheel", 8},
        {"advanced-circuit", 4},
        {"pipe", 5},
        {"steel-plate", 10},
        {"effectivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-steam-engine-07",
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-boiler-4",
            "5d-steam-engine-4",
            "production-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 0.25
emisions = emisions + 15

-- Electric furnace 07
genSteamEngines {
    number = "07",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-steam-engine-06", 1},
        {"iron-gear-wheel", 8},
        {"advanced-circuit", 5},
        {"pipe", 5},
        {"steel-plate", 10},
        {"effectivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-steam-engine-08",
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-boiler-5",
            "5d-steam-engine-5"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.25
emisions = emisions + 15

-- Electric furnace 08
genSteamEngines {
    number = "08",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-steam-engine-07", 1},
        {"iron-gear-wheel", 8},
        {"processing-unit", 5},
        {"pipe", 5},
        {"low-density-structure", 10},
        {"effectivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-steam-engine-09",
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-boiler-6",
            "5d-steam-engine-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 0.25
emisions = emisions + 15

-- Electric furnace 09
genSteamEngines {
    number = "09",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-steam-engine-08", 1},
        {"iron-gear-wheel", 8},
        {"processing-unit", 5},
        {"pipe", 5},
        {"low-density-structure", 10},
        {"effectivity-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-steam-engine-10",
    tech = {
        number = 8,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-boiler-7",
            "5d-steam-engine-7"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 0.25
emisions = emisions + 15

-- Electric furnace 10
genSteamEngines {
    number = "10",
    subgroup = "energy-engine-1",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-steam-engine-09", 1},
        {"iron-gear-wheel", 8},
        {"processing-unit", 5},
        {"pipe", 5},
        {"low-density-structure", 10},
        {"effectivity-module-3", 1}
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
            "5d-boiler-8",
            "5d-steam-engine-8"
        }
    }
}
