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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = false,
    ingredients = {
        speed = {
            {"advanced-circuit", 3},
            {"electronic-circuit", 3}
        },
        effectivity = {
            {"advanced-circuit", 3},
            {"electronic-circuit", 3}
        },
        productivity = {
            {"advanced-circuit", 3},
            {"electronic-circuit", 3}
        },
        pollution = {
            {"advanced-circuit", 3},
            {"electronic-circuit", 3}
        },
        merged = {
            {"speed-module", 1},
            {"effectivity-module", 1},
            {"productivity-module", 1},
            {"5d-pollution-module-01", 1}
        }
    },
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            pollution = {
                "modules"
            },
            merged = {
                "speed-module",
                "effectivity-module",
                "productivity-module",
                "5d-pollution-module-1"
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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = false,
    ingredients = {
        speed = {
            {"speed-module", 3},
            {"advanced-circuit", 4},
            {"electronic-circuit", 4}
        },
        effectivity = {
            {"effectivity-module", 3},
            {"advanced-circuit", 4},
            {"electronic-circuit", 4}
        },
        productivity = {
            {"productivity-module", 3},
            {"advanced-circuit", 4},
            {"electronic-circuit", 4}
        },
        pollution = {
            {"5d-pollution-module-01", 3},
            {"advanced-circuit", 4},
            {"electronic-circuit", 4}
        },
        merged = {
            {"speed-module-2", 1},
            {"effectivity-module-2", 1},
            {"productivity-module-2", 1},
            {"5d-pollution-module-02", 1}
        }
    },
    tech = {
        number = 2,
        count = techCount * 1.5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            pollution = {
                "5d-pollution-module-1"
            },
            merged = {
                "5d-merged-module-1",
                "speed-module-2",
                "effectivity-module-2",
                "productivity-module-2",
                "5d-pollution-module-2"
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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = false,
    ingredients = {
        speed = {
            {"speed-module-2", 3},
            {"advanced-circuit", 5},
            {"electronic-circuit", 5}
        },
        effectivity = {
            {"effectivity-module-2", 3},
            {"advanced-circuit", 5},
            {"electronic-circuit", 5}
        },
        productivity = {
            {"productivity-module-2", 3},
            {"advanced-circuit", 5},
            {"electronic-circuit", 5}
        },
        pollution = {
            {"5d-pollution-module-02", 3},
            {"advanced-circuit", 5},
            {"electronic-circuit", 5}
        },
        merged = {
            {"speed-module-3", 1},
            {"effectivity-module-3", 1},
            {"productivity-module-3", 1},
            {"5d-pollution-module-03", 1}
        }
    },
    tech = {
        number = 3,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            pollution = {
                "5d-pollution-module-2"
            },
            merged = {
                "5d-merged-module-2",
                "speed-module-3",
                "effectivity-module-3",
                "productivity-module-3",
                "5d-pollution-module-3"
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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            {"speed-module-3", 3},
            {"advanced-circuit", 3},
            {"processing-unit", 3}
        },
        effectivity = {
            {"effectivity-module-3", 3},
            {"advanced-circuit", 3},
            {"processing-unit", 3}
        },
        productivity = {
            {"productivity-module-3", 3},
            {"advanced-circuit", 3},
            {"processing-unit", 3}
        },
        pollution = {
            {"5d-pollution-module-03", 3},
            {"advanced-circuit", 3},
            {"processing-unit", 3}
        },
        merged = {
            {"5d-speed-module-04", 1},
            {"5d-effectivity-module-04", 1},
            {"5d-productivity-module-04", 1},
            {"5d-pollution-module-04", 1}
        }
    },
    tech = {
        number = 4,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            speed = {
                "speed-module-3"
            },
            effectivity = {
                "effectivity-module-3"
            },
            productivity = {
                "productivity-module-3"
            },
            pollution = {
                "5d-pollution-module-3"
            },
            merged = {
                "5d-merged-module-3",
                "speed-module-4",
                "effectivity-module-4",
                "productivity-module-4",
                "5d-pollution-module-4"
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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            {"5d-speed-module-04", 3},
            {"advanced-circuit", 4},
            {"processing-unit", 4}
        },
        effectivity = {
            {"5d-effectivity-module-04", 3},
            {"advanced-circuit", 4},
            {"processing-unit", 4}
        },
        productivity = {
            {"5d-productivity-module-04", 3},
            {"advanced-circuit", 4},
            {"processing-unit", 4}
        },
        pollution = {
            {"5d-pollution-module-04", 3},
            {"advanced-circuit", 4},
            {"processing-unit", 4}
        },
        merged = {
            {"5d-speed-module-05", 1},
            {"5d-effectivity-module-05", 1},
            {"5d-productivity-module-05", 1},
            {"5d-pollution-module-05", 1}
        }
    },
    tech = {
        number = 5,
        count = techCount * 12,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            speed = {
                "speed-module-4"
            },
            effectivity = {
                "effectivity-module-4"
            },
            productivity = {
                "productivity-module-4"
            },
            pollution = {
                "5d-pollution-module-4"
            },
            merged = {
                "5d-merged-module-4",
                "speed-module-5",
                "effectivity-module-5",
                "productivity-module-5",
                "5d-pollution-module-5"
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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            {"5d-speed-module-05", 3},
            {"advanced-circuit", 5},
            {"processing-unit", 5}
        },
        effectivity = {
            {"5d-effectivity-module-05", 3},
            {"advanced-circuit", 5},
            {"processing-unit", 5}
        },
        productivity = {
            {"5d-productivity-module-05", 3},
            {"advanced-circuit", 5},
            {"processing-unit", 5}
        },
        pollution = {
            {"5d-pollution-module-05", 3},
            {"advanced-circuit", 5},
            {"processing-unit", 5}
        },
        merged = {
            {"5d-speed-module-06", 1},
            {"5d-effectivity-module-06", 1},
            {"5d-productivity-module-06", 1},
            {"5d-pollution-module-06", 1}
        }
    },
    tech = {
        number = 6,
        count = techCount * 15,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            speed = {
                "speed-module-5"
            },
            effectivity = {
                "effectivity-module-5"
            },
            productivity = {
                "productivity-module-5"
            },
            pollution = {
                "5d-pollution-module-5"
            },
            merged = {
                "5d-merged-module-5",
                "speed-module-6",
                "effectivity-module-6",
                "productivity-module-6",
                "5d-pollution-module-6"
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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            {"5d-speed-module-06", 3},
            {"low-density-structure", 3},
            {"advanced-circuit", 3},
            {"processing-unit", 3}
        },
        effectivity = {
            {"5d-effectivity-module-06", 3},
            {"low-density-structure", 3},
            {"advanced-circuit", 3},
            {"processing-unit", 3}
        },
        productivity = {
            {"5d-productivity-module-06", 3},
            {"low-density-structure", 3},
            {"advanced-circuit", 3},
            {"processing-unit", 3}
        },
        pollution = {
            {"5d-pollution-module-06", 3},
            {"low-density-structure", 3},
            {"advanced-circuit", 3},
            {"processing-unit", 3}
        },
        merged = {
            {"5d-speed-module-07", 1},
            {"5d-effectivity-module-07", 1},
            {"5d-productivity-module-07", 1},
            {"5d-pollution-module-07", 1},
            {"utility-science-pack", 1}
        }
    },
    tech = {
        number = 7,
        count = techCount * 18,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
        },
        prerequisites = {
            speed = {
                "speed-module-6"
            },
            effectivity = {
                "effectivity-module-6"
            },
            productivity = {
                "productivity-module-6"
            },
            pollution = {
                "5d-pollution-module-6"
            },
            merged = {
                "5d-merged-module-6",
                "speed-module-7",
                "effectivity-module-7",
                "productivity-module-7",
                "5d-pollution-module-7"
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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            {"5d-speed-module-07", 3},
            {"low-density-structure", 4},
            {"advanced-circuit", 4},
            {"processing-unit", 4}
        },
        effectivity = {
            {"5d-effectivity-module-07", 3},
            {"low-density-structure", 4},
            {"advanced-circuit", 4},
            {"processing-unit", 4}
        },
        productivity = {
            {"5d-productivity-module-07", 3},
            {"low-density-structure", 4},
            {"advanced-circuit", 4},
            {"processing-unit", 4}
        },
        pollution = {
            {"5d-pollution-module-07", 3},
            {"low-density-structure", 4},
            {"advanced-circuit", 4},
            {"processing-unit", 4}
        },
        merged = {
            {"5d-speed-module-08", 1},
            {"5d-effectivity-module-08", 1},
            {"5d-productivity-module-08", 1},
            {"5d-pollution-module-08", 1}
        }
    },
    tech = {
        number = 8,
        count = techCount * 21,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            speed = {
                "speed-module-7"
            },
            effectivity = {
                "effectivity-module-7"
            },
            productivity = {
                "productivity-module-7"
            },
            pollution = {
                "5d-pollution-module-7"
            },
            merged = {
                "5d-merged-module-7",
                "speed-module-8",
                "effectivity-module-8",
                "productivity-module-8",
                "5d-pollution-module-8"
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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            {"5d-speed-module-08", 3},
            {"low-density-structure", 5},
            {"advanced-circuit", 5},
            {"processing-unit", 5}
        },
        effectivity = {
            {"5d-effectivity-module-08", 3},
            {"low-density-structure", 5},
            {"advanced-circuit", 5},
            {"processing-unit", 5}
        },
        productivity = {
            {"5d-productivity-module-08", 3},
            {"low-density-structure", 5},
            {"advanced-circuit", 5},
            {"processing-unit", 5}
        },
        pollution = {
            {"5d-pollution-module-08", 3},
            {"low-density-structure", 5},
            {"advanced-circuit", 5},
            {"processing-unit", 5}
        },
        merged = {
            {"5d-speed-module-09", 1},
            {"5d-effectivity-module-09", 1},
            {"5d-productivity-module-09", 1},
            {"5d-pollution-module-09", 1}
        }
    },
    tech = {
        number = 9,
        count = techCount * 24,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            speed = {
                "speed-module-8"
            },
            effectivity = {
                "effectivity-module-8"
            },
            productivity = {
                "productivity-module-8"
            },
            pollution = {
                "5d-pollution-module-8"
            },
            merged = {
                "5d-merged-module-8",
                "speed-module-9",
                "effectivity-module-9",
                "productivity-module-9",
                "5d-pollution-module-9"
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
            speed = {bonus = 0.08 * level},
            consumption = {bonus = 0.16 * level}
        },
        effectivity = {
            consumption = {bonus = -0.16 * level}
        },
        productivity = {
            productivity = {bonus = 0.02 * level},
            consumption = {bonus = 0.4 * level},
            pollution = {bonus = 0.04 * level},
            speed = {bonus = -0.08 * level}
        },
        pollution = {
            pollution = {bonus = -0.08 * level}
        }
    },
    tier = level,
    timeCraft = time,
    new = true,
    ingredients = {
        speed = {
            {"5d-speed-module-09", 3},
            {"low-density-structure", 6},
            {"advanced-circuit", 6},
            {"processing-unit", 6}
        },
        effectivity = {
            {"5d-effectivity-module-09", 3},
            {"low-density-structure", 6},
            {"advanced-circuit", 6},
            {"processing-unit", 6}
        },
        productivity = {
            {"5d-productivity-module-09", 3},
            {"low-density-structure", 6},
            {"advanced-circuit", 6},
            {"processing-unit", 6}
        },
        pollution = {
            {"5d-pollution-module-09", 3},
            {"low-density-structure", 6},
            {"advanced-circuit", 6},
            {"processing-unit", 6}
        },
        merged = {
            {"5d-speed-module-10", 1},
            {"5d-effectivity-module-10", 1},
            {"5d-productivity-module-10", 1},
            {"5d-pollution-module-10", 1}
        }
    },
    tech = {
        number = 10,
        count = techCount * 27,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            speed = {
                "speed-module-9"
            },
            effectivity = {
                "effectivity-module-9"
            },
            productivity = {
                "productivity-module-9"
            },
            pollution = {
                "5d-pollution-module-9"
            },
            merged = {
                "5d-merged-module-9",
                "speed-module-10",
                "effectivity-module-10",
                "productivity-module-10",
                "5d-pollution-module-10"
            }
        }
    }
}
