require("__5dim_core__.lib.equipment.generation-personal-laser-defense-equipment")

local consumption = 50
local cooldown = 40
local rangeShoot = 15
local damageModif = 3
local techCount = 200

-- Beacon 01
genPersonalLaserDefenses {
    number = "01",
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "processing-unit",       amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret",          amount = 5 }
    },
    tech = nil
}

consumption = consumption + 50
cooldown = cooldown - 2
rangeShoot = rangeShoot + 3
damageModif = damageModif + 2

-- Beacon 02
genPersonalLaserDefenses {
    number = "02",
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "personal-laser-defense-equipment", amount = 1 },
        { type = "item", name = "processing-unit",                  amount = 20 },
        { type = "item", name = "low-density-structure",            amount = 5 },
        { type = "item", name = "laser-turret",                     amount = 5 }
    },
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 }
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

-- Beacon 03
genPersonalLaserDefenses {
    number = "03",
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-personal-laser-defense-equipment-02", amount = 1 },
        { type = "item", name = "processing-unit",                        amount = 20 },
        { type = "item", name = "low-density-structure",                  amount = 5 },
        { type = "item", name = "laser-turret",                           amount = 5 }
    },
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 }
        },
        prerequisites = {
            "personal-laser-defense-equipment-2"
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
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-personal-laser-defense-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit",                        amount = 20 },
        { type = "item", name = "low-density-structure",                  amount = 5 },
        { type = "item", name = "laser-turret",                           amount = 5 }
    },
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "personal-laser-defense-equipment-3",
            "utility-science-pack"
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
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-personal-laser-defense-equipment-04", amount = 1 },
        { type = "item", name = "processing-unit",                        amount = 20 },
        { type = "item", name = "low-density-structure",                  amount = 5 },
        { type = "item", name = "laser-turret",                           amount = 5 }
    },
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "personal-laser-defense-equipment-4"
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
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-personal-laser-defense-equipment-05", amount = 1 },
        { type = "item", name = "processing-unit",                        amount = 20 },
        { type = "item", name = "low-density-structure",                  amount = 5 },
        { type = "item", name = "laser-turret",                           amount = 5 }
    },
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "personal-laser-defense-equipment-5"
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
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-personal-laser-defense-equipment-06", amount = 1 },
        { type = "item", name = "processing-unit",                        amount = 20 },
        { type = "item", name = "low-density-structure",                  amount = 5 },
        { type = "item", name = "laser-turret",                           amount = 5 }
    },
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            "personal-laser-defense-equipment-6",
            "space-science-pack"
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
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-personal-laser-defense-equipment-07", amount = 1 },
        { type = "item", name = "processing-unit",                        amount = 20 },
        { type = "item", name = "low-density-structure",                  amount = 5 },
        { type = "item", name = "laser-turret",                           amount = 5 }
    },
    tech = {
        number = 8,
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            "personal-laser-defense-equipment-7"
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
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-personal-laser-defense-equipment-08", amount = 1 },
        { type = "item", name = "processing-unit",                        amount = 20 },
        { type = "item", name = "low-density-structure",                  amount = 5 },
        { type = "item", name = "laser-turret",                           amount = 5 }
    },
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            "personal-laser-defense-equipment-8"
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
    subgroup = "armor-laser",
    energyConsumption = consumption,
    cooldown = cooldown,
    range = rangeShoot,
    damage = damageModif,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-personal-laser-defense-equipment-09", amount = 1 },
        { type = "item", name = "processing-unit",                        amount = 20 },
        { type = "item", name = "low-density-structure",                  amount = 5 },
        { type = "item", name = "laser-turret",                           amount = 5 }
    },
    tech = {
        number = 10,
        count = techCount * 10,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            "personal-laser-defense-equipment-9"
        }
    }
}
