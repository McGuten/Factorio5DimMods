require("__5dim_core__.lib.transport.generation-transport-belt")

local transportBeltSpeed = 0.03125
local techCount = 200

-- Transport belts 01
genTransportBelts {
    copy = {
        name = {
            preName = "",
            postName = ""
        },
        tech = "logistics"
    },
    name = {
        preName = ""
    },
    speed = transportBeltSpeed * 1,
    new = false,
    liquids = false,
    number = "01",
    nextUpdate = {
        transportBelt = "fast-transport-belt",
        groundBelt = "fast-underground-belt",
        groundBelt30 = "5d-fast-underground-belt-30-02",
        groundBelt50 = "5d-fast-underground-belt-50-02",
        splitter = "fast-splitter",
        loader = "fast-loader",
        loader1 = "5d-loader-1x1-02",
    },
    order = "a",
    ingredients = {
        transportBelt = {
            { type = "item", name = "iron-plate",      amount = 1 },
            { type = "item", name = "iron-gear-wheel", amount = 1 }
        },
        groundBelt = {
            { type = "item", name = "iron-plate",     amount = 10 },
            { type = "item", name = "transport-belt", amount = 5 }
        },
        groundBelt30 = {
            { type = "item", name = "iron-plate",     amount = 10 },
            { type = "item", name = "transport-belt", amount = 30 }
        },
        groundBelt50 = {
            { type = "item", name = "iron-plate",     amount = 10 },
            { type = "item", name = "transport-belt", amount = 50 }
        },
        splitter = {
            { type = "item", name = "electronic-circuit", amount = 5 },
            { type = "item", name = "iron-plate",         amount = 5 },
            { type = "item", name = "transport-belt",     amount = 4 }
        },
        loader = {
            { type = "item", name = "inserter",           amount = 5 },
            { type = "item", name = "electronic-circuit", amount = 5 },
            { type = "item", name = "iron-gear-wheel",    amount = 5 },
            { type = "item", name = "iron-plate",         amount = 5 },
            { type = "item", name = "transport-belt",     amount = 5 }
        },
        loader1 = {
            { type = "item", name = "inserter",           amount = 5 },
            { type = "item", name = "electronic-circuit", amount = 5 },
            { type = "item", name = "iron-gear-wheel",    amount = 5 },
            { type = "item", name = "iron-plate",         amount = 5 },
            { type = "item", name = "transport-belt",     amount = 5 }
        }
    },
    tech = nil
}

-- Transport belts 02
genTransportBelts {
    copy = {
        name = {
            preName = "fast-",
            postName = ""
        },
        tech = "logistics"
    },
    name = {
        preName = "fast-"
    },
    speed = transportBeltSpeed * 2,
    new = false,
    liquids = false,
    number = "02",
    nextUpdate = {
        transportBelt = "express-transport-belt",
        groundBelt = "express-underground-belt",
        groundBelt30 = "5d-express-underground-belt-30-03",
        groundBelt50 = "5d-express-underground-belt-50-03",
        splitter = "express-splitter",
        loader = "express-loader",
        loader1 = "5d-loader-1x1-03",
    },
    order = "b",
    ingredients = {
        transportBelt = {
            { type = "item", name = "iron-gear-wheel", amount = 5 },
            { type = "item", name = "transport-belt",  amount = 1 }
        },
        groundBelt = {
            { type = "item", name = "iron-gear-wheel",  amount = 40 },
            { type = "item", name = "underground-belt", amount = 2 }
        },
        groundBelt30 = {
            { type = "item", name = "iron-gear-wheel",           amount = 40 },
            { type = "item", name = "5d-underground-belt-30-01", amount = 2 }
        },
        groundBelt50 = {
            { type = "item", name = "iron-gear-wheel",           amount = 40 },
            { type = "item", name = "5d-underground-belt-50-01", amount = 2 }
        },
        splitter = {
            { type = "item", name = "splitter",           amount = 1 },
            { type = "item", name = "iron-gear-wheel",    amount = 10 },
            { type = "item", name = "electronic-circuit", amount = 10 }
        },
        loader = {
            { type = "item", name = "fast-transport-belt", amount = 5 },
            { type = "item", name = "loader",              amount = 1 }
        },
        loader1 = {
            { type = "item", name = "fast-transport-belt", amount = 5 },
            { type = "item", name = "5d-loader-1x1-01",    amount = 1 }
        }
    },
    tech = nil
}

