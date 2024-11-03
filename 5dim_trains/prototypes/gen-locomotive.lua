require("__5dim_core__.lib.trains.generation-locomotive")

local speed = 1.2
local energy = 600
local weightWagon = 2000
local maxHealth = 1000
local techCount = 100

-- Electric furnace 01
genLocomotives {
    number = "01",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "engine-unit",        amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "steel-plate",        amount = 30 }
    },
    tech = nil
}

speed = speed + 0.15
energy = energy + 100
weightWagon = weightWagon + 500
maxHealth = maxHealth + 250

-- Electric furnace 02
genLocomotives {
    number = "02",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "locomotive",         amount = 1 },
        { type = "item", name = "engine-unit",        amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "steel-plate",        amount = 30 },
        { type = "item", name = "pipe",               amount = 2 }
    },
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "railway"
        }
    }
}

speed = speed + 0.15
energy = energy + 100
weightWagon = weightWagon + 500
maxHealth = maxHealth + 250

-- Electric furnace 03
genLocomotives {
    number = "03",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-locomotive-02",   amount = 1 },
        { type = "item", name = "engine-unit",        amount = 15 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "steel-plate",        amount = 20 },
        { type = "item", name = "pipe",               amount = 5 }
    },
    tech = {
        number = 3,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-locomotive-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.15
energy = energy + 100
weightWagon = weightWagon + 500
maxHealth = maxHealth + 250

-- Electric furnace 04
genLocomotives {
    number = "04",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-locomotive-03", amount = 1 },
        { type = "item", name = "engine-unit",      amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "steel-plate",      amount = 20 },
        { type = "item", name = "pipe",             amount = 5 }
    },
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
            "5d-locomotive-3",
            "production-science-pack"
        }
    }
}

speed = speed + 0.15
energy = energy + 100
weightWagon = weightWagon + 500
maxHealth = maxHealth + 250

-- Electric furnace 05
genLocomotives {
    number = "05",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-locomotive-04", amount = 1 },
        { type = "item", name = "engine-unit",      amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "steel-plate",      amount = 20 },
        { type = "item", name = "pipe",             amount = 5 }
    },
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
            "5d-locomotive-4"
        }
    }
}

speed = speed + 0.15
energy = energy + 100
weightWagon = weightWagon + 500
maxHealth = maxHealth + 250

-- Electric furnace 06
genLocomotives {
    number = "06",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-locomotive-05", amount = 1 },
        { type = "item", name = "engine-unit",      amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "steel-plate",      amount = 20 },
        { type = "item", name = "pipe",             amount = 5 }
    },
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
            "5d-locomotive-5"
        }
    }
}

speed = speed + 0.15
energy = energy + 100
weightWagon = weightWagon + 500
maxHealth = maxHealth + 250

-- Electric furnace 07
genLocomotives {
    number = "07",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-locomotive-06",      amount = 1 },
        { type = "item", name = "engine-unit",           amount = 15 },
        { type = "item", name = "advanced-circuit",      amount = 5 },
        { type = "item", name = "low-density-structure", amount = 20 },
        { type = "item", name = "pipe",                  amount = 5 }
    },
    tech = {
        number = 7,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-locomotive-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.15
energy = energy + 100
weightWagon = weightWagon + 500
maxHealth = maxHealth + 250

-- Electric furnace 08
genLocomotives {
    number = "08",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-locomotive-07",      amount = 1 },
        { type = "item", name = "engine-unit",           amount = 15 },
        { type = "item", name = "processing-unit",       amount = 2 },
        { type = "item", name = "low-density-structure", amount = 20 },
        { type = "item", name = "pipe",                  amount = 5 }
    },
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
            "5d-locomotive-7"
        }
    }
}

speed = speed + 0.15
energy = energy + 100
weightWagon = weightWagon + 500
maxHealth = maxHealth + 250

-- Electric furnace 09
genLocomotives {
    number = "09",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-locomotive-08",      amount = 1 },
        { type = "item", name = "engine-unit",           amount = 15 },
        { type = "item", name = "processing-unit",       amount = 2 },
        { type = "item", name = "low-density-structure", amount = 20 },
        { type = "item", name = "pipe",                  amount = 5 }
    },
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
            "5d-locomotive-8"
        }
    }
}

speed = speed + 0.15
energy = energy + 100
weightWagon = weightWagon + 500
maxHealth = maxHealth + 250

-- Electric furnace 10
genLocomotives {
    number = "10",
    subgroup = "trains-locomotive",
    maxSpeed = speed,
    maxPower = energy,
    weight = weightWagon,
    health = maxHealth,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-locomotive-09",      amount = 1 },
        { type = "item", name = "engine-unit",           amount = 15 },
        { type = "item", name = "processing-unit",       amount = 2 },
        { type = "item", name = "low-density-structure", amount = 20 },
        { type = "item", name = "pipe",                  amount = 5 }
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
            "5d-locomotive-9"
        }
    }
}
