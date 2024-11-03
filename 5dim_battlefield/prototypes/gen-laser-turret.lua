require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local rango = 26
local shootingSpeed = 40
local damageModif = 2
local color = { r = 1, g = 0.1, b = 0.1, a = 1 }
local hp = 1000
local techCount = 150

-- Laser turret 01
genLaserTurrets {
    number = "01",
    subgroup = "defense-laser-turret",
    order = "a",
    new = false,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "steel-plate",        amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 20 },
        { type = "item", name = "battery",            amount = 12 }
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
    nextUpdate = "5d-laser-turret-02",
    tech = nil
}

rango = rango + 2
hp = hp + 100

-- Laser turret 02
genLaserTurrets {
    number = "02",
    subgroup = "defense-laser-turret",
    order = "b",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "laser-turret",       amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
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
    nextUpdate = "5d-laser-turret-03",
    tech = {
        number = "laser-turret-2",
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "laser-turret"
        }
    }
}

rango = rango + 2
hp = hp + 100

-- Laser turret 03
genLaserTurrets {
    number = "03",
    subgroup = "defense-laser-turret",
    order = "c",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-02", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
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
    nextUpdate = "5d-laser-turret-04",
    tech = {
        number = "laser-turret-3",
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "laser-turret-2"
        }
    }
}

rango = rango + 2
hp = hp + 100

-- Laser turret 04
genLaserTurrets {
    number = "04",
    subgroup = "defense-laser-turret",
    order = "d",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-03", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
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
    nextUpdate = "5d-laser-turret-05",
    tech = {
        number = "laser-turret-4",
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "laser-turret-3"
        }
    }
}

rango = rango + 2
hp = hp + 100

-- Laser turret 05
genLaserTurrets {
    number = "05",
    subgroup = "defense-laser-turret",
    order = "e",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-04", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
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
    nextUpdate = "5d-laser-turret-06",
    tech = {
        number = "laser-turret-5",
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "laser-turret-4"
        }
    }
}

rango = rango + 2
hp = hp + 100

-- Laser turret 06
genLaserTurrets {
    number = "06",
    subgroup = "defense-laser-turret",
    order = "f",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-05", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
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
    nextUpdate = "5d-laser-turret-07",
    tech = {
        number = "laser-turret-6",
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "laser-turret-5"
        }
    }
}

rango = rango + 2
hp = hp + 100

-- Laser turret 07
genLaserTurrets {
    number = "07",
    subgroup = "defense-laser-turret",
    order = "g",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-06", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
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
    nextUpdate = "5d-laser-turret-08",
    tech = {
        number = "laser-turret-7",
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "laser-turret-6",
            "utility-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 100

-- Laser turret 08
genLaserTurrets {
    number = "08",
    subgroup = "defense-laser-turret",
    order = "h",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-07", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
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
    nextUpdate = "5d-laser-turret-09",
    tech = {
        number = "laser-turret-8",
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "laser-turret-7"
        }
    }
}

rango = rango + 2
hp = hp + 100

-- Laser turret 09
genLaserTurrets {
    number = "09",
    subgroup = "defense-laser-turret",
    order = "i",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-08", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
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
    nextUpdate = "5d-laser-turret-10",
    tech = {
        number = "laser-turret-9",
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "laser-turret-8"
        }
    }
}

rango = rango + 2
hp = hp + 100

-- Laser turret 10
genLaserTurrets {
    number = "10",
    subgroup = "defense-laser-turret",
    order = "j",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-laser-turret-09", amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
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
        number = "laser-turret-10",
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "laser-turret-9"
        }
    }
}
