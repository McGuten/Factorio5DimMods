require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local rango = 18
local shootingSpeed = 20
local damageModif = 1.1
local color = { r = 1, g = 1, b = 0.1, a = 1 }
local hp = 800
local techCount = 50

-- Small laser turret 01
genLaserTurrets {
    number = "small-01",
    subgroup = "defense-laser-turret-small",
    order = "a",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "steel-plate",        amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery",            amount = 6 }
    },
    resistances = {
        {
            type = "fire",
            percent = 5
        },
        {
            type = "explosion",
            percent = 2.5
        }
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turret-small-1",
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "laser-turret",
            "logistic-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 80

-- Small laser turret 02
genLaserTurrets {
    number = "small-02",
    subgroup = "defense-laser-turret-small",
    order = "b",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-small-01", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 2 },
        { type = "item", name = "electronic-circuit",       amount = 2 },
        { type = "item", name = "battery",                  amount = 2 }
    },
    resistances = {
        {
            type = "fire",
            percent = 15
        },
        {
            type = "explosion",
            percent = 7.5
        }
    },
    nextUpdate = "5d-laser-turret-small-03",
    tech = {
        number = "5d-laser-turret-small-2",
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-laser-turret-small-1",
            "logistic-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 80

-- Small laser turret 03
genLaserTurrets {
    number = "small-03",
    subgroup = "defense-laser-turret-small",
    order = "c",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-small-02", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 2 },
        { type = "item", name = "electronic-circuit",       amount = 2 },
        { type = "item", name = "battery",                  amount = 2 }
    },
    resistances = {
        {
            type = "fire",
            percent = 15
        },
        {
            type = "explosion",
            percent = 7.5
        }
    },
    nextUpdate = "5d-laser-turret-small-04",
    tech = {
        number = "5d-laser-turret-small-3",
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-laser-turret-small-2",
            "chemical-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 80

-- Small laser turret 04
genLaserTurrets {
    number = "small-04",
    subgroup = "defense-laser-turret-small",
    order = "d",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-small-03", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 2 },
        { type = "item", name = "electronic-circuit",       amount = 2 },
        { type = "item", name = "battery",                  amount = 2 }
    },
    resistances = {
        {
            type = "fire",
            percent = 20
        },
        {
            type = "explosion",
            percent = 10
        }
    },
    nextUpdate = "5d-laser-turret-small-05",
    tech = {
        number = "5d-laser-turret-small-4",
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-laser-turret-small-3"
        }
    }
}

rango = rango + 2
hp = hp + 80

-- Small laser turret 05
genLaserTurrets {
    number = "small-05",
    subgroup = "defense-laser-turret-small",
    order = "e",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-small-04", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 2 },
        { type = "item", name = "electronic-circuit",       amount = 2 },
        { type = "item", name = "battery",                  amount = 2 }
    },
    resistances = {
        {
            type = "fire",
            percent = 25
        },
        {
            type = "explosion",
            percent = 12.5
        }
    },
    nextUpdate = "5d-laser-turret-small-06",
    tech = {
        number = "5d-laser-turret-small-5",
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-laser-turret-small-4",
            "production-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 80

-- Small laser turret 06
genLaserTurrets {
    number = "small-06",
    subgroup = "defense-laser-turret-small",
    order = "f",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-small-05", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 2 },
        { type = "item", name = "electronic-circuit",       amount = 2 },
        { type = "item", name = "battery",                  amount = 2 }
    },
    resistances = {
        {
            type = "fire",
            percent = 30
        },
        {
            type = "explosion",
            percent = 15
        }
    },
    nextUpdate = "5d-laser-turret-small-07",
    tech = {
        number = "5d-laser-turret-small-6",
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-laser-turret-small-5"
        }
    }
}

rango = rango + 2
hp = hp + 80

-- Small laser turret 07
genLaserTurrets {
    number = "small-07",
    subgroup = "defense-laser-turret-small",
    order = "g",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-small-06", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 2 },
        { type = "item", name = "electronic-circuit",       amount = 2 },
        { type = "item", name = "battery",                  amount = 2 }
    },
    resistances = {
        {
            type = "fire",
            percent = 35
        },
        {
            type = "explosion",
            percent = 17.5
        }
    },
    nextUpdate = "5d-laser-turret-small-08",
    tech = {
        number = "5d-laser-turret-small-7",
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-laser-turret-small-6",
            "utility-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 80

-- Small laser turret 08
genLaserTurrets {
    number = "small-08",
    subgroup = "defense-laser-turret-small",
    order = "h",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-small-07", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 2 },
        { type = "item", name = "electronic-circuit",       amount = 2 },
        { type = "item", name = "battery",                  amount = 2 }
    },
    resistances = {
        {
            type = "fire",
            percent = 40
        },
        {
            type = "explosion",
            percent = 20
        }
    },
    nextUpdate = "5d-laser-turret-small-09",
    tech = {
        number = "5d-laser-turret-small-8",
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-laser-turret-small-7"
        }
    }
}

rango = rango + 2
hp = hp + 80

-- Small laser turret 09
genLaserTurrets {
    number = "small-09",
    subgroup = "defense-laser-turret-small",
    order = "i",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-small-08", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 2 },
        { type = "item", name = "electronic-circuit",       amount = 2 },
        { type = "item", name = "battery",                  amount = 2 }
    },
    resistances = {
        {
            type = "fire",
            percent = 45
        },
        {
            type = "explosion",
            percent = 22.5
        }
    },
    nextUpdate = "5d-laser-turret-small-10",
    tech = {
        number = "5d-laser-turret-small-9",
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-laser-turret-small-8"
        }
    }
}

rango = rango + 2
hp = hp + 80

-- Small laser turret 10
genLaserTurrets {
    number = "small-10",
    subgroup = "defense-laser-turret-small",
    order = "j",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-small-09", amount = 1 },
        { type = "item", name = "steel-plate",              amount = 2 },
        { type = "item", name = "electronic-circuit",       amount = 2 },
        { type = "item", name = "battery",                  amount = 2 }
    },
    resistances = {
        {
            type = "fire",
            percent = 50
        },
        {
            type = "explosion",
            percent = 25
        }
    },
    tech = {
        number = "5d-laser-turret-small-10",
        count = techCount * 10,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-laser-turret-small-9"
        }
    }
}
