require("__5dim_core__.lib.equipment.generation-power-armor")

local inventory = 20
local armorWidth = 10
local armorHeight = 10
local techCount = 400

-- Beacon 01
genPowerArmors {
    number = "01",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = false,
    order = "a",
    ingredients = {
        {"processing-unit", 40},
        {"electric-engine-unit", 20},
        {"steel-plate", 40}
    },
    tech = nil
}

inventory = inventory + 10

-- Beacon 02
genPowerArmors {
    number = "02",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = false,
    order = "b",
    ingredients = {
        {"power-armor", 1},
        {"effectivity-module-2", 25},
        {"speed-module-2", 25},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    },
    tech = nil
}

inventory = inventory + 10

-- Beacon 03
genPowerArmors {
    number = "03",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = true,
    order = "c",
    ingredients = {
        {"power-armor-mk2", 1},
        {"effectivity-module-2", 25},
        {"speed-module-2", 25},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    },
    tech = {
        number = 1,
        count = techCount * 2,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        prerequisites = {
            "power-armor-mk2"
        }
    }
}

inventory = inventory + 10
armorWidth = 10
armorHeight = armorHeight + 2

-- Beacon 04
genPowerArmors {
    number = "04",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = true,
    order = "d",
    ingredients = {
        {"5d-power-armor-03", 1},
        {"effectivity-module-2", 25},
        {"speed-module-2", 25},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    },
    tech = {
        number = 2,
        count = techCount * 3,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-power-armor-1"
        }
    }
}

inventory = inventory + 10
armorHeight = armorHeight + 2

-- Beacon 05
genPowerArmors {
    number = "05",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = true,
    order = "e",
    ingredients = {
        {"5d-power-armor-04", 1},
        {"effectivity-module-3", 10},
        {"speed-module-3", 10},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    },
    tech = {
        number = 3,
        count = techCount * 4,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1}
        },
        prerequisites = {
            "5d-power-armor-2"
        }
    }
}

inventory = inventory + 10
armorHeight = armorHeight + 2

-- Beacon 06
genPowerArmors {
    number = "06",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = true,
    order = "f",
    ingredients = {
        {"5d-power-armor-05", 1},
        {"effectivity-module-3", 10},
        {"speed-module-3", 10},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    },
    tech = {
        number = 4,
        count = techCount * 5,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-power-armor-3",
            "space-science-pack"
        }
    }
}

inventory = inventory + 10
armorHeight = armorHeight + 2

-- Beacon 07
genPowerArmors {
    number = "07",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = true,
    order = "g",
    ingredients = {
        {"5d-power-armor-06", 1},
        {"effectivity-module-3", 10},
        {"speed-module-3", 10},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    },
    tech = {
        number = 5,
        count = techCount * 6,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-power-armor-4"
        }
    }
}

inventory = inventory + 10
armorHeight = armorHeight + 2

-- Beacon 08
genPowerArmors {
    number = "08",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = true,
    order = "h",
    ingredients = {
        {"5d-power-armor-07", 1},
        {"effectivity-module-3", 10},
        {"speed-module-3", 10},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    },
    tech = {
        number = 6,
        count = techCount * 7,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-power-armor-5"
        }
    }
}

inventory = inventory + 10
armorHeight = armorHeight + 2

-- Beacon 09
genPowerArmors {
    number = "09",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = true,
    order = "i",
    ingredients = {
        {"5d-power-armor-08", 1},
        {"effectivity-module-3", 10},
        {"speed-module-3", 10},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    },
    tech = {
        number = 7,
        count = techCount * 8,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-power-armor-6"
        }
    }
}

inventory = inventory + 10
armorHeight = armorHeight + 2

-- Beacon 10
genPowerArmors {
    number = "10",
    subgroup = "armor-power-armor",
    inventoryBonus = inventory,
    width = armorWidth,
    height = armorHeight,
    new = true,
    order = "j",
    ingredients = {
        {"5d-power-armor-09", 1},
        {"effectivity-module-3", 10},
        {"speed-module-3", 10},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    },
    tech = {
        number = 8,
        count = techCount * 9,
        packs = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1}
        },
        prerequisites = {
            "5d-power-armor-7"
        }
    }
}
