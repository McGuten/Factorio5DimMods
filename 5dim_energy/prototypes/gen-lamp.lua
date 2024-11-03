require("__5dim_core__.lib.energy.generation-lamp")

local energy = 5
local size = 40
local techCount = 100

-- Electric furnace 01
genLamps {
    number = "01",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
    },
    nextUpdate = "5d-lamp-02",
    tech = nil
}

size = size + 20
energy = energy + 15

-- Electric furnace 02
genLamps {
    number = "02",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "small-lamp",         amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
    },
    nextUpdate = "5d-lamp-03",
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "lamp",
            "logistic-science-pack"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 03
genLamps {
    number = "03",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-lamp-02",         amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
    },
    nextUpdate = "5d-lamp-04",
    tech = {
        number = 3,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "lamp-2",
            "chemical-science-pack"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 04
genLamps {
    number = "04",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-lamp-03",         amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
    },
    nextUpdate = "5d-lamp-05",
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
            "lamp-3"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 05
genLamps {
    number = "05",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-lamp-04",         amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
    },
    nextUpdate = "5d-lamp-06",
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "lamp-4",
            "production-science-pack"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 06
genLamps {
    number = "06",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-lamp-05",         amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
    },
    nextUpdate = "5d-lamp-07",
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
            "lamp-5"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 07
genLamps {
    number = "07",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-lamp-06",         amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
    },
    nextUpdate = "5d-lamp-08",
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
            "lamp-6",
            "utility-science-pack"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 08
genLamps {
    number = "08",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-lamp-07",         amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
    },
    nextUpdate = "5d-lamp-09",
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
            "lamp-7"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 09
genLamps {
    number = "09",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-lamp-08",         amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
    },
    nextUpdate = "5d-lamp-10",
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
            "lamp-8"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 10
genLamps {
    number = "10",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-lamp-09",         amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 1 },
        { type = "item", name = "copper-cable",       amount = 3 },
        { type = "item", name = "iron-plate",         amount = 1 }
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
            "lamp-9"
        }
    }
}
