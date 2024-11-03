require("__5dim_core__.lib.energy.generation-accumulator")

local speed = 5
local modules = 2
local energy = 300
local emisions = 10
local techCount = 450

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
        {type = "item", name = "iron-plate", amount = 2},
        {type = "item", name = "battery", amount = 5}
    },
    pollution = { pollution = emisions },
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
        {type = "item", name = "accumulator", amount = 1},
        {type = "item", name = "electronic-circuit", amount = 2},
        {type = "item", name = "iron-plate", amount = 2},
        {type = "item", name = "battery", amount = 5}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-accumulator-03",
    tech = {
        number = 2,
        count = techCount * 1,
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
        {type = "item", name = "5d-accumulator-02", amount = 1},
        {type = "item", name = "electronic-circuit", amount = 7},
        {type = "item", name = "iron-plate", amount = 4},
        {type = "item", name = "battery", amount = 10}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-accumulator-04",
    tech = {
        number = 3,
        count = techCount * 2,
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
        {type = "item", name = "5d-accumulator-03", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 7},
        {type = "item", name = "steel-plate", amount = 7},
        {type = "item", name = "battery", amount = 15}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-accumulator-05",
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
            "electric-energy-accumulators-3",
            "production-science-pack"
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
        {type = "item", name = "5d-accumulator-04", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 2},
        {type = "item", name = "steel-plate", amount = 2},
        {type = "item", name = "battery", amount = 15},
        {type = "item", name = "efficiency-module", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-accumulator-06",
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
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
        {type = "item", name = "5d-accumulator-05", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 2},
        {type = "item", name = "steel-plate", amount = 2},
        {type = "item", name = "battery", amount = 15},
        {type = "item", name = "efficiency-module", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-accumulator-07",
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
        {type = "item", name = "5d-accumulator-06", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 2},
        {type = "item", name = "steel-plate", amount = 2},
        {type = "item", name = "battery", amount = 15},
        {type = "item", name = "efficiency-module-2", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-accumulator-08",
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
        {type = "item", name = "5d-accumulator-07", amount = 1},
        {type = "item", name = "processing-unit", amount = 2},
        {type = "item", name = "steel-plate", amount = 2},
        {type = "item", name = "battery", amount = 15},
        {type = "item", name = "efficiency-module-2", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-accumulator-09",
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
        {type = "item", name = "5d-accumulator-08", amount = 1},
        {type = "item", name = "processing-unit", amount = 2},
        {type = "item", name = "low-density-structure", amount = 1},
        {type = "item", name = "battery", amount = 15},
        {type = "item", name = "efficiency-module-3", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-accumulator-10",
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
        {type = "item", name = "5d-accumulator-09", amount = 1},
        {type = "item", name = "processing-unit", amount = 2},
        {type = "item", name = "low-density-structure", amount = 1},
        {type = "item", name = "battery", amount = 15},
        {type = "item", name = "efficiency-module-3", amount = 1}
    },
    pollution = { pollution = emisions },
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
            "electric-energy-accumulators-9"
        }
    }
}