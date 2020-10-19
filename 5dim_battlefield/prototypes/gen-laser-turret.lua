require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local rango = 26
local shootingSpeed = 40
local damageModif = 2
local color = {r = 1, g = 0.1, b = 0.1, a = 1}
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
        {"steel-plate", 20},
        {"electronic-circuit", 20},
        {"battery", 12}
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
        {"laser-turret", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"battery", 4}
    },
    nextUpdate = "5d-laser-turret-03",
    tech = {
        number = "laser-turrets-2",
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets"
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
        {"5d-laser-turret-02", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"battery", 4}
    },
    nextUpdate = "5d-laser-turret-04",
    tech = {
        number = "laser-turrets-3",
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets-2"
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
        {"5d-laser-turret-03", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"battery", 4}
    },
    nextUpdate = "5d-laser-turret-05",
    tech = {
        number = "laser-turrets-4",
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets-3"
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
        {"5d-laser-turret-04", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"battery", 4}
    },
    nextUpdate = "5d-laser-turret-06",
    tech = {
        number = "laser-turrets-5",
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets-4"
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
        {"5d-laser-turret-05", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"battery", 4}
    },
    nextUpdate = "5d-laser-turret-07",
    tech = {
        number = "laser-turrets-6",
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets-5"
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
        {"5d-laser-turret-06", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"battery", 4}
    },
    nextUpdate = "5d-laser-turret-08",
    tech = {
        number = "laser-turrets-7",
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets-6",
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
        {"5d-laser-turret-07", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"battery", 4}
    },
    nextUpdate = "5d-laser-turret-09",
    tech = {
        number = "laser-turrets-8",
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets-7"
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
        {"5d-laser-turret-08", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"battery", 4}
    },
    nextUpdate = "5d-laser-turret-10",
    tech = {
        number = "laser-turrets-9",
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets-8"
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
        {"5d-laser-turret-09", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
        {"battery", 4}
    },
    tech = {
        number = "laser-turrets-10",
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets-9"
        }
    }
}
