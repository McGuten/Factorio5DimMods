require("__5dim_core__.lib.logistic.generation-roboport")

speed = 1000
modules = 5
energy = 50
emisions = 100
logistic = 25
constructions = 55
botSlot = 7
recharges = 40

-- Electric furnace 01
genRoboports {
    number = "01",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"steel-plate", 5},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"pipe", 10}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = nil
}

recharges = recharges + 20
modules = modules + 1.5
speed = speed + 500
energy = energy + 45
emisions = emisions + 50
logistic = logistic + 12.5
constructions = constructions + 25
botSlot = botSlot + 7

-- Electric furnace 02
genRoboports {
    number = "02",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"5d-water-pumpjack-01", 1},
        {"electronic-circuit", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = {
        number = 2,
        count = 150,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-1"
        }
    }
}

recharges = recharges + 20
modules = modules + 1.5
speed = speed + 500
energy = energy + 45
emisions = emisions + 50
logistic = logistic + 12.5
constructions = constructions + 25
botSlot = botSlot + 7

-- Electric furnace 03
genRoboports {
    number = "03",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-water-pumpjack-02", 1},
        {"electronic-circuit", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = {
        number = 3,
        count = 300,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-water-pumpjack-2"
        }
    }
}

recharges = recharges + 20
modules = modules + 1.5
speed = speed + 500
energy = energy + 45
emisions = emisions + 50
logistic = logistic + 12.5
constructions = constructions + 25
botSlot = botSlot + 7

-- Electric furnace 04
genRoboports {
    number = "04",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-water-pumpjack-03", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = {
        number = 4,
        count = 450,
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

recharges = recharges + 20
modules = modules + 1.5
speed = speed + 500
energy = energy + 45
emisions = emisions + 50
logistic = logistic + 12.5
constructions = constructions + 25
botSlot = botSlot + 7

-- Electric furnace 05
genRoboports {
    number = "05",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-water-pumpjack-04", 1},
        {"steel-plate", 2},
        {"pipe", 3},
        {"iron-gear-wheel", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = {
        number = 5,
        count = 500,
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

recharges = recharges + 20
modules = modules + 1.5
speed = speed + 500
energy = energy + 45
emisions = emisions + 50
logistic = logistic + 12.5
constructions = constructions + 25
botSlot = botSlot + 7

-- Electric furnace 06
genRoboports {
    number = "06",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-water-pumpjack-05", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = {
        number = 6,
        count = 600,
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

recharges = recharges + 20
modules = modules + 1.5
speed = speed + 500
energy = energy + 45
emisions = emisions + 50
logistic = logistic + 12.5
constructions = constructions + 25
botSlot = botSlot + 7

-- Electric furnace 07
genRoboports {
    number = "07",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-water-pumpjack-06", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = {
        number = 7,
        count = 700,
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

recharges = recharges + 20
modules = modules + 1.5
speed = speed + 500
energy = energy + 45
emisions = emisions + 50
logistic = logistic + 12.5
constructions = constructions + 25
botSlot = botSlot + 7

-- Electric furnace 08
genRoboports {
    number = "08",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-water-pumpjack-07", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = {
        number = 8,
        count = 800,
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

recharges = recharges + 20
modules = modules + 1.5
speed = speed + 500
energy = energy + 45
emisions = emisions + 50
logistic = logistic + 12.5
constructions = constructions + 25
botSlot = botSlot + 7

-- Electric furnace 09
genRoboports {
    number = "09",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-water-pumpjack-08", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = {
        number = 9,
        count = 900,
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

recharges = recharges + 20
modules = modules + 1.5
speed = speed + 500
energy = energy + 45
emisions = emisions + 50
logistic = logistic + 12.5
constructions = constructions + 25
botSlot = botSlot + 7

-- Electric furnace 10
genRoboports {
    number = "10",
    subgroup = "logistic-roboport",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-water-pumpjack-09", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    tech = {
        number = 10,
        count = 1000,
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
