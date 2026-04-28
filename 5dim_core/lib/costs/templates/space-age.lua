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
        { type = "fluid", name = "lubricant", amount = 200 }
    },
    [2] = {
        { type = "item", name = "foundry", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 30 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-foundry-02", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 40 },
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "advanced-circuit", amount = 15 }
    },
    [4] = {
        { type = "item", name = "5d-foundry-03", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 50 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-foundry-04", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 60 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [6] = {
        { type = "item", name = "5d-foundry-05", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 70 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-foundry-06", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 80 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [8] = {
        { type = "item", name = "5d-foundry-07", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 100 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [9] = {
        { type = "item", name = "5d-foundry-08", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 120 },
        { type = "item", name = "processing-unit", amount = 40 },
        { type = "item", name = "superconductor", amount = 30 }
    },
    [10] = {
        { type = "item", name = "5d-foundry-09", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 150 },
        { type = "item", name = "processing-unit", amount = 50 },
        { type = "item", name = "superconductor", amount = 50 }
    }
}

-- Big Mining Drill templates (Vulcanus)
Templates.bigMiningDrill = {
    [1] = {
        { type = "item", name = "electric-engine-unit", amount = 10 },
        { type = "item", name = "tungsten-carbide", amount = 20 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "carbon-fiber", amount = 20 }
    },
    [2] = {
        { type = "item", name = "big-mining-drill", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-big-mining-drill-02", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 15 }
    },
    [4] = {
        { type = "item", name = "5d-big-mining-drill-03", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 25 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-big-mining-drill-04", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 30 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-big-mining-drill-05", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 35 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [7] = {
        { type = "item", name = "5d-big-mining-drill-06", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 40 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-big-mining-drill-07", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 50 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [9] = {
        { type = "item", name = "5d-big-mining-drill-08", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 60 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-big-mining-drill-09", amount = 1 },
        { type = "item", name = "tungsten-carbide", amount = 80 },
        { type = "item", name = "processing-unit", amount = 40 },
        { type = "item", name = "superconductor", amount = 30 }
    }
}

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
        { type = "item", name = "holmium-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-electromagnetic-plant-02", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 60 },
        { type = "item", name = "processing-unit", amount = 25 }
    },
    [4] = {
        { type = "item", name = "5d-electromagnetic-plant-03", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 70 },
        { type = "item", name = "processing-unit", amount = 30 }
    },
    [5] = {
        { type = "item", name = "5d-electromagnetic-plant-04", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 80 },
        { type = "item", name = "processing-unit", amount = 35 }
    },
    [6] = {
        { type = "item", name = "5d-electromagnetic-plant-05", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 90 },
        { type = "item", name = "processing-unit", amount = 40 }
    },
    [7] = {
        { type = "item", name = "5d-electromagnetic-plant-06", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 100 },
        { type = "item", name = "processing-unit", amount = 45 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-electromagnetic-plant-07", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 110 },
        { type = "item", name = "processing-unit", amount = 50 },
        { type = "item", name = "superconductor", amount = 30 }
    },
    [9] = {
        { type = "item", name = "5d-electromagnetic-plant-08", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 120 },
        { type = "item", name = "processing-unit", amount = 55 },
        { type = "item", name = "superconductor", amount = 40 }
    },
    [10] = {
        { type = "item", name = "5d-electromagnetic-plant-09", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 130 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "superconductor", amount = 50 }
    }
}

-- Recycler templates (Fulgora)
Templates.recycler = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "iron-gear-wheel", amount = 40 },
        { type = "item", name = "electronic-circuit", amount = 20 }
    },
    [2] = {
        { type = "item", name = "recycler", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-recycler-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-recycler-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-recycler-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-recycler-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [7] = {
        { type = "item", name = "5d-recycler-06", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-recycler-07", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [9] = {
        { type = "item", name = "5d-recycler-08", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-recycler-09", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 60 },
        { type = "item", name = "processing-unit", amount = 40 },
        { type = "item", name = "superconductor", amount = 30 }
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
        { type = "item", name = "copper-cable", amount = 10 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-lightning-rod-02", amount = 1 },
        { type = "item", name = "copper-cable", amount = 15 },
        { type = "item", name = "steel-plate", amount = 8 }
    },
    [4] = {
        { type = "item", name = "5d-lightning-rod-03", amount = 1 },
        { type = "item", name = "copper-cable", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-lightning-rod-04", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 10 },
        { type = "item", name = "advanced-circuit", amount = 8 }
    },
    [6] = {
        { type = "item", name = "5d-lightning-rod-05", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-lightning-rod-06", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 20 },
        { type = "item", name = "processing-unit", amount = 5 },
        { type = "item", name = "superconductor", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-lightning-rod-07", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 8 },
        { type = "item", name = "superconductor", amount = 8 }
    },
    [9] = {
        { type = "item", name = "5d-lightning-rod-08", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-lightning-rod-09", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "superconductor", amount = 15 }
    }
}

-- Lightning Collector templates (Fulgora)
Templates.lightningCollector = {
    [1] = {
        { type = "item", name = "lightning-rod", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 8 },
        { type = "item", name = "accumulator", amount = 1 },
        { type = "fluid", name = "electrolyte", amount = 80 }
    },
    [2] = {
        { type = "item", name = "lightning-collector", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 6 },
        { type = "item", name = "holmium-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-lightning-collector-02", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 8 },
        { type = "item", name = "holmium-plate", amount = 15 }
    },
    [4] = {
        { type = "item", name = "5d-lightning-collector-03", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 10 },
        { type = "item", name = "holmium-plate", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-lightning-collector-04", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 12 },
        { type = "item", name = "holmium-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-lightning-collector-05", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 15 },
        { type = "item", name = "holmium-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 8 }
    },
    [7] = {
        { type = "item", name = "5d-lightning-collector-06", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 18 },
        { type = "item", name = "holmium-plate", amount = 35 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-lightning-collector-07", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 20 },
        { type = "item", name = "holmium-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [9] = {
        { type = "item", name = "5d-lightning-collector-08", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 25 },
        { type = "item", name = "holmium-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-lightning-collector-09", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 30 },
        { type = "item", name = "holmium-plate", amount = 60 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "superconductor", amount = 25 }
    }
}

-------------------------------------------------------------------------------
-- GLEBA TEMPLATES
-------------------------------------------------------------------------------

-- Biochamber templates (Gleba)
Templates.biochamber = {
    [1] = {
        { type = "item", name = "iron-plate", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "landfill", amount = 1 },
        { type = "item", name = "pentapod-egg", amount = 1 }
    },
    [2] = {
        { type = "item", name = "biochamber", amount = 1 },
        { type = "item", name = "iron-plate", amount = 15 },
        { type = "item", name = "electronic-circuit", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-biochamber-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-biochamber-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-biochamber-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-biochamber-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-biochamber-06", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 20 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [8] = {
        { type = "item", name = "5d-biochamber-07", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 30 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "biter-egg", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-biochamber-08", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 40 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "bioflux", amount = 50 }
    },
    [10] = {
        { type = "item", name = "5d-biochamber-09", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 50 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "bioflux", amount = 100 }
    }
}

-- Agricultural Tower templates (Gleba)
Templates.agriculturalTower = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "iron-gear-wheel", amount = 20 }
    },
    [2] = {
        { type = "item", name = "agricultural-tower", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-agricultural-tower-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-agricultural-tower-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-agricultural-tower-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-agricultural-tower-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [7] = {
        { type = "item", name = "5d-agricultural-tower-06", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 40 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "bioflux", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-agricultural-tower-07", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 45 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "bioflux", amount = 30 }
    },
    [9] = {
        { type = "item", name = "5d-agricultural-tower-08", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 50 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "bioflux", amount = 40 }
    },
    [10] = {
        { type = "item", name = "5d-agricultural-tower-09", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 55 },
        { type = "item", name = "processing-unit", amount = 35 },
        { type = "item", name = "bioflux", amount = 50 }
    }
}

-- Captive Biter Spawner templates (Gleba)
Templates.captiveBiterSpawner = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "biter-egg", amount = 1 }
    },
    [2] = {
        { type = "item", name = "captive-biter-spawner", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-captive-biter-spawner-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-captive-biter-spawner-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-captive-biter-spawner-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-captive-biter-spawner-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [7] = {
        { type = "item", name = "5d-captive-biter-spawner-06", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 40 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "bioflux", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-captive-biter-spawner-07", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 45 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "bioflux", amount = 30 }
    },
    [9] = {
        { type = "item", name = "5d-captive-biter-spawner-08", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 50 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "bioflux", amount = 40 }
    },
    [10] = {
        { type = "item", name = "5d-captive-biter-spawner-09", amount = 1 },
        { type = "item", name = "carbon-fiber", amount = 55 },
        { type = "item", name = "processing-unit", amount = 35 },
        { type = "item", name = "bioflux", amount = 50 }
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
        { type = "item", name = "lithium-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [3] = {
        { type = "item", name = "5d-cryogenic-plant-02", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-cryogenic-plant-03", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 25 }
    },
    [5] = {
        { type = "item", name = "5d-cryogenic-plant-04", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 60 },
        { type = "item", name = "processing-unit", amount = 30 }
    },
    [6] = {
        { type = "item", name = "5d-cryogenic-plant-05", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 70 },
        { type = "item", name = "processing-unit", amount = 35 }
    },
    [7] = {
        { type = "item", name = "5d-cryogenic-plant-06", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 80 },
        { type = "item", name = "processing-unit", amount = 40 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-cryogenic-plant-07", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 90 },
        { type = "item", name = "processing-unit", amount = 45 },
        { type = "item", name = "superconductor", amount = 30 }
    },
    [9] = {
        { type = "item", name = "5d-cryogenic-plant-08", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 100 },
        { type = "item", name = "processing-unit", amount = 50 },
        { type = "item", name = "superconductor", amount = 40 }
    },
    [10] = {
        { type = "item", name = "5d-cryogenic-plant-09", amount = 1 },
        { type = "item", name = "lithium-plate", amount = 110 },
        { type = "item", name = "processing-unit", amount = 55 },
        { type = "item", name = "superconductor", amount = 50 }
    }
}

-- Heating Tower templates (Aquilo)
Templates.heatingTower = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 50 },
        { type = "item", name = "heat-pipe", amount = 20 },
        { type = "item", name = "concrete", amount = 40 }
    },
    [2] = {
        { type = "item", name = "heating-tower", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "heat-pipe", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-heating-tower-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "heat-pipe", amount = 15 }
    },
    [4] = {
        { type = "item", name = "5d-heating-tower-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "heat-pipe", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-heating-tower-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 45 },
        { type = "item", name = "heat-pipe", amount = 25 }
    },
    [6] = {
        { type = "item", name = "5d-heating-tower-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 50 },
        { type = "item", name = "heat-pipe", amount = 30 }
    },
    [7] = {
        { type = "item", name = "5d-heating-tower-06", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 40 },
        { type = "item", name = "heat-pipe", amount = 35 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-heating-tower-07", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 50 },
        { type = "item", name = "heat-pipe", amount = 40 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [9] = {
        { type = "item", name = "5d-heating-tower-08", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 60 },
        { type = "item", name = "heat-pipe", amount = 50 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-heating-tower-09", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 80 },
        { type = "item", name = "heat-pipe", amount = 60 },
        { type = "item", name = "superconductor", amount = 30 }
    }
}

-------------------------------------------------------------------------------
-- ORBIT TEMPLATES
-------------------------------------------------------------------------------

-- Crusher templates (Orbit)
Templates.crusher = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "iron-gear-wheel", amount = 20 }
    },
    [2] = {
        { type = "item", name = "crusher", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-crusher-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-crusher-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-crusher-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-crusher-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [7] = {
        { type = "item", name = "5d-crusher-06", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-crusher-07", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 45 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [9] = {
        { type = "item", name = "5d-crusher-08", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-crusher-09", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 55 },
        { type = "item", name = "processing-unit", amount = 35 },
        { type = "item", name = "superconductor", amount = 25 }
    }
}

-- Thruster templates (Orbit)
Templates.thruster = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "pipe", amount = 20 }
    },
    [2] = {
        { type = "item", name = "thruster", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-thruster-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-thruster-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-thruster-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-thruster-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [7] = {
        { type = "item", name = "5d-thruster-06", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-thruster-07", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 45 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [9] = {
        { type = "item", name = "5d-thruster-08", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-thruster-09", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 55 },
        { type = "item", name = "processing-unit", amount = 35 },
        { type = "item", name = "superconductor", amount = 25 }
    }
}

-- Cargo Bay templates (Orbit)
Templates.cargoBay = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "plastic-bar", amount = 20 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "low-density-structure", amount = 10 }
    },
    [2] = {
        { type = "item", name = "cargo-bay", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 },
        { type = "item", name = "plastic-bar", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-cargo-bay-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "plastic-bar", amount = 20 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-cargo-bay-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-cargo-bay-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [6] = {
        { type = "item", name = "5d-cargo-bay-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-cargo-bay-06", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-cargo-bay-07", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 45 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [9] = {
        { type = "item", name = "5d-cargo-bay-08", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 35 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-cargo-bay-09", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 55 },
        { type = "item", name = "processing-unit", amount = 40 },
        { type = "item", name = "superconductor", amount = 25 }
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
        { type = "item", name = "concrete", amount = 100 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-cargo-landing-pad-02", amount = 1 },
        { type = "item", name = "concrete", amount = 120 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-cargo-landing-pad-03", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 100 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-cargo-landing-pad-04", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 120 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [6] = {
        { type = "item", name = "5d-cargo-landing-pad-05", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 150 },
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-cargo-landing-pad-06", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 180 },
        { type = "item", name = "tungsten-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-cargo-landing-pad-07", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 200 },
        { type = "item", name = "tungsten-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [9] = {
        { type = "item", name = "5d-cargo-landing-pad-08", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 220 },
        { type = "item", name = "tungsten-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 35 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-cargo-landing-pad-09", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 250 },
        { type = "item", name = "tungsten-plate", amount = 60 },
        { type = "item", name = "processing-unit", amount = 40 },
        { type = "item", name = "superconductor", amount = 25 }
    }
}

-- Asteroid Collector templates (Orbit)
Templates.asteroidCollector = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 20 },
        { type = "item", name = "iron-gear-wheel", amount = 10 }
    },
    [2] = {
        { type = "item", name = "asteroid-collector", amount = 1 },
        { type = "item", name = "steel-plate", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-asteroid-collector-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "advanced-circuit", amount = 15 }
    },
    [4] = {
        { type = "item", name = "5d-asteroid-collector-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 25 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-asteroid-collector-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-asteroid-collector-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 35 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [7] = {
        { type = "item", name = "5d-asteroid-collector-06", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 40 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "superconductor", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-asteroid-collector-07", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 45 },
        { type = "item", name = "processing-unit", amount = 25 },
        { type = "item", name = "superconductor", amount = 15 }
    },
    [9] = {
        { type = "item", name = "5d-asteroid-collector-08", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 30 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-asteroid-collector-09", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 55 },
        { type = "item", name = "processing-unit", amount = 35 },
        { type = "item", name = "superconductor", amount = 25 }
    }
}

-------------------------------------------------------------------------------
-- AQUILO ADDITIONAL TEMPLATES
-------------------------------------------------------------------------------

-- Biolab templates (Gleba/Aquilo research)
Templates.biolab = {
    [1] = {
        { type = "item", name = "lab", amount = 1 },
        { type = "item", name = "biter-egg", amount = 10 },
        { type = "item", name = "refined-concrete", amount = 25 },
        { type = "item", name = "capture-robot-rocket", amount = 2 },
        { type = "item", name = "uranium-235", amount = 3 }
    },
    [2] = {
        { type = "item", name = "biolab", amount = 1 },
        { type = "item", name = "biter-egg", amount = 10 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-biolab-02", amount = 1 },
        { type = "item", name = "biter-egg", amount = 15 },
        { type = "item", name = "processing-unit", amount = 25 }
    },
    [4] = {
        { type = "item", name = "5d-biolab-03", amount = 1 },
        { type = "item", name = "biter-egg", amount = 20 },
        { type = "item", name = "processing-unit", amount = 30 }
    },
    [5] = {
        { type = "item", name = "5d-biolab-04", amount = 1 },
        { type = "item", name = "biter-egg", amount = 25 },
        { type = "item", name = "processing-unit", amount = 35 },
        { type = "item", name = "superconductor", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-biolab-05", amount = 1 },
        { type = "item", name = "biter-egg", amount = 30 },
        { type = "item", name = "processing-unit", amount = 40 },
        { type = "item", name = "superconductor", amount = 30 }
    },
    [7] = {
        { type = "item", name = "5d-biolab-06", amount = 1 },
        { type = "item", name = "biter-egg", amount = 35 },
        { type = "item", name = "quantum-processor", amount = 20 },
        { type = "item", name = "superconductor", amount = 40 }
    },
    [8] = {
        { type = "item", name = "5d-biolab-07", amount = 1 },
        { type = "item", name = "biter-egg", amount = 40 },
        { type = "item", name = "quantum-processor", amount = 30 },
        { type = "item", name = "superconductor", amount = 50 }
    },
    [9] = {
        { type = "item", name = "5d-biolab-08", amount = 1 },
        { type = "item", name = "biter-egg", amount = 45 },
        { type = "item", name = "quantum-processor", amount = 40 },
        { type = "item", name = "superconductor", amount = 60 }
    },
    [10] = {
        { type = "item", name = "5d-biolab-09", amount = 1 },
        { type = "item", name = "biter-egg", amount = 50 },
        { type = "item", name = "quantum-processor", amount = 50 },
        { type = "item", name = "superconductor", amount = 80 }
    }
}

-- Fusion Reactor (building) templates (Aquilo)
Templates.fusionReactor = {
    [1] = {
        { type = "item", name = "tungsten-plate", amount = 200 },
        { type = "item", name = "superconductor", amount = 200 },
        { type = "item", name = "quantum-processor", amount = 250 }
    },
    [2] = {
        { type = "item", name = "fusion-reactor", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 100 },
        { type = "item", name = "superconductor", amount = 100 },
        { type = "item", name = "quantum-processor", amount = 50 }
    },
    [3] = {
        { type = "item", name = "5d-fusion-reactor-building-02", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 120 },
        { type = "item", name = "superconductor", amount = 120 },
        { type = "item", name = "quantum-processor", amount = 60 }
    },
    [4] = {
        { type = "item", name = "5d-fusion-reactor-building-03", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 140 },
        { type = "item", name = "superconductor", amount = 140 },
        { type = "item", name = "quantum-processor", amount = 70 }
    },
    [5] = {
        { type = "item", name = "5d-fusion-reactor-building-04", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 160 },
        { type = "item", name = "superconductor", amount = 160 },
        { type = "item", name = "quantum-processor", amount = 80 }
    },
    [6] = {
        { type = "item", name = "5d-fusion-reactor-building-05", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 180 },
        { type = "item", name = "superconductor", amount = 180 },
        { type = "item", name = "quantum-processor", amount = 100 }
    },
    [7] = {
        { type = "item", name = "5d-fusion-reactor-building-06", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 200 },
        { type = "item", name = "superconductor", amount = 200 },
        { type = "item", name = "quantum-processor", amount = 120 }
    },
    [8] = {
        { type = "item", name = "5d-fusion-reactor-building-07", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 220 },
        { type = "item", name = "superconductor", amount = 220 },
        { type = "item", name = "quantum-processor", amount = 140 }
    },
    [9] = {
        { type = "item", name = "5d-fusion-reactor-building-08", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 250 },
        { type = "item", name = "superconductor", amount = 250 },
        { type = "item", name = "quantum-processor", amount = 160 }
    },
    [10] = {
        { type = "item", name = "5d-fusion-reactor-building-09", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 300 },
        { type = "item", name = "superconductor", amount = 300 },
        { type = "item", name = "quantum-processor", amount = 200 }
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
        { type = "item", name = "tungsten-plate", amount = 50 },
        { type = "item", name = "superconductor", amount = 50 },
        { type = "item", name = "quantum-processor", amount = 25 }
    },
    [3] = {
        { type = "item", name = "5d-fusion-generator-02", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 60 },
        { type = "item", name = "superconductor", amount = 60 },
        { type = "item", name = "quantum-processor", amount = 30 }
    },
    [4] = {
        { type = "item", name = "5d-fusion-generator-03", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 70 },
        { type = "item", name = "superconductor", amount = 70 },
        { type = "item", name = "quantum-processor", amount = 35 }
    },
    [5] = {
        { type = "item", name = "5d-fusion-generator-04", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 80 },
        { type = "item", name = "superconductor", amount = 80 },
        { type = "item", name = "quantum-processor", amount = 40 }
    },
    [6] = {
        { type = "item", name = "5d-fusion-generator-05", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 90 },
        { type = "item", name = "superconductor", amount = 90 },
        { type = "item", name = "quantum-processor", amount = 50 }
    },
    [7] = {
        { type = "item", name = "5d-fusion-generator-06", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 100 },
        { type = "item", name = "superconductor", amount = 100 },
        { type = "item", name = "quantum-processor", amount = 60 }
    },
    [8] = {
        { type = "item", name = "5d-fusion-generator-07", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 110 },
        { type = "item", name = "superconductor", amount = 110 },
        { type = "item", name = "quantum-processor", amount = 70 }
    },
    [9] = {
        { type = "item", name = "5d-fusion-generator-08", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 120 },
        { type = "item", name = "superconductor", amount = 120 },
        { type = "item", name = "quantum-processor", amount = 80 }
    },
    [10] = {
        { type = "item", name = "5d-fusion-generator-09", amount = 1 },
        { type = "item", name = "tungsten-plate", amount = 150 },
        { type = "item", name = "superconductor", amount = 150 },
        { type = "item", name = "quantum-processor", amount = 100 }
    }
}

-- Mech Armor templates (Fulgora)
Templates.mechArmor = {
    [1] = {
        { type = "item", name = "power-armor-mk2", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 200 },
        { type = "item", name = "processing-unit", amount = 100 },
        { type = "item", name = "superconductor", amount = 50 },
        { type = "item", name = "supercapacitor", amount = 50 }
    },
    [2] = {
        { type = "item", name = "mech-armor", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 100 },
        { type = "item", name = "processing-unit", amount = 50 },
        { type = "item", name = "superconductor", amount = 30 }
    },
    [3] = {
        { type = "item", name = "5d-mech-armor-02", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 120 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "superconductor", amount = 40 }
    },
    [4] = {
        { type = "item", name = "5d-mech-armor-03", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 140 },
        { type = "item", name = "quantum-processor", amount = 30 },
        { type = "item", name = "superconductor", amount = 50 }
    },
    [5] = {
        { type = "item", name = "5d-mech-armor-04", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 160 },
        { type = "item", name = "quantum-processor", amount = 40 },
        { type = "item", name = "superconductor", amount = 60 }
    },
    [6] = {
        { type = "item", name = "5d-mech-armor-05", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 180 },
        { type = "item", name = "quantum-processor", amount = 50 },
        { type = "item", name = "superconductor", amount = 70 }
    },
    [7] = {
        { type = "item", name = "5d-mech-armor-06", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 200 },
        { type = "item", name = "quantum-processor", amount = 60 },
        { type = "item", name = "superconductor", amount = 80 }
    },
    [8] = {
        { type = "item", name = "5d-mech-armor-07", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 220 },
        { type = "item", name = "quantum-processor", amount = 70 },
        { type = "item", name = "superconductor", amount = 90 }
    },
    [9] = {
        { type = "item", name = "5d-mech-armor-08", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 250 },
        { type = "item", name = "quantum-processor", amount = 80 },
        { type = "item", name = "superconductor", amount = 100 }
    },
    [10] = {
        { type = "item", name = "5d-mech-armor-09", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 300 },
        { type = "item", name = "quantum-processor", amount = 100 },
        { type = "item", name = "superconductor", amount = 120 }
    }
}

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
        { type = "item", name = "supercapacitor", amount = 5 },
        { type = "item", name = "processing-unit", amount = 5 },
        { type = "item", name = "superconductor", amount = 25 }
    },
    [3] = {
        { type = "item", name = "5d-tesla-turret-sa-02", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 6 },
        { type = "item", name = "processing-unit", amount = 6 },
        { type = "item", name = "superconductor", amount = 30 }
    },
    [4] = {
        { type = "item", name = "5d-tesla-turret-sa-03", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 7 },
        { type = "item", name = "quantum-processor", amount = 5 },
        { type = "item", name = "superconductor", amount = 35 }
    },
    [5] = {
        { type = "item", name = "5d-tesla-turret-sa-04", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 8 },
        { type = "item", name = "quantum-processor", amount = 7 },
        { type = "item", name = "superconductor", amount = 40 }
    },
    [6] = {
        { type = "item", name = "5d-tesla-turret-sa-05", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 10 },
        { type = "item", name = "quantum-processor", amount = 10 },
        { type = "item", name = "superconductor", amount = 50 }
    },
    [7] = {
        { type = "item", name = "5d-tesla-turret-sa-06", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 12 },
        { type = "item", name = "quantum-processor", amount = 12 },
        { type = "item", name = "superconductor", amount = 60 }
    },
    [8] = {
        { type = "item", name = "5d-tesla-turret-sa-07", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 15 },
        { type = "item", name = "quantum-processor", amount = 15 },
        { type = "item", name = "superconductor", amount = 70 }
    },
    [9] = {
        { type = "item", name = "5d-tesla-turret-sa-08", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 18 },
        { type = "item", name = "quantum-processor", amount = 18 },
        { type = "item", name = "superconductor", amount = 80 }
    },
    [10] = {
        { type = "item", name = "5d-tesla-turret-sa-09", amount = 1 },
        { type = "item", name = "supercapacitor", amount = 20 },
        { type = "item", name = "quantum-processor", amount = 20 },
        { type = "item", name = "superconductor", amount = 100 }
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
        { type = "item", name = "quantum-processor", amount = 50 },
        { type = "item", name = "tungsten-plate", amount = 15 },
        { type = "item", name = "superconductor", amount = 25 }
    },
    [3] = {
        { type = "item", name = "5d-railgun-turret-02", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 60 },
        { type = "item", name = "tungsten-plate", amount = 20 },
        { type = "item", name = "superconductor", amount = 30 }
    },
    [4] = {
        { type = "item", name = "5d-railgun-turret-03", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 70 },
        { type = "item", name = "tungsten-plate", amount = 25 },
        { type = "item", name = "superconductor", amount = 35 }
    },
    [5] = {
        { type = "item", name = "5d-railgun-turret-04", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 80 },
        { type = "item", name = "tungsten-plate", amount = 30 },
        { type = "item", name = "superconductor", amount = 40 }
    },
    [6] = {
        { type = "item", name = "5d-railgun-turret-05", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 90 },
        { type = "item", name = "tungsten-plate", amount = 35 },
        { type = "item", name = "superconductor", amount = 50 }
    },
    [7] = {
        { type = "item", name = "5d-railgun-turret-06", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 100 },
        { type = "item", name = "tungsten-plate", amount = 40 },
        { type = "item", name = "superconductor", amount = 60 }
    },
    [8] = {
        { type = "item", name = "5d-railgun-turret-07", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 120 },
        { type = "item", name = "tungsten-plate", amount = 50 },
        { type = "item", name = "superconductor", amount = 70 }
    },
    [9] = {
        { type = "item", name = "5d-railgun-turret-08", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 140 },
        { type = "item", name = "tungsten-plate", amount = 60 },
        { type = "item", name = "superconductor", amount = 80 }
    },
    [10] = {
        { type = "item", name = "5d-railgun-turret-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 160 },
        { type = "item", name = "tungsten-plate", amount = 80 },
        { type = "item", name = "superconductor", amount = 100 }
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
        { type = "item", name = "processing-unit", amount = 4 },
        { type = "item", name = "carbon-fiber", amount = 10 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-rocket-turret-02", amount = 1 },
        { type = "item", name = "processing-unit", amount = 5 },
        { type = "item", name = "carbon-fiber", amount = 12 },
        { type = "item", name = "steel-plate", amount = 12 }
    },
    [4] = {
        { type = "item", name = "5d-rocket-turret-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 6 },
        { type = "item", name = "carbon-fiber", amount = 15 },
        { type = "item", name = "tungsten-plate", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-rocket-turret-04", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 5 },
        { type = "item", name = "carbon-fiber", amount = 18 },
        { type = "item", name = "tungsten-plate", amount = 15 }
    },
    [6] = {
        { type = "item", name = "5d-rocket-turret-05", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 7 },
        { type = "item", name = "carbon-fiber", amount = 20 },
        { type = "item", name = "tungsten-plate", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-rocket-turret-06", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 10 },
        { type = "item", name = "carbon-fiber", amount = 25 },
        { type = "item", name = "tungsten-plate", amount = 25 }
    },
    [8] = {
        { type = "item", name = "5d-rocket-turret-07", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 12 },
        { type = "item", name = "carbon-fiber", amount = 30 },
        { type = "item", name = "tungsten-plate", amount = 30 }
    },
    [9] = {
        { type = "item", name = "5d-rocket-turret-08", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 15 },
        { type = "item", name = "carbon-fiber", amount = 35 },
        { type = "item", name = "tungsten-plate", amount = 35 }
    },
    [10] = {
        { type = "item", name = "5d-rocket-turret-09", amount = 1 },
        { type = "item", name = "quantum-processor", amount = 20 },
        { type = "item", name = "carbon-fiber", amount = 40 },
        { type = "item", name = "tungsten-plate", amount = 40 }
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
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [3] = {
        { type = "item", name = "5d-fusion-reactor-equipment-02", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 60 }
    },
    [4] = {
        { type = "item", name = "5d-fusion-reactor-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 70 }
    },
    [5] = {
        { type = "item", name = "5d-fusion-reactor-equipment-04", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 80 }
    },
    [6] = {
        { type = "item", name = "5d-fusion-reactor-equipment-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 90 }
    },
    [7] = {
        { type = "item", name = "5d-fusion-reactor-equipment-06", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 100 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "superconductor", amount = 50 }
    },
    [8] = {
        { type = "item", name = "5d-fusion-reactor-equipment-07", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 120 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "superconductor", amount = 60 }
    },
    [9] = {
        { type = "item", name = "5d-fusion-reactor-equipment-08", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 150 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "superconductor", amount = 80 }
    },
    [10] = {
        { type = "item", name = "5d-fusion-reactor-equipment-09", amount = 1 },
        { type = "item", name = "holmium-plate", amount = 200 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "superconductor", amount = 100 }
    }
}

return Templates
