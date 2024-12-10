require("__5dim_core__.lib.module.generation-module")

local level = 1
local time = 5
local techCount = 50

-- Modules 01
genModules {
    number = "01",
    order = "a",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = false,
    ingredients = {
        speed = {
            { type = "item", name = "advanced-circuit",   amount = 3 },
            { type = "item", name = "electronic-circuit", amount = 3 }
        },
        effectivity = {
            { type = "item", name = "advanced-circuit",   amount = 3 },
            { type = "item", name = "electronic-circuit", amount = 3 }
        },
        productivity = {
            { type = "item", name = "advanced-circuit",   amount = 3 },
            { type = "item", name = "electronic-circuit", amount = 3 }
        },
        pollution = {
            { type = "item", name = "advanced-circuit",   amount = 3 },
            { type = "item", name = "electronic-circuit", amount = 3 }
        },
        quality = {
            { type = "item", name = "advanced-circuit",   amount = 3 },
            { type = "item", name = "electronic-circuit", amount = 3 }
        },
        merged = {
            { type = "item", name = "speed-module",           amount = 1 },
            { type = "item", name = "efficiency-module",      amount = 1 },
            { type = "item", name = "productivity-module",    amount = 1 },
            { type = "item", name = "5d-pollution-module-01", amount = 1 },
        }
    },
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 }
        },
        prerequisites = {
            pollution = {
                "modules"
            },
            merged = {
                "speed-module",
                "efficiency-module",
                "productivity-module",
                "5d-pollution-module-1",
            }
        }
    }
}

level = level + 1
time = time + 5

-- Modules 02
genModules {
    number = "02",
    order = "b",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = false,
    ingredients = {
        speed = {
            { type = "item", name = "speed-module",       amount = 3 },
            { type = "item", name = "advanced-circuit",   amount = 4 },
            { type = "item", name = "electronic-circuit", amount = 4 }
        },
        effectivity = {
            { type = "item", name = "efficiency-module",  amount = 3 },
            { type = "item", name = "advanced-circuit",   amount = 4 },
            { type = "item", name = "electronic-circuit", amount = 4 }
        },
        productivity = {
            { type = "item", name = "productivity-module", amount = 3 },
            { type = "item", name = "advanced-circuit",    amount = 4 },
            { type = "item", name = "electronic-circuit",  amount = 4 }
        },
        pollution = {
            { type = "item", name = "5d-pollution-module-01", amount = 3 },
            { type = "item", name = "advanced-circuit",       amount = 4 },
            { type = "item", name = "electronic-circuit",     amount = 4 }
        },
        quality = {
            { type = "item", name = "quality-module",     amount = 3 },
            { type = "item", name = "advanced-circuit",   amount = 4 },
            { type = "item", name = "electronic-circuit", amount = 4 }
        },
        merged = {
            { type = "item", name = "speed-module-2",         amount = 1 },
            { type = "item", name = "efficiency-module-2",    amount = 1 },
            { type = "item", name = "productivity-module-2",  amount = 1 },
            { type = "item", name = "5d-pollution-module-02", amount = 1 },
        }
    },
    tech = {
        number = 2,
        count = techCount * 1.5,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        prerequisites = {
            pollution = {
                "5d-pollution-module-1"
            },
            merged = {
                "5d-merged-module-1",
                "speed-module-2",
                "efficiency-module-2",
                "productivity-module-2",
                "5d-pollution-module-2",
            }
        }
    }
}

level = level + 1
time = time + 5