-- Transport belts 03
genTransportBelts {
    copy = {
        name = {
            preName = "express-",
            postName = ""
        },
        tech = "logistics"
    },
    name = {
        preName = "express-"
    },
    speed = transportBeltSpeed * 3,
    new = false,
    liquids = true,
    number = "03",
    nextUpdate = {
        transportBelt = "5d-transport-belt-04",
        groundBelt = "5d-underground-belt-04",
        groundBelt30 = "5d-underground-belt-30-04",
        groundBelt50 = "5d-underground-belt-50-04",
        splitter = "5d-splitter-04",
        loader = "5d-loader-04",
        loader1 = "5d-loader-1x1-04",
    },
    order = "c",
    ingredients = {
        transportBelt = {
            { type = "item",  name = "iron-gear-wheel",     amount = 10 },
            { type = "item",  name = "fast-transport-belt", amount = 1 },
            { type = "fluid", name = "lubricant",           amount = 20 }
        },
        groundBelt = {
            { type = "item",  name = "iron-gear-wheel",       amount = 80 },
            { type = "item",  name = "fast-underground-belt", amount = 2 },
            { type = "fluid", name = "lubricant",             amount = 40 }
        },
        groundBelt30 = {
            { type = "item",  name = "iron-gear-wheel",                amount = 80 },
            { type = "item",  name = "5d-fast-underground-belt-30-02", amount = 2 },
            { type = "fluid", name = "lubricant",                      amount = 40 }
        },
        groundBelt50 = {
            { type = "item",  name = "iron-gear-wheel",                amount = 80 },
            { type = "item",  name = "5d-fast-underground-belt-50-02", amount = 2 },
            { type = "fluid", name = "lubricant",                      amount = 40 }
        },
        splitter = {
            { type = "item",  name = "fast-splitter",    amount = 1 },
            { type = "item",  name = "iron-gear-wheel",  amount = 10 },
            { type = "item",  name = "advanced-circuit", amount = 10 },
            { type = "fluid", name = "lubricant",        amount = 80 }
        },
        loader = {
            { type = "item", name = "express-transport-belt", amount = 5 },
            { type = "item", name = "fast-loader",            amount = 1 }
        },
        loader1 = {
            { type = "item", name = "express-transport-belt", amount = 5 },
            { type = "item", name = "5d-loader-1x1-02",       amount = 1 }
        }
    },
    tech = nil
}

-- Transport belts 04
genTransportBelts {
    copy = {
        name = {
            preName = "express-",
            postName = ""
        },
        tech = "logistics"
    },
    name = {
        preName = ""
    },
    speed = transportBeltSpeed * 4,
    new = true,
    liquids = true,
    number = "04",
    nextUpdate = {
        transportBelt = "5d-transport-belt-05",
        groundBelt = "5d-underground-belt-05",
        groundBelt30 = "5d-underground-belt-30-05",
        groundBelt50 = "5d-underground-belt-50-05",
        splitter = "5d-splitter-05",
        loader = "5d-loader-05",
        loader1 = "5d-loader-1x1-05",
    },
    order = "d",
    ingredients = {
        transportBelt = {
            { type = "item",  name = "iron-gear-wheel",        amount = 15 },
            { type = "item",  name = "express-transport-belt", amount = 1 },
            { type = "fluid", name = "lubricant",              amount = 20 }
        },
        groundBelt = {
            { type = "item",  name = "iron-gear-wheel",          amount = 80 },
            { type = "item",  name = "express-underground-belt", amount = 2 },
            { type = "fluid", name = "lubricant",                amount = 40 }
        },
        groundBelt30 = {
            { type = "item",  name = "iron-gear-wheel",                   amount = 80 },
            { type = "item",  name = "5d-express-underground-belt-30-03", amount = 2 },
            { type = "fluid", name = "lubricant",                         amount = 40 }
        },
        groundBelt50 = {
            { type = "item",  name = "iron-gear-wheel",                   amount = 80 },
            { type = "item",  name = "5d-express-underground-belt-50-03", amount = 2 },
            { type = "fluid", name = "lubricant",                         amount = 40 }
        },
        splitter = {
            { type = "item",  name = "express-splitter", amount = 1 },
            { type = "item",  name = "iron-gear-wheel",  amount = 10 },
            { type = "item",  name = "advanced-circuit", amount = 10 },
            { type = "fluid", name = "lubricant",        amount = 80 }
        },
        loader = {
            { type = "item", name = "5d-transport-belt-04", amount = 5 },
            { type = "item", name = "express-loader",       amount = 1 }
        },
        loader1 = {
            { type = "item", name = "5d-transport-belt-04", amount = 5 },
            { type = "item", name = "5d-loader-1x1-03",     amount = 1 }
        }
    },
    tech = {
        number = 4,
        count = techCount * 2,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "logistics-3",
            "utility-science-pack"
        }
    }
}

