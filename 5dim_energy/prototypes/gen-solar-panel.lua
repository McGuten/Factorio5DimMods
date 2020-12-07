require("__5dim_core__.lib.energy.generation-solar-panel")

local speed = 60
local modules = 2
local energy = 90
local emisions = 10
local techCount = 450

-- Electric furnace 01
genSolarPanels {
    number = "01",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"steel-plate", 5},
        {"electronic-circuit", 15},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-solar-panel-02",
    tech = nil
}

speed = speed + 30
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 02
genSolarPanels {
    number = "02",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"solar-panel", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 15},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-solar-panel-03",
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "solar-energy"
        }
    }
}

speed = speed + 30
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 03
genSolarPanels {
    number = "03",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-solar-panel-02", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 15},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-solar-panel-04",
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

speed = speed + 30
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 04
genSolarPanels {
    number = "04",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-solar-panel-03", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 15},
        {"copper-plate", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-solar-panel-05",
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

speed = speed + 30
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 05
genSolarPanels {
    number = "05",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-solar-panel-04", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 15},
        {"copper-plate", 5},
        {"productivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-solar-panel-06",
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

speed = speed + 30
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 06
genSolarPanels {
    number = "06",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-solar-panel-05", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 15},
        {"copper-plate", 5},
        {"effectivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-solar-panel-07",
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

speed = speed + 30
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 07
genSolarPanels {
    number = "07",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-solar-panel-06", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 15},
        {"copper-plate", 5},
        {"productivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-solar-panel-08",
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

speed = speed + 30
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 08
genSolarPanels {
    number = "08",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-solar-panel-07", 1},
        {"steel-plate", 5},
        {"processing-unit", 2},
        {"low-density-structure", 2},
        {"effectivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-solar-panel-09",
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

speed = speed + 30
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 09
genSolarPanels {
    number = "09",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-solar-panel-08", 1},
        {"steel-plate", 10},
        {"processing-unit", 5},
        {"low-density-structure", 2},
        {"productivity-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-solar-panel-10",
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

speed = speed + 30
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 10
genSolarPanels {
    number = "10",
    subgroup = "energy-solar-panel",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-solar-panel-09", 1},
        {"steel-plate", 15},
        {"processing-unit", 8},
        {"low-density-structure", 2},
        {"productivity-module-3", 2}
    },
    pollution = emisions,
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
