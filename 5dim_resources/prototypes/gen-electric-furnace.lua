require("__5dim_core__.lib.resources.generation-electric-furnace")

local crafting = 2
local modules = 2
local energy = 180
local emisions = 1
local techCount = 250

-- Electric furnace 01
genElectricFurnaces {
    number = "01",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"steel-plate", 10},
        {"advanced-circuit", 3},
        {"stone-brick", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-furnace-02",
    tech = nil
}

crafting = crafting + 1
modules = modules + 1
energy = energy + 90
emisions = emisions + 0.75

-- Electric furnace 02
genElectricFurnaces {
    number = "02",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"electric-furnace", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"stone-brick", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-furnace-03",
    tech = {
        number = 3,
        count = techCount * 1,
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

crafting = crafting + 1
energy = energy + 90
emisions = emisions + 0.75

-- Electric furnace 03
genElectricFurnaces {
    number = "03",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-electric-furnace-02", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"concrete", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-furnace-04",
    tech = {
        number = 4,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "advanced-material-processing-3",
            "production-science-pack"
        }
    }
}

crafting = crafting + 1
modules = modules + 1
energy = energy + 90
emisions = emisions + 0.75

-- Electric furnace 04
genElectricFurnaces {
    number = "04",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-electric-furnace-03", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"concrete", 5}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-furnace-05",
    tech = {
        number = 5,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "advanced-material-processing-4"
        }
    }
}

crafting = crafting + 1
energy = energy + 90
emisions = emisions + 0.75

-- Electric furnace 05
genElectricFurnaces {
    number = "05",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-electric-furnace-04", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"concrete", 5},
        {"speed-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-furnace-06",
    tech = {
        number = 6,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "advanced-material-processing-5"
        }
    }
}

crafting = crafting + 1
modules = modules + 1
energy = energy + 90
emisions = emisions + 0.75

-- Electric furnace 06
genElectricFurnaces {
    number = "06",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-electric-furnace-05", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"refined-concrete", 5},
        {"productivity-module", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-furnace-07",
    tech = {
        number = 7,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "advanced-material-processing-6"
        }
    }
}

crafting = crafting + 1
energy = energy + 90
emisions = emisions + 0.75

-- Electric furnace 07
genElectricFurnaces {
    number = "07",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-electric-furnace-06", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"refined-concrete", 5},
        {"speed-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-furnace-08",
    tech = {
        number = 8,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "advanced-material-processing-7"
        }
    }
}

crafting = crafting + 1
modules = modules + 1
energy = energy + 90
emisions = emisions + 0.75

-- Electric furnace 08
genElectricFurnaces {
    number = "08",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-electric-furnace-07", 1},
        {"steel-plate", 5},
        {"low-density-structure", 1},
        {"refined-concrete", 5},
        {"productivity-module-2", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-furnace-09",
    tech = {
        number = 9,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "advanced-material-processing-8",
            "utility-science-pack"
        }
    }
}

crafting = crafting + 1
energy = energy + 90
emisions = emisions + 0.75

-- Electric furnace 09
genElectricFurnaces {
    number = "09",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-electric-furnace-08", 1},
        {"steel-plate", 5},
        {"low-density-structure", 1},
        {"refined-concrete", 5},
        {"speed-module-3", 1}
    },
    pollution = emisions,
    nextUpdate = "5d-electric-furnace-10",
    tech = {
        number = 10,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "advanced-material-processing-9"
        }
    }
}

crafting = crafting + 1
modules = modules + 1
energy = energy + 90
emisions = emisions + 0.75

-- Electric furnace 10
genElectricFurnaces {
    number = "10",
    subgroup = "furnace-electric",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-electric-furnace-09", 1},
        {"steel-plate", 5},
        {"low-density-structure", 3},
        {"refined-concrete", 5},
        {"productivity-module-3", 1}
    },
    pollution = emisions,
    tech = {
        number = 11,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "advanced-material-processing-10"
        }
    }
}
