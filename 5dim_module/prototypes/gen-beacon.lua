require("__5dim_core__.lib.module.generation-beacon")

local modules = 2
local energy = 480
local areaEffect = 3
local efficiencyArea = 1.5
local techCount = 400

-- Beacon 01
genBeacons {
    number = "01",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = false,
    order = "a",
    ingredients = {
        { type = "item", name = "electronic-circuit", amount = 20 },
        { type = "item", name = "advanced-circuit",   amount = 20 },
        { type = "item", name = "steel-plate",        amount = 10 },
        { type = "item", name = "copper-cable",       amount = 10 }
    },
    nextUpdate = "5d-beacon-02",
    tech = nil
}

modules = modules + 1
energy = energy + 240

-- Beacon 02
genBeacons {
    number = "02",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "b",
    ingredients = {
        { type = "item", name = "beacon",               amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 5 },
        { type = "item", name = "electronic-circuit",   amount = 5 },
        { type = "item", name = "battery",              amount = 5 }
    },
    nextUpdate = "5d-beacon-03",
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "effect-transmission"
        }
    }
}

efficiencyArea = efficiencyArea + 0.05
modules = modules + 1
energy = energy + 240

-- Beacon 03
genBeacons {
    number = "03",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "c",
    ingredients = {
        { type = "item", name = "5d-beacon-02",         amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 5 },
        { type = "item", name = "electronic-circuit",   amount = 5 },
        { type = "item", name = "battery",              amount = 5 }
    },
    nextUpdate = "5d-beacon-04",
    tech = {
        number = 3,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "effect-transmission-2"
        }
    }
}

modules = modules + 1
energy = energy + 240

-- Beacon 04
genBeacons {
    number = "04",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "d",
    ingredients = {
        { type = "item", name = "5d-beacon-03",         amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 5 },
        { type = "item", name = "electronic-circuit",   amount = 5 },
        { type = "item", name = "battery",              amount = 5 }
    },
    nextUpdate = "5d-beacon-05",
    tech = {
        number = 4,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            "effect-transmission-3"
        }
    }
}

efficiencyArea = efficiencyArea + 0.05
areaEffect = areaEffect + 1
energy = energy + 240

-- Beacon 05
genBeacons {
    number = "05",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "e",
    ingredients = {
        { type = "item", name = "5d-beacon-04",         amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 5 },
        { type = "item", name = "advanced-circuit",     amount = 5 },
        { type = "item", name = "battery",              amount = 5 }
    },
    nextUpdate = "5d-beacon-06",
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "effect-transmission-4",
            "utility-science-pack"
        }
    }
}

energy = energy + 240
modules = modules + 1

-- Beacon 06
genBeacons {
    number = "06",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "f",
    ingredients = {
        { type = "item", name = "5d-beacon-05",         amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 5 },
        { type = "item", name = "advanced-circuit",     amount = 5 },
        { type = "item", name = "battery",              amount = 5 }
    },
    nextUpdate = "5d-beacon-07",
    tech = {
        number = 6,
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "effect-transmission-5"
        }
    }
}

efficiencyArea = efficiencyArea + 0.05
energy = energy + 240
areaEffect = areaEffect + 1

-- Beacon 07
genBeacons {
    number = "07",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "g",
    ingredients = {
        { type = "item", name = "5d-beacon-06",         amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 5 },
        { type = "item", name = "advanced-circuit",     amount = 5 },
        { type = "item", name = "battery",              amount = 5 }
    },
    nextUpdate = "5d-beacon-08",
    tech = {
        number = 7,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "effect-transmission-6"
        }
    }
}

modules = modules + 1
energy = energy + 240

-- Beacon 08
genBeacons {
    number = "08",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "h",
    ingredients = {
        { type = "item", name = "5d-beacon-07",         amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 5 },
        { type = "item", name = "advanced-circuit",     amount = 5 },
        { type = "item", name = "battery",              amount = 5 }
    },
    nextUpdate = "5d-beacon-09",
    tech = {
        number = 8,
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "effect-transmission-7"
        }
    }
}

efficiencyArea = efficiencyArea + 0.05
energy = energy + 240
areaEffect = areaEffect + 1

-- Beacon 09
genBeacons {
    number = "09",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "i",
    ingredients = {
        { type = "item", name = "5d-beacon-08",         amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 5 },
        { type = "item", name = "processing-unit",      amount = 5 },
        { type = "item", name = "battery",              amount = 5 }
    },
    nextUpdate = "5d-beacon-10",
    tech = {
        number = 9,
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "effect-transmission-8"
        }
    }
}

modules = modules + 1
energy = energy + 240

-- Beacon 10
genBeacons {
    number = "10",
    subgroup = "beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "j",
    ingredients = {
        { type = "item", name = "5d-beacon-09",         amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 5 },
        { type = "item", name = "processing-unit",      amount = 5 },
        { type = "item", name = "battery",              amount = 5 }
    },
    tech = {
        number = 10,
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "effect-transmission-9"
        }
    }
}
