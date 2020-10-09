require("__5dim_core__.lib.equipment.generation-personal-tesla-defense-equipment")

local consumption = 50
local cooldown = 40
local rangeShoot = 15
local damageModif = 3
local techCount = 400

-- Beacon 01
genPersonalLaserDefenses {
    number = "01",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "a",
    ingredients = {
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "personal-laser-defense-equipment"
        }
    }
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 02
genPersonalLaserDefenses {
    number = "02",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "b",
    ingredients = {
        {"5d-personal-tesla-defense-equipment-01", 1},
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-personal-tesla-defense-equipment-1",
            "personal-laser-defense-equipment-2",
            "utility-science-pack"
        }
    }
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 03
genPersonalLaserDefenses {
    number = "03",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "c",
    ingredients = {
        {"5d-personal-tesla-defense-equipment-02", 1},
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-personal-tesla-defense-equipment-2",
            "personal-laser-defense-equipment-3"
        }
    }
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 04
genPersonalLaserDefenses {
    number = "04",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "d",
    ingredients = {
        {"5d-personal-tesla-defense-equipment-03", 1},
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-personal-tesla-defense-equipment-3",
            "personal-laser-defense-equipment-4",
            "space-science-pack"
        }
    }
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 05
genPersonalLaserDefenses {
    number = "05",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "e",
    ingredients = {
        {"5d-personal-tesla-defense-equipment-04", 1},
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-personal-tesla-defense-equipment-4",
            "personal-laser-defense-equipment-5"
        }
    }
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 06
genPersonalLaserDefenses {
    number = "06",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "f",
    ingredients = {
        {"5d-personal-tesla-defense-equipment-05", 1},
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-personal-tesla-defense-equipment-5",
            "personal-laser-defense-equipment-6"
        }
    }
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 07
genPersonalLaserDefenses {
    number = "07",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "g",
    ingredients = {
        {"5d-personal-tesla-defense-equipment-06", 1},
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-personal-tesla-defense-equipment-6",
            "personal-laser-defense-equipment-7"
        }
    }
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 08
genPersonalLaserDefenses {
    number = "08",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "h",
    ingredients = {
        {"5d-personal-tesla-defense-equipment-07", 1},
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 8,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-personal-tesla-defense-equipment-7",
            "personal-laser-defense-equipment-8"
        }
    }
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 09
genPersonalLaserDefenses {
    number = "09",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "i",
    ingredients = {
        {"5d-personal-tesla-defense-equipment-08", 1},
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-personal-tesla-defense-equipment-8",
            "personal-laser-defense-equipment-9"
        }
    }
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 10
genPersonalLaserDefenses {
    number = "10",
    subgroup = "armor-tesla",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "j",
    ingredients = {
        {"5d-personal-tesla-defense-equipment-09", 1},
        {"processing-unit", 20},
        {"low-density-structure", 5},
        {"laser-turret", 5}
    },
    tech = {
        number = 10,
        count = techCount * 10,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-personal-tesla-defense-equipment-9",
            "personal-laser-defense-equipment-10"
        }
    }
}
