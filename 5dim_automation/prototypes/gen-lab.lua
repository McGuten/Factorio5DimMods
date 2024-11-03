require("__5dim_core__.lib.automation.generation-lab")

local speed = 1
local modules = 2
local energy = 60
local techCount = 200

-- Labs 01
genLabs {
    number = "01",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {type = "item", name = "electronic-circuit", amount = 10},
        {type = "item", name = "iron-gear-wheel", amount = 10},
        {type = "item", name = "transport-belt", amount = 4}
    },
    nextUpdate = "5d-lab-02",
    tech = nil
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 02
genLabs {
    number = "02",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {type = "item", name = "lab", amount = 1},
        {type = "item", name = "electronic-circuit", amount = 10},
        {type = "item", name = "iron-gear-wheel", amount = 10},
        {type = "item", name = "transport-belt", amount = 4}
    },
    nextUpdate = "5d-lab-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "engine",
            "logistic-science-pack",
        }
    }
}

speed = speed + 0.2
energy = energy + 30

-- Labs 03
genLabs {
    number = "03",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {type = "item", name = "5d-lab-02", amount = 1},
        {type = "item", name = "electronic-circuit", amount = 10},
        {type = "item", name = "steel-plate", amount = 10},
        {type = "item", name = "transport-belt", amount = 4}
    },
    nextUpdate = "5d-lab-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-lab-1"
        }
    }
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 04
genLabs {
    number = "04",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {type = "item", name = "5d-lab-03", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "steel-plate", amount = 10},
        {type = "item", name = "fast-transport-belt", amount = 4}
    },
    nextUpdate = "5d-lab-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-lab-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.2
energy = energy + 30

-- Labs 05
genLabs {
    number = "05",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {type = "item", name = "5d-lab-04", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "steel-plate", amount = 10},
        {type = "item", name = "fast-transport-belt", amount = 4},
        {type = "item", name = "speed-module", amount = 1}
    },
    nextUpdate = "5d-lab-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-lab-3"
        }
    }
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 06
genLabs {
    number = "06",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {type = "item", name = "5d-lab-05", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "steel-plate", amount = 10},
        {type = "item", name = "fast-transport-belt", amount = 4},
        {type = "item", name = "productivity-module", amount = 1}
    },
    nextUpdate = "5d-lab-07",
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
            "5d-lab-4",
            "production-science-pack"
        }
    }
}

speed = speed + 0.2
energy = energy + 30

-- Labs 07
genLabs {
    number = "07",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {type = "item", name = "5d-lab-06", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "steel-plate", amount = 10},
        {type = "item", name = "express-transport-belt", amount = 4},
        {type = "item", name = "speed-module-2", amount = 1}
    },
    nextUpdate = "5d-lab-08",
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
            "5d-lab-5"
        }
    }
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 08
genLabs {
    number = "08",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {type = "item", name = "5d-lab-07", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "low-density-structure", amount = 3},
        {type = "item", name = "express-transport-belt", amount = 4},
        {type = "item", name = "productivity-module-2", amount = 1}
    },
    nextUpdate = "5d-lab-09",
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
            "5d-lab-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.2
energy = energy + 30

-- Labs 09
genLabs {
    number = "09",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {type = "item", name = "5d-lab-08", amount = 1},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "low-density-structure", amount = 3},
        {type = "item", name = "express-transport-belt", amount = 4},
        {type = "item", name = "speed-module-3", amount = 1}
    },
    nextUpdate = "5d-lab-10",
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
            "5d-lab-7"
        }
    }
}

speed = speed + 0.2
modules = modules + 1
energy = energy + 30

-- Labs 10
genLabs {
    number = "10",
    subgroup = "lab",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {type = "item", name = "5d-lab-09", amount = 1},
        {type = "item", name = "processing-unit", amount = 2},
        {type = "item", name = "low-density-structure", amount = 3},
        {type = "item", name = "express-transport-belt", amount = 4},
        {type = "item", name = "productivity-module-3", amount = 1}
    },
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
            "5d-lab-8"
        }
    }
}