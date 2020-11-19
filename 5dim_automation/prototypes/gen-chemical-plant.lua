require("__5dim_core__.lib.automatization.generation-chemical-plant")

local speed = 1
local modules = 3
local energy = 210
local emisions = 4
local techCount = 200

-- Electric furnace 01
genChemicalPlants {
    number = "01",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"steel-plate", 5},
        {"iron-gear-wheel", 5},
        {"electronic-circuit", 5},
        {"pipe", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-chemical-plant-02",
    tech = nil
}

speed = speed + 1
modules = modules + 1
energy = energy + 100
emisions = emisions + 2

-- Electric furnace 02
genChemicalPlants {
    number = "02",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"chemical-plant", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 5},
        {"electronic-circuit", 5},
        {"pipe", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-chemical-plant-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "oil-processing",
            "logistic-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 100
emisions = emisions + 2

-- Electric furnace 03
genChemicalPlants {
    number = "03",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-chemical-plant-02", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 5},
        {"electronic-circuit", 5},
        {"pipe", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-chemical-plant-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-chemical-plant-1"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 100
emisions = emisions + 2

-- Electric furnace 04
genChemicalPlants {
    number = "04",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-chemical-plant-03", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 5},
        {"advanced-circuit", 5},
        {"pipe", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-chemical-plant-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-chemical-plant-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 100
emisions = emisions + 2

-- Electric furnace 05
genChemicalPlants {
    number = "05",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-chemical-plant-04", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 5},
        {"advanced-circuit", 5},
        {"pipe", 5},
        {"speed-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-chemical-plant-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-chemical-plant-3"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 100
emisions = emisions + 2

-- Electric furnace 06
genChemicalPlants {
    number = "06",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-chemical-plant-05", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 5},
        {"productivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-chemical-plant-07",
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
            "5d-chemical-plant-4",
            "production-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 100
emisions = emisions + 2

-- Electric furnace 07
genChemicalPlants {
    number = "07",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-chemical-plant-06", 1},
        {"steel-plate", 5},
        {"low-density-structure", 2},
        {"advanced-circuit", 5},
        {"pipe", 5},
        {"speed-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-chemical-plant-08",
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
            "5d-chemical-plant-5"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 100
emisions = emisions + 2

-- Electric furnace 08
genChemicalPlants {
    number = "08",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-chemical-plant-07", 1},
        {"steel-plate", 5},
        {"low-density-structure", 2},
        {"advanced-circuit", 5},
        {"pipe", 5},
        {"productivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-chemical-plant-09",
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
            "5d-chemical-plant-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 100
emisions = emisions + 2

-- Electric furnace 09
genChemicalPlants {
    number = "09",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-chemical-plant-08", 1},
        {"steel-plate", 5},
        {"low-density-structure", 2},
        {"processing-unit", 3},
        {"pipe", 5},
        {"speed-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-chemical-plant-10",
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
            "5d-chemical-plant-7"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 100
emisions = emisions + 2

-- Electric furnace 10
genChemicalPlants {
    number = "10",
    subgroup = "liquid-plant",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-chemical-plant-09", 1},
        {"steel-plate", 5},
        {"low-density-structure", 2},
        {"processing-unit", 3},
        {"pipe", 5},
        {"productivity-module-3", 1}
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
            "5d-chemical-plant-8"
        }
    }
}
