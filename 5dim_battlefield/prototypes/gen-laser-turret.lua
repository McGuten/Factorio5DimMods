require("__5dim_core__.lib.battlefield.laser-turret.generation-laser-turret")

local rango = 26
local shootingSpeed = 40
local damageModif = 2
local color = {r = 1, g = 0.1, b = 0.1, a = 1}

-- Laser turret 01
genLaserTurrets {
    number = "01",
    subgroup = "defense-laser-turret",
    order = "a",
    new = false,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = nil
}

rango = rango + 2

-- Laser turret 02
genLaserTurrets {
    number = "02",
    subgroup = "defense-laser-turret",
    order = "b",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 2,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators",
            "logistic-science-pack"
        }
    }
}

rango = rango + 2

-- Laser turret 03
genLaserTurrets {
    number = "03",
    subgroup = "defense-laser-turret",
    order = "c",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 3,
        count = 750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-2",
            "chemical-science-pack"
        }
    }
}

rango = rango + 2

-- Laser turret 04
genLaserTurrets {
    number = "04",
    subgroup = "defense-laser-turret",
    order = "d",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 4,
        count = 1000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-3"
        }
    }
}

rango = rango + 2

-- Laser turret 05
genLaserTurrets {
    number = "05",
    subgroup = "defense-laser-turret",
    order = "e",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 5,
        count = 1250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-4",
            "production-science-pack"
        }
    }
}

rango = rango + 2

-- Laser turret 06
genLaserTurrets {
    number = "06",
    subgroup = "defense-laser-turret",
    order = "f",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 6,
        count = 1500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-5"
        }
    }
}

rango = rango + 2

-- Laser turret 07
genLaserTurrets {
    number = "07",
    subgroup = "defense-laser-turret",
    order = "g",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 7,
        count = 1750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-6",
            "utility-science-pack"
        }
    }
}

rango = rango + 2

-- Laser turret 08
genLaserTurrets {
    number = "08",
    subgroup = "defense-laser-turret",
    order = "h",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 8,
        count = 2000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-7"
        }
    }
}

rango = rango + 2

-- Laser turret 09
genLaserTurrets {
    number = "09",
    subgroup = "defense-laser-turret",
    order = "i",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 9,
        count = 2250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-8"
        }
    }
}

rango = rango + 2

-- Laser turret 10
genLaserTurrets {
    number = "10",
    subgroup = "defense-laser-turret",
    order = "j",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 10,
        count = 2500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-9"
        }
    }
}
