require("__5dim_core__.lib.logistic.generation-roboport")

local speed = 1000
local modules = 5
local energy = 50
local emisions = 100
local logistic = 25
local constructions = 55
local botSlot = 7
local recharges = 40

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
    nextUpdate = "5d-roboport-02",
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
        {"roboport", 1},
        {"electronic-circuit", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    nextUpdate = "5d-roboport-03",
    tech = {
        number = 1,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "logistic-robotics",
            "construction-robotics"
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
        {"5d-roboport-02", 1},
        {"electronic-circuit", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    nextUpdate = "5d-roboport-04",
    tech = {
        number = 2,
        count = 750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-1",
            "5d-logistic-robot-1",
            "5d-roboport-1"
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
        {"5d-roboport-03", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 2}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    nextUpdate = "5d-roboport-05",
    tech = {
        number = 3,
        count = 1000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-2",
            "5d-logistic-robot-2",
            "5d-roboport-2",
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
        {"5d-roboport-04", 1},
        {"steel-plate", 2},
        {"pipe", 3},
        {"iron-gear-wheel", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    nextUpdate = "5d-roboport-06",
    tech = {
        number = 4,
        count = 1250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-3",
            "5d-logistic-robot-3",
            "5d-roboport-3"
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
        {"5d-roboport-05", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"iron-gear-wheel", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    nextUpdate = "5d-roboport-07",
    tech = {
        number = 5,
        count = 1500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-4",
            "5d-logistic-robot-4",
            "5d-roboport-4",
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
        {"5d-roboport-06", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    nextUpdate = "5d-roboport-08",
    tech = {
        number = 6,
        count = 1750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-5",
            "5d-logistic-robot-5",
            "5d-roboport-5"
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
        {"5d-roboport-07", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    nextUpdate = "5d-roboport-09",
    tech = {
        number = 7,
        count = 2000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-6",
            "5d-logistic-robot-6",
            "5d-roboport-6",
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
        {"5d-roboport-08", 1},
        {"steel-plate", 5},
        {"pipe", 3},
        {"advanced-circuit", 1}
    },
    pollution = emisions,
    logistics = logistic,
    construction = constructions,
    botSlots = botSlot,
    recharge = recharges,
    nextUpdate = "5d-roboport-10",
    tech = {
        number = 8,
        count = 2250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-7",
            "5d-logistic-robot-7",
            "5d-roboport-7"
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
        {"5d-roboport-09", 1},
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
        count = 2500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-construction-robot-8",
            "5d-logistic-robot-8",
            "5d-roboport-8"
        }
    }
}
