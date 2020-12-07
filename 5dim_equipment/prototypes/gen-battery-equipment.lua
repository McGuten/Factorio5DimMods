require("__5dim_core__.lib.equipment.generation-battery-equipment")

local batteryCapacity = 20
local techCount = 200

-- Beacon 01
genBatterys {
    number = "01",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = false,
    order = "a",
    ingredients = {
        {"battery", 5},
        {"steel-plate", 10}
    },
    tech = nil
}

batteryCapacity = batteryCapacity * 2

-- Beacon 02
genBatterys {
    number = "02",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = false,
    order = "b",
    ingredients = {
        {"battery-equipment", 10},
        {"processing-unit", 15},
        {"low-density-structure", 5}
    },
    tech = nil
}

batteryCapacity = batteryCapacity * 2

-- Beacon 03
genBatterys {
    number = "03",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = true,
    order = "c",
    ingredients = {
        {"battery-mk2-equipment", 2},
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
            "battery-mk2-equipment"
        }
    }
}

batteryCapacity = batteryCapacity * 2

-- Beacon 04
genBatterys {
    number = "04",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = true,
    order = "d",
    ingredients = {
        {"5d-battery-equipment-03", 2},
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
            "5d-battery-equipment-1"
        }
    }
}

batteryCapacity = batteryCapacity * 2

-- Beacon 05
genBatterys {
    number = "05",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = true,
    order = "e",
    ingredients = {
        {"5d-battery-equipment-04", 2},
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
            "5d-battery-equipment-2"
        }
    }
}

batteryCapacity = batteryCapacity * 2

-- Beacon 06
genBatterys {
    number = "06",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = true,
    order = "f",
    ingredients = {
        {"5d-battery-equipment-05", 2},
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
            "5d-battery-equipment-3"
        }
    }
}

batteryCapacity = batteryCapacity * 2

-- Beacon 07
genBatterys {
    number = "07",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = true,
    order = "g",
    ingredients = {
        {"5d-battery-equipment-06", 2},
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
            "5d-battery-equipment-4"
        }
    }
}

batteryCapacity = batteryCapacity * 2

-- Beacon 08
genBatterys {
    number = "08",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = true,
    order = "h",
    ingredients = {
        {"5d-battery-equipment-07", 2},
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
            "5d-battery-equipment-5"
        }
    }
}

batteryCapacity = batteryCapacity * 2

-- Beacon 09
genBatterys {
    number = "09",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = true,
    order = "i",
    ingredients = {
        {"5d-battery-equipment-08", 2},
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
            "5d-battery-equipment-6"
        }
    }
}

batteryCapacity = batteryCapacity * 2

-- Beacon 10
genBatterys {
    number = "10",
    subgroup = "armor-baterry",
    capacity = batteryCapacity,
    new = true,
    order = "j",
    ingredients = {
        {"5d-battery-equipment-09", 2},
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
            "5d-battery-equipment-7"
        }
    }
}
