require("__5dim_core__.lib.equipment.generation-solar-panel-equipment")

local powerProduction = 30
local techCount = 400

-- Beacon 01
genSolarPanels {
    number = "01",
    subgroup = "armor-solar",
    power = powerProduction,
    new = false,
    order = "a",
    ingredients = {
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
    },
    tech = nil
}

powerProduction = powerProduction * 1.25

-- Beacon 02
genSolarPanels {
    number = "02",
    subgroup = "armor-solar",
    power = powerProduction,
    new = true,
    order = "b",
    ingredients = {
        {"solar-panel-equipment", 1},
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
    },
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "solar-panel-equipment"
        }
    }
}

powerProduction = powerProduction * 1.25

-- Beacon 03
genSolarPanels {
    number = "03",
    subgroup = "armor-solar",
    power = powerProduction,
    new = true,
    order = "c",
    ingredients = {
        {"5d-solar-panel-equipment-02", 1},
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
    },
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "solar-panel-equipment-2"
        }
    }
}

powerProduction = powerProduction * 1.25

-- Beacon 04
genSolarPanels {
    number = "04",
    subgroup = "armor-solar",
    power = powerProduction,
    new = true,
    order = "d",
    ingredients = {
        {"5d-solar-panel-equipment-03", 1},
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
    },
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "solar-panel-equipment-3"
        }
    }
}

powerProduction = powerProduction * 1.25

-- Beacon 05
genSolarPanels {
    number = "05",
    subgroup = "armor-solar",
    power = powerProduction,
    new = true,
    order = "e",
    ingredients = {
        {"5d-solar-panel-equipment-04", 1},
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
    },
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "solar-panel-equipment-4"
        }
    }
}

powerProduction = powerProduction * 1.25

-- Beacon 06
genSolarPanels {
    number = "06",
    subgroup = "armor-solar",
    power = powerProduction,
    new = true,
    order = "f",
    ingredients = {
        {"5d-solar-panel-equipment-05", 1},
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
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
            "solar-panel-equipment-5"
        }
    }
}

powerProduction = powerProduction * 1.25

-- Beacon 07
genSolarPanels {
    number = "07",
    subgroup = "armor-solar",
    power = powerProduction,
    new = true,
    order = "g",
    ingredients = {
        {"5d-solar-panel-equipment-06", 1},
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
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
            "solar-panel-equipment-6"
        }
    }
}

powerProduction = powerProduction * 1.25

-- Beacon 08
genSolarPanels {
    number = "08",
    subgroup = "armor-solar",
    power = powerProduction,
    new = true,
    order = "h",
    ingredients = {
        {"5d-solar-panel-equipment-07", 1},
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
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
            "solar-panel-equipment-7"
        }
    }
}

powerProduction = powerProduction * 1.25

-- Beacon 09
genSolarPanels {
    number = "09",
    subgroup = "armor-solar",
    power = powerProduction,
    new = true,
    order = "i",
    ingredients = {
        {"5d-solar-panel-equipment-08", 1},
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
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
            "solar-panel-equipment-8"
        }
    }
}

powerProduction = powerProduction * 1.25

-- Beacon 10
genSolarPanels {
    number = "10",
    subgroup = "armor-solar",
    power = powerProduction,
    new = true,
    order = "j",
    ingredients = {
        {"5d-solar-panel-equipment-09", 1},
        {"solar-panel", 1},
        {"advanced-circuit", 2},
        {"steel-plate", 5}
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
            "solar-panel-equipment-9"
        }
    }
}
