require("__5dim_core__.lib.equipment.generation-energy-shield-equipment")

local bufferCapacity = 120
local energyShield = 20
local shield = 50
local input = 240
local techCount = 200

-- Beacon 01
genEnergyShields {
    number = "01",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = false,
    order = "a",
    ingredients = {
        {"advanced-circuit", 5},
        {"steel-plate", 10}
    },
    tech = nil
}

bufferCapacity = bufferCapacity + 60
energyShield = energyShield + 10
shield = shield * 2
input = input + 120

-- Beacon 02
genEnergyShields {
    number = "02",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = false,
    order = "b",
    ingredients = {
        {"energy-shield-equipment", 10},
        {"processing-unit", 5},
        {"low-density-structure", 5}
    },
    tech = nil
}

bufferCapacity = bufferCapacity + 60
energyShield = energyShield + 10
shield = shield * 2
input = input + 120

-- Beacon 03
genEnergyShields {
    number = "03",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "c",
    ingredients = {
        {"energy-shield-mk2-equipment", 2},
        {"processing-unit", 15},
        {"low-density-structure", 5}
    },
    tech = {
        number = 1,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "energy-shield-mk2-equipment"
        }
    }
}

bufferCapacity = bufferCapacity + 60
energyShield = energyShield + 10
shield = shield * 2
input = input + 120

-- Beacon 04
genEnergyShields {
    number = "04",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "d",
    ingredients = {
        {"5d-energy-shield-equipment-03", 2},
        {"processing-unit", 15},
        {"low-density-structure", 5}
    },
    tech = {
        number = 2,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-energy-shield-equipment-1"
        }
    }
}

bufferCapacity = bufferCapacity + 60
energyShield = energyShield + 10
shield = shield * 2
input = input + 120

-- Beacon 05
genEnergyShields {
    number = "05",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "e",
    ingredients = {
        {"5d-energy-shield-equipment-04", 2},
        {"processing-unit", 15},
        {"low-density-structure", 5}
    },
    tech = {
        number = 3,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-energy-shield-equipment-2"
        }
    }
}

bufferCapacity = bufferCapacity + 60
energyShield = energyShield + 10
shield = shield * 2
input = input + 120

-- Beacon 06
genEnergyShields {
    number = "06",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "f",
    ingredients = {
        {"5d-energy-shield-equipment-05", 2},
        {"processing-unit", 15},
        {"low-density-structure", 5}
    },
    tech = {
        number = 4,
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
            "5d-energy-shield-equipment-3"
        }
    }
}

bufferCapacity = bufferCapacity + 60
energyShield = energyShield + 10
shield = shield * 2
input = input + 120

-- Beacon 07
genEnergyShields {
    number = "07",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "g",
    ingredients = {
        {"5d-energy-shield-equipment-06", 2},
        {"processing-unit", 15},
        {"low-density-structure", 5}
    },
    tech = {
        number = 5,
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
            "5d-energy-shield-equipment-4"
        }
    }
}

bufferCapacity = bufferCapacity + 60
energyShield = energyShield + 10
shield = shield * 2
input = input + 120

-- Beacon 08
genEnergyShields {
    number = "08",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "h",
    ingredients = {
        {"5d-energy-shield-equipment-07", 2},
        {"processing-unit", 15},
        {"low-density-structure", 5}
    },
    tech = {
        number = 6,
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
            "5d-energy-shield-equipment-5"
        }
    }
}

bufferCapacity = bufferCapacity + 60
energyShield = energyShield + 10
shield = shield * 2
input = input + 120

-- Beacon 09
genEnergyShields {
    number = "09",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "i",
    ingredients = {
        {"5d-energy-shield-equipment-08", 2},
        {"processing-unit", 15},
        {"low-density-structure", 5}
    },
    tech = {
        number = 7,
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
            "5d-energy-shield-equipment-6"
        }
    }
}

bufferCapacity = bufferCapacity + 60
energyShield = energyShield + 10
shield = shield * 2
input = input + 120

-- Beacon 10
genEnergyShields {
    number = "10",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    energyPerShield = energyShield,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "j",
    ingredients = {
        {"5d-energy-shield-equipment-09", 2},
        {"processing-unit", 15},
        {"low-density-structure", 5}
    },
    tech = {
        number = 8,
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
            "5d-energy-shield-equipment-7"
        }
    }
}
