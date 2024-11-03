require("__5dim_core__.lib.battlefield.gun-turret.generation-gun-turret")

local rango = 12
local ammo = 15
local shootingSpeed = 4
local damageModif = 0.55
local color = { r = 1, g = 1, b = 0.1, a = 1 }
local hp = 400
local techCount = 50

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "iron-gear-wheel", amount = 7 },
        { type = "item", name = "copper-plate",    amount = 7 },
        { type = "item", name = "iron-plate",      amount = 13 }
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
    nextUpdate = "5d-gun-turret-small-02",
    tech = {
        number = "5d-gun-turret-small-1",
        count = 20,
        packs = {
            { "automation-science-pack", 1 }
        },
        prerequisites = {
            "gun-turret"
        }
    }
}

rango = rango + 2
hp = hp + 40

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-gun-turret-small-01", amount = 1 },
        { type = "item", name = "iron-gear-wheel",        amount = 3 },
        { type = "item", name = "copper-plate",           amount = 3 },
        { type = "item", name = "iron-plate",             amount = 5 }
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
    nextUpdate = "5d-gun-turret-small-03",
    tech = {
        number = "5d-gun-turret-small-2",
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 }
        },
        prerequisites = {
            "5d-gun-turret-small-1"
        }
    }
}

rango = rango + 2
hp = hp + 40

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-gun-turret-small-02", amount = 1 },
        { type = "item", name = "iron-gear-wheel",        amount = 3 },
        { type = "item", name = "copper-plate",           amount = 3 },
        { type = "item", name = "iron-plate",             amount = 5 }
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
    nextUpdate = "5d-gun-turret-small-04",
    tech = {
        number = "5d-gun-turret-small-3",
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 }
        },
        prerequisites = {
            "5d-gun-turret-small-2"
        }
    }
}

rango = rango + 2
hp = hp + 40

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-gun-turret-small-03", amount = 1 },
        { type = "item", name = "iron-gear-wheel",        amount = 3 },
        { type = "item", name = "copper-plate",           amount = 3 },
        { type = "item", name = "iron-plate",             amount = 5 }
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
    nextUpdate = "5d-gun-turret-small-05",
    tech = {
        number = "5d-gun-turret-small-4",
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "5d-gun-turret-small-3",
            "logistic-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 40

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-gun-turret-small-04", amount = 1 },
        { type = "item", name = "iron-gear-wheel",        amount = 3 },
        { type = "item", name = "copper-plate",           amount = 3 },
        { type = "item", name = "iron-plate",             amount = 5 }
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
    nextUpdate = "5d-gun-turret-small-06",
    tech = {
        number = "5d-gun-turret-small-5",
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "5d-gun-turret-small-4",
            "production-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 40

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-gun-turret-small-05", amount = 1 },
        { type = "item", name = "iron-gear-wheel",        amount = 3 },
        { type = "item", name = "copper-plate",           amount = 3 },
        { type = "item", name = "iron-plate",             amount = 5 }
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
    nextUpdate = "5d-gun-turret-small-07",
    tech = {
        number = "5d-gun-turret-small-6",
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 }
        },
        prerequisites = {
            "5d-gun-turret-small-5",
            "military-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 40

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-gun-turret-small-06", amount = 1 },
        { type = "item", name = "iron-gear-wheel",        amount = 3 },
        { type = "item", name = "copper-plate",           amount = 3 },
        { type = "item", name = "iron-plate",             amount = 5 }
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
    nextUpdate = "5d-gun-turret-small-08",
    tech = {
        number = "5d-gun-turret-small-7",
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 }
        },
        prerequisites = {
            "5d-gun-turret-small-6"
        }
    }
}

rango = rango + 2
hp = hp + 40

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-gun-turret-small-07", amount = 1 },
        { type = "item", name = "iron-gear-wheel",        amount = 3 },
        { type = "item", name = "copper-plate",           amount = 3 },
        { type = "item", name = "iron-plate",             amount = 5 }
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
    nextUpdate = "5d-gun-turret-small-09",
    tech = {
        number = "5d-gun-turret-small-8",
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 }
        },
        prerequisites = {
            "5d-gun-turret-small-7"
        }
    }
}

rango = rango + 2
hp = hp + 40

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-gun-turret-small-08", amount = 1 },
        { type = "item", name = "iron-gear-wheel",        amount = 3 },
        { type = "item", name = "copper-plate",           amount = 3 },
        { type = "item", name = "iron-plate",             amount = 5 }
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
    nextUpdate = "5d-gun-turret-small-10",
    tech = {
        number = "5d-gun-turret-small-9",
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-gun-turret-small-8",
            "chemical-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 40

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
    health = hp,
    tint = color,
    ingredients = {
        { type = "item", name = "5d-gun-turret-small-09", amount = 1 },
        { type = "item", name = "iron-gear-wheel",        amount = 3 },
        { type = "item", name = "copper-plate",           amount = 3 },
        { type = "item", name = "iron-plate",             amount = 5 }
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
        number = "5d-gun-turret-small-10",
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-gun-turret-small-9"
        }
    }
}