-- Transport belts 05
genTransportBelts {
    copy = {
        name = {
            preName = "express-",
            postName = ""
        },
        tech = "logistics-3"
    },
    name = {
        preName = ""
    },
    speed = transportBeltSpeed * 5,
    new = true,
    liquids = true,
    number = "05",
    nextUpdate = {
        transportBelt = "5d-transport-belt-06",
        groundBelt = "5d-underground-belt-06",
        groundBelt30 = "5d-underground-belt-30-06",
        groundBelt50 = "5d-underground-belt-50-06",
        splitter = "5d-splitter-06",
        loader = "5d-loader-06",
        loader1 = "5d-loader-1x1-06",
    },
    order = "e",
    ingredients = {
        transportBelt = {
            { type = "item",  name = "iron-gear-wheel",      amount = 15 },
            { type = "item",  name = "5d-transport-belt-04", amount = 1 },
            { type = "fluid", name = "lubricant",            amount = 20 }
        },
        groundBelt = {
            { type = "item",  name = "iron-gear-wheel",        amount = 80 },
            { type = "item",  name = "5d-underground-belt-04", amount = 2 },
            { type = "fluid", name = "lubricant",              amount = 40 }
        },
        groundBelt30 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-30-04", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        groundBelt50 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-50-04", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        splitter = {
            { type = "item",  name = "5d-splitter-04",   amount = 1 },
            { type = "item",  name = "iron-gear-wheel",  amount = 10 },
            { type = "item",  name = "advanced-circuit", amount = 10 },
            { type = "fluid", name = "lubricant",        amount = 80 }
        },
        loader = {
            { type = "item", name = "5d-transport-belt-05", amount = 5 },
            { type = "item", name = "5d-loader-04",         amount = 1 }
        },
        loader1 = {
            { type = "item", name = "5d-transport-belt-05", amount = 5 },
            { type = "item", name = "5d-loader-1x1-04",     amount = 1 }
        }
    },
    tech = {
        number = 5,
        count = techCount * 3,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "logistics-4",
            "utility-science-pack"
        }
    }
}

-- Transport belts 06
genTransportBelts {
    copy = {
        name = {
            preName = "express-",
            postName = ""
        },
        tech = "logistics-3"
    },
    name = {
        preName = ""
    },
    speed = transportBeltSpeed * 6,
    new = true,
    liquids = true,
    number = "06",
    nextUpdate = {
        transportBelt = "5d-transport-belt-07",
        groundBelt = "5d-underground-belt-07",
        groundBelt30 = "5d-underground-belt-30-07",
        groundBelt50 = "5d-underground-belt-50-07",
        splitter = "5d-splitter-07",
        loader = "5d-loader-07",
        loader1 = "5d-loader-1x1-07",
    },
    order = "f",
    ingredients = {
        transportBelt = {
            { type = "item",  name = "iron-gear-wheel",      amount = 15 },
            { type = "item",  name = "5d-transport-belt-05", amount = 1 },
            { type = "fluid", name = "lubricant",            amount = 20 }
        },
        groundBelt = {
            { type = "item",  name = "iron-gear-wheel",        amount = 80 },
            { type = "item",  name = "5d-underground-belt-05", amount = 2 },
            { type = "fluid", name = "lubricant",              amount = 40 }
        },
        groundBelt30 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-30-05", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        groundBelt50 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-50-05", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        splitter = {
            { type = "item",  name = "5d-splitter-05",   amount = 1 },
            { type = "item",  name = "iron-gear-wheel",  amount = 10 },
            { type = "item",  name = "advanced-circuit", amount = 10 },
            { type = "fluid", name = "lubricant",        amount = 80 }
        },
        loader = {
            { type = "item", name = "5d-transport-belt-06", amount = 5 },
            { type = "item", name = "5d-loader-05",         amount = 1 }
        },
        loader1 = {
            { type = "item", name = "5d-transport-belt-06", amount = 5 },
            { type = "item", name = "5d-loader-1x1-05",     amount = 1 }
        }
    },
    tech = {
        number = 6,
        count = techCount * 4,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "logistics-5"
        }
    }
}

