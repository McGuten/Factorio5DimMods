require("__5dim_core__.lib.battlefield.generation-radar")

local escaner = 14
local revelado = 3
local energia = 300

-- Laser turret 01
genRadars {
    number = "01",
    subgroup = "defense-radar",
    order = "a",
    new = false,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        {"iron-plate", 2},
        {"battery", 5}
    },
    tech = nil
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 150

-- Laser turret 02
genRadars {
    number = "02",
    subgroup = "defense-radar",
    order = "b",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
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

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 150

-- Laser turret 03
genRadars {
    number = "03",
    subgroup = "defense-radar",
    order = "c",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
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

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 150

-- Laser turret 04
genRadars {
    number = "04",
    subgroup = "defense-radar",
    order = "d",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
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

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 150

-- Laser turret 05
genRadars {
    number = "05",
    subgroup = "defense-radar",
    order = "e",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
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

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 150

-- Laser turret 06
genRadars {
    number = "06",
    subgroup = "defense-radar",
    order = "f",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
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

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 150

-- Laser turret 07
genRadars {
    number = "07",
    subgroup = "defense-radar",
    order = "g",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
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

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 150

-- Laser turret 08
genRadars {
    number = "08",
    subgroup = "defense-radar",
    order = "h",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
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

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 150

-- Laser turret 09
genRadars {
    number = "09",
    subgroup = "defense-radar",
    order = "i",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
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

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 150

-- Laser turret 10
genRadars {
    number = "10",
    subgroup = "defense-radar",
    order = "j",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
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
