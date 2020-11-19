require("__5dim_core__.lib.transport.generation-inserter")

local rotation = 0.014
local extension = 0.03
local energy = 5
local drain = 0.4
local extension = 0.03
local techCount = 200

-- Electric furnace 01
genInserters {
    number = "01",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = false,
    order = "a",
    ingredients = {
        inserter = {
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"inserter", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1},
            {"inserter", 1}
        },
        stackFilterInserter = {
            {"stack-inserter", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        inserter = "long-handed-inserter",
        filterInserter = "5d-filter-inserter-02",
        stackInserter = "5d-stack-inserter-02",
        stackFilterInserter = "5d-stack-filter-inserter-02"
    },
    tech = nil,
    copyName = "inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Electric furnace 02
genInserters {
    number = "02",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = false,
    order = "b",
    ingredients = {
        inserter = {
            {"inserter", 1},
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"long-handed-inserter", 1},
            {"filter-inserter", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"long-handed-inserter", 1},
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1},
            {"stack-inserter", 1}
        },
        stackFilterInserter = {
            {"5d-stack-inserter-02", 1},
            {"stack-filter-inserter", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        inserter = "fast-inserter",
        filterInserter = "5d-filter-inserter-03",
        stackInserter = "5d-stack-inserter-03",
        stackFilterInserter = "5d-stack-filter-inserter-03"
    },
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "stack-inserter",
            "logistics-2",
            "chemical-science-pack"
        }
    },
    copyName = "long-handed-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Electric furnace 03
genInserters {
    number = "03",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = false,
    order = "c",
    ingredients = {
        inserter = {
            {"long-handed-inserter", 1},
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"fast-inserter", 1},
            {"5d-filter-inserter-02", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"fast-inserter", 1},
            {"5d-stack-inserter-02", 1},
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1}
        },
        stackFilterInserter = {
            {"5d-stack-inserter-03", 1},
            {"5d-stack-filter-inserter-02", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        inserter = "5d-inserter-04",
        filterInserter = "5d-filter-inserter-04",
        stackInserter = "5d-stack-inserter-04",
        stackFilterInserter = "5d-stack-filter-inserter-04"
    },
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "stack-inserter-2",
            "logistics-3"
        }
    },
    copyName = "fast-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Electric furnace 04
genInserters {
    number = "04",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "d",
    ingredients = {
        inserter = {
            {"fast-inserter", 1},
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"5d-inserter-04", 1},
            {"5d-filter-inserter-03", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"5d-inserter-04", 1},
            {"5d-stack-inserter-03", 1},
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1}
        },
        stackFilterInserter = {
            {"5d-stack-inserter-04", 1},
            {"5d-stack-filter-inserter-03", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        inserter = "5d-inserter-05",
        filterInserter = "5d-filter-inserter-05",
        stackInserter = "5d-stack-inserter-05",
        stackFilterInserter = "5d-stack-filter-inserter-05"
    },
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "stack-inserter-3",
            "production-science-pack",
            "logistics-4"
        }
    },
    copyName = "fast-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Electric furnace 05
genInserters {
    number = "05",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "e",
    ingredients = {
        inserter = {
            {"5d-inserter-04", 1},
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"5d-inserter-05", 1},
            {"5d-filter-inserter-04", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"5d-inserter-05", 1},
            {"5d-stack-inserter-04", 1},
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1}
        },
        stackFilterInserter = {
            {"5d-stack-inserter-05", 1},
            {"5d-stack-filter-inserter-04", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        inserter = "5d-inserter-06",
        filterInserter = "5d-filter-inserter-06",
        stackInserter = "5d-stack-inserter-06",
        stackFilterInserter = "5d-stack-filter-inserter-06"
    },
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "stack-inserter-4",
            "logistics-5"
        }
    },
    copyName = "fast-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Electric furnace 06
