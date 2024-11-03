require("__5dim_core__.lib.equipment.generation-exoskeleton-equipment")

local consumption = 200
local speed = 0.3
local techCount = 400

-- Beacon 01
genExoskeletons {
    number = "01",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = false,
    order = "a",
    ingredients = {
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
    },
    tech = nil
}

consumption = consumption + 100
speed = speed + 0.1

-- Beacon 02
genExoskeletons {
    number = "02",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = true,
    order = "b",
    ingredients = {
        {type = "item", name = "exoskeleton-equipment", amount = 1},
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
    },
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "exoskeleton-equipment"
        }
    }
}

consumption = consumption + 100
speed = speed + 0.1

-- Beacon 03
genExoskeletons {
    number = "03",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = true,
    order = "c",
    ingredients = {
        {type = "item", name = "5d-exoskeleton-equipment-02", amount = 1},
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
    },
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "exoskeleton-equipment-2"
        }
    }
}

consumption = consumption + 100
speed = speed + 0.1

-- Beacon 04
genExoskeletons {
    number = "04",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = true,
    order = "d",
    ingredients = {
        {type = "item", name = "5d-exoskeleton-equipment-03", amount = 1},
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
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
            "exoskeleton-equipment-3"
        }
    }
}

consumption = consumption + 100
speed = speed + 0.1

-- Beacon 05
genExoskeletons {
    number = "05",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = true,
    order = "e",
    ingredients = {
        {type = "item", name = "5d-exoskeleton-equipment-04", amount = 1},
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
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
            "exoskeleton-equipment-4"
        }
    }
}

consumption = consumption + 100
speed = speed + 0.1

-- Beacon 06
genExoskeletons {
    number = "06",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = true,
    order = "f",
    ingredients = {
        {type = "item", name = "5d-exoskeleton-equipment-05", amount = 1},
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
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
            "exoskeleton-equipment-5"
        }
    }
}

consumption = consumption + 100
speed = speed + 0.1

-- Beacon 07
genExoskeletons {
    number = "07",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = true,
    order = "g",
    ingredients = {
        {type = "item", name = "5d-exoskeleton-equipment-06", amount = 1},
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
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
            "exoskeleton-equipment-6"
        }
    }
}

consumption = consumption + 100
speed = speed + 0.1

-- Beacon 08
genExoskeletons {
    number = "08",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = true,
    order = "h",
    ingredients = {
        {type = "item", name = "5d-exoskeleton-equipment-07", amount = 1},
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
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
            "exoskeleton-equipment-7"
        }
    }
}

consumption = consumption + 100
speed = speed + 0.1

-- Beacon 09
genExoskeletons {
    number = "09",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = true,
    order = "i",
    ingredients = {
        {type = "item", name = "5d-exoskeleton-equipment-08", amount = 1},
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
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
            "exoskeleton-equipment-8"
        }
    }
}

consumption = consumption + 100
speed = speed + 0.1

-- Beacon 10
genExoskeletons {
    number = "10",
    subgroup = "armor-exoesqueleto",
    energyConsumption = consumption,
    movementSpeed = speed,
    new = true,
    order = "j",
    ingredients = {
        {type = "item", name = "5d-exoskeleton-equipment-09", amount = 1},
        {type = "item", name = "processing-unit", amount = 10},
        {type = "item", name = "electric-engine-unit", amount = 30},
        {type = "item", name = "steel-plate", amount = 20}
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
            "exoskeleton-equipment-9"
        }
    }
}