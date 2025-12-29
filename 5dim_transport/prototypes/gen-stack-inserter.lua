require("__5dim_core__.lib.transport.generation-stack-inserter")

local rotation = 0.014
local extension = 0.03
local energy = 5
local drain = 0.4
local techCount = 200

-- Stack inserter 01
genStackInserters {
    number = "01",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "bulk-inserter",   amount = 1 },
        { type = "item", name = "processing-unit", amount = 1 },
        { type = "item", name = "carbon-fiber",    amount = 2 },
        { type = "item", name = "jelly",           amount = 10 }
    },
    tech = nil,
    nextUpdate = "5d-stack-inserter-02",
    copyName = "stack-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Stack inserter 02
genStackInserters {
    number = "02",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "stack-inserter",  amount = 1 },
        { type = "item", name = "processing-unit", amount = 1 },
        { type = "item", name = "carbon-fiber",    amount = 2 },
        { type = "item", name = "jelly",           amount = 10 }
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
            "stack-inserter",
            "logistics-2",
            "chemical-science-pack"
        }
    },
    nextUpdate = "5d-stack-inserter-03",
    copyName = "stack-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Stack inserter 03
genStackInserters {
    number = "03",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-stack-inserter-02", amount = 1 },
        { type = "item", name = "iron-gear-wheel",      amount = 15 },
        { type = "item", name = "electronic-circuit",   amount = 15 },
        { type = "item", name = "advanced-circuit",     amount = 1 }
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
    nextUpdate = "5d-stack-inserter-04",
    copyName = "stack-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Stack inserter 04
if mods["space-age"] then
    -- Stack inserter 04
    genStackInserters {
        number = "04",
        extensionSpeed = extension,
        rotationSpeed = rotation,
        energyMovement = energy,
        energyRotation = energy,
        energyDrain = drain,
        new = true,
        order = "d",
        ingredients = {
            { type = "item", name = "5d-stack-inserter-03", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
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
                "turbo-transport-belt"
            }
        },
        nextUpdate = "5d-stack-inserter-05",
        copyName = "stack-inserter"
    }
else
    genStackInserters {
        number = "04",
        extensionSpeed = extension,
        rotationSpeed = rotation,
        energyMovement = energy,
        energyRotation = energy,
        energyDrain = drain,
        new = true,
        order = "d",
        ingredients = {
            { type = "item", name = "5d-stack-inserter-03", amount = 1 },
            { type = "item", name = "iron-gear-wheel",      amount = 15 },
            { type = "item", name = "electronic-circuit",   amount = 15 },
            { type = "item", name = "advanced-circuit",     amount = 1 }
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
        nextUpdate = "5d-stack-inserter-05",
        copyName = "stack-inserter"
    }
end

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Stack inserter 05
genStackInserters {
    number = "05",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-stack-inserter-04", amount = 1 },
        { type = "item", name = "iron-gear-wheel",      amount = 15 },
        { type = "item", name = "electronic-circuit",   amount = 15 },
        { type = "item", name = "advanced-circuit",     amount = 1 }
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
    nextUpdate = "5d-stack-inserter-06",
    copyName = "stack-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Stack inserter 06
genStackInserters {
    number = "06",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-stack-inserter-05", amount = 1 },
        { type = "item", name = "iron-gear-wheel",      amount = 15 },
        { type = "item", name = "electronic-circuit",   amount = 15 },
        { type = "item", name = "advanced-circuit",     amount = 1 }
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
    nextUpdate = "5d-stack-inserter-07",
    copyName = "stack-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Stack inserter 07
genStackInserters {
    number = "07",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-stack-inserter-06", amount = 1 },
        { type = "item", name = "iron-gear-wheel",      amount = 15 },
        { type = "item", name = "electronic-circuit",   amount = 15 },
        { type = "item", name = "advanced-circuit",     amount = 1 }
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
    nextUpdate = "5d-stack-inserter-08",
    copyName = "stack-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Stack inserter 08
genStackInserters {
    number = "08",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-stack-inserter-07", amount = 1 },
        { type = "item", name = "iron-gear-wheel",      amount = 15 },
        { type = "item", name = "electronic-circuit",   amount = 15 },
        { type = "item", name = "advanced-circuit",     amount = 1 }
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
    nextUpdate = "5d-stack-inserter-09",
    copyName = "stack-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Stack inserter 09
genStackInserters {
    number = "09",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-stack-inserter-08", amount = 1 },
        { type = "item", name = "iron-gear-wheel",      amount = 15 },
        { type = "item", name = "electronic-circuit",   amount = 15 },
        { type = "item", name = "advanced-circuit",     amount = 1 }
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
            "bulk-inserter-8",
            "space-science-pack",
            "logistics-9"
        }
    },
    nextUpdate = "5d-stack-inserter-10",
    copyName = "stack-inserter"
}

extension = extension + 0.02
rotation = rotation + 0.02
energy = energy + 2
drain = drain + 0.02

-- Stack inserter 10
genStackInserters {
    number = "10",
    extensionSpeed = extension,
    rotationSpeed = rotation,
    energyMovement = energy,
    energyRotation = energy,
    energyDrain = drain,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-stack-inserter-09", amount = 1 },
        { type = "item", name = "iron-gear-wheel",      amount = 15 },
        { type = "item", name = "electronic-circuit",   amount = 15 },
        { type = "item", name = "advanced-circuit",     amount = 1 }
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
    nextUpdate = nil,
    copyName = "stack-inserter"
}
