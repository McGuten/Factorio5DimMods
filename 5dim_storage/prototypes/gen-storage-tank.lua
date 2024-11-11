require("__5dim_core__.lib.storage.generation-storage-tank")

local tankCapacity = 25000
local techCount = 250

-- Electric furnace 01
genStorageTanks {
    number = "01",
    subgroup = "liquid-store",
    capacity = tankCapacity * 1,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "iron-plate",  amount = 20 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    nextUpdate = "5d-storage-tank-02",
    tech = nil
}

-- Electric furnace 02
genStorageTanks {
    number = "02",
    subgroup = "liquid-store",
    capacity = tankCapacity * 2,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "storage-tank",     amount = 1 },
        { type = "item", name = "steel-plate",      amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "stone-brick",      amount = 5 }
    },
    nextUpdate = "5d-storage-tank-03",
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "fluid-handling"
        }
    }
}

-- Electric furnace 03
genStorageTanks {
    number = "03",
    subgroup = "liquid-store",
    capacity = tankCapacity * 3,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-storage-tank-02", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "advanced-circuit",   amount = 3 },
        { type = "item", name = "concrete",           amount = 5 }
    },
    nextUpdate = "5d-storage-tank-04",
    tech = {
        number = 3,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "fluid-handling-2",
            "production-science-pack"
        }
    }
}

-- Electric furnace 04
genStorageTanks {
    number = "04",
    subgroup = "liquid-store",
    capacity = tankCapacity * 4,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-storage-tank-03", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "advanced-circuit",   amount = 3 },
        { type = "item", name = "concrete",           amount = 5 }
    },
    nextUpdate = "5d-storage-tank-05",
    tech = {
        number = 4,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "fluid-handling-3"
        }
    }
}

-- Electric furnace 05
genStorageTanks {
    number = "05",
    subgroup = "liquid-store",
    capacity = tankCapacity * 5,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-storage-tank-04", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "advanced-circuit",   amount = 3 },
        { type = "item", name = "concrete",           amount = 5 },
        { type = "item", name = "speed-module",       amount = 1 }
    },
    nextUpdate = "5d-storage-tank-06",
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "fluid-handling-4"
        }
    }
}

-- Electric furnace 06
genStorageTanks {
    number = "06",
    subgroup = "liquid-store",
    capacity = tankCapacity * 6,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-storage-tank-05",  amount = 1 },
        { type = "item", name = "steel-plate",         amount = 5 },
        { type = "item", name = "advanced-circuit",    amount = 3 },
        { type = "item", name = "refined-concrete",    amount = 5 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    nextUpdate = "5d-storage-tank-07",
    tech = {
        number = 6,
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "fluid-handling-5"
        }
    }
}

-- Electric furnace 07
genStorageTanks {
    number = "07",
    subgroup = "liquid-store",
    capacity = tankCapacity * 7,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-storage-tank-06", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "advanced-circuit",   amount = 3 },
        { type = "item", name = "refined-concrete",   amount = 5 },
        { type = "item", name = "speed-module-2",     amount = 1 }
    },
    nextUpdate = "5d-storage-tank-08",
    tech = {
        number = 7,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "fluid-handling-6"
        }
    }
}

-- Electric furnace 08
genStorageTanks {
    number = "08",
    subgroup = "liquid-store",
    capacity = tankCapacity * 8,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-storage-tank-07",    amount = 1 },
        { type = "item", name = "steel-plate",           amount = 5 },
        { type = "item", name = "low-density-structure", amount = 1 },
        { type = "item", name = "refined-concrete",      amount = 5 },
        { type = "item", name = "productivity-module-2", amount = 1 }
    },
    nextUpdate = "5d-storage-tank-09",
    tech = {
        number = 8,
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "fluid-handling-7",
            "utility-science-pack"
        }
    }
}

-- Electric furnace 09
genStorageTanks {
    number = "09",
    subgroup = "liquid-store",
    capacity = tankCapacity * 9,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-storage-tank-08",    amount = 1 },
        { type = "item", name = "steel-plate",           amount = 5 },
        { type = "item", name = "low-density-structure", amount = 1 },
        { type = "item", name = "refined-concrete",      amount = 5 },
        { type = "item", name = "speed-module-3",        amount = 1 }
    },
    nextUpdate = "5d-storage-tank-10",
    tech = {
        number = 9,
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "fluid-handling-8"
        }
    }
}

-- Electric furnace 10
genStorageTanks {
    number = "10",
    subgroup = "liquid-store",
    capacity = tankCapacity * 10,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-storage-tank-09",    amount = 1 },
        { type = "item", name = "steel-plate",           amount = 5 },
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "refined-concrete",      amount = 5 },
        { type = "item", name = "productivity-module-3", amount = 1 }
    },
    tech = {
        number = 10,
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "fluid-handling-9"
        }
    }
}
