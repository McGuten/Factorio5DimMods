require("__5dim_core__.lib.trains.generation-fluid-wagon")

local speed = 1.5
local maxCargo = 25000
local techCount = 100

-- Electric furnace 01
genFluidWagons {
    number = "01",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = false,
    order = "a",
    ingredients = {
        {"iron-gear-wheel", 10},
        {"steel-plate", 16},
        {"pipe", 8},
        {"storage-tank", 1}
    },
    tech = nil
}

speed = speed + 0.4
maxCargo = maxCargo + 25000

-- Electric furnace 02
genFluidWagons {
    number = "02",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = true,
    order = "b",
    ingredients = {
        {"fluid-wagon", 1},
        {"iron-gear-wheel", 10},
        {"steel-plate", 16},
        {"pipe", 8},
        {"storage-tank", 1}
    },
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "fluid-wagon",
            "logistic-science-pack"
        }
    }
}

speed = speed + 0.4
maxCargo = maxCargo + 25000

-- Electric furnace 03
genFluidWagons {
    number = "03",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = true,
    order = "c",
    ingredients = {
        {"5d-fluid-wagon-02", 1},
        {"iron-gear-wheel", 10},
        {"steel-plate", 16},
        {"pipe", 8},
        {"storage-tank", 1}
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
            "fluid-wagon-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 0.4
maxCargo = maxCargo + 25000

-- Electric furnace 04
genFluidWagons {
    number = "04",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = true,
    order = "d",
    ingredients = {
        {"5d-fluid-wagon-03", 1},
        {"electronic-circuit", 10},
        {"steel-plate", 16},
        {"pipe", 8},
        {"storage-tank", 1}
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
            "fluid-wagon-3"
        }
    }
}

speed = speed + 0.4
maxCargo = maxCargo + 25000

-- Electric furnace 05
genFluidWagons {
    number = "05",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = true,
    order = "e",
    ingredients = {
        {"5d-fluid-wagon-04", 1},
        {"electronic-circuit", 10},
        {"steel-plate", 16},
        {"pipe", 8},
        {"storage-tank", 1}
    },
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "fluid-wagon-4",
            "production-science-pack"
        }
    }
}

speed = speed + 0.4
maxCargo = maxCargo + 25000

-- Electric furnace 06
genFluidWagons {
    number = "06",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = true,
    order = "f",
    ingredients = {
        {"5d-fluid-wagon-05", 1},
        {"advanced-circuit", 10},
        {"steel-plate", 16},
        {"pipe", 8},
        {"storage-tank", 1}
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
            "fluid-wagon-5"
        }
    }
}

speed = speed + 0.4
maxCargo = maxCargo + 25000

-- Electric furnace 07
genFluidWagons {
    number = "07",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = true,
    order = "g",
    ingredients = {
        {"5d-fluid-wagon-06", 1},
        {"advanced-circuit", 10},
        {"steel-plate", 16},
        {"pipe", 8},
        {"storage-tank", 1}
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
            "fluid-wagon-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 0.4
maxCargo = maxCargo + 25000

-- Electric furnace 08
genFluidWagons {
    number = "08",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = true,
    order = "h",
    ingredients = {
        {"5d-fluid-wagon-07", 1},
        {"advanced-circuit", 10},
        {"low-density-structure", 5},
        {"pipe", 8},
        {"storage-tank", 1}
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
            "fluid-wagon-7"
        }
    }
}

speed = speed + 0.4
maxCargo = maxCargo + 25000

-- Electric furnace 09
genFluidWagons {
    number = "09",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = true,
    order = "i",
    ingredients = {
        {"5d-fluid-wagon-08", 1},
        {"advanced-circuit", 10},
        {"low-density-structure", 5},
        {"pipe", 8},
        {"storage-tank", 1}
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
            "fluid-wagon-8"
        }
    }
}

speed = speed + 0.4
maxCargo = maxCargo + 25000

-- Electric furnace 10
genFluidWagons {
    number = "10",
    subgroup = "trains-liquids",
    maxSpeed = speed,
    cargo = maxCargo,
    new = true,
    order = "j",
    ingredients = {
        {"5d-fluid-wagon-09", 1},
        {"processing-unit", 5},
        {"low-density-structure", 5},
        {"pipe", 8},
        {"storage-tank", 1}
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
            "fluid-wagon-9"
        }
    }
}
