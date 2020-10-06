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
    number = "01",
    nextUpdate = {
        transportBelt = "fast-transport-belt",
        groundBelt = "fast-underground-belt",
        groundBelt30 = "5d-fast-underground-belt-30-02",
        groundBelt50 = "5d-fast-underground-belt-50-02",
        splitter = "fast-splitter",
        loader = "fast-loader"
    },
    order = "a",
    ingredients = {
        transportBelt = {
            {"iron-plate", 1},
            {"iron-gear-wheel", 1}
        },
        groundBelt = {
            {"iron-plate", 10},
            {"transport-belt", 5}
        },
        groundBelt30 = {
            {"iron-plate", 10},
            {"transport-belt", 30}
        },
        groundBelt50 = {
            {"iron-plate", 10},
            {"transport-belt", 50}
        },
        splitter = {
            {"electronic-circuit", 5},
            {"iron-plate", 5},
            {"transport-belt", 4}
        },
        loader = {
            {"inserter", 5},
            {"electronic-circuit", 5},
            {"iron-gear-wheel", 5},
            {"iron-plate", 5},
            {"transport-belt", 5}
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
    number = "02",
    nextUpdate = {
        transportBelt = "express-transport-belt",
        groundBelt = "express-underground-belt",
        groundBelt30 = "5d-express-underground-belt-30-03",
        groundBelt50 = "5d-express-underground-belt-50-03",
        splitter = "express-splitter",
        loader = "express-loader"
    },
    order = "b",
    ingredients = {
        transportBelt = {
            {"iron-plate", 1},
            {"iron-gear-wheel", 1}
        },
        groundBelt = {
            {"iron-gear-wheel", 40},
            {"underground-belt", 2}
        },
        groundBelt30 = {
            {"iron-gear-wheel", 40},
            {"5d-underground-belt-30-01", 2}
        },
        groundBelt50 = {
            {"iron-gear-wheel", 40},
            {"5d-underground-belt-50-01", 2}
        },
        splitter = {
            {"splitter", 1},
            {"iron-gear-wheel", 10},
            {"electronic-circuit", 10}
        },
        loader = {
            {"fast-transport-belt", 5},
            {"loader", 1}
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
    number = "03",
    nextUpdate = {
        transportBelt = "5d-transport-belt-04",
        groundBelt = "5d-underground-belt-04",
        groundBelt30 = "5d-underground-belt-30-04",
        groundBelt50 = "5d-underground-belt-50-04",
        splitter = "5d-splitter-04",
        loader = "5d-loader-04"
    },
    order = "c",
    ingredients = {
        transportBelt = {
            {"iron-gear-wheel", 10},
            {"fast-transport-belt", 1},
            {
                type = "fluid",
                name = "lubricant",
                amount = 20
            }
        },
        groundBelt = {
            {"iron-gear-wheel", 80},
            {"fast-underground-belt", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt30 = {
            {"iron-gear-wheel", 80},
            {"5d-fast-underground-belt-30-02", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt50 = {
            {"iron-gear-wheel", 80},
            {"5d-fast-underground-belt-50-02", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        splitter = {
            {"fast-splitter", 1},
            {"iron-gear-wheel", 10},
            {"advanced-circuit", 10},
            {
                type = "fluid",
                name = "lubricant",
                amount = 80
            }
        },
        loader = {
            {"express-transport-belt", 5},
            {"fast-loader", 1}
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
        tech = "logistics-3"
    },
    name = {
        preName = ""
    },
    speed = transportBeltSpeed * 4,
    new = true,
    number = "04",
    nextUpdate = {
        transportBelt = "5d-transport-belt-05",
        groundBelt = "5d-underground-belt-05",
        groundBelt30 = "5d-underground-belt-30-05",
        groundBelt50 = "5d-underground-belt-50-05",
        splitter = "5d-splitter-05",
        loader = "5d-loader-05"
    },
    order = "d",
    ingredients = {
        transportBelt = {
            {"iron-gear-wheel", 15},
            {"express-transport-belt", 1},
            {
                type = "fluid",
                name = "lubricant",
                amount = 20
            }
        },
        groundBelt = {
            {"iron-gear-wheel", 80},
            {"express-underground-belt", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt30 = {
            {"iron-gear-wheel", 80},
            {"5d-express-underground-belt-30-03", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt50 = {
            {"iron-gear-wheel", 80},
            {"5d-express-underground-belt-50-03", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        splitter = {
            {"express-splitter", 1},
            {"iron-gear-wheel", 10},
            {"advanced-circuit", 10},
            {
                type = "fluid",
                name = "lubricant",
                amount = 80
            }
        },
        loader = {
            {"5d-transport-belt-04", 5},
            {"express-loader", 1}
        }
    },
    tech = {
        number = 4,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "logistics-3"
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
    number = "05",
    nextUpdate = {
        transportBelt = "5d-transport-belt-06",
        groundBelt = "5d-underground-belt-06",
        groundBelt30 = "5d-underground-belt-30-06",
        groundBelt50 = "5d-underground-belt-50-06",
        splitter = "5d-splitter-06",
        loader = "5d-loader-06"
    },
    order = "e",
    ingredients = {
        transportBelt = {
            {"iron-gear-wheel", 15},
            {"5d-transport-belt-04", 1},
            {
                type = "fluid",
                name = "lubricant",
                amount = 20
            }
        },
        groundBelt = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-04", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt30 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-30-04", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt50 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-50-04", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        splitter = {
            {"5d-splitter-04", 1},
            {"iron-gear-wheel", 10},
            {"advanced-circuit", 10},
            {
                type = "fluid",
                name = "lubricant",
                amount = 80
            }
        },
        loader = {
            {"5d-transport-belt-05", 5},
            {"5d-loader-04", 1}
        }
    },
    tech = {
        number = 5,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    number = "06",
    nextUpdate = {
        transportBelt = "5d-transport-belt-07",
        groundBelt = "5d-underground-belt-07",
        groundBelt30 = "5d-underground-belt-30-07",
        groundBelt50 = "5d-underground-belt-50-07",
        splitter = "5d-splitter-07",
        loader = "5d-loader-07"
    },
    order = "f",
    ingredients = {
        transportBelt = {
            {"iron-gear-wheel", 15},
            {"5d-transport-belt-05", 1},
            {
                type = "fluid",
                name = "lubricant",
                amount = 20
            }
        },
        groundBelt = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-05", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt30 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-30-05", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt50 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-50-05", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        splitter = {
            {"5d-splitter-05", 1},
            {"iron-gear-wheel", 10},
            {"advanced-circuit", 10},
            {
                type = "fluid",
                name = "lubricant",
                amount = 80
            }
        },
        loader = {
            {"5d-transport-belt-06", 5},
            {"5d-loader-05", 1}
        }
    },
    tech = {
        number = 6,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    number = "07",
    nextUpdate = {
        transportBelt = "5d-transport-belt-08",
        groundBelt = "5d-underground-belt-08",
        groundBelt30 = "5d-underground-belt-30-08",
        groundBelt50 = "5d-underground-belt-50-08",
        splitter = "5d-splitter-08",
        loader = "5d-loader-08"
    },
    order = "g",
    ingredients = {
        transportBelt = {
            {"iron-gear-wheel", 15},
            {"5d-transport-belt-06", 1},
            {
                type = "fluid",
                name = "lubricant",
                amount = 20
            }
        },
        groundBelt = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-06", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt30 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-30-06", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt50 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-50-06", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        splitter = {
            {"5d-splitter-06", 1},
            {"iron-gear-wheel", 10},
            {"advanced-circuit", 10},
            {
                type = "fluid",
                name = "lubricant",
                amount = 80
            }
        },
        loader = {
            {"5d-transport-belt-07", 5},
            {"5d-loader-06", 1}
        }
    },
    tech = {
        number = 7,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    number = "08",
    nextUpdate = {
        transportBelt = "5d-transport-belt-09",
        groundBelt = "5d-underground-belt-09",
        groundBelt30 = "5d-underground-belt-30-09",
        groundBelt50 = "5d-underground-belt-50-09",
        splitter = "5d-splitter-09",
        loader = "5d-loader-09"
    },
    order = "h",
    ingredients = {
        transportBelt = {
            {"iron-gear-wheel", 15},
            {"5d-transport-belt-07", 1},
            {
                type = "fluid",
                name = "lubricant",
                amount = 20
            }
        },
        groundBelt = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-07", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt30 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-30-07", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt50 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-50-07", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        splitter = {
            {"5d-splitter-07", 1},
            {"iron-gear-wheel", 10},
            {"advanced-circuit", 10},
            {
                type = "fluid",
                name = "lubricant",
                amount = 80
            }
        },
        loader = {
            {"5d-transport-belt-08", 5},
            {"5d-loader-07", 1}
        }
    },
    tech = {
        number = 8,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    number = "09",
    nextUpdate = {
        transportBelt = "5d-transport-belt-10",
        groundBelt = "5d-underground-belt-10",
        groundBelt30 = "5d-underground-belt-30-10",
        groundBelt50 = "5d-underground-belt-50-10",
        splitter = "5d-splitter-10",
        loader = "5d-loader-10"
    },
    order = "i",
    ingredients = {
        transportBelt = {
            {"iron-gear-wheel", 15},
            {"5d-transport-belt-08", 1},
            {
                type = "fluid",
                name = "lubricant",
                amount = 20
            }
        },
        groundBelt = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-08", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt30 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-30-08", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt50 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-50-08", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        splitter = {
            {"5d-splitter-08", 1},
            {"iron-gear-wheel", 10},
            {"advanced-circuit", 10},
            {
                type = "fluid",
                name = "lubricant",
                amount = 80
            }
        },
        loader = {
            {"5d-transport-belt-09", 5},
            {"5d-loader-08", 1}
        }
    },
    tech = {
        number = 9,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
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
    number = "10",
    nextUpdate = {},
    order = "j",
    ingredients = {
        transportBelt = {
            {"iron-gear-wheel", 15},
            {"5d-transport-belt-09", 1},
            {
                type = "fluid",
                name = "lubricant",
                amount = 20
            }
        },
        groundBelt = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-09", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt30 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-30-09", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        groundBelt50 = {
            {"iron-gear-wheel", 80},
            {"5d-underground-belt-50-09", 2},
            {
                type = "fluid",
                name = "lubricant",
                amount = 40
            }
        },
        splitter = {
            {"5d-splitter-09", 1},
            {"iron-gear-wheel", 10},
            {"advanced-circuit", 10},
            {
                type = "fluid",
                name = "lubricant",
                amount = 80
            }
        },
        loader = {
            {"5d-transport-belt-10", 5},
            {"5d-loader-09", 1}
        }
    },
    tech = {
        number = 10,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "logistics-9"
        }
    }
}