-- Modules 03
genModules {
    number = "03",
    order = "c",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = false,
    ingredients = {
        speed = {
            { type = "item", name = "speed-module-2",     amount = 3 },
            { type = "item", name = "advanced-circuit",   amount = 5 },
            { type = "item", name = "electronic-circuit", amount = 5 }
        },
        effectivity = {
            { type = "item", name = "efficiency-module-2", amount = 3 },
            { type = "item", name = "advanced-circuit",    amount = 5 },
            { type = "item", name = "electronic-circuit",  amount = 5 }
        },
        productivity = {
            { type = "item", name = "productivity-module-2", amount = 3 },
            { type = "item", name = "advanced-circuit",      amount = 5 },
            { type = "item", name = "electronic-circuit",    amount = 5 }
        },
        pollution = {
            { type = "item", name = "5d-pollution-module-02", amount = 3 },
            { type = "item", name = "advanced-circuit",       amount = 5 },
            { type = "item", name = "electronic-circuit",     amount = 5 }
        },
        quality = {
            { type = "item", name = "quality-module-2",   amount = 3 },
            { type = "item", name = "advanced-circuit",   amount = 5 },
            { type = "item", name = "electronic-circuit", amount = 5 }
        },
        merged = {
            { type = "item", name = "speed-module-3",         amount = 1 },
            { type = "item", name = "efficiency-module-3",    amount = 1 },
            { type = "item", name = "productivity-module-3",  amount = 1 },
            { type = "item", name = "5d-pollution-module-03", amount = 1 },
        }
    },
    tech = {
        number = 3,
        count = techCount * 6,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            pollution = {
                "5d-pollution-module-2"
            },
            merged = {
                "5d-merged-module-2",
                "speed-module-3",
                "efficiency-module-3",
                "productivity-module-3",
                "5d-pollution-module-3",
            }
        }
    }
}

level = level + 1
time = time + 5

-- Modules 04
genModules {
    number = "04",
    order = "d",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            { type = "item", name = "speed-module-3",   amount = 3 },
            { type = "item", name = "advanced-circuit", amount = 3 },
            { type = "item", name = "processing-unit",  amount = 3 }
        },
        effectivity = {
            { type = "item", name = "efficiency-module-3", amount = 3 },
            { type = "item", name = "advanced-circuit",    amount = 3 },
            { type = "item", name = "processing-unit",     amount = 3 }
        },
        productivity = {
            { type = "item", name = "productivity-module-3", amount = 3 },
            { type = "item", name = "advanced-circuit",      amount = 3 },
            { type = "item", name = "processing-unit",       amount = 3 }
        },
        pollution = {
            { type = "item", name = "5d-pollution-module-03", amount = 3 },
            { type = "item", name = "advanced-circuit",       amount = 3 },
            { type = "item", name = "processing-unit",        amount = 3 }
        },
        quality = {
            { type = "item", name = "quality-module-3", amount = 3 },
            { type = "item", name = "advanced-circuit", amount = 3 },
            { type = "item", name = "processing-unit",  amount = 3 }
        },
        merged = {
            { type = "item", name = "5d-speed-module-04",        amount = 1 },
            { type = "item", name = "5d-efficiency-module-04",   amount = 1 },
            { type = "item", name = "5d-productivity-module-04", amount = 1 },
            { type = "item", name = "5d-pollution-module-04",    amount = 1 },
        }
    },
    tech = {
        number = 4,
        count = techCount * 9,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 }
        },
        prerequisites = {
            speed = {
                "speed-module-3"
            },
            effectivity = {
                "efficiency-module-3"
            },
            productivity = {
                "productivity-module-3"
            },
            pollution = {
                "5d-pollution-module-3"
            },
            quality = {
                "quality-module-3"
            },
            merged = {
                "5d-merged-module-3",
                "speed-module-4",
                "efficiency-module-4",
                "productivity-module-4",
                "5d-pollution-module-4",
            }
        }
    }
}

level = level + 1
time = time + 5

-- Modules 05
genModules {
    number = "05",
    order = "e",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            { type = "item", name = "5d-speed-module-04", amount = 3 },
            { type = "item", name = "advanced-circuit",   amount = 4 },
            { type = "item", name = "processing-unit",    amount = 4 }
        },
        effectivity = {
            { type = "item", name = "5d-efficiency-module-04", amount = 3 },
            { type = "item", name = "advanced-circuit",        amount = 4 },
            { type = "item", name = "processing-unit",         amount = 4 }
        },
        productivity = {
            { type = "item", name = "5d-productivity-module-04", amount = 3 },
            { type = "item", name = "advanced-circuit",          amount = 4 },
            { type = "item", name = "processing-unit",           amount = 4 }
        },
        pollution = {
            { type = "item", name = "5d-pollution-module-04", amount = 3 },
            { type = "item", name = "advanced-circuit",       amount = 4 },
            { type = "item", name = "processing-unit",        amount = 4 }
        },
        quality = {
            { type = "item", name = "5d-quality-module-04", amount = 3 },
            { type = "item", name = "advanced-circuit",     amount = 4 },
            { type = "item", name = "processing-unit",      amount = 4 }
        },
        merged = {
            { type = "item", name = "5d-speed-module-05",        amount = 1 },
            { type = "item", name = "5d-efficiency-module-05",   amount = 1 },
            { type = "item", name = "5d-productivity-module-05", amount = 1 },
            { type = "item", name = "5d-pollution-module-05",    amount = 1 },
        }
    },
    tech = {
        number = 5,
        count = techCount * 12,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            speed = {
                "speed-module-4"
            },
            effectivity = {
                "efficiency-module-4"
            },
            productivity = {
                "productivity-module-4"
            },
            pollution = {
                "5d-pollution-module-4"
            },
            quality = {
                "quality-module-4"
            },
            merged = {
                "5d-merged-module-4",
                "speed-module-5",
                "efficiency-module-5",
                "productivity-module-5",
                "5d-pollution-module-5",
            }
        }
    }
}

