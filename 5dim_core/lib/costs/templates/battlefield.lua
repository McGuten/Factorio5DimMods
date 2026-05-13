-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Battlefield)
-- Templates for defensive structures and turrets
-------------------------------------------------------------------------------

local Templates = {}

local function copyTemplateIngredient(ingredient)
    return {
        type = ingredient.type,
        name = ingredient.name,
        amount = ingredient.amount,
        fixedAmount = ingredient.fixedAmount
    }
end

local function buildMkFamilyName(vanillaName, prefix, tier)
    if tier == 1 then
        return vanillaName
    end

    return prefix .. string.format("%02d", tier)
end

local function buildUpgradeTemplates(upgradeNameFn, baseNameFn, deltaIngredientsByTier)
    local templates = {}

    for tier, deltaIngredients in ipairs(deltaIngredientsByTier) do
        local ingredients = {}

        if tier > 1 then
            table.insert(ingredients, {
                type = "item",
                name = upgradeNameFn(tier - 1),
                amount = 1,
                fixedAmount = true
            })
        end

        table.insert(ingredients, {
            type = "item",
            name = baseNameFn(tier),
            amount = 1,
            fixedAmount = true
        })

        for _, ingredient in ipairs(deltaIngredients) do
            table.insert(ingredients, copyTemplateIngredient(ingredient))
        end

        templates[tier] = ingredients
    end

    return templates
end

