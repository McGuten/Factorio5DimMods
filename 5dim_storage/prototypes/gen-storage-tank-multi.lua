require("__5dim_core__.lib.storage.generation-storage-tank-multi")

local tankCapacity = 250
local techCount = 250

-- Electric furnace 01
genStorageTankMultis {
    number = "01",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 1,
    new = true,
    order = "a",
    ingredients = {
        { type = "item", name = "iron-plate",  amount = 20 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    nextUpdate = "5d-storage-tank-multi-02",
    tech = {
        number = 1,
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

-- Electric furnace 02
genStorageTankMultis {
    number = "02",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 2,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "5d-storage-tank-multi-01", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 5 },
        { type = "item", name = "advanced-circuit",         amount = 3 },
        { type = "item", name = "stone-brick",              amount = 5 }
    },
    nextUpdate = "5d-storage-tank-multi-03",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "fluid-handling-2",
            "5d-storage-tank-multi-1"
        }
    }
}

-- Electric furnace 03
genStorageTankMultis {
    number = "03",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 3,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-storage-tank-multi-02", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 5 },
        { type = "item", name = "advanced-circuit",         amount = 3 },
        { type = "item", name = "concrete",                 amount = 5 }
    },
    nextUpdate = "5d-storage-tank-multi-04",
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
            "fluid-handling-3",
            "production-science-pack",
            "5d-storage-tank-multi-2"
        }
    }
}

-- Electric furnace 04
genStorageTankMultis {
    number = "04",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 4,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-storage-tank-multi-03", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 5 },
        { type = "item", name = "advanced-circuit",         amount = 3 },
        { type = "item", name = "concrete",                 amount = 5 }
    },
    nextUpdate = "5d-storage-tank-multi-05",
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
            "fluid-handling-4",
            "5d-storage-tank-multi-3"
        }
    }
}

-- Electric furnace 05
genStorageTankMultis {
    number = "05",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 5,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-storage-tank-multi-04", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 5 },
        { type = "item", name = "advanced-circuit",         amount = 3 },
        { type = "item", name = "concrete",                 amount = 5 },
        { type = "item", name = "speed-module",             amount = 1 }
    },
    nextUpdate = "5d-storage-tank-multi-06",
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
            "fluid-handling-5",
            "5d-storage-tank-multi-4"
        }
    }
}

-- Electric furnace 06
genStorageTankMultis {
    number = "06",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 6,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-storage-tank-multi-05", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 5 },
        { type = "item", name = "advanced-circuit",         amount = 3 },
        { type = "item", name = "refined-concrete",         amount = 5 },
        { type = "item", name = "productivity-module",      amount = 1 }
    },
    nextUpdate = "5d-storage-tank-multi-07",
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
            "fluid-handling-6",
            "5d-storage-tank-multi-5"
        }
    }
}

-- Electric furnace 07
genStorageTankMultis {
    number = "07",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 7,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-storage-tank-multi-06", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 5 },
        { type = "item", name = "advanced-circuit",         amount = 3 },
        { type = "item", name = "refined-concrete",         amount = 5 },
        { type = "item", name = "speed-module-2",           amount = 1 }
    },
    nextUpdate = "5d-storage-tank-multi-08",
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
            "fluid-handling-7",
            "5d-storage-tank-multi-6"
        }
    }
}

-- Electric furnace 08
genStorageTankMultis {
    number = "08",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 8,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-storage-tank-multi-07", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 5 },
        { type = "item", name = "low-density-structure",    amount = 1 },
        { type = "item", name = "refined-concrete",         amount = 5 },
        { type = "item", name = "productivity-module-2",    amount = 1 }
    },
    nextUpdate = "5d-storage-tank-multi-09",
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
            "fluid-handling-8",
            "utility-science-pack",
            "5d-storage-tank-multi-7"
        }
    }
}

-- Electric furnace 09
genStorageTankMultis {
    number = "09",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 9,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-storage-tank-multi-08", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 5 },
        { type = "item", name = "low-density-structure",    amount = 1 },
        { type = "item", name = "refined-concrete",         amount = 5 },
        { type = "item", name = "speed-module-3",           amount = 1 }
    },
    nextUpdate = "5d-storage-tank-multi-10",
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
            "fluid-handling-9",
            "5d-storage-tank-multi-8"
        }
    }
}

-- Electric furnace 10
genStorageTankMultis {
    number = "10",
    subgroup = "liquid-store-multi",
    capacity = tankCapacity * 10,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-storage-tank-multi-09", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 5 },
        { type = "item", name = "low-density-structure",    amount = 3 },
        { type = "item", name = "refined-concrete",         amount = 5 },
        { type = "item", name = "productivity-module-3",    amount = 1 }
    },
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
            "fluid-handling-10",
            "5d-storage-tank-multi-9"
        }
    }
}
