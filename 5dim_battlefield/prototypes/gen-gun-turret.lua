require("__5dim_core__.lib.battlefield.gun-turret.generation-gun-turret")

local rango = 22
local ammo = 10
local shootingSpeed = 6
local damageModif = 1
local color = {r = 1, g = 0.1, b = 0.1, a = 1}
local hp = 480

-- Gun turret 01
genGunTurrets {
    number = "01",
    subgroup = "defense-gun-turret",
    order = "a",
    new = false,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = nil
}

rango = rango + 2
hp = hp + 48

-- Gun turret 02
genGunTurrets {
    number = "02",
    subgroup = "defense-gun-turret",
    order = "b",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"gun-turret", 1},
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = {
        number = "turrets-2",
        count = 50,
        packs = {
            {"automation-science-pack", 1}
        },
        prerequisites = {
            "turrets"
        }
    }
}

rango = rango + 2
hp = hp + 48

-- Gun turret 03
genGunTurrets {
    number = "03",
    subgroup = "defense-gun-turret",
    order = "c",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-02", 1},
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = {
        number = "turrets-3",
        count = 100,
        packs = {
            {"automation-science-pack", 1}
        },
        prerequisites = {
            "turrets-2"
        }
    }
}

rango = rango + 2
hp = hp + 48

-- Gun turret 04
genGunTurrets {
    number = "04",
    subgroup = "defense-gun-turret",
    order = "d",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-03", 1},
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = {
        number = "turrets-4",
        count = 150,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "turrets-3",
            "logistic-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 48

-- Gun turret 05
genGunTurrets {
    number = "05",
    subgroup = "defense-gun-turret",
    order = "e",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-04", 1},
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = {
        number = "turrets-5",
        count = 200,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "turrets-4"
        }
    }
}

rango = rango + 2
hp = hp + 48

-- Gun turret 06
genGunTurrets {
    number = "06",
    subgroup = "defense-gun-turret",
    order = "f",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-05", 1},
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = {
        number = "turrets-6",
        count = 250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "turrets-5",
            "military-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 48

-- Gun turret 07
genGunTurrets {
    number = "07",
    subgroup = "defense-gun-turret",
    order = "g",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-06", 1},
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = {
        number = "turrets-7",
        count = 300,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "turrets-6",
            "utility-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 48

-- Gun turret 08
genGunTurrets {
    number = "08",
    subgroup = "defense-gun-turret",
    order = "h",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-07", 1},
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = {
        number = "turrets-8",
        count = 350,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "turrets-7"
        }
    }
}

rango = rango + 2
hp = hp + 48

-- Gun turret 09
genGunTurrets {
    number = "09",
    subgroup = "defense-gun-turret",
    order = "i",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-08", 1},
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = {
        number = "turrets-9",
        count = 400,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "turrets-8",
            "chemical-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 48

-- Gun turret 10
genGunTurrets {
    number = "10",
    subgroup = "defense-gun-turret",
    order = "j",
    new = true,
    ammoCount = ammo,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-gun-turret-09", 1},
        {"iron-gear-wheel", 10},
        {"copper-plate", 10},
        {"iron-plate", 20}
    },
    tech = {
        number = "turrets-10",
        count = 450,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "turrets-9"
        }
    }
}