level = level + 1
time = time + 5

-- Modules 06
genModules {
    number = "06",
    order = "f",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            { type = "item", name = "5d-speed-module-05", amount = 3 },
            { type = "item", name = "advanced-circuit",   amount = 5 },
            { type = "item", name = "processing-unit",    amount = 5 }
        },
        effectivity = {
            { type = "item", name = "5d-efficiency-module-05", amount = 3 },
            { type = "item", name = "advanced-circuit",        amount = 5 },
            { type = "item", name = "processing-unit",         amount = 5 }
        },
        productivity = {
            { type = "item", name = "5d-productivity-module-05", amount = 3 },
            { type = "item", name = "advanced-circuit",          amount = 5 },
            { type = "item", name = "processing-unit",           amount = 5 }
        },
        pollution = {
            { type = "item", name = "5d-pollution-module-05", amount = 3 },
            { type = "item", name = "advanced-circuit",       amount = 5 },
            { type = "item", name = "processing-unit",        amount = 5 }
        },
        quality = {
            { type = "item", name = "5d-quality-module-05", amount = 3 },
            { type = "item", name = "advanced-circuit",   amount = 5 },
            { type = "item", name = "processing-unit",    amount = 5 }
        },
        merged = {
            { type = "item", name = "5d-speed-module-06",        amount = 1 },
            { type = "item", name = "5d-efficiency-module-06",   amount = 1 },
            { type = "item", name = "5d-productivity-module-06", amount = 1 },
            { type = "item", name = "5d-pollution-module-06",    amount = 1 },
        }
    },
    tech = {
        number = 6,
        count = techCount * 15,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            speed = {
                "speed-module-5"
            },
            effectivity = {
                "efficiency-module-5"
            },
            productivity = {
                "productivity-module-5"
            },
            pollution = {
                "5d-pollution-module-5"
            },
            quality = {
                "quality-module-5"
            },
            merged = {
                "5d-merged-module-5",
                "speed-module-6",
                "efficiency-module-6",
                "productivity-module-6",
                "5d-pollution-module-6",
            }
        }
    }
}

level = level + 1
time = time + 5

-- Modules 07
genModules {
    number = "07",
    order = "g",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            { type = "item", name = "5d-speed-module-06",    amount = 3 },
            { type = "item", name = "low-density-structure", amount = 3 },
            { type = "item", name = "advanced-circuit",      amount = 3 },
            { type = "item", name = "processing-unit",       amount = 3 }
        },
        effectivity = {
            { type = "item", name = "5d-efficiency-module-06", amount = 3 },
            { type = "item", name = "low-density-structure",   amount = 3 },
            { type = "item", name = "advanced-circuit",        amount = 3 },
            { type = "item", name = "processing-unit",         amount = 3 }
        },
        productivity = {
            { type = "item", name = "5d-productivity-module-06", amount = 3 },
            { type = "item", name = "low-density-structure",     amount = 3 },
            { type = "item", name = "advanced-circuit",          amount = 3 },
            { type = "item", name = "processing-unit",           amount = 3 }
        },
        pollution = {
            { type = "item", name = "5d-pollution-module-06", amount = 3 },
            { type = "item", name = "low-density-structure",  amount = 3 },
            { type = "item", name = "advanced-circuit",       amount = 3 },
            { type = "item", name = "processing-unit",        amount = 3 }
        },
        quality = {
            { type = "item", name = "5d-quality-module-06",    amount = 3 },
            { type = "item", name = "low-density-structure", amount = 3 },
            { type = "item", name = "advanced-circuit",      amount = 3 },
            { type = "item", name = "processing-unit",       amount = 3 }
        },
        merged = {
            { type = "item", name = "5d-speed-module-07",        amount = 1 },
            { type = "item", name = "5d-efficiency-module-07",   amount = 1 },
            { type = "item", name = "5d-productivity-module-07", amount = 1 },
            { type = "item", name = "5d-pollution-module-07",    amount = 1 },
        }
    },
    tech = {
        number = 7,
        count = techCount * 18,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 }
        },
        prerequisites = {
            speed = {
                "speed-module-6"
            },
            effectivity = {
                "efficiency-module-6"
            },
            productivity = {
                "productivity-module-6"
            },
            pollution = {
                "5d-pollution-module-6"
            },
            quality = {
                "quality-module-6"
            },
            merged = {
                "5d-merged-module-6",
                "speed-module-7",
                "efficiency-module-7",
                "productivity-module-7",
                "5d-pollution-module-7",
            }
        }
    }
}

