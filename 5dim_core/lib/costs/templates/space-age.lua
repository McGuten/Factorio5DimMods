-------------------------------------------------------------------------------
-- 5DIM'S MOD - SPACE AGE TEMPLATES
-- Templates for Space Age DLC entities from different planets:
-- Vulcanus: foundry, big mining drill
-- Fulgora: electromagnetic plant, recycler
-- Gleba: biochamber, agricultural tower, captive biter spawner
-- Aquilo: cryogenic plant, heating tower
-- Orbit: crusher, thruster, cargo bay, asteroid collector
-- Fusion reactor equipment
-- Each template defines 10 tiers of ingredient progression
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

local function buildPowerArmorFamilyName(tier)
    if tier == 1 then
        return "power-armor"
    end

    if tier == 2 then
        return "power-armor-mk2"
    end

    return "5d-power-armor-" .. string.format("%02d", tier)
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

-------------------------------------------------------------------------------
-- VULCANUS TEMPLATES
-------------------------------------------------------------------------------

-- Foundry templates (Vulcanus)
Templates.foundry = {
    [1] = {
        { type = "item", name = "tungsten-carbide", amount = 50 },
        { type = "item", name = "steel-plate", amount = 50 },
        { type = "item", name = "electronic-circuit", amount = 30 },
        { type = "item", name = "refined-concrete", amount = 20 },
        { type = "fluid", name = "lubricant", amount = 20 }
    },
    [2] = {
        { type = "item", name = "foundry", amount = 1 },
        { type = "item", name = "calcite", amount = 60 }
    },
    [3] = {
        { type = "item", name = "5d-foundry-02", amount = 1 },
        { type = "fluid", name = "molten-iron", amount = 400 }
    },
    [4] = {
        { type = "item", name = "5d-foundry-03", amount = 1 },
        { type = "fluid", name = "molten-copper", amount = 400 }
    },
    [5] = {
        { type = "item", name = "5d-foundry-04", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 40 }
    },
    [6] = {
        { type = "item", name = "5d-foundry-05", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 40 }
    },
    [7] = {
        { type = "item", name = "5d-foundry-06", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-foundry-07", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 40 }
    },
    [9] = {
        { type = "item", name = "5d-foundry-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 200 }
    },
    [10] = {
        { type = "item", name = "5d-foundry-09", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 20 }
    }
}

Templates.bigMiningDrill = buildUpgradeTemplates(
    function(tier)
        return buildMkFamilyName("big-mining-drill", "5d-big-mining-drill-", tier)
    end,
    function(tier)
        return buildMkFamilyName("electric-mining-drill", "5d-electric-mining-drill-", tier)
    end,
    {
        [1] = {
            { type = "fluid", name = "molten-iron", amount = 200 },
            { type = "item", name = "tungsten-carbide", amount = 20 },
            { type = "item", name = "electric-engine-unit", amount = 10 },
            { type = "item", name = "advanced-circuit", amount = 10 }
        },
        [2] = {
            { type = "item", name = "calcite", amount = 40 }
        },
        [3] = {
            { type = "fluid", name = "molten-copper", amount = 300 }
        },
        [4] = {
            { type = "item", name = "tungsten-plate", amount = 30 }
        },
        [5] = {
            { type = "item", name = "holmium-plate", amount = 30 }
        },
        [6] = {
            { type = "fluid", name = "electrolyte", amount = 200 }
        },
        [7] = {
            { type = "item", name = "supercapacitor", amount = 15 }
        },
        [8] = {
            { type = "item", name = "lithium-plate", amount = 30 }
        },
        [9] = {
            { type = "fluid", name = "fluoroketone-hot", amount = 150 }
        },
        [10] = {
            { type = "item", name = "fusion-power-cell", amount = 15 }
        }
    }
)

-------------------------------------------------------------------------------
-- FULGORA TEMPLATES
-------------------------------------------------------------------------------

-- Electromagnetic Plant templates (Fulgora)
Templates.electromagneticPlant = {
    [1] = {
        { type = "item", name = "holmium-plate", amount = 150 },
        { type = "item", name = "steel-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 50 },
        { type = "item", name = "refined-concrete", amount = 50 }
    },
    [2] = {
        { type = "item", name = "electromagnetic-plant", amount = 1 },
        { type = "fluid", name = "electrolyte", amount = 120 }
    },
    [3] = {
        { type = "item", name = "5d-electromagnetic-plant-02", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 12 }
    },
    [4] = {
        { type = "item", name = "5d-electromagnetic-plant-03", amount = 1 },
        { type = "item", name = "superconductor", amount = 12 }
    },
    [5] = {
        { type = "item", name = "5d-electromagnetic-plant-04", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-electromagnetic-plant-05", amount = 1 },
        { type = "fluid", name = "ammoniacal-solution", amount = 100 }
    },
    [7] = {
        { type = "item", name = "5d-electromagnetic-plant-06", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 100 }
    },
    [8] = {
        { type = "item", name = "5d-electromagnetic-plant-07", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-electromagnetic-plant-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 100 }
    },
    [10] = {
        { type = "item", name = "5d-electromagnetic-plant-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 20 }
    }
}

-- Recycler templates (Fulgora)
Templates.recycler = {
    [1] = {
        { type = "item", name = "processing-unit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "iron-gear-wheel", amount = 40 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [2] = {
        { type = "item", name = "recycler", amount = 1 },
        { type = "fluid", name = "holmium-solution", amount = 200 }
    },
    [3] = {
        { type = "item", name = "5d-recycler-02", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-recycler-03", amount = 1 },
        { type = "fluid", name = "electrolyte", amount = 100 }
    },
    [5] = {
        { type = "item", name = "5d-recycler-04", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-recycler-05", amount = 1 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-recycler-06", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-recycler-07", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-recycler-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 100 }
    },
    [10] = {
        { type = "item", name = "5d-recycler-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 10 }
    }
}

-- Lightning Rod templates (Fulgora)
Templates.lightningRod = {
    [1] = {
        { type = "item", name = "copper-cable", amount = 12 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "stone-brick", amount = 4 }
    },
    [2] = {
        { type = "item", name = "lightning-rod", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-lightning-rod-02", amount = 1 },
        { type = "fluid", name = "holmium-solution", amount = 100 }
    },
    [4] = {
        { type = "item", name = "5d-lightning-rod-03", amount = 1 },
        { type = "fluid", name = "electrolyte", amount = 50 }
    },
    [5] = {
        { type = "item", name = "5d-lightning-rod-04", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-lightning-rod-05", amount = 1 },
        { type = "item", name = "superconductor", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-lightning-rod-06", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-lightning-rod-07", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 50 }
    },
    [9] = {
        { type = "item", name = "5d-lightning-rod-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 50 }
    },
    [10] = {
        { type = "item", name = "5d-lightning-rod-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 5 }
    }
}

Templates.lightningCollector = buildUpgradeTemplates(
    function(tier)
        return buildMkFamilyName("lightning-collector", "5d-lightning-collector-", tier)
    end,
    function(tier)
        return buildMkFamilyName("lightning-rod", "5d-lightning-rod-", tier)
    end,
    {
        [1] = {
            { type = "item", name = "supercapacitor", amount = 8 },
            { type = "item", name = "accumulator", amount = 1 },
            { type = "fluid", name = "electrolyte", amount = 80 }
        },
        [2] = {
            { type = "item", name = "superconductor", amount = 8 }
        },
        [3] = {
            { type = "item", name = "lithium", amount = 20 }
        },
        [4] = {
            { type = "item", name = "lithium-plate", amount = 20 }
        },
        [5] = {
            { type = "fluid", name = "ammoniacal-solution", amount = 100 }
        },
        [6] = {
            { type = "fluid", name = "fluorine", amount = 100 }
        },
        [7] = {
            { type = "fluid", name = "fluoroketone-hot", amount = 100 }
        },
        [8] = {
            { type = "fluid", name = "fluoroketone-cold", amount = 100 }
        },
        [9] = {
            { type = "item", name = "quantum-processor", amount = 10 }
        },
        [10] = {
            { type = "item", name = "fusion-power-cell", amount = 10 }
        }
    }
)

-------------------------------------------------------------------------------
-- GLEBA TEMPLATES
-------------------------------------------------------------------------------

-- Biochamber templates (Gleba)
Templates.biochamber = {
    [1] = {
        { type = "item", name = "nutrients", amount = 5 },
        { type = "item", name = "iron-plate", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "landfill", amount = 1 },
        { type = "item", name = "pentapod-egg", amount = 1 }
    },
    [2] = {
        { type = "item", name = "biochamber", amount = 1 },
        { type = "item", name = "jelly", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-biochamber-02", amount = 1 },
        { type = "item", name = "bioflux", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-biochamber-03", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-biochamber-04", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-biochamber-05", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-biochamber-06", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-biochamber-07", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 50 }
    },
    [9] = {
        { type = "item", name = "5d-biochamber-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 50 }
    },
    [10] = {
        { type = "item", name = "5d-biochamber-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 5 }
    }
}

-- Agricultural Tower templates (Gleba)
Templates.agriculturalTower = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "spoilage", amount = 20 },
        { type = "item", name = "landfill", amount = 1 }
    },
    [2] = {
        { type = "item", name = "agricultural-tower", amount = 1 },
        { type = "item", name = "jelly", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-agricultural-tower-02", amount = 1 },
        { type = "item", name = "bioflux", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-agricultural-tower-03", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-agricultural-tower-04", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-agricultural-tower-05", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-agricultural-tower-06", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-agricultural-tower-07", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 50 }
    },
    [9] = {
        { type = "item", name = "5d-agricultural-tower-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 50 }
    },
    [10] = {
        { type = "item", name = "5d-agricultural-tower-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 5 }
    }
}

-- Captive Biter Spawner templates (Gleba)
Templates.captiveBiterSpawner = {
    [1] = {
        { type = "item", name = "biter-egg", amount = 10 },
        { type = "item", name = "capture-robot-rocket", amount = 1 },
        { type = "item", name = "uranium-235", amount = 15 },
        { type = "fluid", name = "fluoroketone-cold", amount = 100 }
    },
    [2] = {
        { type = "item", name = "captive-biter-spawner", amount = 1 },
        { type = "item", name = "bioflux", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-captive-biter-spawner-02", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-captive-biter-spawner-03", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-captive-biter-spawner-04", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-captive-biter-spawner-05", amount = 1 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-captive-biter-spawner-06", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-captive-biter-spawner-07", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-captive-biter-spawner-08", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-captive-biter-spawner-09", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    }
}

-------------------------------------------------------------------------------
-- AQUILO TEMPLATES
-------------------------------------------------------------------------------

-- Cryogenic Plant templates (Aquilo)
Templates.cryogenicPlant = {
    [1] = {
        { type = "item", name = "refined-concrete", amount = 40 },
        { type = "item", name = "lithium-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "fluid", name = "fluoroketone-cold", amount = 200 }
    },
    [2] = {
        { type = "item", name = "cryogenic-plant", amount = 1 },
        { type = "item", name = "lithium", amount = 40 }
    },
    [3] = {
        { type = "item", name = "5d-cryogenic-plant-02", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 40 }
    },
    [4] = {
        { type = "item", name = "5d-cryogenic-plant-03", amount = 1 },
        { type = "fluid", name = "ammoniacal-solution", amount = 100 }
    },
    [5] = {
        { type = "item", name = "5d-cryogenic-plant-04", amount = 1 },
        { type = "fluid", name = "ammonia", amount = 50 }
    },
    [6] = {
        { type = "item", name = "5d-cryogenic-plant-05", amount = 1 },
        { type = "item", name = "solid-fuel", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-cryogenic-plant-06", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 100 }
    },
    [8] = {
        { type = "item", name = "5d-cryogenic-plant-07", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-cryogenic-plant-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 100 }
    },
    [10] = {
        { type = "item", name = "5d-cryogenic-plant-09", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    }
}

-- Heating Tower templates (Aquilo)
Templates.heatingTower = {
    [1] = {
        { type = "item", name = "boiler", amount = 2 },
        { type = "item", name = "heat-pipe", amount = 5 },
        { type = "item", name = "concrete", amount = 20 }
    },
    [2] = {
        { type = "item", name = "heating-tower", amount = 1 },
        { type = "item", name = "lithium", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-heating-tower-02", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-heating-tower-03", amount = 1 },
        { type = "fluid", name = "ammoniacal-solution", amount = 50 }
    },
    [5] = {
        { type = "item", name = "5d-heating-tower-04", amount = 1 },
        { type = "fluid", name = "ammonia", amount = 50 }
    },
    [6] = {
        { type = "item", name = "5d-heating-tower-05", amount = 1 },
        { type = "item", name = "solid-fuel", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-heating-tower-06", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 50 }
    },
    [8] = {
        { type = "item", name = "5d-heating-tower-07", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 50 }
    },
    [9] = {
        { type = "item", name = "5d-heating-tower-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 50 }
    },
    [10] = {
        { type = "item", name = "5d-heating-tower-09", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 5 }
    }
}

-------------------------------------------------------------------------------
-- ORBIT TEMPLATES
-------------------------------------------------------------------------------

-- Crusher templates (Orbit)
Templates.crusher = {
    [1] = {
        { type = "item", name = "low-density-structure", amount = 20 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 10 }
    },
    [2] = {
        { type = "item", name = "crusher", amount = 1 },
        { type = "item", name = "calcite", amount = 40 }
    },
    [3] = {
        { type = "item", name = "5d-crusher-02", amount = 1 },
        { type = "fluid", name = "molten-iron", amount = 200 }
    },
    [4] = {
        { type = "item", name = "5d-crusher-03", amount = 1 },
        { type = "fluid", name = "molten-copper", amount = 200 }
    },
    [5] = {
        { type = "item", name = "5d-crusher-04", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-crusher-05", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-crusher-06", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-crusher-07", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 10 }
    },
    [9] = {
        { type = "item", name = "5d-crusher-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 100 }
    },
    [10] = {
        { type = "item", name = "5d-crusher-09", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    }
}

-- Thruster templates (Orbit)
Templates.thruster = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 5 }
    },
    [2] = {
        { type = "item", name = "thruster", amount = 1 },
        { type = "item", name = "space-platform-foundation", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-thruster-02", amount = 1 },
        { type = "item", name = "metallic-asteroid-chunk", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-thruster-03", amount = 1 },
        { type = "item", name = "carbonic-asteroid-chunk", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-thruster-04", amount = 1 },
        { type = "item", name = "oxide-asteroid-chunk", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-thruster-05", amount = 1 },
        { type = "item", name = "ice", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-thruster-06", amount = 1 },
        { type = "fluid", name = "thruster-fuel", amount = 100 }
    },
    [8] = {
        { type = "item", name = "5d-thruster-07", amount = 1 },
        { type = "fluid", name = "thruster-oxidizer", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-thruster-08", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-thruster-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 5 }
    }
}

-- Cargo Bay templates (Orbit)
Templates.cargoBay = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 20 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [2] = {
        { type = "item", name = "cargo-bay", amount = 1 },
        { type = "item", name = "space-platform-foundation", amount = 40 }
    },
    [3] = {
        { type = "item", name = "5d-cargo-bay-02", amount = 1 },
        { type = "item", name = "metallic-asteroid-chunk", amount = 30 }
    },
    [4] = {
        { type = "item", name = "5d-cargo-bay-03", amount = 1 },
        { type = "item", name = "oxide-asteroid-chunk", amount = 30 }
    },
    [5] = {
        { type = "item", name = "5d-cargo-bay-04", amount = 1 },
        { type = "item", name = "carbonic-asteroid-chunk", amount = 30 }
    },
    [6] = {
        { type = "item", name = "5d-cargo-bay-05", amount = 1 },
        { type = "item", name = "ice", amount = 50 }
    },
    [7] = {
        { type = "item", name = "5d-cargo-bay-06", amount = 1 },
        { type = "fluid", name = "thruster-fuel", amount = 150 }
    },
    [8] = {
        { type = "item", name = "5d-cargo-bay-07", amount = 1 },
        { type = "fluid", name = "thruster-oxidizer", amount = 150 }
    },
    [9] = {
        { type = "item", name = "5d-cargo-bay-08", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-cargo-bay-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 10 }
    }
}

-- Cargo Landing Pad templates (Orbit - receives cargo from space platforms)
Templates.cargoLandingPad = {
    [1] = {
        { type = "item", name = "concrete", amount = 200 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [2] = {
        { type = "item", name = "cargo-landing-pad", amount = 1 },
        { type = "item", name = "space-platform-foundation", amount = 60 }
    },
    [3] = {
        { type = "item", name = "5d-cargo-landing-pad-02", amount = 1 },
        { type = "item", name = "oxide-asteroid-chunk", amount = 30 }
    },
    [4] = {
        { type = "item", name = "5d-cargo-landing-pad-03", amount = 1 },
        { type = "item", name = "metallic-asteroid-chunk", amount = 30 }
    },
    [5] = {
        { type = "item", name = "5d-cargo-landing-pad-04", amount = 1 },
        { type = "item", name = "carbonic-asteroid-chunk", amount = 30 }
    },
    [6] = {
        { type = "item", name = "5d-cargo-landing-pad-05", amount = 1 },
        { type = "item", name = "ice", amount = 50 }
    },
    [7] = {
        { type = "item", name = "5d-cargo-landing-pad-06", amount = 1 },
        { type = "fluid", name = "thruster-oxidizer", amount = 150 }
    },
    [8] = {
        { type = "item", name = "5d-cargo-landing-pad-07", amount = 1 },
        { type = "fluid", name = "thruster-fuel", amount = 150 }
    },
    [9] = {
        { type = "item", name = "5d-cargo-landing-pad-08", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-cargo-landing-pad-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 10 }
    }
}

-- Asteroid Collector templates (Orbit)
Templates.asteroidCollector = {
    [1] = {
        { type = "item", name = "low-density-structure", amount = 20 },
        { type = "item", name = "electric-engine-unit", amount = 8 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [2] = {
        { type = "item", name = "asteroid-collector", amount = 1 },
        { type = "item", name = "space-platform-foundation", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-asteroid-collector-02", amount = 1 },
        { type = "item", name = "carbonic-asteroid-chunk", amount = 40 }
    },
    [4] = {
        { type = "item", name = "5d-asteroid-collector-03", amount = 1 },
        { type = "item", name = "metallic-asteroid-chunk", amount = 40 }
    },
    [5] = {
        { type = "item", name = "5d-asteroid-collector-04", amount = 1 },
        { type = "item", name = "oxide-asteroid-chunk", amount = 40 }
    },
    [6] = {
        { type = "item", name = "5d-asteroid-collector-05", amount = 1 },
        { type = "item", name = "ice", amount = 50 }
    },
    [7] = {
        { type = "item", name = "5d-asteroid-collector-06", amount = 1 },
        { type = "fluid", name = "thruster-fuel", amount = 100 }
    },
    [8] = {
        { type = "item", name = "5d-asteroid-collector-07", amount = 1 },
        { type = "fluid", name = "thruster-oxidizer", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-asteroid-collector-08", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-asteroid-collector-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 5 }
    }
}

-------------------------------------------------------------------------------
-- AQUILO ADDITIONAL TEMPLATES
-------------------------------------------------------------------------------

Templates.biolab = buildUpgradeTemplates(
    function(tier)
        return buildMkFamilyName("biolab", "5d-biolab-", tier)
    end,
    function(tier)
        return buildMkFamilyName("lab", "5d-lab-", tier)
    end,
    {
        [1] = {
            { type = "item", name = "biter-egg", amount = 10 },
            { type = "item", name = "refined-concrete", amount = 25 },
            { type = "item", name = "capture-robot-rocket", amount = 2 },
            { type = "item", name = "uranium-235", amount = 3 }
        },
        [2] = {
            { type = "item", name = "bioflux", amount = 20 }
        },
        [3] = {
            { type = "item", name = "carbon-fiber", amount = 20 }
        },
        [4] = {
            { type = "item", name = "holmium-plate", amount = 20 }
        },
        [5] = {
            { type = "item", name = "supercapacitor", amount = 10 }
        },
        [6] = {
            { type = "item", name = "superconductor", amount = 10 }
        },
        [7] = {
            { type = "item", name = "lithium-plate", amount = 20 }
        },
        [8] = {
            { type = "fluid", name = "fluorine", amount = 100 }
        },
        [9] = {
            { type = "fluid", name = "fluoroketone-cold", amount = 100 }
        },
        [10] = {
            { type = "item", name = "quantum-processor", amount = 20 }
        }
    }
)

-- Fusion Reactor (building) templates (Aquilo)
Templates.fusionReactor = {
    [1] = {
        { type = "item", name = "tungsten-plate", amount = 200 },
        { type = "item", name = "superconductor", amount = 200 },
        { type = "item", name = "quantum-processor", amount = 250 }
    },
    [2] = {
        { type = "item", name = "fusion-reactor", amount = 1 },
        { type = "item", name = "lithium", amount = 100 }
    },
    [3] = {
        { type = "item", name = "5d-fusion-reactor-building-02", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 100 }
    },
    [4] = {
        { type = "item", name = "5d-fusion-reactor-building-03", amount = 1 },
        { type = "fluid", name = "ammoniacal-solution", amount = 200 }
    },
    [5] = {
        { type = "item", name = "5d-fusion-reactor-building-04", amount = 1 },
        { type = "fluid", name = "ammonia", amount = 200 }
    },
    [6] = {
        { type = "item", name = "5d-fusion-reactor-building-05", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 200 }
    },
    [7] = {
        { type = "item", name = "5d-fusion-reactor-building-06", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 200 }
    },
    [8] = {
        { type = "item", name = "5d-fusion-reactor-building-07", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 200 }
    },
    [9] = {
        { type = "item", name = "5d-fusion-reactor-building-08", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-fusion-reactor-building-09", amount = 1 },
        { type = "fluid", name = "fusion-plasma", amount = 200 }
    }
}

-- Fusion Generator templates (Aquilo)
Templates.fusionGenerator = {
    [1] = {
        { type = "item", name = "tungsten-plate", amount = 100 },
        { type = "item", name = "superconductor", amount = 100 },
        { type = "item", name = "quantum-processor", amount = 50 }
    },
    [2] = {
        { type = "item", name = "fusion-generator", amount = 1 },
        { type = "item", name = "lithium", amount = 50 }
    },
    [3] = {
        { type = "item", name = "5d-fusion-generator-02", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 50 }
    },
    [4] = {
        { type = "item", name = "5d-fusion-generator-03", amount = 1 },
        { type = "fluid", name = "ammoniacal-solution", amount = 100 }
    },
    [5] = {
        { type = "item", name = "5d-fusion-generator-04", amount = 1 },
        { type = "fluid", name = "ammonia", amount = 100 }
    },
    [6] = {
        { type = "item", name = "5d-fusion-generator-05", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 100 }
    },
    [7] = {
        { type = "item", name = "5d-fusion-generator-06", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 100 }
    },
    [8] = {
        { type = "item", name = "5d-fusion-generator-07", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-fusion-generator-08", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-fusion-generator-09", amount = 1 },
        { type = "fluid", name = "fusion-plasma", amount = 100 }
    }
}

Templates.mechArmor = buildUpgradeTemplates(
    function(tier)
        return buildMkFamilyName("mech-armor", "5d-mech-armor-", tier)
    end,
    function(tier)
        return buildPowerArmorFamilyName(tier)
    end,
    {
        [1] = {
            { type = "item", name = "holmium-plate", amount = 200 },
            { type = "item", name = "processing-unit", amount = 100 },
            { type = "item", name = "superconductor", amount = 50 },
            { type = "item", name = "supercapacitor", amount = 50 }
        },
        [2] = {
            { type = "fluid", name = "electrolyte", amount = 100 }
        },
        [3] = {
            { type = "fluid", name = "holmium-solution", amount = 100 }
        },
        [4] = {
            { type = "item", name = "quantum-processor", amount = 20 }
        },
        [5] = {
            { type = "item", name = "carbon-fiber", amount = 50 }
        },
        [6] = {
            { type = "item", name = "lithium-plate", amount = 50 }
        },
        [7] = {
            { type = "fluid", name = "ammoniacal-solution", amount = 100 }
        },
        [8] = {
            { type = "fluid", name = "fluorine", amount = 100 }
        },
        [9] = {
            { type = "fluid", name = "fluoroketone-cold", amount = 100 }
        },
        [10] = {
            { type = "item", name = "fusion-power-cell", amount = 10 }
        }
    }
)

-------------------------------------------------------------------------------
-- SPACE AGE TURRETS TEMPLATES
-------------------------------------------------------------------------------

-- Tesla Turret (Space Age) templates
Templates.teslaTurretSA = {
    [1] = {
        { type = "item", name = "teslagun", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 10 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "superconductor", amount = 50 }
    },
    [2] = {
        { type = "item", name = "tesla-turret", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-tesla-turret-sa-02", amount = 1 },
        { type = "fluid", name = "holmium-solution", amount = 100 }
    },
    [4] = {
        { type = "item", name = "5d-tesla-turret-sa-03", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-tesla-turret-sa-04", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-tesla-turret-sa-05", amount = 1 },
        { type = "fluid", name = "ammoniacal-solution", amount = 100 }
    },
    [7] = {
        { type = "item", name = "5d-tesla-turret-sa-06", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 100 }
    },
    [8] = {
        { type = "item", name = "5d-tesla-turret-sa-07", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-tesla-turret-sa-08", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-tesla-turret-sa-09", amount = 1 },
        { type = "fluid", name = "fusion-plasma", amount = 100 }
    }
}

-- Railgun Turret templates (Aquilo)
Templates.railgunTurret = {
    [1] = {
        { type = "item", name = "quantum-processor", amount = 100 },
        { type = "item", name = "tungsten-plate", amount = 30 },
        { type = "item", name = "superconductor", amount = 50 },
        { type = "item", name = "carbon-fiber", amount = 20 }
    },
    [2] = {
        { type = "item", name = "railgun-turret", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-railgun-turret-02", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-railgun-turret-03", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-railgun-turret-04", amount = 1 },
        { type = "fluid", name = "ammoniacal-solution", amount = 100 }
    },
    [6] = {
        { type = "item", name = "5d-railgun-turret-05", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 100 }
    },
    [7] = {
        { type = "item", name = "5d-railgun-turret-06", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 100 }
    },
    [8] = {
        { type = "item", name = "5d-railgun-turret-07", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 20 }
    },
    [9] = {
        { type = "item", name = "5d-railgun-turret-08", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-railgun-turret-09", amount = 1 },
        { type = "fluid", name = "fusion-plasma", amount = 100 }
    }
}

-- Rocket Turret templates (Vulcanus)
Templates.rocketTurret = {
    [1] = {
        { type = "item", name = "rocket-launcher", amount = 4 },
        { type = "item", name = "processing-unit", amount = 4 },
        { type = "item", name = "carbon-fiber", amount = 20 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "iron-gear-wheel", amount = 20 }
    },
    [2] = {
        { type = "item", name = "rocket-turret", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-rocket-turret-02", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-rocket-turret-03", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-rocket-turret-04", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-rocket-turret-05", amount = 1 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-rocket-turret-06", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-rocket-turret-07", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-rocket-turret-08", amount = 1 },
        { type = "item", name = "fusion-power-cell", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-rocket-turret-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 10 }
    }
}

-------------------------------------------------------------------------------
-- EQUIPMENT TEMPLATES (Space Age)
-------------------------------------------------------------------------------

-- Fusion Reactor Equipment templates (Space Age)
Templates.fusionReactorEquipment = {
    [1] = {
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [2] = {
        { type = "item", name = "fusion-reactor-equipment", amount = 1 },
        { type = "item", name = "lithium", amount = 50 }
    },
    [3] = {
        { type = "item", name = "5d-fusion-reactor-equipment-02", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 50 }
    },
    [4] = {
        { type = "item", name = "5d-fusion-reactor-equipment-03", amount = 1 },
        { type = "fluid", name = "ammoniacal-solution", amount = 100 }
    },
    [5] = {
        { type = "item", name = "5d-fusion-reactor-equipment-04", amount = 1 },
        { type = "fluid", name = "ammonia", amount = 100 }
    },
    [6] = {
        { type = "item", name = "5d-fusion-reactor-equipment-05", amount = 1 },
        { type = "item", name = "solid-fuel", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-fusion-reactor-equipment-06", amount = 1 },
        { type = "fluid", name = "fluorine", amount = 100 }
    },
    [8] = {
        { type = "item", name = "5d-fusion-reactor-equipment-07", amount = 1 },
        { type = "fluid", name = "fluoroketone-hot", amount = 100 }
    },
    [9] = {
        { type = "item", name = "5d-fusion-reactor-equipment-08", amount = 1 },
        { type = "fluid", name = "fluoroketone-cold", amount = 100 }
    },
    [10] = {
        { type = "item", name = "5d-fusion-reactor-equipment-09", amount = 1 },
        { type = "fluid", name = "fusion-plasma", amount = 100 }
    }
}

return Templates
