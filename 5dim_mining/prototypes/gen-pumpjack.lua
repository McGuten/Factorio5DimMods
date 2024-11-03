require("__5dim_core__.lib.mining.generation-pumpjack")

local speed = 1
local modules = 2
local energy = 90
local emisions = 10
local techCount = 200

-- Electric furnace 01
genPumpjacks {
    number = "01",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "iron-gear-wheel",    amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe",               amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-pumpjack-02",
    tech = nil
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 02
genPumpjacks {
    number = "02",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "pumpjack",           amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "iron-gear-wheel",    amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe",               amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-pumpjack-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "oil-processing",
            "logistic-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 03
genPumpjacks {
    number = "03",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-pumpjack-02",     amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "iron-gear-wheel",    amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe",               amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-pumpjack-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "5d-pumpjack-1"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 04
genPumpjacks {
    number = "04",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-pumpjack-03",     amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "iron-gear-wheel",    amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe",               amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-pumpjack-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-pumpjack-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 05
genPumpjacks {
    number = "05",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-pumpjack-04",     amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "iron-gear-wheel",    amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "pipe",               amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-pumpjack-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-pumpjack-3"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 06
genPumpjacks {
    number = "06",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-pumpjack-05",      amount = 1 },
        { type = "item", name = "steel-plate",         amount = 5 },
        { type = "item", name = "advanced-circuit",    amount = 5 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-pumpjack-07",
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
            "5d-pumpjack-4",
            "production-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 07
genPumpjacks {
    number = "07",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-pumpjack-06",   amount = 1 },
        { type = "item", name = "steel-plate",      amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "speed-module-2",   amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-pumpjack-08",
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
            "5d-pumpjack-5"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 08
genPumpjacks {
    number = "08",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-pumpjack-07",        amount = 1 },
        { type = "item", name = "advanced-circuit",      amount = 5 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "productivity-module-2", amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-pumpjack-09",
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
            "5d-pumpjack-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.5
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 09
genPumpjacks {
    number = "09",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-pumpjack-08",        amount = 1 },
        { type = "item", name = "advanced-circuit",      amount = 5 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "speed-module-3",        amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-pumpjack-10",
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
            "5d-pumpjack-7"
        }
    }
}

speed = speed + 0.5
modules = modules + 1
energy = energy + 45
emisions = emisions + 5

-- Electric furnace 10
genPumpjacks {
    number = "10",
    subgroup = "liquid-pump",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-pumpjack-09",        amount = 1 },
        { type = "item", name = "steel-plate",           amount = 5 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "processing-unit",       amount = 2 },
        { type = "item", name = "productivity-module-3", amount = 1 }
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
            "5d-pumpjack-8"
        }
    }
}
