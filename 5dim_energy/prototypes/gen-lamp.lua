require("__5dim_core__.lib.energy.generation-lamp")

local energy = 5
local size = 40
local techCount = 100

-- Electric furnace 01
genLamps {
    number = "01",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
    },
    nextUpdate = "5d-lamp-02",
    tech = nil
}

size = size + 20
energy = energy + 15

-- Electric furnace 02
genLamps {
    number = "02",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {"small-lamp", 1},
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
    },
    nextUpdate = "5d-lamp-03",
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "optics",
            "logistic-science-pack"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 03
genLamps {
    number = "03",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {"5d-lamp-02", 1},
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
    },
    nextUpdate = "5d-lamp-04",
    tech = {
        number = 3,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "optics-2",
            "chemical-science-pack"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 04
genLamps {
    number = "04",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {"5d-lamp-03", 1},
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
    },
    nextUpdate = "5d-lamp-05",
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
            "optics-3"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 05
genLamps {
    number = "05",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {"5d-lamp-04", 1},
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
    },
    nextUpdate = "5d-lamp-06",
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "optics-4",
            "production-science-pack"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 06
genLamps {
    number = "06",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {"5d-lamp-05", 1},
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
    },
    nextUpdate = "5d-lamp-07",
    tech = {
        number = 6,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "optics-5"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 07
genLamps {
    number = "07",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {"5d-lamp-06", 1},
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
    },
    nextUpdate = "5d-lamp-08",
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
            "optics-6",
            "utility-science-pack"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 08
genLamps {
    number = "08",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {"5d-lamp-07", 1},
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
    },
    nextUpdate = "5d-lamp-09",
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
            "optics-7"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 09
genLamps {
    number = "09",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {"5d-lamp-08", 1},
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
    },
    nextUpdate = "5d-lamp-10",
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
            "optics-8"
        }
    }
}

size = size + 20
energy = energy + 15

-- Electric furnace 10
genLamps {
    number = "10",
    subgroup = "energy-lamp",
    lightSize = size,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {"5d-lamp-09", 1},
        {"electronic-circuit", 1},
        {"copper-cable", 3},
        {"iron-plate", 1}
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
            "optics-9"
        }
    }
}
