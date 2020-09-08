require("__5dim_core__.lib.battlefield.flamethrower-turret.generation-flamethrower-turret")

local rango = 30
local minRango = 6
local fluid_consumption = 0.2
local damageModif = 19
local color = {r = 0, g = 1, b = 1, a = 1}
local hp = 1400

-- Tesla turret 01
genFlamethrowerTurrets {
    number = "01",
    subgroup = "defense-flame",
    order = "a",
    new = false,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
    tint = color,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = nil
}

rango = rango + 3
hp = hp + 140

-- Tesla turret 02
genFlamethrowerTurrets {
    number = "02",
    subgroup = "defense-flame",
    order = "b",
    new = true,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
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
hp = hp + 140
minRango = minRango + 1

-- Tesla turret 03
genFlamethrowerTurrets {
    number = "03",
    subgroup = "defense-flame",
    order = "c",
    new = true,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
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
hp = hp + 140

-- Tesla turret 04
genFlamethrowerTurrets {
    number = "04",
    subgroup = "defense-flame",
    order = "d",
    new = true,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
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
hp = hp + 140
minRango = minRango + 1

-- Tesla turret 05
genFlamethrowerTurrets {
    number = "05",
    subgroup = "defense-flame",
    order = "e",
    new = true,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
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
hp = hp + 140

-- Tesla turret 06
genFlamethrowerTurrets {
    number = "06",
    subgroup = "defense-flame",
    order = "f",
    new = true,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
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
hp = hp + 140
minRango = minRango + 1

-- Tesla turret 07
genFlamethrowerTurrets {
    number = "07",
    subgroup = "defense-flame",
    order = "g",
    new = true,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
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
hp = hp + 140

-- Tesla turret 08
genFlamethrowerTurrets {
    number = "08",
    subgroup = "defense-flame",
    order = "h",
    new = true,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
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
hp = hp + 140
minRango = minRango + 1

-- Tesla turret 09
genFlamethrowerTurrets {
    number = "09",
    subgroup = "defense-flame",
    order = "i",
    new = true,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
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
hp = hp + 140

-- Tesla turret 10
genFlamethrowerTurrets {
    number = "10",
    subgroup = "defense-flame",
    order = "j",
    new = true,
    attackSpeed = fluid_consumption,
    range = rango,
    minRange = minRango,
    cooldown = damageModif,
    health = hp,
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
