-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Logistic)
-- Templates for robots and roboports
-------------------------------------------------------------------------------

local Templates = {}

-- Construction Robot templates (bulk items - less Space Age materials)
Templates.constructionRobot = {
    [1] = {
        { type = "item", name = "flying-robot-frame", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    [2] = {
        { type = "item", name = "construction-robot", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-construction-robot-02", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 3 }
    },
    [4] = {
        { type = "item", name = "5d-construction-robot-03", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-construction-robot-04", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "battery", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-construction-robot-05", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "battery", amount = 1 }
    },
    [7] = {
        { type = "item", name = "5d-construction-robot-06", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "processing-unit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-construction-robot-07", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "processing-unit", amount = 3 },
        { type = "item", name = "battery", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-construction-robot-08", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "processing-unit", amount = 4 },
        { type = "item", name = "low-density-structure", amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-construction-robot-09", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 3 },
        { type = "item", name = "processing-unit", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 2 }
    }
}

-- Logistic Robot templates
Templates.logisticRobot = {
    [1] = {
        { type = "item", name = "flying-robot-frame", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [2] = {
        { type = "item", name = "logistic-robot", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-logistic-robot-02", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 3 }
    },
    [4] = {
        { type = "item", name = "5d-logistic-robot-03", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-logistic-robot-04", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "battery", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-logistic-robot-05", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "processing-unit", amount = 2 },
        { type = "item", name = "battery", amount = 1 }
    },
    [7] = {
        { type = "item", name = "5d-logistic-robot-06", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "processing-unit", amount = 3 },
        { type = "item", name = "battery", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-logistic-robot-07", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 2 },
        { type = "item", name = "processing-unit", amount = 4 },
        { type = "item", name = "battery", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-logistic-robot-08", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 3 },
        { type = "item", name = "processing-unit", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-logistic-robot-09", amount = 1 },
        { type = "item", name = "flying-robot-frame", amount = 3 },
        { type = "item", name = "processing-unit", amount = 6 },
        { type = "item", name = "low-density-structure", amount = 2 }
    }
}

-- Roboport templates
Templates.roboport = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 45 },
        { type = "item", name = "iron-gear-wheel", amount = 45 },
        { type = "item", name = "advanced-circuit", amount = 45 }
    },
    [2] = {
        { type = "item", name = "roboport", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "iron-gear-wheel", amount = 30 },
        { type = "item", name = "advanced-circuit", amount = 30 }
    },
    [3] = {
        { type = "item", name = "5d-roboport-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "iron-gear-wheel", amount = 35 },
        { type = "item", name = "advanced-circuit", amount = 35 }
    },
    [4] = {
        { type = "item", name = "5d-roboport-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "iron-gear-wheel", amount = 40 },
        { type = "item", name = "advanced-circuit", amount = 40 },
        { type = "item", name = "battery", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-roboport-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 45 },
        { type = "item", name = "iron-gear-wheel", amount = 45 },
        { type = "item", name = "advanced-circuit", amount = 45 },
        { type = "item", name = "battery", amount = 4 }
    },
    [6] = {
        { type = "item", name = "5d-roboport-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "iron-gear-wheel", amount = 30 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "battery", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-roboport-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "iron-gear-wheel", amount = 35 },
        { type = "item", name = "processing-unit", amount = 35 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-roboport-07", amount = 1 },
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "iron-gear-wheel", amount = 40 },
        { type = "item", name = "processing-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 8 }
    },
    [9] = {
        { type = "item", name = "5d-roboport-08", amount = 1 },
        { type = "item", name = "steel-plate", amount = 45 },
        { type = "item", name = "iron-gear-wheel", amount = 45 },
        { type = "item", name = "processing-unit", amount = 45 },
        { type = "item", name = "low-density-structure", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-roboport-09", amount = 1 },
        { type = "item", name = "steel-plate", amount = 50 },
        { type = "item", name = "iron-gear-wheel", amount = 50 },
        { type = "item", name = "processing-unit", amount = 50 },
        { type = "item", name = "low-density-structure", amount = 15 }
    }
}

return Templates
