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
        { type = "item", name = "flying-robot-frame", amount = 1 }
    },
    [3] = {
        { type = "item", name = "5d-construction-robot-02", amount = 1 },
        { type = "item", name = "battery", amount = 1 }
    },
    [4] = {
        { type = "item", name = "5d-construction-robot-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-construction-robot-04", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-construction-robot-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-construction-robot-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-construction-robot-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-construction-robot-08", amount = 1 },
        { type = "item", name = "efficiency-module-2", amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-construction-robot-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 1 }
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
        { type = "item", name = "flying-robot-frame", amount = 1 }
    },
    [3] = {
        { type = "item", name = "5d-logistic-robot-02", amount = 1 },
        { type = "item", name = "battery", amount = 1 }
    },
    [4] = {
        { type = "item", name = "5d-logistic-robot-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 3 }
    },
    [5] = {
        { type = "item", name = "5d-logistic-robot-04", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-logistic-robot-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-logistic-robot-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-logistic-robot-07", amount = 1 },
        { type = "item", name = "speed-module", amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-logistic-robot-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-logistic-robot-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 1 }
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
        { type = "item", name = "steel-plate", amount = 30 }
    },
    [3] = {
        { type = "item", name = "5d-roboport-02", amount = 1 },
        { type = "item", name = "battery", amount = 6 }
    },
    [4] = {
        { type = "item", name = "5d-roboport-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-roboport-04", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 12 }
    },
    [6] = {
        { type = "item", name = "5d-roboport-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [7] = {
        { type = "item", name = "5d-roboport-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 8 }
    },
    [8] = {
        { type = "item", name = "5d-roboport-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 6 }
    },
    [9] = {
        { type = "item", name = "5d-roboport-08", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 6 }
    },
    [10] = {
        { type = "item", name = "5d-roboport-09", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 6 }
    }
}

local function appendIngredients(target, source)
    for _, ingredient in ipairs(source) do
        table.insert(target, table.deepcopy(ingredient))
    end
end

local function buildHalfRoboportIngredients(source, startIndex)
    local result = {}

    for index = startIndex or 1, #source do
        local ingredient = table.deepcopy(source[index])
        ingredient.amount = ingredient.amount * 0.5
        table.insert(result, ingredient)
    end

    return result
end

local function buildSpecializedRoboportTemplates(namePrefix)
    local templates = {}

    for tier = 1, 10 do
        local ingredients

        if tier == 1 then
            ingredients = buildHalfRoboportIngredients(Templates.roboport[tier])
        else
            ingredients = {
                { type = "item", name = namePrefix .. string.format("%02d", tier - 1), amount = 1 }
            }

            appendIngredients(ingredients, buildHalfRoboportIngredients(Templates.roboport[tier], 2))
        end

        templates[tier] = ingredients
    end

    return templates
end

Templates.roboportCharging = buildSpecializedRoboportTemplates("5d-roboport-charging-")

Templates.roboportLogistic = buildSpecializedRoboportTemplates("5d-roboport-logistic-")

Templates.roboportConstruction = buildSpecializedRoboportTemplates("5d-roboport-construction-")

Templates.roboportCompact = buildSpecializedRoboportTemplates("5d-roboport-compact-")

return Templates
