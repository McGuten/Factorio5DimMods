require("__5dim_core__.lib.mining.generation-water-pumpjack")

local speed = 20
local modules = 2
local energy = 90
local emisions = 10
local techCount = 150

-- Water pumpjack 01
genWaterPumpjacks {
    number = "01",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "a",
    ingredients = {
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-water-pumpjack-02",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "automation-2",
            "logistic-science-pack"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Water pumpjack 02
genWaterPumpjacks {
    number = "02",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"5d-water-pumpjack-01", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-water-pumpjack-03",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-1"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Water pumpjack 03
genWaterPumpjacks {
    number = "03",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-water-pumpjack-02", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-water-pumpjack-04",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-2"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Water pumpjack 04
genWaterPumpjacks {
    number = "04",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-water-pumpjack-03", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-water-pumpjack-05",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-3",
            "chemical-science-pack"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Water pumpjack 05
genWaterPumpjacks {
    number = "05",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-water-pumpjack-04", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-water-pumpjack-06",
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-4"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Water pumpjack 06
genWaterPumpjacks {
    number = "06",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-water-pumpjack-05", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-water-pumpjack-07",
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
            "5d-water-pumpjack-5",
            "production-science-pack"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Water pumpjack 07
genWaterPumpjacks {
    number = "07",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-water-pumpjack-06", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-water-pumpjack-08",
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-6"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Water pumpjack 08
genWaterPumpjacks {
    number = "08",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-water-pumpjack-07", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-water-pumpjack-09",
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
            "5d-water-pumpjack-7",
            "utility-science-pack"
        }
    }
}

speed = speed + 5
energy = energy + 45
emisions = emisions + 5

-- Water pumpjack 09
genWaterPumpjacks {
    number = "09",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-water-pumpjack-08", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    nextUpdate = "5d-water-pumpjack-10",
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
            "5d-water-pumpjack-8"
        }
    }
}

speed = speed + 5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Water pumpjack 10
genWaterPumpjacks {
    number = "10",
    subgroup = "liquid-water",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-water-pumpjack-09", 1},
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    tech = {
        number = 10,
        count = techCount * 10,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-9"
        }
    }
}
