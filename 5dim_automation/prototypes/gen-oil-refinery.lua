require("__5dim_core__.lib.automation.generation-oil-refinery")

local speed = 1
local modules = 3
local energy = 420
local emisions = 6
local techCount = 200

-- Electric furnace 01
genOilRefinery {
    number = "01",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = false,
    order = "a",
    ingredients = {
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "iron-gear-wheel", amount = 10},
        {type = "item", name = "stone-brick", amount = 10},
        {type = "item", name = "electronic-circuit", amount = 10},
        {type = "item", name = "pipe", amount = 10}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-oil-refinery-02",
    tech = nil
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 02
genOilRefinery {
    number = "02",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "b",
    ingredients = {
        {type = "item", name = "oil-refinery", amount = 1},
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "iron-gear-wheel", amount = 10},
        {type = "item", name = "concrete", amount = 10},
        {type = "item", name = "electronic-circuit", amount = 10},
        {type = "item", name = "pipe", amount = 10}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-oil-refinery-03",
    tech = {
        number = 1,
        count = techCount * 1,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "oil-processing",
            "logistic-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 03
genOilRefinery {
    number = "03",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "c",
    ingredients = {
        {type = "item", name = "5d-oil-refinery-02", amount = 1},
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "iron-gear-wheel", amount = 10},
        {type = "item", name = "concrete", amount = 10},
        {type = "item", name = "electronic-circuit", amount = 10},
        {type = "item", name = "pipe", amount = 10}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-oil-refinery-04",
    tech = {
        number = 2,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-1"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 04
genOilRefinery {
    number = "04",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "d",
    ingredients = {
        {type = "item", name = "5d-oil-refinery-03", amount = 1},
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "iron-gear-wheel", amount = 10},
        {type = "item", name = "concrete", amount = 10},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "pipe", amount = 10}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-oil-refinery-05",
    tech = {
        number = 3,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-2",
            "chemical-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 05
genOilRefinery {
    number = "05",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "e",
    ingredients = {
        {type = "item", name = "5d-oil-refinery-04", amount = 1},
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "iron-gear-wheel", amount = 10},
        {type = "item", name = "refined-concrete", amount = 10},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "pipe", amount = 10},
        {type = "item", name = "speed-module", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-oil-refinery-06",
    tech = {
        number = 4,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-3"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 06
genOilRefinery {
    number = "06",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "f",
    ingredients = {
        {type = "item", name = "5d-oil-refinery-05", amount = 1},
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "iron-gear-wheel", amount = 10},
        {type = "item", name = "refined-concrete", amount = 10},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "pipe", amount = 10},
        {type = "item", name = "productivity-module", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-oil-refinery-07",
    tech = {
        number = 5,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-4",
            "production-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 07
genOilRefinery {
    number = "07",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "g",
    ingredients = {
        {type = "item", name = "5d-oil-refinery-06", amount = 1},
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "low-density-structure", amount = 3},
        {type = "item", name = "concrete", amount = 10},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "pipe", amount = 10},
        {type = "item", name = "speed-module-2", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-oil-refinery-08",
    tech = {
        number = 6,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-5"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 08
genOilRefinery {
    number = "08",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules,
    energyUsage = energy,
    new = true,
    order = "h",
    ingredients = {
        {type = "item", name = "5d-oil-refinery-07", amount = 1},
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "low-density-structure", amount = 3},
        {type = "item", name = "concrete", amount = 10},
        {type = "item", name = "advanced-circuit", amount = 10},
        {type = "item", name = "pipe", amount = 10},
        {type = "item", name = "productivity-module-2", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-oil-refinery-09",
    tech = {
        number = 7,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-6",
            "utility-science-pack"
        }
    }
}

speed = speed + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 09
genOilRefinery {
    number = "09",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "i",
    ingredients = {
        {type = "item", name = "5d-oil-refinery-08", amount = 1},
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "low-density-structure", amount = 3},
        {type = "item", name = "concrete", amount = 10},
        {type = "item", name = "processing-unit", amount = 2},
        {type = "item", name = "pipe", amount = 10},
        {type = "item", name = "speed-module-3", amount = 1}
    },
    pollution = { pollution = emisions },
    nextUpdate = "5d-oil-refinery-10",
    tech = {
        number = 8,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-7"
        }
    }
}

speed = speed + 1
modules = modules + 1
energy = energy + 200
emisions = emisions + 3

-- Electric furnace 10
genOilRefinery {
    number = "10",
    subgroup = "liquid-refinery",
    craftingSpeed = speed,
    moduleSlots = modules + 1,
    energyUsage = energy,
    new = true,
    order = "j",
    ingredients = {
        {type = "item", name = "5d-oil-refinery-09", amount = 1},
        {type = "item", name = "steel-plate", amount = 15},
        {type = "item", name = "low-density-structure", amount = 3},
        {type = "item", name = "concrete", amount = 10},
        {type = "item", name = "processing-unit", amount = 2},
        {type = "item", name = "pipe", amount = 10},
        {type = "item", name = "productivity-module-3", amount = 1}
    },
    pollution = { pollution = emisions },
    tech = {
        number = 9,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-oil-refinery-8"
        }
    }
}