require("__5dim_core__.lib.battlefield.gun-turret.generation-gun-turret")

local rango = 42
local ammo = 5
local shootingSpeed = 18
local damageModif = 9
local color = {r = 0, g = 1, b = 1, a = 1}
local hp = 750
local techCount = 250

-- Sniper gun turret 01
genGunTurrets {
    number = "sniper-01",
    subgroup = "defense-gun-turret-sniper",
    order = "a",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 10},
        {"steel-plate", 5}
    },
    nextUpdate = "5d-gun-turret-sniper-02",
    tech = {
        number = "5d-turrets-sniper-1",
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-big-5",
            "military-science-pack"
        }
    }
}

rango = rango + 3
hp = hp + 75

-- Sniper gun turret 02
genGunTurrets {
    number = "sniper-02",
    subgroup = "defense-gun-turret-sniper",
    order = "b",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-sniper-01", 1},
        {"iron-gear-wheel", 6},
        {"electronic-circuit", 6},
        {"steel-plate", 3}
    },
    nextUpdate = "5d-gun-turret-sniper-03",
    tech = {
        number = "5d-turrets-sniper-2",
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-sniper-1",
            "logistic-science-pack"
        }
    }
}

rango = rango + 3
hp = hp + 75

-- Sniper gun turret 03
genGunTurrets {
    number = "sniper-03",
    subgroup = "defense-gun-turret-sniper",
    order = "c",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-sniper-02", 1},
        {"iron-gear-wheel", 6},
        {"electronic-circuit", 6},
        {"steel-plate", 3}
    },
    nextUpdate = "5d-gun-turret-sniper-04",
    tech = {
        number = "5d-turrets-sniper-3",
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-sniper-2"
        }
    }
}

rango = rango + 3
hp = hp + 75

-- Sniper gun turret 04
genGunTurrets {
    number = "sniper-04",
    subgroup = "defense-gun-turret-sniper",
    order = "d",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-sniper-03", 1},
        {"iron-gear-wheel", 6},
        {"electronic-circuit", 6},
        {"steel-plate", 3}
    },
    nextUpdate = "5d-gun-turret-sniper-05",
    tech = {
        number = "5d-turrets-sniper-4",
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-sniper-3"
        }
    }
}

rango = rango + 3
hp = hp + 75

-- Sniper gun turret 05
genGunTurrets {
    number = "sniper-05",
    subgroup = "defense-gun-turret-sniper",
    order = "e",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-sniper-04", 1},
        {"iron-gear-wheel", 6},
        {"electronic-circuit", 6},
        {"steel-plate", 3}
    },
    nextUpdate = "5d-gun-turret-sniper-06",
    tech = {
        number = "5d-turrets-sniper-5",
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-sniper-4"
        }
    }
}

rango = rango + 3
hp = hp + 75

-- Sniper gun turret 06
genGunTurrets {
    number = "sniper-06",
    subgroup = "defense-gun-turret-sniper",
    order = "f",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-sniper-05", 1},
        {"iron-gear-wheel", 6},
        {"electronic-circuit", 6},
        {"steel-plate", 3}
    },
    nextUpdate = "5d-gun-turret-sniper-07",
    tech = {
        number = "5d-turrets-sniper-6",
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-sniper-5"
        }
    }
}

rango = rango + 3
hp = hp + 75

-- Sniper gun turret 07
genGunTurrets {
    number = "sniper-07",
    subgroup = "defense-gun-turret-sniper",
    order = "g",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-sniper-06", 1},
        {"iron-gear-wheel", 6},
        {"electronic-circuit", 6},
        {"steel-plate", 3}
    },
    nextUpdate = "5d-gun-turret-sniper-08",
    tech = {
        number = "5d-turrets-sniper-7",
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-sniper-6"
        }
    }
}

rango = rango + 3
hp = hp + 75

-- Sniper gun turret 08
genGunTurrets {
    number = "sniper-08",
    subgroup = "defense-gun-turret-sniper",
    order = "h",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-sniper-07", 1},
        {"iron-gear-wheel", 6},
        {"electronic-circuit", 6},
        {"steel-plate", 3}
    },
    nextUpdate = "5d-gun-turret-sniper-09",
    tech = {
        number = "5d-turrets-sniper-8",
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-sniper-7"
        }
    }
}

rango = rango + 3
hp = hp + 75

-- Sniper gun turret 09
genGunTurrets {
    number = "sniper-09",
    subgroup = "defense-gun-turret-sniper",
    order = "i",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-sniper-08", 1},
        {"iron-gear-wheel", 6},
        {"electronic-circuit", 6},
        {"steel-plate", 3}
    },
    nextUpdate = "5d-gun-turret-sniper-10",
    tech = {
        number = "5d-turrets-sniper-9",
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-sniper-8"
        }
    }
}

rango = rango + 3
hp = hp + 75

-- Sniper gun turret 10
genGunTurrets {
    number = "sniper-10",
    subgroup = "defense-gun-turret-sniper",
    order = "j",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-sniper-09", 1},
        {"iron-gear-wheel", 6},
        {"electronic-circuit", 6},
        {"steel-plate", 3}
    },
    tech = {
        number = "5d-turrets-sniper-10",
        count = techCount * 10,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "5d-turrets-sniper-9"
        }
    }
}
