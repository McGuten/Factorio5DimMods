require("__5dim_core__.lib.battlefield.generation-wall")

local revelado = 350

-- Stone wall 01
genStoneWalls {
    number = "01",
    subgroup = "defense-wall",
    order = "a",
    new = false,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = nil
}

revelado = revelado + 35

-- Stone wall 02
genStoneWalls {
    number = "02",
    subgroup = "defense-wall",
    order = "b",
    new = true,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 2,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators",
            "logistic-science-pack"
        }
    }
}

revelado = revelado + 35

-- Stone wall 03
genStoneWalls {
    number = "03",
    subgroup = "defense-wall",
    order = "c",
    new = true,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 3,
        count = 750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-2",
            "chemical-science-pack"
        }
    }
}

revelado = revelado + 35

-- Stone wall 04
genStoneWalls {
    number = "04",
    subgroup = "defense-wall",
    order = "d",
    new = true,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 4,
        count = 1000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-3"
        }
    }
}

revelado = revelado + 35

-- Stone wall 05
genStoneWalls {
    number = "05",
    subgroup = "defense-wall",
    order = "e",
    new = true,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 5,
        count = 1250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-4",
            "production-science-pack"
        }
    }
}

revelado = revelado + 35

-- Stone wall 06
genStoneWalls {
    number = "06",
    subgroup = "defense-wall",
    order = "f",
    new = true,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 6,
        count = 1500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-5"
        }
    }
}

revelado = revelado + 35

-- Stone wall 07
genStoneWalls {
    number = "07",
    subgroup = "defense-wall",
    order = "g",
    new = true,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 7,
        count = 1750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-6",
            "utility-science-pack"
        }
    }
}

revelado = revelado + 35

-- Stone wall 08
genStoneWalls {
    number = "08",
    subgroup = "defense-wall",
    order = "h",
    new = true,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 8,
        count = 2000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-7"
        }
    }
}

revelado = revelado + 35

-- Stone wall 09
genStoneWalls {
    number = "09",
    subgroup = "defense-wall",
    order = "i",
    new = true,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 9,
        count = 2250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-8"
        }
    }
}

revelado = revelado + 35

-- Stone wall 10
genStoneWalls {
    number = "10",
    subgroup = "defense-wall",
    order = "j",
    new = true,
    health = revelado,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = {
        number = 10,
        count = 2500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "electric-energy-accumulators-9"
        }
    }
}
