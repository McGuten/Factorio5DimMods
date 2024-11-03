require("__5dim_core__.lib.equipment.generation-personal-roboport-equipment")

local bufferCapacity = 10
local robot = 10
local radius = 15
local input = 2000
local chargingEnergy = 1000
local techCount = 200

-- Beacon 01
genPersonalRoboports {
    number = "01",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "steel-plate",      amount = 10 }
    },
    tech = nil
}

bufferCapacity = bufferCapacity * 1.5
robot = robot + 10
radius = radius + 1
input = input * 2
chargingEnergy = chargingEnergy + 500

-- Beacon 02
genPersonalRoboports {
    number = "02",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = false,
    order = "b",
    ingredients = {
        { type = "item", name = "personal-roboport-equipment", amount = 10 },
        { type = "item", name = "processing-unit",             amount = 5 },
        { type = "item", name = "low-density-structure",       amount = 5 }
    },
    tech = nil
}

bufferCapacity = bufferCapacity * 1.5
robot = robot + 10
radius = radius + 1
input = input * 2
chargingEnergy = chargingEnergy + 500

-- Beacon 03
genPersonalRoboports {
    number = "03",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "personal-roboport-mk2-equipment", amount = 2 },
        { type = "item", name = "processing-unit",                 amount = 15 },
        { type = "item", name = "low-density-structure",           amount = 5 }
    },
    tech = {
        number = 1,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "personal-roboport-mk2-equipment"
        }
    }
}

bufferCapacity = bufferCapacity * 1.5
robot = robot + 10
radius = radius + 1
input = input * 2
chargingEnergy = chargingEnergy + 500

-- Beacon 04
genPersonalRoboports {
    number = "04",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-personal-roboport-equipment-03", amount = 2 },
        { type = "item", name = "processing-unit",                   amount = 15 },
        { type = "item", name = "low-density-structure",             amount = 5 }
    },
    tech = {
        number = 2,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-personal-roboport-equipment-1"
        }
    }
}

bufferCapacity = bufferCapacity * 1.5
robot = robot + 10
radius = radius + 1
input = input * 2
chargingEnergy = chargingEnergy + 500

-- Beacon 05
genPersonalRoboports {
    number = "05",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-personal-roboport-equipment-04", amount = 2 },
        { type = "item", name = "processing-unit",                   amount = 15 },
        { type = "item", name = "low-density-structure",             amount = 5 }
    },
    tech = {
        number = 3,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-personal-roboport-equipment-2"
        }
    }
}

bufferCapacity = bufferCapacity * 1.5
robot = robot + 10
radius = radius + 1
input = input * 2
chargingEnergy = chargingEnergy + 500

-- Beacon 06
genPersonalRoboports {
    number = "06",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-personal-roboport-equipment-05", amount = 2 },
        { type = "item", name = "processing-unit",                   amount = 15 },
        { type = "item", name = "low-density-structure",             amount = 5 }
    },
    tech = {
        number = 4,
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            "5d-personal-roboport-equipment-3"
        }
    }
}

bufferCapacity = bufferCapacity * 1.5
robot = robot + 10
radius = radius + 1
input = input * 2
chargingEnergy = chargingEnergy + 500

-- Beacon 07
genPersonalRoboports {
    number = "07",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-personal-roboport-equipment-06", amount = 2 },
        { type = "item", name = "processing-unit",                   amount = 15 },
        { type = "item", name = "low-density-structure",             amount = 5 }
    },
    tech = {
        number = 5,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "military-science-pack",   1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            "5d-personal-roboport-equipment-4"
        }
    }
}

bufferCapacity = bufferCapacity * 1.5
robot = robot + 10
radius = radius + 1
input = input * 2
chargingEnergy = chargingEnergy + 500

-- Beacon 08
genPersonalRoboports {
    number = "08",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-personal-roboport-equipment-07", amount = 2 },
        { type = "item", name = "processing-unit",                   amount = 15 },
        { type = "item", name = "low-density-structure",             amount = 5 }
    },
    tech = {
        number = 6,
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
            "5d-personal-roboport-equipment-5"
        }
    }
}

bufferCapacity = bufferCapacity * 1.5
robot = robot + 10
radius = radius + 1
input = input * 2
chargingEnergy = chargingEnergy + 500

-- Beacon 09
genPersonalRoboports {
    number = "09",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-personal-roboport-equipment-08", amount = 2 },
        { type = "item", name = "processing-unit",                   amount = 15 },
        { type = "item", name = "low-density-structure",             amount = 5 }
    },
    tech = {
        number = 7,
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
            "5d-personal-roboport-equipment-6"
        }
    }
}

bufferCapacity = bufferCapacity * 1.5
robot = robot + 10
radius = radius + 1
input = input * 2
chargingEnergy = chargingEnergy + 500

-- Beacon 10
genPersonalRoboports {
    number = "10",
    subgroup = "armor-roboport",
    capacity = bufferCapacity,
    inputFlow = input,
    robotLimit = robot,
    constructionRadius = radius,
    charging = chargingEnergy,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-personal-roboport-equipment-09", amount = 2 },
        { type = "item", name = "processing-unit",                   amount = 15 },
        { type = "item", name = "low-density-structure",             amount = 5 }
    },
    tech = {
        number = 8,
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
            "5d-personal-roboport-equipment-7"
        }
    }
}
