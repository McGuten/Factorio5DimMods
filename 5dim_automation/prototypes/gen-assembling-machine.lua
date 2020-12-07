require("__5dim_core__.lib.automation.generation-assembling-machine")

local energy = 75
local crafting = 0.5
local techCount = 150

-- Electric furnace 01
genAssemblingMachines {
    number = "01",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"electronic-circuit", 3},
        {"iron-gear-wheel", 5},
        {"iron-plate", 9}
    },
    nextUpdate = "assembling-machine-2",
    tech = nil,
    copy = {
        name = "assembling-machine",
        postName = "-1"
    }
}

crafting = crafting + 0.5
energy = energy + 40

-- Electric furnace 02
genAssemblingMachines {
    number = "02",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = false,
    order = "b",
    ingredients = {
        {"steel-plate", 2},
        {"electronic-circuit", 3},
        {"iron-gear-wheel", 5},
        {"assembling-machine-1", 1}
    },
    nextUpdate = "assembling-machine-3",
    tech = nil,
    copy = {
        name = "assembling-machine",
        postName = "-2"
    }
}

crafting = crafting + 0.5
energy = energy + 40

-- Electric furnace 03
genAssemblingMachines {
    number = "03",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = false,
    order = "c",
    ingredients = {
        {"speed-module", 5},
        {"assembling-machine-2", 1}
    },
    nextUpdate = "5d-assembling-machine-04",
    tech = nil,
    copy = nil
}

crafting = crafting + 0.5
energy = energy + 40

-- Electric furnace 04
genAssemblingMachines {
    number = "04",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"assembling-machine-3", 1},
        {"productivity-module", 4},
        {"steel-plate", 6}
    },
    nextUpdate = "5d-assembling-machine-05",
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
            "automation-3",
            "production-science-pack"
        }
    },
    copy = nil
}

crafting = crafting + 0.5
energy = energy + 40

-- Electric furnace 05
genAssemblingMachines {
    number = "05",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-assembling-machine-04", 1},
        {"speed-module-2", 4},
        {"steel-plate", 6}
    },
    nextUpdate = "5d-assembling-machine-06",
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
            "automation-4"
        }
    },
    copy = nil
}

crafting = crafting + 0.5
energy = energy + 40

-- Electric furnace 06
genAssemblingMachines {
    number = "06",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-assembling-machine-05", 1},
        {"productivity-module-2", 4},
        {"steel-plate", 6}
    },
    nextUpdate = "5d-assembling-machine-07",
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
            "automation-5"
        }
    },
    copy = nil
}

crafting = crafting + 0.5
energy = energy + 40

-- Electric furnace 07
genAssemblingMachines {
    number = "07",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-assembling-machine-06", 1},
        {"speed-module-3", 4},
        {"steel-plate", 6}
    },
    nextUpdate = "5d-assembling-machine-08",
    tech = {
        number = 7,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "automation-6",
            "utility-science-pack"
        }
    },
    copy = nil
}

crafting = crafting + 0.5
energy = energy + 40

-- Electric furnace 08
genAssemblingMachines {
    number = "08",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-assembling-machine-07", 1},
        {"productivity-module-3", 4},
        {"steel-plate", 6}
    },
    nextUpdate = "5d-assembling-machine-09",
    tech = {
        number = 8,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "automation-7"
        }
    },
    copy = nil
}

crafting = crafting + 0.5
energy = energy + 40

-- Electric furnace 09
genAssemblingMachines {
    number = "09",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-assembling-machine-08", 1},
        {"speed-module-3", 4},
        {"low-density-structure", 2},
        {"processing-unit", 2}
    },
    nextUpdate = "5d-assembling-machine-10",
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
            "automation-8"
        }
    },
    copy = nil
}

crafting = crafting + 0.5
energy = energy + 40

-- Electric furnace 10
genAssemblingMachines {
    number = "10",
    subgroup = "assembling-machine",
    craftingSpeed = crafting,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-assembling-machine-09", 1},
        {"productivity-module-3", 4},
        {"low-density-structure", 2},
        {"processing-unit", 2}
    },
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
            "automation-9"
        }
    },
    copy = nil
}
