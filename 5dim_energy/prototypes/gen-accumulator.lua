require("__5dim_core__.lib.energy.generation-accumulator")

local speed = 5
local modules = 2
local energy = 300
local emisions = 10

-- Electric furnace 01
genAccumulators {
    number = "01",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-accumulator-02",
    tech = nil
}

speed = speed + 2.5
modules = modules + 1
energy = energy + 150
emisions = emisions + 5

-- Electric furnace 02
genAccumulators {
    number = "02",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"accumulator", 1},
        {"electronic-circuit", 2},
        {"iron-plate", 2},
        {"battery", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-accumulator-03",
    tech = {
        number = 2,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators"
        }
    }
}

speed = speed + 2.5
energy = energy + 150
emisions = emisions + 5

-- Electric furnace 03
genAccumulators {
    number = "03",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-accumulator-02", 1},
        {"electronic-circuit", 7},
        {"iron-plate", 4},
        {"battery", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-accumulator-04",
    tech = {
        number = 3,
        count = 750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 2.5
modules = modules + 1
energy = energy + 150
emisions = emisions + 5

-- Electric furnace 04
genAccumulators {
    number = "04",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-accumulator-03", 1},
        {"advanced-circuit", 7},
        {"steel-plate", 7},
        {"battery", 15}
    },
    pollution = emisions,
    nextUpdate = "5d-accumulator-05",
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
            "electric-energy-accumulators-3"
        }
    }
}

speed = speed + 2.5
energy = energy + 150
emisions = emisions + 5

-- Electric furnace 05
genAccumulators {
    number = "05",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-accumulator-04", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 2},
        {"battery", 15},
        {"effectivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-accumulator-06",
    tech = {
        number = 5,
        count = 1250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-4",
            "production-science-pack"
        }
    }
}

speed = speed + 2.5
modules = modules + 1
energy = energy + 150
emisions = emisions + 5

-- Electric furnace 06
genAccumulators {
    number = "06",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-accumulator-05", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 2},
        {"battery", 15},
        {"effectivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-accumulator-07",
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
            "electric-energy-accumulators-5"
        }
    }
}

speed = speed + 2.5
energy = energy + 150
emisions = emisions + 5

-- Electric furnace 07
genAccumulators {
    number = "07",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-accumulator-06", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 2},
        {"battery", 15},
        {"effectivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-accumulator-08",
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
            "electric-energy-accumulators-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 2.5
modules = modules + 1
energy = energy + 150
emisions = emisions + 5

-- Electric furnace 08
genAccumulators {
    number = "08",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-accumulator-07", 1},
        {"processing-unit", 2},
        {"steel-plate", 2},
        {"battery", 15},
        {"effectivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-accumulator-09",
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
            "electric-energy-accumulators-7"
        }
    }
}

speed = speed + 2.5
energy = energy + 150
emisions = emisions + 5

-- Electric furnace 09
genAccumulators {
    number = "09",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-accumulator-08", 1},
        {"processing-unit", 2},
        {"low-density-structure", 1},
        {"battery", 15},
        {"effectivity-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-accumulator-10",
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
            "electric-energy-accumulators-8"
        }
    }
}

speed = speed + 2.5
modules = modules + 1
energy = energy + 150
emisions = emisions + 5

-- Electric furnace 10
genAccumulators {
    number = "10",
    subgroup = "energy-accumulator",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-accumulator-09", 1},
        {"processing-unit", 2},
        {"low-density-structure", 1},
        {"battery", 15},
        {"effectivity-module-3", 1}
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
            "electric-energy-accumulators-9"
        }
    }
}
