require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local rango = 62
local shootingSpeed = 120
local damageModif = 50
local color = {r = 0, g = 1, b = 1, a = 1}
local hp = 1400
local techCount = 200

-- Sniper laser turret 01
genLaserTurrets {
    number = "sniper-01",
    subgroup = "defense-laser-turret-sniper",
    order = "a",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
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
    nextUpdate = "5d-laser-turret-sniper-02",
    tech = {
        number = "5d-laser-turret-sniper-1",
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-5"
        }
    }
}

rango = rango + 2
hp = hp + 140

-- Sniper laser turret 02
genLaserTurrets {
    number = "sniper-02",
    subgroup = "defense-laser-turret-sniper",
    order = "b",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-sniper-01", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 7}
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
    nextUpdate = "5d-laser-turret-sniper-03",
    tech = {
        number = "5d-laser-turret-sniper-2",
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-sniper-1"
        }
    }
}

rango = rango + 2
hp = hp + 140

-- Sniper laser turret 03
genLaserTurrets {
    number = "sniper-03",
    subgroup = "defense-laser-turret-sniper",
    order = "c",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-sniper-02", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 7}
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
    nextUpdate = "5d-laser-turret-sniper-04",
    tech = {
        number = "5d-laser-turret-sniper-3",
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-sniper-2"
        }
    }
}

rango = rango + 2
hp = hp + 140

-- Sniper laser turret 04
genLaserTurrets {
    number = "sniper-04",
    subgroup = "defense-laser-turret-sniper",
    order = "d",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-sniper-03", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 7}
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
    nextUpdate = "5d-laser-turret-sniper-05",
    tech = {
        number = "5d-laser-turret-sniper-4",
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-sniper-3",
            "utility-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 140

-- Sniper laser turret 05
genLaserTurrets {
    number = "sniper-05",
    subgroup = "defense-laser-turret-sniper",
    order = "e",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-sniper-04", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 7}
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
    nextUpdate = "5d-laser-turret-sniper-06",
    tech = {
        number = "5d-laser-turret-sniper-5",
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-sniper-4"
        }
    }
}

rango = rango + 2
hp = hp + 140

-- Sniper laser turret 06
genLaserTurrets {
    number = "sniper-06",
    subgroup = "defense-laser-turret-sniper",
    order = "f",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-sniper-05", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 7}
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
    nextUpdate = "5d-laser-turret-sniper-07",
    tech = {
        number = "5d-laser-turret-sniper-6",
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-sniper-5"
        }
    }
}

rango = rango + 2
hp = hp + 140

-- Sniper laser turret 07
genLaserTurrets {
    number = "sniper-07",
    subgroup = "defense-laser-turret-sniper",
    order = "g",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-sniper-06", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 7}
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
    nextUpdate = "5d-laser-turret-sniper-08",
    tech = {
        number = "5d-laser-turret-sniper-7",
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-sniper-6"
        }
    }
}

rango = rango + 2
hp = hp + 140

-- Sniper laser turret 08
genLaserTurrets {
    number = "sniper-08",
    subgroup = "defense-laser-turret-sniper",
    order = "h",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-sniper-07", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 7}
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
    nextUpdate = "5d-laser-turret-sniper-09",
    tech = {
        number = "5d-laser-turret-sniper-8",
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-sniper-7"
        }
    }
}

rango = rango + 2
hp = hp + 140

-- Sniper laser turret 09
genLaserTurrets {
    number = "sniper-09",
    subgroup = "defense-laser-turret-sniper",
    order = "i",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-sniper-08", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 7}
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
    nextUpdate = "5d-laser-turret-sniper-10",
    tech = {
        number = "5d-laser-turret-sniper-9",
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-sniper-8"
        }
    }
}

rango = rango + 2
hp = hp + 140

-- Sniper laser turret 10
genLaserTurrets {
    number = "sniper-10",
    subgroup = "defense-laser-turret-sniper",
    order = "j",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-sniper-09", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 7}
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
        number = "5d-laser-turret-sniper-10",
        count = techCount * 10,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-sniper-9"
        }
    }
}
