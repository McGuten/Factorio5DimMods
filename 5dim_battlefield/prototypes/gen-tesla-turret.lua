require("__5dim_core__.lib.battlefield.tesla-turret.generation-tesla-turret")

local rango = 50
local shootingSpeed = 25
local damageModif = 19
local color = {r = 0.9, g = 0.1, b = 0.9, a = 1}
local hp = 1500

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
        {"steel-plate", 60},
        {"electronic-circuit", 50},
        {"battery", 50}
    },
    tech = {
        number = 1,
        count = 10000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators",
            "logistic-science-pack"
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
        {"steel-plate", 60},
        {"electronic-circuit", 50},
        {"battery", 50}
    },
    tech = {
        number = 2,
        count = 20000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators",
            "logistic-science-pack"
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
        {"steel-plate", 60},
        {"advanced-circuit", 35},
        {"battery", 50}
    },
    tech = {
        number = 3,
        count = 3000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-2",
            "chemical-science-pack"
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
        {"steel-plate", 60},
        {"advanced-circuit", 35},
        {"battery", 50}
    },
    tech = {
        number = 4,
        count = 4000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-3"
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
        {"steel-plate", 60},
        {"advanced-circuit", 35},
        {"battery", 50}
    },
    tech = {
        number = 5,
        count = 5000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-4",
            "production-science-pack"
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
        {"advanced-circuit", 35},
        {"battery", 50}
    },
    tech = {
        number = 6,
        count = 6000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-5"
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
        {"advanced-circuit", 35},
        {"battery", 50}
    },
    tech = {
        number = 7,
        count = 7000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-6",
            "utility-science-pack"
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
        {"low-density-structure", 30},
        {"advanced-circuit", 35},
        {"battery", 50}
    },
    tech = {
        number = 8,
        count = 8000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-7"
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
        {"low-density-structure", 30},
        {"processing-unit", 20},
        {"battery", 50}
    },
    tech = {
        number = 9,
        count = 9000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-8"
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
        {"low-density-structure", 30},
        {"processing-unit", 20},
        {"battery", 50}
    },
    tech = {
        number = 10,
        count = 10000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-9"
        }
    }
}
