require("__5dim_core__.lib.transport.generation-inserter")

local rotation = 0.014
local extension = 0.03
local energy = 5
local drain = 0.4
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
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "iron-gear-wheel",    amount = 15 },
            { type = "item", name = "electronic-circuit", amount = 15 },
            { type = "item", name = "advanced-circuit",   amount = 1 },
            { type = "item", name = "inserter",           amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "fast-inserter",
        filterInserter = "5d-filter-inserter-02",
        stackInserter = "5d-bulk-inserter-02",
        stackFilterInserter = "5d-bulk-filter-inserter-02"
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
            { type = "item", name = "inserter",           amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "long-handed-inserter", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 },
            { type = "item", name = "bulk-inserter",       amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "5d-inserter-03",
        filterInserter = "5d-filter-inserter-03",
        stackInserter = "5d-bulk-inserter-03",
        stackFilterInserter = "5d-bulk-filter-inserter-03"
    },
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "bulk-inserter",
            "logistics-2",
            "chemical-science-pack"
        }
    },
    copyName = "fast-inserter"
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
    new = true,
    order = "c",
    ingredients = {
        inserter = {
            { type = "item", name = "fast-inserter",      amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "5d-inserter-03",       amount = 1 },
            { type = "item", name = "5d-bulk-inserter-02", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "5d-inserter-04",
        filterInserter = "5d-filter-inserter-04",
        stackInserter = "5d-bulk-inserter-04",
        stackFilterInserter = "5d-bulk-filter-inserter-04"
    },
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
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
            { type = "item", name = "5d-inserter-03",     amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "5d-inserter-04",       amount = 1 },
            { type = "item", name = "5d-bulk-inserter-03", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "5d-inserter-05",
        filterInserter = "5d-filter-inserter-05",
        stackInserter = "5d-bulk-inserter-05",
        stackFilterInserter = "5d-bulk-filter-inserter-05"
    },
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
            { type = "item", name = "5d-inserter-04",     amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "5d-inserter-05",       amount = 1 },
            { type = "item", name = "5d-bulk-inserter-04", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "5d-inserter-06",
        filterInserter = "5d-filter-inserter-06",
        stackInserter = "5d-bulk-inserter-06",
        stackFilterInserter = "5d-bulk-filter-inserter-06"
    },
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
            { type = "item", name = "5d-inserter-05",     amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "5d-inserter-06",       amount = 1 },
            { type = "item", name = "5d-bulk-inserter-05", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "5d-inserter-07",
        filterInserter = "5d-filter-inserter-07",
        stackInserter = "5d-bulk-inserter-07",
        stackFilterInserter = "5d-bulk-filter-inserter-07"
    },
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
            { type = "item", name = "5d-inserter-05",     amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "5d-inserter-06",       amount = 1 },
            { type = "item", name = "5d-bulk-inserter-05", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "5d-inserter-07",
        filterInserter = "5d-filter-inserter-07",
        stackInserter = "5d-bulk-inserter-07",
        stackFilterInserter = "5d-bulk-filter-inserter-07"
    },
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
            { type = "item", name = "5d-inserter-06",     amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "5d-inserter-07",       amount = 1 },
            { type = "item", name = "5d-bulk-inserter-06", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "5d-inserter-08",
        filterInserter = "5d-filter-inserter-08",
        stackInserter = "5d-bulk-inserter-08",
        stackFilterInserter = "5d-bulk-filter-inserter-08"
    },
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
            { type = "item", name = "5d-inserter-07",     amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "5d-inserter-08",       amount = 1 },
            { type = "item", name = "5d-bulk-inserter-07", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "5d-inserter-09",
        filterInserter = "5d-filter-inserter-09",
        stackInserter = "5d-bulk-inserter-09",
        stackFilterInserter = "5d-bulk-filter-inserter-09"
    },
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
            { type = "item", name = "5d-inserter-08",     amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "5d-inserter-09",       amount = 1 },
            { type = "item", name = "5d-bulk-inserter-08", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
        },
    },
    nextUpdate = {
        inserter = "5d-inserter-10",
        filterInserter = "5d-filter-inserter-10",
        stackInserter = "5d-bulk-inserter-10",
        stackFilterInserter = "5d-bulk-filter-inserter-10"
    },
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
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
            { type = "item", name = "5d-inserter-09",     amount = 1 },
            { type = "item", name = "electronic-circuit", amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 1 },
            { type = "item", name = "iron-plate",         amount = 1 }
        },
        stackInserter = {
            { type = "item", name = "5d-inserter-10",       amount = 1 },
            { type = "item", name = "5d-bulk-inserter-09", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
        },
    },
    nextUpdate = {
        -- inserter = "fast-inserter",
        -- filterInserter = "5d-filter-inserter-04",
        -- stackInserter = "5d-bulk-inserter-04",
        -- stackFilterInserter = "5d-bulk-filter-inserter-04"
    },
    tech = {
        number = 10,
        count = techCount * 10,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            "stack-inserter-9",
            "logistics-10"
        }
    },
    copyName = "fast-inserter"
}
