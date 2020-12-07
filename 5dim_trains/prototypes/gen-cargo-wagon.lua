require("__5dim_core__.lib.trains.generation-cargo-wagon")

local speed = 1.5
local maxCargo = 40
local weightWagon = 2000
local techCount = 100

-- Electric furnace 01
genCargoWagons {
    number = "01",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = false,
    order = "a",
    ingredients = {
        {"iron-gear-wheel", 10},
        {"iron-plate", 20},
        {"steel-plate", 20}
    },
    tech = nil
}

speed = speed + 0.17
maxCargo = maxCargo + 40
weightWagon = weightWagon + 500

-- Electric furnace 02
genCargoWagons {
    number = "02",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "b",
    ingredients = {
        {"cargo-wagon", 1},
        {"iron-gear-wheel", 10},
        {"iron-plate", 20},
        {"steel-plate", 20}
    },
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "railway"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 40
weightWagon = weightWagon + 500

-- Electric furnace 03
genCargoWagons {
    number = "03",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "c",
    ingredients = {
        {"5d-cargo-wagon-02", 1},
        {"iron-gear-wheel", 10},
        {"iron-plate", 20},
        {"steel-plate", 20}
    },
    tech = {
        number = 3,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-cargo-wagon-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 40
weightWagon = weightWagon + 500

-- Electric furnace 04
genCargoWagons {
    number = "04",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "d",
    ingredients = {
        {"5d-cargo-wagon-03", 1},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"steel-plate", 20}
    },
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
            "5d-cargo-wagon-3",
            "production-science-pack"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 40
weightWagon = weightWagon + 500

-- Electric furnace 05
genCargoWagons {
    number = "05",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "e",
    ingredients = {
        {"5d-cargo-wagon-04", 1},
        {"iron-gear-wheel", 10},
        {"electronic-circuit", 5},
        {"steel-plate", 20}
    },
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-cargo-wagon-4",
            "production-science-pack"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 40
weightWagon = weightWagon + 500

-- Electric furnace 06
genCargoWagons {
    number = "06",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "f",
    ingredients = {
        {"5d-cargo-wagon-05", 1},
        {"low-density-structure", 5},
        {"electronic-circuit", 5},
        {"steel-plate", 20}
    },
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
            "5d-cargo-wagon-5"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 40
weightWagon = weightWagon + 500

-- Electric furnace 07
genCargoWagons {
    number = "07",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "g",
    ingredients = {
        {"5d-cargo-wagon-06", 1},
        {"low-density-structure", 5},
        {"advanced-circuit", 5},
        {"steel-plate", 20}
    },
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
            "5d-cargo-wagon-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 40
weightWagon = weightWagon + 500

-- Electric furnace 08
genCargoWagons {
    number = "08",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "h",
    ingredients = {
        {"5d-cargo-wagon-07", 1},
        {"low-density-structure", 5},
        {"advanced-circuit", 5},
        {"steel-plate", 20}
    },
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
            "5d-cargo-wagon-7"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 40
weightWagon = weightWagon + 500

-- Electric furnace 09
genCargoWagons {
    number = "09",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "i",
    ingredients = {
        {"5d-cargo-wagon-08", 1},
        {"low-density-structure", 5},
        {"advanced-circuit", 5},
        {"steel-plate", 20}
    },
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
            "5d-cargo-wagon-8"
        }
    }
}

speed = speed + 0.17
maxCargo = maxCargo + 40
weightWagon = weightWagon + 500

-- Electric furnace 10
genCargoWagons {
    number = "10",
    subgroup = "trains-wagons",
    maxSpeed = speed,
    cargo = maxCargo,
    weight = weightWagon,
    new = true,
    order = "j",
    ingredients = {
        {"5d-cargo-wagon-09", 1},
        {"low-density-structure", 5},
        {"processing-unit", 3},
        {"steel-plate", 20}
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
            "5d-cargo-wagon-9"
        }
    }
}