genInserters {
    number = "06",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "f",
    ingredients = {
        inserter = {
            {"5d-inserter-05", 1},
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"5d-inserter-06", 1},
            {"5d-filter-inserter-05", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"5d-inserter-06", 1},
            {"5d-stack-inserter-05", 1},
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1}
        },
        stackFilterInserter = {
            {"5d-stack-inserter-06", 1},
            {"5d-stack-filter-inserter-05", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        inserter = "5d-inserter-07",
        filterInserter = "5d-filter-inserter-07",
        stackInserter = "5d-stack-inserter-07",
        stackFilterInserter = "5d-stack-filter-inserter-07"
    },
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
            "stack-inserter-5",
            "logistics-6"
        }
    },
    copyName = "fast-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Electric furnace 07
genInserters {
    number = "07",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "g",
    ingredients = {
        inserter = {
            {"5d-inserter-06", 1},
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"5d-inserter-07", 1},
            {"5d-filter-inserter-06", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"5d-inserter-07", 1},
            {"5d-stack-inserter-06", 1},
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1}
        },
        stackFilterInserter = {
            {"5d-stack-inserter-07", 1},
            {"5d-stack-filter-inserter-06", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        inserter = "5d-inserter-08",
        filterInserter = "5d-filter-inserter-08",
        stackInserter = "5d-stack-inserter-08",
        stackFilterInserter = "5d-stack-filter-inserter-08"
    },
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "stack-inserter-6",
            "utility-science-pack",
            "logistics-7"
        }
    },
    copyName = "fast-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Electric furnace 08
genInserters {
    number = "08",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "h",
    ingredients = {
        inserter = {
            {"5d-inserter-07", 1},
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"5d-inserter-08", 1},
            {"5d-filter-inserter-07", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"5d-inserter-08", 1},
            {"5d-stack-inserter-07", 1},
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1}
        },
        stackFilterInserter = {
            {"5d-stack-inserter-08", 1},
            {"5d-stack-filter-inserter-07", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        inserter = "5d-inserter-09",
        filterInserter = "5d-filter-inserter-09",
        stackInserter = "5d-stack-inserter-09",
        stackFilterInserter = "5d-stack-filter-inserter-09"
    },
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
            "stack-inserter-7",
            "logistics-8"
        }
    },
    copyName = "fast-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Electric furnace 09
genInserters {
    number = "09",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "i",
    ingredients = {
        inserter = {
            {"5d-inserter-08", 1},
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"5d-inserter-09", 1},
            {"5d-stack-inserter-08", 1},
            {"5d-filter-inserter-08", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"5d-inserter-09", 1},
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1}
        },
        stackFilterInserter = {
            {"5d-stack-inserter-09", 1},
            {"5d-stack-filter-inserter-08", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        inserter = "5d-inserter-10",
        filterInserter = "5d-filter-inserter-10",
        stackInserter = "5d-stack-inserter-10",
        stackFilterInserter = "5d-stack-filter-inserter-10"
    },
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "stack-inserter-8",
            "space-science-pack",
            "logistics-9"
        }
    },
    copyName = "fast-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Electric furnace 10
genInserters {
    number = "10",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "j",
    ingredients = {
        inserter = {
            {"5d-inserter-09", 1},
            {"electronic-circuit", 1},
            {"iron-gear-wheel", 1},
            {"iron-plate", 1}
        },
        filterInserter = {
            {"5d-inserter-10", 1},
            {"5d-filter-inserter-09", 1},
            {"electronic-circuit", 4}
        },
        stackInserter = {
            {"5d-inserter-10", 1},
            {"5d-stack-inserter-09", 1},
            {"iron-gear-wheel", 15},
            {"electronic-circuit", 15},
            {"advanced-circuit", 1}
        },
        stackFilterInserter = {
            {"5d-stack-inserter-10", 1},
            {"5d-stack-filter-inserter-09", 1},
            {"electronic-circuit", 5}
        }
    },
    nextUpdate = {
        -- inserter = "fast-inserter",
        -- filterInserter = "5d-filter-inserter-04",
        -- stackInserter = "5d-stack-inserter-04",
        -- stackFilterInserter = "5d-stack-filter-inserter-04"
    },
    tech = {
        number = 10,
        count = techCount * 10,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "stack-inserter-9",
            "logistics-10"
        }
    },
    copyName = "fast-inserter"
}
