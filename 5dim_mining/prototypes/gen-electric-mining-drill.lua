require("__5dim_core__.lib.mining.generation-electric-mining-drill")

local speed = 0.5
local modules = 2
local energy = 90
local emisions = 10
local techCount = 200

-- Electric Mining Drill 01
genMiningDrills {
    number = "01",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "iron-gear-wheel",    amount = 5 },
        { type = "item", name = "iron-plate",         amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-electric-mining-drill-02",
    tech = nil
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric Mining Drill 02
genMiningDrills {
    number = "02",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "electric-mining-drill", amount = 1 },
        { type = "item", name = "electronic-circuit",    amount = 3 },
        { type = "item", name = "iron-gear-wheel",       amount = 5 },
        { type = "item", name = "iron-plate",            amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-electric-mining-drill-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "automation-2",
            "logistic-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric Mining Drill 03
genMiningDrills {
    number = "03",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-electric-mining-drill-02", amount = 1 },
        { type = "item", name = "electronic-circuit",          amount = 3 },
        { type = "item", name = "iron-gear-wheel",             amount = 5 },
        { type = "item", name = "steel-plate",                 amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-electric-mining-drill-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "5d-mining-1"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric Mining Drill 04
genMiningDrills {
    number = "04",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-electric-mining-drill-03", amount = 1 },
        { type = "item", name = "electronic-circuit",          amount = 3 },
        { type = "item", name = "iron-gear-wheel",             amount = 5 },
        { type = "item", name = "steel-plate",                 amount = 5 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-electric-mining-drill-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-mining-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric Mining Drill 05
genMiningDrills {
    number = "05",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-electric-mining-drill-04", amount = 1 },
        { type = "item", name = "steel-plate",                 amount = 5 },
        { type = "item", name = "advanced-circuit",            amount = 3 },
        { type = "item", name = "speed-module",                amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-electric-mining-drill-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-mining-3"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric Mining Drill 06
genMiningDrills {
    number = "06",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-electric-mining-drill-05", amount = 1 },
        { type = "item", name = "steel-plate",                 amount = 5 },
        { type = "item", name = "advanced-circuit",            amount = 3 },
        { type = "item", name = "productivity-module",         amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-electric-mining-drill-07",
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "5d-mining-4",
            "production-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric Mining Drill 07
genMiningDrills {
    number = "07",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-electric-mining-drill-06", amount = 1 },
        { type = "item", name = "steel-plate",                 amount = 5 },
        { type = "item", name = "advanced-circuit",            amount = 3 },
        { type = "item", name = "speed-module-2",              amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-electric-mining-drill-08",
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "5d-mining-5"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric Mining Drill 08
genMiningDrills {
    number = "08",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-electric-mining-drill-07", amount = 1 },
        { type = "item", name = "advanced-circuit",            amount = 3 },
        { type = "item", name = "low-density-structure",       amount = 2 },
        { type = "item", name = "productivity-module-2",       amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-electric-mining-drill-09",
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-mining-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric Mining Drill 09
genMiningDrills {
    number = "09",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-electric-mining-drill-08", amount = 1 },
        { type = "item", name = "advanced-circuit",            amount = 3 },
        { type = "item", name = "low-density-structure",       amount = 2 },
        { type = "item", name = "speed-module-3",              amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-electric-mining-drill-10",
    tech = {
        number = 8,
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-mining-7"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric Mining Drill 10
genMiningDrills {
    number = "10",
    subgroup = "mining-speed",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-electric-mining-drill-09", amount = 1 },
        { type = "item", name = "steel-plate",                 amount = 5 },
        { type = "item", name = "low-density-structure",       amount = 5 },
        { type = "item", name = "processing-unit",             amount = 2 },
        { type = "item", name = "productivity-module-3",       amount = 1 }
    },
    pollution = { pollution = emisions },
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-mining-8"
        }
    }
}
