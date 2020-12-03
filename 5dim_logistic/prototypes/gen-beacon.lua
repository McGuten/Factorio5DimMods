require("__5dim_core__.lib.logistic.generation-beacon")

local modules = 2
local energy = 480
local areaEffect = 3
local efficiencyArea = 0.5
local techCount = 400

-- Beacon 01
genBeacons {
    number = "01",
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = false,
    order = "a",
    ingredients = {
        {"electronic-circuit", 20},
        {"advanced-circuit", 20},
        {"steel-plate", 10},
        {"copper-cable", 10}
    },
    nextUpdate = "5d-beacon-02",
    tech = nil
}

modules = modules + 1
energy = energy + 240

-- Beacon 02
genBeacons {
    number = "02",
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "b",
    ingredients = {
        {"beacon", 1},
        {"electric-engine-unit", 5},
        {"electronic-circuit", 5},
        {"battery", 5}
    },
    nextUpdate = "5d-beacon-03",
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
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
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "c",
    ingredients = {
        {"5d-beacon-02", 1},
        {"electric-engine-unit", 5},
        {"electronic-circuit", 5},
        {"battery", 5}
    },
    nextUpdate = "5d-beacon-04",
    tech = {
        number = 3,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
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
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "d",
    ingredients = {
        {"5d-beacon-03", 1},
        {"electric-engine-unit", 5},
        {"electronic-circuit", 5},
        {"battery", 5}
    },
    nextUpdate = "5d-beacon-05",
    tech = {
        number = 4,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
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
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "e",
    ingredients = {
        {"5d-beacon-04", 1},
        {"electric-engine-unit", 5},
        {"advanced-circuit", 5},
        {"battery", 5}
    },
    nextUpdate = "5d-beacon-06",
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "f",
    ingredients = {
        {"5d-beacon-05", 1},
        {"electric-engine-unit", 5},
        {"advanced-circuit", 5},
        {"battery", 5}
    },
    nextUpdate = "5d-beacon-07",
    tech = {
        number = 6,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "g",
    ingredients = {
        {"5d-beacon-06", 1},
        {"electric-engine-unit", 5},
        {"advanced-circuit", 5},
        {"battery", 5}
    },
    nextUpdate = "5d-beacon-08",
    tech = {
        number = 7,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "h",
    ingredients = {
        {"5d-beacon-07", 1},
        {"electric-engine-unit", 5},
        {"advanced-circuit", 5},
        {"battery", 5}
    },
    nextUpdate = "5d-beacon-09",
    tech = {
        number = 8,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "i",
    ingredients = {
        {"5d-beacon-08", 1},
        {"electric-engine-unit", 5},
        {"processing-unit", 5},
        {"battery", 5}
    },
    nextUpdate = "5d-beacon-10",
    tech = {
        number = 9,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    subgroup = "logistic-beacon",
    area = areaEffect,
    moduleSlots = modules,
    energyUsage = energy,
    efficiency = efficiencyArea,
    new = true,
    order = "j",
    ingredients = {
        {"5d-beacon-09", 1},
        {"electric-engine-unit", 5},
        {"processing-unit", 5},
        {"battery", 5}
    },
    tech = {
        number = 10,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "effect-transmission-9"
        }
    }
}
