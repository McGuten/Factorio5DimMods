require("__5dim_core__.lib.battlefield.gun-turret.generation-gun-turret")

local rango = 12
local ammo = 15
local shootingSpeed = 4
local damageModif = 0.6
local color = {r = 1, g = 1, b = 0.1, a = 1}

-- Small gun turret 01
genGunTurrets {
    number = "small-01",
    subgroup = "defense-gun-turret-small",
    order = "a",
    new = true,
    ammoCount = ammo,
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

-- Small gun turret 02
genGunTurrets {
    number = "small-02",
    subgroup = "defense-gun-turret-small",
    order = "b",
    new = true,
    ammoCount = ammo,
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

-- Small gun turret 03
genGunTurrets {
    number = "small-03",
    subgroup = "defense-gun-turret-small",
    order = "c",
    new = true,
    ammoCount = ammo,
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

-- Small gun turret 04
genGunTurrets {
    number = "small-04",
    subgroup = "defense-gun-turret-small",
    order = "d",
    new = true,
    ammoCount = ammo,
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

-- Small gun turret 05
genGunTurrets {
    number = "small-05",
    subgroup = "defense-gun-turret-small",
    order = "e",
    new = true,
    ammoCount = ammo,
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

-- Small gun turret 06
genGunTurrets {
    number = "small-06",
    subgroup = "defense-gun-turret-small",
    order = "f",
    new = true,
    ammoCount = ammo,
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

-- Small gun turret 07
genGunTurrets {
    number = "small-07",
    subgroup = "defense-gun-turret-small",
    order = "g",
    new = true,
    ammoCount = ammo,
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

-- Small gun turret 08
genGunTurrets {
    number = "small-08",
    subgroup = "defense-gun-turret-small",
    order = "h",
    new = true,
    ammoCount = ammo,
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

-- Small gun turret 09
genGunTurrets {
    number = "small-09",
    subgroup = "defense-gun-turret-small",
    order = "i",
    new = true,
    ammoCount = ammo,
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

-- Small gun turret 10
genGunTurrets {
    number = "small-10",
    subgroup = "defense-gun-turret-small",
    order = "j",
    new = true,
    ammoCount = ammo,
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