-- Transport belts 07
genTransportBelts {
    copy = {
        name = {
            preName = "express-",
            postName = ""
        },
        tech = "logistics-3"
    },
    name = {
        preName = ""
    },
    speed = transportBeltSpeed * 7,
    new = true,
    liquids = true,
    number = "07",
    nextUpdate = {
        transportBelt = "5d-transport-belt-08",
        groundBelt = "5d-underground-belt-08",
        groundBelt30 = "5d-underground-belt-30-08",
        groundBelt50 = "5d-underground-belt-50-08",
        splitter = "5d-splitter-08",
        loader = "5d-loader-08",
        loader1 = "5d-loader-1x1-08",
    },
    order = "g",
    ingredients = {
        transportBelt = {
            { type = "item",  name = "iron-gear-wheel",      amount = 15 },
            { type = "item",  name = "5d-transport-belt-06", amount = 1 },
            { type = "fluid", name = "lubricant",            amount = 20 }
        },
        groundBelt = {
            { type = "item",  name = "iron-gear-wheel",        amount = 80 },
            { type = "item",  name = "5d-underground-belt-06", amount = 2 },
            { type = "fluid", name = "lubricant",              amount = 40 }
        },
        groundBelt30 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-30-06", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        groundBelt50 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-50-06", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        splitter = {
            { type = "item",  name = "5d-splitter-06",   amount = 1 },
            { type = "item",  name = "iron-gear-wheel",  amount = 10 },
            { type = "item",  name = "advanced-circuit", amount = 10 },
            { type = "fluid", name = "lubricant",        amount = 80 }
        },
        loader = {
            { type = "item", name = "5d-transport-belt-07", amount = 5 },
            { type = "item", name = "5d-loader-06",         amount = 1 }
        },
        loader1 = {
            { type = "item", name = "5d-transport-belt-07", amount = 5 },
            { type = "item", name = "5d-loader-1x1-06",     amount = 1 }
        }
    },
    tech = {
        number = 7,
        count = techCount * 5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "logistics-6"
        }
    }
}

-- Transport belts 08
genTransportBelts {
    copy = {
        name = {
            preName = "express-",
            postName = ""
        },
        tech = "logistics-3"
    },
    name = {
        preName = ""
    },
    speed = transportBeltSpeed * 8,
    new = true,
    liquids = true,
    number = "08",
    nextUpdate = {
        transportBelt = "5d-transport-belt-09",
        groundBelt = "5d-underground-belt-09",
        groundBelt30 = "5d-underground-belt-30-09",
        groundBelt50 = "5d-underground-belt-50-09",
        splitter = "5d-splitter-09",
        loader = "5d-loader-09",
        loader1 = "5d-loader-1x1-09",
    },
    order = "h",
    ingredients = {
        transportBelt = {
            { type = "item",  name = "iron-gear-wheel",      amount = 15 },
            { type = "item",  name = "5d-transport-belt-07", amount = 1 },
            { type = "fluid", name = "lubricant",            amount = 20 }
        },
        groundBelt = {
            { type = "item",  name = "iron-gear-wheel",        amount = 80 },
            { type = "item",  name = "5d-underground-belt-07", amount = 2 },
            { type = "fluid", name = "lubricant",              amount = 40 }
        },
        groundBelt30 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-30-07", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        groundBelt50 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-50-07", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        splitter = {
            { type = "item",  name = "5d-splitter-07",   amount = 1 },
            { type = "item",  name = "iron-gear-wheel",  amount = 10 },
            { type = "item",  name = "advanced-circuit", amount = 10 },
            { type = "fluid", name = "lubricant",        amount = 80 }
        },
        loader = {
            { type = "item", name = "5d-transport-belt-08", amount = 5 },
            { type = "item", name = "5d-loader-07",         amount = 1 }
        },
        loader1 = {
            { type = "item", name = "5d-transport-belt-08", amount = 5 },
            { type = "item", name = "5d-loader-1x1-07",     amount = 1 }
        }
    },
    tech = {
        number = 8,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "logistics-7"
        }
    }
}

