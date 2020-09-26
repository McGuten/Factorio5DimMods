require("__5dim_core__.lib.storage.generation-storage-tank")

local tankCapacity = 250
local techCount = 250

-- Electric furnace 01
genStorageTanks {
    number = "01",
    subgroup = "liquid-store",
    capacity = tankCapacity * 1,
    new = false,
    order = "a",
    ingredients = {
        {"iron-plate", 20},
        {"steel-plate", 5}
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
        {"storage-tank", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"stone-brick", 5}
    },
    nextUpdate = "5d-storage-tank-03",
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
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
        {"5d-storage-tank-02", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"concrete", 5}
    },
    nextUpdate = "5d-storage-tank-04",
    tech = {
        number = 3,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
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
        {"5d-storage-tank-03", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"concrete", 5}
    },
    nextUpdate = "5d-storage-tank-05",
    tech = {
        number = 4,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
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
        {"5d-storage-tank-04", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"concrete", 5},
        {"speed-module", 1}
    },
    nextUpdate = "5d-storage-tank-06",
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
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
        {"5d-storage-tank-05", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"refined-concrete", 5},
        {"productivity-module", 1}
    },
    nextUpdate = "5d-storage-tank-07",
    tech = {
        number = 6,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
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
        {"5d-storage-tank-06", 1},
        {"steel-plate", 5},
        {"advanced-circuit", 3},
        {"refined-concrete", 5},
        {"speed-module-2", 1}
    },
    nextUpdate = "5d-storage-tank-08",
    tech = {
        number = 7,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
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
        {"5d-storage-tank-07", 1},
        {"steel-plate", 5},
        {"low-density-structure", 1},
        {"refined-concrete", 5},
        {"productivity-module-2", 1}
    },
    nextUpdate = "5d-storage-tank-09",
    tech = {
        number = 8,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
        {"5d-storage-tank-08", 1},
        {"steel-plate", 5},
        {"low-density-structure", 1},
        {"refined-concrete", 5},
        {"speed-module-3", 1}
    },
    nextUpdate = "5d-storage-tank-10",
    tech = {
        number = 9,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
        {"5d-storage-tank-09", 1},
        {"steel-plate", 5},
        {"low-density-structure", 3},
        {"refined-concrete", 5},
        {"productivity-module-3", 1}
    },
    tech = {
        number = 10,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "fluid-handling-9"
        }
    }
}