level = level + 1
time = time + 5

-- Modules 08
genModules {
    number = "08",
    order = "h",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            { type = "item", name = "5d-speed-module-07",    amount = 3 },
            { type = "item", name = "low-density-structure", amount = 4 },
            { type = "item", name = "advanced-circuit",      amount = 4 },
            { type = "item", name = "processing-unit",       amount = 4 }
        },
        effectivity = {
            { type = "item", name = "5d-efficiency-module-07", amount = 3 },
            { type = "item", name = "low-density-structure",   amount = 4 },
            { type = "item", name = "advanced-circuit",        amount = 4 },
            { type = "item", name = "processing-unit",         amount = 4 }
        },
        productivity = {
            { type = "item", name = "5d-productivity-module-07", amount = 3 },
            { type = "item", name = "low-density-structure",     amount = 4 },
            { type = "item", name = "advanced-circuit",          amount = 4 },
            { type = "item", name = "processing-unit",           amount = 4 }
        },
        pollution = {
            { type = "item", name = "5d-pollution-module-07", amount = 3 },
            { type = "item", name = "low-density-structure",  amount = 4 },
            { type = "item", name = "advanced-circuit",       amount = 4 },
            { type = "item", name = "processing-unit",        amount = 4 }
        },
        quality = {
            { type = "item", name = "5d-quality-module-07",    amount = 3 },
            { type = "item", name = "low-density-structure", amount = 4 },
            { type = "item", name = "advanced-circuit",      amount = 4 },
            { type = "item", name = "processing-unit",       amount = 4 }
        },
        merged = {
            { type = "item", name = "5d-speed-module-08",        amount = 1 },
            { type = "item", name = "5d-efficiency-module-08",   amount = 1 },
            { type = "item", name = "5d-productivity-module-08", amount = 1 },
            { type = "item", name = "5d-pollution-module-08",    amount = 1 },
        }
    },
    tech = {
        number = 8,
        count = techCount * 21,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            speed = {
                "speed-module-7"
            },
            effectivity = {
                "efficiency-module-7"
            },
            productivity = {
                "productivity-module-7"
            },
            pollution = {
                "5d-pollution-module-7"
            },
            quality = {
                "quality-module-7"
            },
            merged = {
                "5d-merged-module-7",
                "speed-module-8",
                "efficiency-module-8",
                "productivity-module-8",
                "5d-pollution-module-8",
            }
        }
    }
}

level = level + 1
time = time + 5

