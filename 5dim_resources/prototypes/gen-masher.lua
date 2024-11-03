require("__5dim_core__.lib.resources.generation-masher")

local crafting = 2
local modules = 2
local energy = 360
local emisions = 1
local techCount = 250

-- Electric furnace 01
genMasher {
    number = "01",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "a",
    ingredients = {
        { type = "item", name = "steel-plate",        amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel",    amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-masher-02",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "advanced-material-processing-2"
        }
    }
}

crafting = crafting + 2
modules = modules + 1
energy = energy + 180
emisions = emisions + 0.75

-- Electric furnace 02
genMasher {
    number = "02",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "5d-masher-01",       amount = 1 },
        { type = "item", name = "steel-plate",        amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "iron-gear-wheel",    amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-masher-03",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-masher-1",
            "advanced-material-processing-3"
        }
    }
}

crafting = crafting + 2
energy = energy + 180
emisions = emisions + 0.75

-- Electric furnace 03
genMasher {
    number = "03",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-masher-02",     amount = 1 },
        { type = "item", name = "steel-plate",      amount = 10 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "iron-gear-wheel",  amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-masher-04",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "5d-masher-2",
            "production-science-pack",
            "advanced-material-processing-4"
        }
    }
}

crafting = crafting + 2
modules = modules + 1
energy = energy + 180
emisions = emisions + 0.75

-- Electric furnace 04
genMasher {
    number = "04",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-masher-03",     amount = 1 },
        { type = "item", name = "steel-plate",      amount = 10 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "iron-gear-wheel",  amount = 10 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-masher-05",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "5d-masher-3",
            "advanced-material-processing-5"
        }
    }
}

crafting = crafting + 2
energy = energy + 180
emisions = emisions + 0.75

-- Electric furnace 05
genMasher {
    number = "05",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-masher-04",     amount = 1 },
        { type = "item", name = "steel-plate",      amount = 10 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "iron-gear-wheel",  amount = 10 },
        { type = "item", name = "speed-module",     amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-masher-06",
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
            "5d-masher-4",
            "advanced-material-processing-6"
        }
    }
}

crafting = crafting + 2
modules = modules + 1
energy = energy + 180
emisions = emisions + 0.75

-- Electric furnace 06
genMasher {
    number = "06",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-masher-05",        amount = 1 },
        { type = "item", name = "steel-plate",         amount = 10 },
        { type = "item", name = "advanced-circuit",    amount = 3 },
        { type = "item", name = "iron-gear-wheel",     amount = 10 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-masher-07",
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
            "5d-masher-5",
            "advanced-material-processing-7"
        }
    }
}

crafting = crafting + 2
energy = energy + 180
emisions = emisions + 0.75

-- Electric furnace 07
genMasher {
    number = "07",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-masher-06",    amount = 1 },
        { type = "item", name = "steel-plate",     amount = 10 },
        { type = "item", name = "processing-unit", amount = 5 },
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "speed-module-2",  amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-masher-08",
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "5d-masher-6",
            "advanced-material-processing-8"
        }
    }
}

crafting = crafting + 2
modules = modules + 1
energy = energy + 180
emisions = emisions + 0.75

-- Electric furnace 08
genMasher {
    number = "08",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-masher-07",          amount = 1 },
        { type = "item", name = "steel-plate",           amount = 10 },
        { type = "item", name = "processing-unit",       amount = 5 },
        { type = "item", name = "iron-gear-wheel",       amount = 10 },
        { type = "item", name = "productivity-module-2", amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-masher-09",
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
            "5d-masher-7",
            "utility-science-pack",
            "advanced-material-processing-9"
        }
    }
}

crafting = crafting + 2
energy = energy + 180
emisions = emisions + 0.75

-- Electric furnace 09
genMasher {
    number = "09",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-masher-08",          amount = 1 },
        { type = "item", name = "steel-plate",           amount = 10 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "iron-gear-wheel",       amount = 10 },
        { type = "item", name = "speed-module-3",        amount = 1 }
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-masher-10",
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
            "5d-masher-8",
            "advanced-material-processing-10"
        }
    }
}

crafting = crafting + 2
modules = modules + 1
energy = energy + 180
emisions = emisions + 0.75

-- Electric furnace 10
genMasher {
    number = "10",
    subgroup = "masher",
    craftingSpeed = crafting,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-masher-09",          amount = 1 },
        { type = "item", name = "steel-plate",           amount = 10 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "iron-gear-wheel",       amount = 10 },
        { type = "item", name = "productivity-module-3", amount = 1 }
    },
    pollution = { pollution = emisions },
    tech = {
        number = 10,
        count = techCount * 10,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-masher-9",
            "advanced-material-processing-11"
        }
    }
}