-- Transport belts 09
genTransportBelts {
    copy = {
        name = {
            preName = "express-",
            postName = ""
        },
        tech = "logistics-3"
    },
    name = {
        preName = ""
    },
    speed = transportBeltSpeed * 9,
    new = true,
    liquids = true,
    number = "09",
    nextUpdate = {
        transportBelt = "5d-transport-belt-10",
        groundBelt = "5d-underground-belt-10",
        groundBelt30 = "5d-underground-belt-30-10",
        groundBelt50 = "5d-underground-belt-50-10",
        splitter = "5d-splitter-10",
        loader = "5d-loader-10",
        loader1 = "5d-loader-1x1-10",
    },
    order = "i",
    ingredients = {
        transportBelt = {
            { type = "item",  name = "iron-gear-wheel",      amount = 15 },
            { type = "item",  name = "5d-transport-belt-08", amount = 1 },
            { type = "fluid", name = "lubricant",            amount = 20 }
        },
        groundBelt = {
            { type = "item",  name = "iron-gear-wheel",        amount = 80 },
            { type = "item",  name = "5d-underground-belt-08", amount = 2 },
            { type = "fluid", name = "lubricant",              amount = 40 }
        },
        groundBelt30 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-30-08", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        groundBelt50 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-50-08", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        splitter = {
            { type = "item",  name = "5d-splitter-08",   amount = 1 },
            { type = "item",  name = "iron-gear-wheel",  amount = 10 },
            { type = "item",  name = "advanced-circuit", amount = 10 },
            { type = "fluid", name = "lubricant",        amount = 80 }
        },
        loader = {
            { type = "item", name = "5d-transport-belt-09", amount = 5 },
            { type = "item", name = "5d-loader-08",         amount = 1 }
        },
        loader1 = {
            { type = "item", name = "5d-transport-belt-09", amount = 5 },
            { type = "item", name = "5d-loader-1x1-08",     amount = 1 }
        }
    },
    tech = {
        number = 9,
        count = techCount * 7,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "logistics-8"
        }
    }
}

-- Transport belts 10
genTransportBelts {
    copy = {
        name = {
            preName = "express-",
            postName = ""
        },
        tech = "logistics-3"
    },
    name = {
        preName = ""
    },
    speed = transportBeltSpeed * 10,
    new = true,
    liquids = true,
    number = "10",
    nextUpdate = {},
    order = "j",
    ingredients = {
        transportBelt = {
            { type = "item",  name = "iron-gear-wheel",      amount = 15 },
            { type = "item",  name = "5d-transport-belt-09", amount = 1 },
            { type = "fluid", name = "lubricant",            amount = 20 }
        },
        groundBelt = {
            { type = "item",  name = "iron-gear-wheel",        amount = 80 },
            { type = "item",  name = "5d-underground-belt-09", amount = 2 },
            { type = "fluid", name = "lubricant",              amount = 40 }
        },
        groundBelt30 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-30-09", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        groundBelt50 = {
            { type = "item",  name = "iron-gear-wheel",           amount = 80 },
            { type = "item",  name = "5d-underground-belt-50-09", amount = 2 },
            { type = "fluid", name = "lubricant",                 amount = 40 }
        },
        splitter = {
            { type = "item",  name = "5d-splitter-09",   amount = 1 },
            { type = "item",  name = "iron-gear-wheel",  amount = 10 },
            { type = "item",  name = "advanced-circuit", amount = 10 },
            { type = "fluid", name = "lubricant",        amount = 80 }
        },
        loader = {
            { type = "item", name = "5d-transport-belt-10", amount = 5 },
            { type = "item", name = "5d-loader-09",         amount = 1 }
        },
        loader1 = {
            { type = "item", name = "5d-transport-belt-10", amount = 5 },
            { type = "item", name = "5d-loader-1x1-09",     amount = 1 }
        }
    },
    tech = {
        number = 10,
        count = techCount * 8,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            "logistics-9"
        }
    }
}
