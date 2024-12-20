require("__5dim_core__.lib.battlefield.generation-radar")

local escaner = 14
local revelado = 3
local energia = 300
local techCount = 150

-- Radar 01
genRadars {
    number = "01",
    subgroup = "defense-radar",
    order = "a",
    new = false,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "iron-gear-wheel",    amount = 5 },
        { type = "item", name = "iron-plate",         amount = 10 }
    },
    nextUpdate = "5d-radar-02",
    tech = nil
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 300

-- Radar 02
genRadars {
    number = "02",
    subgroup = "defense-radar",
    order = "b",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "iron-gear-wheel",    amount = 5 },
        { type = "item", name = "iron-plate",         amount = 10 },
        { type = "item", name = "radar",              amount = 1 }
    },
    nextUpdate = "5d-radar-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            "electronics"
        }
    }
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 300

-- Radar 03
genRadars {
    number = "03",
    subgroup = "defense-radar",
    order = "c",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel",    amount = 5 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "5d-radar-02",        amount = 1 }
    },
    nextUpdate = "5d-radar-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 }
        },
        prerequisites = {
            "5d-radars-1",
            "military-science-pack"
        }
    }
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 300

-- Radar 04
genRadars {
    number = "04",
    subgroup = "defense-radar",
    order = "d",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel",    amount = 5 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "5d-radar-03",        amount = 1 }
    },
    nextUpdate = "5d-radar-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 }
        },
        prerequisites = {
            "5d-radars-2"
        }
    }
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 300

-- Radar 05
genRadars {
    number = "05",
    subgroup = "defense-radar",
    order = "e",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "advanced-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel",  amount = 5 },
        { type = "item", name = "steel-plate",      amount = 5 },
        { type = "item", name = "5d-radar-04",      amount = 1 }
    },
    nextUpdate = "5d-radar-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-radars-3",
            "chemical-science-pack"
        }
    }
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 300

-- Radar 06
genRadars {
    number = "06",
    subgroup = "defense-radar",
    order = "f",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "advanced-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel",  amount = 5 },
        { type = "item", name = "steel-plate",      amount = 5 },
        { type = "item", name = "5d-radar-05",      amount = 1 }
    },
    nextUpdate = "5d-radar-07",
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-radars-4"
        }
    }
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 300

-- Radar 07
genRadars {
    number = "07",
    subgroup = "defense-radar",
    order = "g",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "advanced-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel",  amount = 5 },
        { type = "item", name = "steel-plate",      amount = 5 },
        { type = "item", name = "5d-radar-06",      amount = 1 }
    },
    nextUpdate = "5d-radar-08",
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            "5d-radars-5"
        }
    }
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 300

-- Radar 08
genRadars {
    number = "08",
    subgroup = "defense-radar",
    order = "h",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "processing-unit", amount = 3 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "steel-plate",     amount = 5 },
        { type = "item", name = "5d-radar-07",     amount = 1 }
    },
    nextUpdate = "5d-radar-09",
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-radars-6",
            "utility-science-pack"
        }
    }
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 300

-- Radar 09
genRadars {
    number = "09",
    subgroup = "defense-radar",
    order = "i",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "processing-unit",       amount = 3 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "steel-plate",           amount = 5 },
        { type = "item", name = "5d-radar-08",           amount = 1 }
    },
    nextUpdate = "5d-radar-10",
    tech = {
        number = 8,
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-radars-7"
        }
    }
}

escaner = escaner + 2
revelado = revelado + 2
energia = energia + 300

-- Radar 10
genRadars {
    number = "10",
    subgroup = "defense-radar",
    order = "j",
    new = true,
    reveal = revelado,
    scan = escaner,
    energy = energia,
    ingredients = {
        { type = "item", name = "processing-unit",       amount = 3 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "steel-plate",           amount = 5 },
        { type = "item", name = "5d-radar-09",           amount = 1 }
    },
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "5d-radars-8"
        }
    }
}
