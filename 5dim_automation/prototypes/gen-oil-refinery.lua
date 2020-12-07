require("__5dim_core__.lib.automation.generation-oil-refinery")

local speed = 1
local modules = 3
local energy = 420
local emisions = 6
local techCount = 200

-- Electric furnace 01
genChemicalPlants {
    number = "01",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"steel-plate", 15},
        {"iron-gear-wheel", 10},
        {"stone-brick", 10},
        {"electronic-circuit", 10},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-oil-refinery-02",
    tech = nil
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 02
genChemicalPlants {
    number = "02",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"oil-refinery", 1},
        {"steel-plate", 15},
        {"iron-gear-wheel", 10},
        {"concrete", 10},
        {"electronic-circuit", 10},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-oil-refinery-03",
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
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 03
genChemicalPlants {
    number = "03",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-oil-refinery-02", 1},
        {"steel-plate", 15},
        {"iron-gear-wheel", 10},
        {"concrete", 10},
        {"electronic-circuit", 10},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-oil-refinery-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-1"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 04
genChemicalPlants {
    number = "04",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-oil-refinery-03", 1},
        {"steel-plate", 15},
        {"iron-gear-wheel", 10},
        {"concrete", 10},
        {"advanced-circuit", 10},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-oil-refinery-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 05
genChemicalPlants {
    number = "05",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-oil-refinery-04", 1},
        {"steel-plate", 15},
        {"iron-gear-wheel", 10},
        {"refined-concrete", 10},
        {"advanced-circuit", 10},
        {"pipe", 10},
        {"speed-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-oil-refinery-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-3"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 06
genChemicalPlants {
    number = "06",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-oil-refinery-05", 1},
        {"steel-plate", 15},
        {"iron-gear-wheel", 10},
        {"refined-concrete", 10},
        {"advanced-circuit", 10},
        {"pipe", 10},
        {"productivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-oil-refinery-07",
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
            "5d-oil-refinery-4",
            "production-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 07
genChemicalPlants {
    number = "07",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-oil-refinery-06", 1},
        {"steel-plate", 15},
        {"low-density-structure", 3},
        {"concrete", 10},
        {"advanced-circuit", 10},
        {"pipe", 10},
        {"speed-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-oil-refinery-08",
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
            "5d-oil-refinery-5"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 08
genChemicalPlants {
    number = "08",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-oil-refinery-07", 1},
        {"steel-plate", 15},
        {"low-density-structure", 3},
        {"concrete", 10},
        {"advanced-circuit", 10},
        {"pipe", 10},
        {"productivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-oil-refinery-09",
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
            "5d-oil-refinery-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 09
genChemicalPlants {
    number = "09",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-oil-refinery-08", 1},
        {"steel-plate", 15},
        {"low-density-structure", 3},
        {"concrete", 10},
        {"processing-unit", 2},
        {"pipe", 10},
        {"speed-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-oil-refinery-10",
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
            "5d-oil-refinery-7"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 10
genChemicalPlants {
    number = "10",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-oil-refinery-09", 1},
        {"steel-plate", 15},
        {"low-density-structure", 3},
        {"concrete", 10},
        {"processing-unit", 2},
        {"pipe", 10},
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
            "5d-oil-refinery-8"
        }
    }
}