-- Wall templates
Templates.wall = {
    [1] = {
        { type = "item", name = "stone-brick", amount = 5 }
    },
    [2] = {
        { type = "item", name = "stone-wall", amount = 1 },
        { type = "item", name = "stone", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-stone-wall-02", amount = 1 },
        { type = "item", name = "concrete", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-stone-wall-03", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-stone-wall-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-stone-wall-05", amount = 1 },
        { type = "item", name = "iron-stick", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-stone-wall-06", amount = 1 },
        { type = "item", name = "hazard-concrete", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-stone-wall-07", amount = 1 },
        { type = "item", name = "refined-hazard-concrete", amount = 10 }
    },
    [9] = {
        { type = "item", name = "5d-stone-wall-08", amount = 1 },
        { type = "item", name = "repair-pack", amount = 6 }
    },
    [10] = {
        { type = "item", name = "5d-stone-wall-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    }
}

-- Gate templates
Templates.gate = {
    [1] = {
        { type = "item", name = "stone-wall", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    [2] = {
        { type = "item", name = "5d-stone-wall-02", amount = 1 },
        { type = "item", name = "gate", amount = 1 },
        { type = "item", name = "stone", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-stone-wall-03", amount = 1 },
        { type = "item", name = "5d-gate-02", amount = 1 },
        { type = "item", name = "concrete", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-stone-wall-04", amount = 1 },
        { type = "item", name = "5d-gate-03", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-stone-wall-05", amount = 1 },
        { type = "item", name = "5d-gate-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-stone-wall-06", amount = 1 },
        { type = "item", name = "5d-gate-05", amount = 1 },
        { type = "item", name = "iron-stick", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-stone-wall-07", amount = 1 },
        { type = "item", name = "5d-gate-06", amount = 1 },
        { type = "item", name = "hazard-concrete", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-stone-wall-08", amount = 1 },
        { type = "item", name = "5d-gate-07", amount = 1 },
        { type = "item", name = "refined-hazard-concrete", amount = 10 }
    },
    [9] = {
        { type = "item", name = "5d-stone-wall-09", amount = 1 },
        { type = "item", name = "5d-gate-08", amount = 1 },
        { type = "item", name = "repair-pack", amount = 6 }
    },
    [10] = {
        { type = "item", name = "5d-stone-wall-10", amount = 1 },
        { type = "item", name = "5d-gate-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    }
}

-- Radar templates
Templates.radar = {
    [1] = {
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [2] = {
        { type = "item", name = "radar", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 6 }
    },
    [3] = {
        { type = "item", name = "5d-radar-02", amount = 1 },
        { type = "item", name = "battery", amount = 6 }
    },
    [4] = {
        { type = "item", name = "5d-radar-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-radar-04", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [6] = {
        { type = "item", name = "5d-radar-05", amount = 1 },
        { type = "item", name = "speed-module", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-radar-06", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-radar-07", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-radar-08", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-radar-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 4 }
    }
}

-- Gun Turret templates (standard)
Templates.gunTurret = {
    [1] = {
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "copper-plate", amount = 10 },
        { type = "item", name = "iron-plate", amount = 20 }
    },
    [2] = {
        { type = "item", name = "gun-turret", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 }
    },
    [3] = {
        { type = "item", name = "5d-gun-turret-02", amount = 1 },
        { type = "item", name = "concrete", amount = 12 }
    },
    [4] = {
        { type = "item", name = "5d-gun-turret-03", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 6 }
    },
    [5] = {
        { type = "item", name = "5d-gun-turret-04", amount = 1 },
        { type = "item", name = "battery", amount = 8 }
    },
    [6] = {
        { type = "item", name = "5d-gun-turret-05", amount = 1 },
        { type = "item", name = "engine-unit", amount = 6 }
    },
    [7] = {
        { type = "item", name = "5d-gun-turret-06", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 6 }
    },
    [8] = {
        { type = "item", name = "5d-gun-turret-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 6 }
    },
    [9] = {
        { type = "item", name = "5d-gun-turret-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-gun-turret-09", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 4 }
    }
}

local function buildDerivedGunTurretTemplates(previousTierNameFn, extraIngredientFn)
    local templates = {}

    for tier = 1, 10 do
        local ingredients = {}

        if tier == 1 then
            for _, ing in ipairs(Templates.gunTurret[1]) do
                table.insert(ingredients, {
                    type = ing.type,
                    name = ing.name,
                    amount = ing.amount
                })
            end
        else
            table.insert(ingredients, {
                type = "item",
                name = previousTierNameFn(tier),
                amount = 1
            })

            for index = 2, #Templates.gunTurret[tier] do
                local ing = Templates.gunTurret[tier][index]
                table.insert(ingredients, {
                    type = ing.type,
                    name = ing.name,
                    amount = ing.amount
                })
            end
        end

        local extraIngredient = extraIngredientFn(tier)
        table.insert(ingredients, {
            type = extraIngredient.type,
            name = extraIngredient.name,
            amount = extraIngredient.amount
        })

        templates[tier] = ingredients
    end

    return templates
end

Templates.acidTurret = buildDerivedGunTurretTemplates(
    function(tier)
        return "5d-acid-turret-" .. (tier - 1)
    end,
    function(tier)
        return { type = "item", name = "sulfur", amount = 5 + tier * 2 }
    end
)

Templates.poisonTurret = buildDerivedGunTurretTemplates(
    function(tier)
        return "5d-poison-turret-" .. (tier - 1)
    end,
    function(tier)
        return { type = "item", name = "coal", amount = 5 + tier * 2 }
    end
)

Templates.flareTurret = buildDerivedGunTurretTemplates(
    function(tier)
        return "5d-flare-turret-" .. (tier - 1)
    end,
    function(tier)
        return { type = "item", name = "electronic-circuit", amount = 3 + tier }
    end
)

Templates.mortarTurret = buildDerivedGunTurretTemplates(
    function(tier)
        return "5d-mortar-turret-" .. (tier - 1)
    end,
    function(tier)
        return { type = "item", name = "steel-plate", amount = 5 + tier * 3 }
    end
)

Templates.robotDeployer = buildDerivedGunTurretTemplates(
    function(tier)
        return "5d-robot-deployer-" .. (tier - 1)
    end,
    function(tier)
        return { type = "item", name = "electronic-circuit", amount = 5 + tier * 2 }
    end
)

Templates.gunTurretSniper = buildUpgradeTemplates(
    function(tier)
        return "5d-gun-turret-sniper-" .. string.format("%02d", tier)
    end,
    function(tier)
        return buildMkFamilyName("gun-turret", "5d-gun-turret-", tier)
    end,
    {
        [1] = {
            { type = "item", name = "iron-gear-wheel", amount = 10 },
            { type = "item", name = "advanced-circuit", amount = 8 },
            { type = "item", name = "steel-plate", amount = 12 }
        },
        [2] = {
            { type = "item", name = "steel-plate", amount = 6 }
        },
        [3] = {
            { type = "item", name = "advanced-circuit", amount = 6 }
        },
        [4] = {
            { type = "item", name = "battery", amount = 6 }
        },
        [5] = {
            { type = "item", name = "processing-unit", amount = 4 }
        },
        [6] = {
            { type = "item", name = "low-density-structure", amount = 4 }
        },
        [7] = {
            { type = "item", name = "speed-module", amount = 4 }
        },
        [8] = {
            { type = "item", name = "speed-module-2", amount = 4 }
        },
        [9] = {
            { type = "item", name = "speed-module-3", amount = 4 }
        },
        [10] = {
            { type = "item", name = "productivity-module-3", amount = 4 }
        }
    }
)

-- Laser Turret templates (standard)
Templates.laserTurret = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 20 },
        { type = "item", name = "battery", amount = 12 }
    },
    [2] = {
        { type = "item", name = "laser-turret", amount = 1 },
        { type = "item", name = "battery", amount = 6 }
    },
    [3] = {
        { type = "item", name = "5d-laser-turret-02", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 6 }
    },
    [4] = {
        { type = "item", name = "5d-laser-turret-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-laser-turret-04", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [6] = {
        { type = "item", name = "5d-laser-turret-05", amount = 1 },
        { type = "item", name = "speed-module", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-laser-turret-06", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-laser-turret-07", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-laser-turret-08", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-laser-turret-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 4 }
    }
}

Templates.laserTurretSniper = buildUpgradeTemplates(
    function(tier)
        return "5d-laser-turret-sniper-" .. string.format("%02d", tier)
    end,
    function(tier)
        return buildMkFamilyName("laser-turret", "5d-laser-turret-", tier)
    end,
    {
        [1] = {
            { type = "item", name = "steel-plate", amount = 15 },
            { type = "item", name = "advanced-circuit", amount = 10 },
            { type = "item", name = "battery", amount = 12 }
        },
        [2] = {
            { type = "item", name = "battery", amount = 6 }
        },
        [3] = {
            { type = "item", name = "advanced-circuit", amount = 6 }
        },
        [4] = {
            { type = "item", name = "processing-unit", amount = 4 }
        },
        [5] = {
            { type = "item", name = "low-density-structure", amount = 4 }
        },
        [6] = {
            { type = "item", name = "speed-module", amount = 4 }
        },
        [7] = {
            { type = "item", name = "speed-module-2", amount = 4 }
        },
        [8] = {
            { type = "item", name = "productivity-module-2", amount = 4 }
        },
        [9] = {
            { type = "item", name = "speed-module-3", amount = 4 }
        },
        [10] = {
            { type = "item", name = "productivity-module-3", amount = 4 }
        }
    }
)

local function accumulatorIngredientName(tier)
    if mods and mods["5dim_energy"] and tier >= 2 then
        return "5d-accumulator-" .. string.format("%02d", tier)
    end

    return "accumulator"
end

-- Tesla Turret templates
Templates.teslaTurret = buildUpgradeTemplates(
    function(tier)
        return "5d-tesla-turret-" .. string.format("%02d", tier)
    end,
    function(tier)
        return "5d-laser-turret-sniper-" .. string.format("%02d", tier)
    end,
    {
        [1] = {
            { type = "item", name = "steel-plate", amount = 50 },
            { type = "item", name = "electronic-circuit", amount = 50 },
            { type = "item", name = "battery", amount = 40 }
        },
        [2] = {
            { type = "item", name = "battery", amount = 10 }
        },
        [3] = {
            { type = "item", name = "advanced-circuit", amount = 8 }
        },
        [4] = {
            { type = "item", name = "processing-unit", amount = 4 }
        },
        [5] = {
            { type = "item", name = "low-density-structure", amount = 4 }
        },
        [6] = {
            { type = "item", name = "speed-module", amount = 4 }
        },
        [7] = {
            { type = "item", name = "speed-module-2", amount = 4 }
        },
        [8] = {
            { type = "item", name = "productivity-module-2", amount = 4 }
        },
        [9] = {
            { type = "item", name = "speed-module-3", amount = 4 }
        },
        [10] = {
            { type = "item", name = "productivity-module-3", amount = 4 }
        }
    }
)

-- Flamethrower Turret templates
Templates.flamethrowerTurret = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "iron-gear-wheel", amount = 15 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "engine-unit", amount = 5 }
    },
    [2] = {
        { type = "item", name = "flamethrower-turret", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "iron-gear-wheel", amount = 15 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "engine-unit", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-flamethrower-turret-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "iron-gear-wheel", amount = 15 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "engine-unit", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-flamethrower-turret-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "iron-gear-wheel", amount = 15 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-flamethrower-turret-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 34 },
        { type = "item", name = "iron-gear-wheel", amount = 16 },
        { type = "item", name = "advanced-circuit", amount = 6 },
        { type = "item", name = "pipe", amount = 12 },
        { type = "item", name = "electric-engine-unit", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-flamethrower-turret-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 36 },
        { type = "item", name = "iron-gear-wheel", amount = 18 },
        { type = "item", name = "advanced-circuit", amount = 8 },
        { type = "item", name = "pipe", amount = 12 },
        { type = "item", name = "electric-engine-unit", amount = 6 }
    },
    [7] = {
        { type = "item", name = "5d-flamethrower-turret-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "iron-gear-wheel", amount = 18 },
        { type = "item", name = "advanced-circuit", amount = 10 },
        { type = "item", name = "pipe", amount = 14 },
        { type = "item", name = "electric-engine-unit", amount = 6 }
    },
    [8] = {
        { type = "item", name = "5d-flamethrower-turret-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 6 },
        { type = "item", name = "iron-gear-wheel", amount = 18 },
        { type = "item", name = "advanced-circuit", amount = 10 },
        { type = "item", name = "pipe", amount = 14 },
        { type = "item", name = "electric-engine-unit", amount = 6 }
    },
    [9] = {
        { type = "item", name = "5d-flamethrower-turret-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 8 },
        { type = "item", name = "processing-unit", amount = 6 },
        { type = "item", name = "pipe", amount = 16 },
        { type = "item", name = "electric-engine-unit", amount = 8 }
    },
    [10] = {
        { type = "item", name = "5d-flamethrower-turret-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 10 },
        { type = "item", name = "processing-unit", amount = 8 },
        { type = "item", name = "pipe", amount = 18 },
        { type = "item", name = "electric-engine-unit", amount = 8 }
    }
}

-- Artillery Turret templates
Templates.artilleryTurret = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 60 },
        { type = "item", name = "concrete", amount = 60 },
        { type = "item", name = "iron-gear-wheel", amount = 40 },
        { type = "item", name = "advanced-circuit", amount = 20 }
    },
    [2] = {
        { type = "item", name = "artillery-turret", amount = 1 },
        { type = "item", name = "steel-plate", amount = 40 }
    },
    [3] = {
        { type = "item", name = "5d-artillery-turret-02", amount = 1 },
        { type = "item", name = "concrete", amount = 40 }
    },
    [4] = {
        { type = "item", name = "5d-artillery-turret-03", amount = 1 },
        { type = "item", name = "explosives", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-artillery-turret-04", amount = 1 },
        { type = "item", name = "engine-unit", amount = 16 }
    },
    [6] = {
        { type = "item", name = "5d-artillery-turret-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 12 }
    },
    [7] = {
        { type = "item", name = "5d-artillery-turret-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 12 }
    },
    [8] = {
        { type = "item", name = "5d-artillery-turret-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 12 }
    },
    [9] = {
        { type = "item", name = "5d-artillery-turret-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 8 }
    },
    [10] = {
        { type = "item", name = "5d-artillery-turret-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 6 }
    }
}

-- Artillery Wagon templates
Templates.artilleryWagon = {
    [1] = {
        { type = "item", name = "engine-unit", amount = 64 },
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "pipe", amount = 16 },
        { type = "item", name = "advanced-circuit", amount = 20 }
    },
    [2] = {
        { type = "item", name = "artillery-wagon", amount = 1 },
        { type = "item", name = "steel-plate", amount = 40 }
    },
    [3] = {
        { type = "item", name = "5d-artillery-wagon-02", amount = 1 },
        { type = "item", name = "concrete", amount = 40 }
    },
    [4] = {
        { type = "item", name = "5d-artillery-wagon-03", amount = 1 },
        { type = "item", name = "explosives", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-artillery-wagon-04", amount = 1 },
        { type = "item", name = "engine-unit", amount = 16 }
    },
    [6] = {
        { type = "item", name = "5d-artillery-wagon-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 12 }
    },
    [7] = {
        { type = "item", name = "5d-artillery-wagon-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 12 }
    },
    [8] = {
        { type = "item", name = "5d-artillery-wagon-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 12 }
    },
    [9] = {
        { type = "item", name = "5d-artillery-wagon-08", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 8 }
    },
    [10] = {
        { type = "item", name = "5d-artillery-wagon-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 6 }
    }
}

-- Slow Turret templates (electric debuff turret, T1-T10)
-- Ingredients lean on laser tech tree (battery + circuits) plus a tier-1 chip
-- for the slow effect logic; later tiers chain previous tier as upgrade.
Templates.slowTurret = {
    [1] = {
        { type = "item", name = "steel-plate",        amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 30 },
        { type = "item", name = "battery",            amount = 10 }
    },
    [2] = {
        { type = "item", name = "5d-slow-turret-01",  amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "advanced-circuit",   amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
    },
    [3] = {
        { type = "item", name = "5d-slow-turret-02",  amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "advanced-circuit",   amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
    },
    [4] = {
        { type = "item", name = "5d-slow-turret-03",  amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "advanced-circuit",   amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-slow-turret-04",  amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "advanced-circuit",   amount = 5 },
        { type = "item", name = "battery",            amount = 4 }
    },
    [6] = {
        { type = "item", name = "5d-slow-turret-05",  amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "processing-unit",    amount = 3 },
        { type = "item", name = "battery",            amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-slow-turret-06",  amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "processing-unit",    amount = 3 },
        { type = "item", name = "battery",            amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-slow-turret-07",  amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "processing-unit",    amount = 3 },
        { type = "item", name = "battery",            amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-slow-turret-08",  amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "processing-unit",    amount = 3 },
        { type = "item", name = "battery",            amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-slow-turret-09",  amount = 1 },
        { type = "item", name = "steel-plate",        amount = 5 },
        { type = "item", name = "processing-unit",    amount = 3 },
        { type = "item", name = "battery",            amount = 4 }
    }
}

return Templates
