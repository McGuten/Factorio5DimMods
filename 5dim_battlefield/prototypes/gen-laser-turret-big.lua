require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local rango = 42
local shootingSpeed = 80
local damageModif = 6
local color = {r = 0.2, g = 0.2, b = 1, a = 1}
local hp = 1200
local techCount = 150

-- Big laser turret 01
genLaserTurrets {
    number = "big-01",
    subgroup = "defense-laser-turret-big",
    order = "a",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"steel-plate", 30},
        {"electronic-circuit", 30},
        {"battery", 15}
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
    nextUpdate = "5d-laser-turret-big-02",
    tech = {
        number = "5d-laser-turret-big-1",
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "laser-turret",
            "logistic-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 120

-- Big laser turret 02
genLaserTurrets {
    number = "big-02",
    subgroup = "defense-laser-turret-big",
    order = "b",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-big-01", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 7},
        {"battery", 5}
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
    nextUpdate = "5d-laser-turret-big-03",
    tech = {
        number = "5d-laser-turret-big-2",
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-1",
            "logistic-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 120

-- Big laser turret 03
genLaserTurrets {
    number = "big-03",
    subgroup = "defense-laser-turret-big",
    order = "c",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-big-02", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 7},
        {"battery", 5}
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
    nextUpdate = "5d-laser-turret-big-04",
    tech = {
        number = "5d-laser-turret-big-3",
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-2",
            "chemical-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 120

-- Big laser turret 04
genLaserTurrets {
    number = "big-04",
    subgroup = "defense-laser-turret-big",
    order = "d",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-big-03", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 7},
        {"battery", 5}
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
    nextUpdate = "5d-laser-turret-big-05",
    tech = {
        number = "5d-laser-turret-big-4",
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-3"
        }
    }
}

rango = rango + 2
hp = hp + 120

-- Big laser turret 05
genLaserTurrets {
    number = "big-05",
    subgroup = "defense-laser-turret-big",
    order = "e",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-big-04", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 7},
        {"battery", 5}
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
    nextUpdate = "5d-laser-turret-big-06",
    tech = {
        number = "5d-laser-turret-big-5",
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-4",
            "production-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 120

-- Big laser turret 06
genLaserTurrets {
    number = "big-06",
    subgroup = "defense-laser-turret-big",
    order = "f",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-big-05", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 7},
        {"battery", 5}
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
    nextUpdate = "5d-laser-turret-big-07",
    tech = {
        number = "5d-laser-turret-big-6",
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-5"
        }
    }
}

rango = rango + 2
hp = hp + 120

-- Big laser turret 07
genLaserTurrets {
    number = "big-07",
    subgroup = "defense-laser-turret-big",
    order = "g",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-big-06", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 7},
        {"battery", 5}
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
    nextUpdate = "5d-laser-turret-big-08",
    tech = {
        number = "5d-laser-turret-big-7",
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-6",
            "utility-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 120

-- Big laser turret 08
genLaserTurrets {
    number = "big-08",
    subgroup = "defense-laser-turret-big",
    order = "h",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-big-07", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 7},
        {"battery", 5}
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
    nextUpdate = "5d-laser-turret-big-09",
    tech = {
        number = "5d-laser-turret-big-8",
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-7"
        }
    }
}

rango = rango + 2
hp = hp + 120

-- Big laser turret 09
genLaserTurrets {
    number = "big-09",
    subgroup = "defense-laser-turret-big",
    order = "i",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-big-08", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 7},
        {"battery", 5}
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
    nextUpdate = "5d-laser-turret-big-10",
    tech = {
        number = "5d-laser-turret-big-9",
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-8"
        }
    }
}

rango = rango + 2
hp = hp + 120

-- Big laser turret 10
genLaserTurrets {
    number = "big-10",
    subgroup = "defense-laser-turret-big",
    order = "j",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-laser-turret-big-09", 1},
        {"steel-plate", 7},
        {"electronic-circuit", 7},
        {"battery", 5}
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
        number = "5d-laser-turret-big-10",
        count = techCount * 10,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turret-big-9"
        }
    }
}
