require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local rango = 18
local shootingSpeed = 25
local damageModif = 1.2
local color = {r = 1, g = 1, b = 0.1, a = 1}
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
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 6}
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turrets-small-1",
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "laser-turrets",
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
        {"5d-laser-turret-small-01", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2},
        {"battery", 2}
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turrets-small-2",
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-1",
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
        {"5d-laser-turret-small-02", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2},
        {"battery", 2}
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turrets-small-3",
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-2",
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
        {"5d-laser-turret-small-03", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2},
        {"battery", 2}
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turrets-small-4",
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-3"
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
        {"5d-laser-turret-small-04", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2},
        {"battery", 2}
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turrets-small-5",
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-4",
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
        {"5d-laser-turret-small-05", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2},
        {"battery", 2}
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turrets-small-6",
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-5"
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
        {"5d-laser-turret-small-06", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2},
        {"battery", 2}
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turrets-small-7",
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-6",
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
        {"5d-laser-turret-small-07", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2},
        {"battery", 2}
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turrets-small-8",
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-7"
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
        {"5d-laser-turret-small-08", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2},
        {"battery", 2}
    },
    nextUpdate = "5d-laser-turret-small-02",
    tech = {
        number = "5d-laser-turrets-small-9",
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-8"
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
        {"5d-laser-turret-small-09", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2},
        {"battery", 2}
    },
    tech = {
        number = "5d-laser-turrets-small-10",
        count = techCount * 10,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-9"
        }
    }
}
