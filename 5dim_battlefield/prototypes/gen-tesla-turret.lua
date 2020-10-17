require("__5dim_core__.lib.battlefield.tesla-turret.generation-tesla-turret")

local rango = 50
local shootingSpeed = 25
local damageModif = 23
local color = {r = 0.9, g = 0.1, b = 0.9, a = 1}
local hp = 1500
local techCount = 500

-- Tesla turret 01
genTeslaTurrets {
    number = "01",
    subgroup = "defense-tesla",
    order = "a",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"steel-plate", 50},
        {"electronic-circuit", 50},
        {"battery", 40}
    },
    nextUpdate = "5d-tesla-turret-02",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-laser-turrets-small-10",
            "laser-turrets-10",
            "5d-laser-turrets-big-10",
            "5d-laser-turrets-sniper-10"
        }
    }
}

rango = rango + 2
hp = hp + 150

-- Tesla turret 02
genTeslaTurrets {
    number = "02",
    subgroup = "defense-tesla",
    order = "b",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-tesla-turret-01", 1},
        {"steel-plate", 10},
        {"electronic-circuit", 10},
        {"battery", 10}
    },
    nextUpdate = "5d-tesla-turret-02",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-tesla-turrets-1"
        }
    }
}

rango = rango + 2
hp = hp + 150

-- Tesla turret 03
genTeslaTurrets {
    number = "03",
    subgroup = "defense-tesla",
    order = "c",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-tesla-turret-02", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"battery", 10}
    },
    nextUpdate = "5d-tesla-turret-02",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-tesla-turrets-2"
        }
    }
}

rango = rango + 2
hp = hp + 150

-- Tesla turret 04
genTeslaTurrets {
    number = "04",
    subgroup = "defense-tesla",
    order = "d",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-tesla-turret-03", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"battery", 10}
    },
    nextUpdate = "5d-tesla-turret-02",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-tesla-turrets-3"
        }
    }
}

rango = rango + 2
hp = hp + 150

-- Tesla turret 05
genTeslaTurrets {
    number = "05",
    subgroup = "defense-tesla",
    order = "e",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-tesla-turret-04", 1},
        {"steel-plate", 10},
        {"advanced-circuit", 5},
        {"battery", 10}
    },
    nextUpdate = "5d-tesla-turret-02",
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-tesla-turrets-4"
        }
    }
}

rango = rango + 2
hp = hp + 150

-- Tesla turret 06
genTeslaTurrets {
    number = "06",
    subgroup = "defense-tesla",
    order = "f",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-tesla-turret-05", 1},
        {"low-density-structure", 30},
        {"advanced-circuit", 5},
        {"battery", 10}
    },
    nextUpdate = "5d-tesla-turret-02",
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-tesla-turrets-5"
        }
    }
}

rango = rango + 2
hp = hp + 150

-- Tesla turret 07
genTeslaTurrets {
    number = "07",
    subgroup = "defense-tesla",
    order = "g",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-tesla-turret-06", 1},
        {"low-density-structure", 30},
        {"advanced-circuit", 5},
        {"battery", 10}
    },
    nextUpdate = "5d-tesla-turret-02",
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-tesla-turrets-6",
            "space-science-pack"
        }
    }
}

rango = rango + 2
hp = hp + 150

-- Tesla turret 08
genTeslaTurrets {
    number = "08",
    subgroup = "defense-tesla",
    order = "h",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-tesla-turret-07", 1},
        {"low-density-structure", 5},
        {"advanced-circuit", 5},
        {"battery", 10}
    },
    nextUpdate = "5d-tesla-turret-02",
    tech = {
        number = 8,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-tesla-turrets-7"
        }
    }
}

rango = rango + 2
hp = hp + 150

-- Tesla turret 09
genTeslaTurrets {
    number = "09",
    subgroup = "defense-tesla",
    order = "i",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-tesla-turret-08", 1},
        {"low-density-structure", 5},
        {"processing-unit", 3},
        {"battery", 10}
    },
    nextUpdate = "5d-tesla-turret-02",
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-tesla-turrets-8"
        }
    }
}

rango = rango + 2
hp = hp + 150

-- Tesla turret 10
genTeslaTurrets {
    number = "10",
    subgroup = "defense-tesla",
    order = "j",
    new = true,
    attackSpeed = shootingSpeed,
    range = rango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"5d-tesla-turret-09", 1},
        {"low-density-structure", 5},
        {"processing-unit", 3},
        {"battery", 10}
    },
    tech = {
        number = 10,
        count = techCount * 10,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-tesla-turrets-9"
        }
    }
}
