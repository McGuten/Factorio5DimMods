require("__5dim_core__.lib.trains.generation-fluid-wagon")

local speed = 1.5
local maxCargo = 25000
local weightWagon = 2000
local techCount = 100

-- Electric furnace 01
genFluidWagons {
    number = "01",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "steel-plate",     amount = 16 },
        { type = "item", name = "pipe",            amount = 8 },
        { type = "item", name = "storage-tank",    amount = 1 }
    },
    tech = nil
}

speed = speed + 0.17
maxCargo = maxCargo + 25000
weightWagon = weightWagon + 500

-- Electric furnace 02
genFluidWagons {
    number = "02",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "fluid-wagon",     amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "steel-plate",     amount = 16 },
        { type = "item", name = "pipe",            amount = 8 },
        { type = "item", name = "storage-tank",    amount = 1 }
    },
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "fluid-wagon",
            "logistic-science-pack"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 25000
weightWagon = weightWagon + 500

-- Electric furnace 03
genFluidWagons {
    number = "03",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-fluid-wagon-02", amount = 1 },
        { type = "item", name = "iron-gear-wheel",   amount = 10 },
        { type = "item", name = "steel-plate",       amount = 16 },
        { type = "item", name = "pipe",              amount = 8 },
        { type = "item", name = "storage-tank",      amount = 1 }
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
            "fluid-wagon-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 25000
weightWagon = weightWagon + 500

-- Electric furnace 04
genFluidWagons {
    number = "04",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-fluid-wagon-03",  amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "steel-plate",        amount = 16 },
        { type = "item", name = "pipe",               amount = 8 },
        { type = "item", name = "storage-tank",       amount = 1 }
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
            "fluid-wagon-3",
            "production-science-pack"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 25000
weightWagon = weightWagon + 500

-- Electric furnace 05
genFluidWagons {
    number = "05",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-fluid-wagon-04",  amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "steel-plate",        amount = 16 },
        { type = "item", name = "pipe",               amount = 8 },
        { type = "item", name = "storage-tank",       amount = 1 }
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
            "fluid-wagon-4"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 25000
weightWagon = weightWagon + 500

-- Electric furnace 06
genFluidWagons {
    number = "06",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-fluid-wagon-05", amount = 1 },
        { type = "item", name = "advanced-circuit",  amount = 10 },
        { type = "item", name = "steel-plate",       amount = 16 },
        { type = "item", name = "pipe",              amount = 8 },
        { type = "item", name = "storage-tank",      amount = 1 }
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
            "fluid-wagon-5"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 25000
weightWagon = weightWagon + 500

-- Electric furnace 07
genFluidWagons {
    number = "07",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-fluid-wagon-06", amount = 1 },
        { type = "item", name = "advanced-circuit",  amount = 10 },
        { type = "item", name = "steel-plate",       amount = 16 },
        { type = "item", name = "pipe",              amount = 8 },
        { type = "item", name = "storage-tank",      amount = 1 }
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
            "fluid-wagon-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 25000
weightWagon = weightWagon + 500

-- Electric furnace 08
genFluidWagons {
    number = "08",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-fluid-wagon-07",     amount = 1 },
        { type = "item", name = "advanced-circuit",      amount = 10 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "pipe",                  amount = 8 },
        { type = "item", name = "storage-tank",          amount = 1 }
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
            "fluid-wagon-7"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 25000
weightWagon = weightWagon + 500

-- Electric furnace 09
genFluidWagons {
    number = "09",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-fluid-wagon-08",     amount = 1 },
        { type = "item", name = "advanced-circuit",      amount = 10 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "pipe",                  amount = 8 },
        { type = "item", name = "storage-tank",          amount = 1 }
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
            "fluid-wagon-8"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 25000
weightWagon = weightWagon + 500

-- Electric furnace 10
genFluidWagons {
    number = "10",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-fluid-wagon-09",     amount = 1 },
        { type = "item", name = "processing-unit",       amount = 5 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "pipe",                  amount = 8 },
        { type = "item", name = "storage-tank",          amount = 1 }
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
            "fluid-wagon-9"
        }
    }
}
