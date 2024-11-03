require("__5dim_core__.lib.battlefield.generation-gate")

local revelado = 350
local techCount = 500

-- Stone wall 01
genGates {
    number = "01",
    subgroup = "defense-gate",
    order = "a",
    new = false,
    health = revelado,
    ingredients = {
        { type = "item", name = "stone-wall",         amount = 1 },
        { type = "item", name = "steel-plate",        amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 }
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
        { type = "item", name = "5d-stone-wall-02",   amount = 1 },
        { type = "item", name = "gate",               amount = 1 },
        { type = "item", name = "steel-plate",        amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    nextUpdate = "5d-gate-03",
    tech = {
        number = 2,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "gate",
            "stone-wall-2",
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
        { type = "item", name = "5d-stone-wall-03",   amount = 1 },
        { type = "item", name = "5d-gate-02",         amount = 1 },
        { type = "item", name = "steel-plate",        amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    nextUpdate = "5d-gate-04",
    tech = {
        number = 3,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 }
        },
        prerequisites = {
            "gate-2",
            "stone-wall-3",
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
        { type = "item", name = "5d-stone-wall-04",   amount = 1 },
        { type = "item", name = "5d-gate-03",         amount = 1 },
        { type = "item", name = "steel-plate",        amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    nextUpdate = "5d-gate-05",
    tech = {
        number = 4,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 }
        },
        prerequisites = {
            "gate-3",
            "stone-wall-4"
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
        { type = "item", name = "5d-stone-wall-05", amount = 1 },
        { type = "item", name = "5d-gate-04",       amount = 1 },
        { type = "item", name = "steel-plate",      amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    nextUpdate = "5d-gate-06",
    tech = {
        number = 5,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 }
        },
        prerequisites = {
            "gate-4",
            "stone-wall-5"
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
        { type = "item", name = "5d-stone-wall-06", amount = 1 },
        { type = "item", name = "5d-gate-05",       amount = 1 },
        { type = "item", name = "steel-plate",      amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    nextUpdate = "5d-gate-07",
    tech = {
        number = 6,
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "gate-5",
            "stone-wall-6",
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
        { type = "item", name = "5d-stone-wall-07", amount = 1 },
        { type = "item", name = "5d-gate-06",       amount = 1 },
        { type = "item", name = "steel-plate",      amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    nextUpdate = "5d-gate-08",
    tech = {
        number = 7,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "gate-6",
            "stone-wall-7"
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
        { type = "item", name = "5d-stone-wall-08",      amount = 1 },
        { type = "item", name = "5d-gate-07",            amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "advanced-circuit",      amount = 2 }
    },
    nextUpdate = "5d-gate-09",
    tech = {
        number = 8,
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "gate-7",
            "stone-wall-8",
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
        { type = "item", name = "5d-stone-wall-09",      amount = 1 },
        { type = "item", name = "5d-gate-08",            amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "advanced-circuit",      amount = 2 }
    },
    nextUpdate = "5d-gate-10",
    tech = {
        number = 9,
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "gate-8",
            "stone-wall-9"
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
        { type = "item", name = "5d-stone-wall-10",      amount = 1 },
        { type = "item", name = "5d-gate-09",            amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "processing-unit",       amount = 2 }
    },
    tech = {
        number = 10,
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "gate-9",
            "stone-wall-10"
        }
    }
}