-- Modules 09
genModules {
    number = "09",
    order = "i",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            { type = "item", name = "5d-speed-module-08",    amount = 3 },
            { type = "item", name = "low-density-structure", amount = 5 },
            { type = "item", name = "advanced-circuit",      amount = 5 },
            { type = "item", name = "processing-unit",       amount = 5 }
        },
        effectivity = {
            { type = "item", name = "5d-efficiency-module-08", amount = 3 },
            { type = "item", name = "low-density-structure",   amount = 5 },
            { type = "item", name = "advanced-circuit",        amount = 5 },
            { type = "item", name = "processing-unit",         amount = 5 }
        },
        productivity = {
            { type = "item", name = "5d-productivity-module-08", amount = 3 },
            { type = "item", name = "low-density-structure",     amount = 5 },
            { type = "item", name = "advanced-circuit",          amount = 5 },
            { type = "item", name = "processing-unit",           amount = 5 }
        },
        pollution = {
            { type = "item", name = "5d-pollution-module-08", amount = 3 },
            { type = "item", name = "low-density-structure",  amount = 5 },
            { type = "item", name = "advanced-circuit",       amount = 5 },
            { type = "item", name = "processing-unit",        amount = 5 }
        },
        quality = {
            { type = "item", name = "5d-quality-module-08",    amount = 3 },
            { type = "item", name = "low-density-structure", amount = 5 },
            { type = "item", name = "advanced-circuit",      amount = 5 },
            { type = "item", name = "processing-unit",       amount = 5 }
        },
        merged = {
            { type = "item", name = "5d-speed-module-09",        amount = 1 },
            { type = "item", name = "5d-efficiency-module-09",   amount = 1 },
            { type = "item", name = "5d-productivity-module-09", amount = 1 },
            { type = "item", name = "5d-pollution-module-09",    amount = 1 },
        }
    },
    tech = {
        number = 9,
        count = techCount * 24,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            speed = {
                "speed-module-8"
            },
            effectivity = {
                "efficiency-module-8"
            },
            productivity = {
                "productivity-module-8"
            },
            pollution = {
                "5d-pollution-module-8"
            },
            quality = {
                "quality-module-8"
            },
            merged = {
                "5d-merged-module-8",
                "speed-module-9",
                "efficiency-module-9",
                "productivity-module-9",
                "5d-pollution-module-9",
            }
        }
    }
}

level = level + 1
time = time + 5

-- Modules 10
genModules {
    number = "10",
    order = "j",
    effects = {
        speed = {
            speed = 0.08 * level,
            consumption = 0.16 * level
        },
        effectivity = {
            consumption = -0.16 * level
        },
        productivity = {
            productivity = 0.02 * level,
            consumption = 0.4 * level,
            pollution = 0.04 * level,
            speed = -0.08 * level
        },
        pollution = {
            pollution = -0.08 * level
        },
        quality = {
            quality = 0.05 * level
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            { type = "item", name = "5d-speed-module-09",    amount = 3 },
            { type = "item", name = "low-density-structure", amount = 6 },
            { type = "item", name = "advanced-circuit",      amount = 6 },
            { type = "item", name = "processing-unit",       amount = 6 }
        },
        effectivity = {
            { type = "item", name = "5d-efficiency-module-09", amount = 3 },
            { type = "item", name = "low-density-structure",   amount = 6 },
            { type = "item", name = "advanced-circuit",        amount = 6 },
            { type = "item", name = "processing-unit",         amount = 6 }
        },
        productivity = {
            { type = "item", name = "5d-productivity-module-09", amount = 3 },
            { type = "item", name = "low-density-structure",     amount = 6 },
            { type = "item", name = "advanced-circuit",          amount = 6 },
            { type = "item", name = "processing-unit",           amount = 6 }
        },
        pollution = {
            { type = "item", name = "5d-pollution-module-09", amount = 3 },
            { type = "item", name = "low-density-structure",  amount = 6 },
            { type = "item", name = "advanced-circuit",       amount = 6 },
            { type = "item", name = "processing-unit",        amount = 6 }
        },
        quality = {
            { type = "item", name = "5d-quality-module-09",    amount = 3 },
            { type = "item", name = "low-density-structure", amount = 6 },
            { type = "item", name = "advanced-circuit",      amount = 6 },
            { type = "item", name = "processing-unit",       amount = 6 }
        },
        merged = {
            { type = "item", name = "5d-speed-module-10",        amount = 1 },
            { type = "item", name = "5d-efficiency-module-10",   amount = 1 },
            { type = "item", name = "5d-productivity-module-10", amount = 1 },
            { type = "item", name = "5d-pollution-module-10",    amount = 1 },
        }
    },
    tech = {
        number = 10,
        count = techCount * 27,
        packs = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 }
        },
        prerequisites = {
            speed = {
                "speed-module-9"
            },
            effectivity = {
                "efficiency-module-9"
            },
            productivity = {
                "productivity-module-9"
            },
            pollution = {
                "5d-pollution-module-9"
            },
            quality = {
                "quality-module-9"
            },
            merged = {
                "5d-merged-module-9",
                "speed-module-10",
                "efficiency-module-10",
                "productivity-module-10",
                "5d-pollution-module-10",
            }
        }
    }
}
