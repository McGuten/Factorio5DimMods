require("__5dim_core__.lib.equipment.generation-energy-shield-equipment")

local bufferCapacity = 120
local shield = 50
local input = 240
local techCount = 200

-- Beacon 01
genEnergyShields {
    number = "01",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = false,
    order = "a",
    ingredients = {
        {type = "item", name = "advanced-circuit", amount = 5},
        {type = "item", name = "steel-plate", amount = 10}
    },
    tech = nil
}

bufferCapacity = bufferCapacity + 60
shield = shield * 2
input = input + 120

-- Beacon 02
genEnergyShields {
    number = "02",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = false,
    order = "b",
    ingredients = {
        {type = "item", name = "energy-shield-equipment", amount = 10},
        {type = "item", name = "processing-unit", amount = 5},
        {type = "item", name = "low-density-structure", amount = 5}
    },
    tech = nil
}

bufferCapacity = bufferCapacity + 60
shield = shield * 2
input = input + 120

-- Beacon 03
genEnergyShields {
    number = "03",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "c",
    ingredients = {
        {type = "item", name = "energy-shield-mk2-equipment", amount = 2},
        {type = "item", name = "processing-unit", amount = 15},
        {type = "item", name = "low-density-structure", amount = 5}
    },
    tech = {
        number = 1,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "energy-shield-mk2-equipment"
        }
    }
}

bufferCapacity = bufferCapacity + 60
shield = shield * 2
input = input + 120

-- Beacon 04
genEnergyShields {
    number = "04",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "d",
    ingredients = {
        {type = "item", name = "5d-energy-shield-equipment-03", amount = 2},
        {type = "item", name = "processing-unit", amount = 15},
        {type = "item", name = "low-density-structure", amount = 5}
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
shield = shield * 2
input = input + 120

-- Beacon 05
genEnergyShields {
    number = "05",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "e",
    ingredients = {
        {type = "item", name = "5d-energy-shield-equipment-04", amount = 2},
        {type = "item", name = "processing-unit", amount = 15},
        {type = "item", name = "low-density-structure", amount = 5}
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
shield = shield * 2
input = input + 120

-- Beacon 06
genEnergyShields {
    number = "06",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "f",
    ingredients = {
        {type = "item", name = "5d-energy-shield-equipment-05", amount = 2},
        {type = "item", name = "processing-unit", amount = 15},
        {type = "item", name = "low-density-structure", amount = 5}
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
shield = shield * 2
input = input + 120

-- Beacon 07
genEnergyShields {
    number = "07",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "g",
    ingredients = {
        {type = "item", name = "5d-energy-shield-equipment-06", amount = 2},
        {type = "item", name = "processing-unit", amount = 15},
        {type = "item", name = "low-density-structure", amount = 5}
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
shield = shield * 2
input = input + 120

-- Beacon 08
genEnergyShields {
    number = "08",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "h",
    ingredients = {
        {type = "item", name = "5d-energy-shield-equipment-07", amount = 2},
        {type = "item", name = "processing-unit", amount = 15},
        {type = "item", name = "low-density-structure", amount = 5}
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
shield = shield * 2
input = input + 120

-- Beacon 09
genEnergyShields {
    number = "09",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "i",
    ingredients = {
        {type = "item", name = "5d-energy-shield-equipment-08", amount = 2},
        {type = "item", name = "processing-unit", amount = 15},
        {type = "item", name = "low-density-structure", amount = 5}
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
shield = shield * 2
input = input + 120

-- Beacon 10
genEnergyShields {
    number = "10",
    subgroup = "armor-shield",
    capacity = bufferCapacity,
    shieldCapacity = shield,
    inputFlow = input,
    new = true,
    order = "j",
    ingredients = {
        {type = "item", name = "5d-energy-shield-equipment-09", amount = 2},
        {type = "item", name = "processing-unit", amount = 15},
        {type = "item", name = "low-density-structure", amount = 5}
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