require("__5dim_core__.lib.battlefield.generation-gate")

local revelado = 350

-- Stone wall 01
genGates {
    number = "01",
    subgroup = "defense-gate",
    order = "a",
    new = false,
    health = revelado,
    ingredients = {
        {"stone-wall", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2}
    },
    nextUpdate = "5d-gate-02",
    tech = nil
}

revelado = revelado + 35

-- Stone wall 02
genGates {
    number = "02",
    subgroup = "defense-gate",
    order = "b",
    new = true,
    health = revelado,
    ingredients = {
        {"5d-stone-wall-02", 1},
        {"gate", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2}
    },
    nextUpdate = "5d-gate-03",
    tech = {
        number = 2,
        count = 500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "gates",
            "stone-walls-2",
            "logistic-science-pack"
        }
    }
}

revelado = revelado + 35

-- Stone wall 03
genGates {
    number = "03",
    subgroup = "defense-gate",
    order = "c",
    new = true,
    health = revelado,
    ingredients = {
        {"5d-stone-wall-03", 1},
        {"5d-gate-02", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2}
    },
    nextUpdate = "5d-gate-04",
    tech = {
        number = 3,
        count = 750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "gates-2",
            "stone-walls-3",
            "military-science-pack"
        }
    }
}

revelado = revelado + 35

-- Stone wall 04
genGates {
    number = "04",
    subgroup = "defense-gate",
    order = "d",
    new = true,
    health = revelado,
    ingredients = {
        {"5d-stone-wall-04", 1},
        {"5d-gate-03", 1},
        {"steel-plate", 2},
        {"electronic-circuit", 2}
    },
    nextUpdate = "5d-gate-05",
    tech = {
        number = 4,
        count = 1000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "gates-3",
            "stone-walls-4"
        }
    }
}

revelado = revelado + 35

-- Stone wall 05
genGates {
    number = "05",
    subgroup = "defense-gate",
    order = "e",
    new = true,
    health = revelado,
    ingredients = {
        {"5d-stone-wall-05", 1},
        {"5d-gate-04", 1},
        {"steel-plate", 2},
        {"advanced-circuit", 2}
    },
    nextUpdate = "5d-gate-06",
    tech = {
        number = 5,
        count = 1250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1}
        },
        prerequisites = {
            "gates-4",
            "stone-walls-5"
        }
    }
}

revelado = revelado + 35

-- Stone wall 06
genGates {
    number = "06",
    subgroup = "defense-gate",
    order = "f",
    new = true,
    health = revelado,
    ingredients = {
        {"5d-stone-wall-06", 1},
        {"5d-gate-05", 1},
        {"steel-plate", 2},
        {"advanced-circuit", 2}
    },
    nextUpdate = "5d-gate-07",
    tech = {
        number = 6,
        count = 1500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "gates-5",
            "stone-walls-6",
            "chemical-science-pack"
        }
    }
}

revelado = revelado + 35

-- Stone wall 07
genGates {
    number = "07",
    subgroup = "defense-gate",
    order = "g",
    new = true,
    health = revelado,
    ingredients = {
        {"5d-stone-wall-07", 1},
        {"5d-gate-06", 1},
        {"steel-plate", 2},
        {"advanced-circuit", 2}
    },
    nextUpdate = "5d-gate-08",
    tech = {
        number = 7,
        count = 1750,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "gates-6",
            "stone-walls-7"
        }
    }
}

revelado = revelado + 35

-- Stone wall 08
genGates {
    number = "08",
    subgroup = "defense-gate",
    order = "h",
    new = true,
    health = revelado,
    ingredients = {
        {"5d-stone-wall-08", 1},
        {"5d-gate-07", 1},
        {"low-density-structure", 2},
        {"advanced-circuit", 2}
    },
    nextUpdate = "5d-gate-09",
    tech = {
        number = 8,
        count = 2000,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "gates-7",
            "stone-walls-8",
            "utility-science-pack"
        }
    }
}

revelado = revelado + 35

-- Stone wall 09
genGates {
    number = "09",
    subgroup = "defense-gate",
    order = "i",
    new = true,
    health = revelado,
    ingredients = {
        {"5d-stone-wall-09", 1},
        {"5d-gate-08", 1},
        {"low-density-structure", 2},
        {"advanced-circuit", 2}
    },
    nextUpdate = "5d-gate-10",
    tech = {
        number = 9,
        count = 2250,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "gates-8",
            "stone-walls-9"
        }
    }
}

revelado = revelado + 35

-- Stone wall 10
genGates {
    number = "10",
    subgroup = "defense-gate",
    order = "j",
    new = true,
    health = revelado,
    ingredients = {
        {"5d-stone-wall-10", 1},
        {"5d-gate-09", 1},
        {"low-density-structure", 2},
        {"processing-unit", 2}
    },
    tech = {
        number = 10,
        count = 2500,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"military-science-pack", 1},
            {"chemical-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "gates-9",
            "stone-walls-10"
        }
    }
}
