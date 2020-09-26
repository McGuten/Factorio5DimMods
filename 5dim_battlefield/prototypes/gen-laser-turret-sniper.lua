require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local rango = 50
local shootingSpeed = 25
local damageModif = 19
local color = {r = 0, g = 1, b = 1, a = 1}
local hp = 1400
local techCount = 500

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
    nextUpdate = "5d-laser-turret-sniper-02",
    tech = {
        number = "5d-laser-turrets-sniper-1",
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-big-5",
            "utility-science-pack"
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
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
    },
    nextUpdate = "5d-laser-turret-sniper-03",
    tech = {
        number = "5d-laser-turrets-sniper-2",
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-sniper-1"
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
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
    },
    nextUpdate = "5d-laser-turret-sniper-04",
    tech = {
        number = "5d-laser-turrets-sniper-3",
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-sniper-2",
            "chemical-science-pack"
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
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
    },
    nextUpdate = "5d-laser-turret-sniper-05",
    tech = {
        number = "5d-laser-turrets-sniper-4",
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-sniper-3"
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
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
    },
    nextUpdate = "5d-laser-turret-sniper-06",
    tech = {
        number = "5d-laser-turrets-sniper-5",
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-sniper-4",
            "production-science-pack"
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
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
    },
    nextUpdate = "5d-laser-turret-sniper-07",
    tech = {
        number = "5d-laser-turrets-sniper-6",
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-sniper-5"
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
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
    },
    nextUpdate = "5d-laser-turret-sniper-08",
    tech = {
        number = "5d-laser-turrets-sniper-7",
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-sniper-6",
            "utility-science-pack"
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
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
    },
    nextUpdate = "5d-laser-turret-sniper-09",
    tech = {
        number = "5d-laser-turrets-sniper-8",
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-sniper-7"
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
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
    },
    nextUpdate = "5d-laser-turret-sniper-10",
    tech = {
        number = "5d-laser-turrets-sniper-9",
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-sniper-8"
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
        {"steel-plate", 40},
        {"electronic-circuit", 40},
        {"battery", 25}
    },
    tech = {
        number = "5d-laser-turrets-sniper-10",
        count = techCount * 10,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-sniper-9"
        }
    }
}
