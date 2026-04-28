-------------------------------------------------------------------------------
-- 5DIM'S MOD - EQUIPMENT TEMPLATES
-- Templates for armor equipment: battery, shield, exoskeleton, reactor,
-- personal laser defense, personal roboport, power armor, solar panel
-- Each template defines 10 tiers of ingredient progression
-------------------------------------------------------------------------------

local Templates = {}

-- Helper: Get battery tier 3 name based on Space Age availability
local batteryTier3Name = (mods and mods["space-age"]) and "battery-mk3-equipment" or "5d-battery-equipment-03"

-------------------------------------------------------------------------------
-- POWER EQUIPMENT TEMPLATES
-------------------------------------------------------------------------------

-- Battery Equipment templates
Templates.batteryEquipment = {
    [1] = {
        { type = "item", name = "battery", amount = 5 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [2] = {
        { type = "item", name = "battery-equipment", amount = 10 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [3] = {
        { type = "item", name = "battery-mk2-equipment", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [4] = {
        { type = "item", name = batteryTier3Name, amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-battery-equipment-04", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-battery-equipment-05", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-battery-equipment-06", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-battery-equipment-07", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-battery-equipment-08", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-battery-equipment-09", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    }
}

-- Solar Panel Equipment templates
Templates.solarPanelEquipment = {
    [1] = {
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [2] = {
        { type = "item", name = "solar-panel-equipment", amount = 1 },
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-solar-panel-equipment-02", amount = 1 },
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-solar-panel-equipment-03", amount = 1 },
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-solar-panel-equipment-04", amount = 1 },
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-solar-panel-equipment-05", amount = 1 },
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-solar-panel-equipment-06", amount = 1 },
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-solar-panel-equipment-07", amount = 1 },
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-solar-panel-equipment-08", amount = 1 },
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-solar-panel-equipment-09", amount = 1 },
        { type = "item", name = "solar-panel", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    }
}

-- Fission Reactor Equipment templates
Templates.fissionReactorEquipment = {
    [1] = {
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [2] = {
        { type = "item", name = "fission-reactor-equipment", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [3] = {
        { type = "item", name = "5d-fission-reactor-equipment-02", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [4] = {
        { type = "item", name = "5d-fission-reactor-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [5] = {
        { type = "item", name = "5d-fission-reactor-equipment-04", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [6] = {
        { type = "item", name = "5d-fission-reactor-equipment-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [7] = {
        { type = "item", name = "5d-fission-reactor-equipment-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [8] = {
        { type = "item", name = "5d-fission-reactor-equipment-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [9] = {
        { type = "item", name = "5d-fission-reactor-equipment-08", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    },
    [10] = {
        { type = "item", name = "5d-fission-reactor-equipment-09", amount = 1 },
        { type = "item", name = "processing-unit", amount = 200 },
        { type = "item", name = "low-density-structure", amount = 50 }
    }
}

-------------------------------------------------------------------------------
-- DEFENSE EQUIPMENT TEMPLATES
-------------------------------------------------------------------------------

-- Energy Shield Equipment templates
Templates.energyShieldEquipment = {
    [1] = {
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [2] = {
        { type = "item", name = "energy-shield-equipment", amount = 10 },
        { type = "item", name = "processing-unit", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [3] = {
        { type = "item", name = "energy-shield-mk2-equipment", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-energy-shield-equipment-03", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-energy-shield-equipment-04", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-energy-shield-equipment-05", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-energy-shield-equipment-06", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-energy-shield-equipment-07", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-energy-shield-equipment-08", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-energy-shield-equipment-09", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    }
}

-- Personal Laser Defense Equipment templates
Templates.personalLaserDefenseEquipment = {
    [1] = {
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [2] = {
        { type = "item", name = "personal-laser-defense-equipment", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-02", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-04", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-08", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-09", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    }
}

-- Personal Tesla Defense Equipment templates
Templates.personalTeslaDefenseEquipment = {
    [1] = {
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [2] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-01", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-02", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-04", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-08", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-09", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "laser-turret", amount = 5 }
    }
}

-------------------------------------------------------------------------------
-- MOBILITY EQUIPMENT TEMPLATES
-------------------------------------------------------------------------------

-- Exoskeleton Equipment templates
Templates.exoskeletonEquipment = {
    [1] = {
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [2] = {
        { type = "item", name = "exoskeleton-equipment", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-exoskeleton-equipment-02", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-exoskeleton-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-exoskeleton-equipment-04", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [6] = {
        { type = "item", name = "5d-exoskeleton-equipment-05", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-exoskeleton-equipment-06", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [8] = {
        { type = "item", name = "5d-exoskeleton-equipment-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [9] = {
        { type = "item", name = "5d-exoskeleton-equipment-08", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [10] = {
        { type = "item", name = "5d-exoskeleton-equipment-09", amount = 1 },
        { type = "item", name = "processing-unit", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 20 }
    }
}

-------------------------------------------------------------------------------
-- LOGISTICS EQUIPMENT TEMPLATES
-------------------------------------------------------------------------------

-- Personal Roboport Equipment templates
Templates.personalRoboportEquipment = {
    [1] = {
        { type = "item", name = "advanced-circuit", amount = 5 },
        { type = "item", name = "steel-plate", amount = 10 }
    },
    [2] = {
        { type = "item", name = "personal-roboport-equipment", amount = 10 },
        { type = "item", name = "processing-unit", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [3] = {
        { type = "item", name = "personal-roboport-mk2-equipment", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-personal-roboport-equipment-03", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-personal-roboport-equipment-04", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-personal-roboport-equipment-05", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-personal-roboport-equipment-06", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-personal-roboport-equipment-07", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-personal-roboport-equipment-08", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-personal-roboport-equipment-09", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 },
        { type = "item", name = "low-density-structure", amount = 5 }
    }
}

-------------------------------------------------------------------------------
-- ARMOR TEMPLATES
-------------------------------------------------------------------------------

-- Power Armor templates
Templates.powerArmor = {
    [1] = {
        { type = "item", name = "processing-unit", amount = 40 },
        { type = "item", name = "electric-engine-unit", amount = 20 },
        { type = "item", name = "steel-plate", amount = 40 }
    },
    [2] = {
        { type = "item", name = "efficiency-module-2", amount = 25 },
        { type = "item", name = "speed-module-2", amount = 25 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 30 }
    },
    [3] = {
        { type = "item", name = "power-armor-mk2", amount = 1 },
        { type = "item", name = "efficiency-module-2", amount = 25 },
        { type = "item", name = "speed-module-2", amount = 25 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 30 }
    },
    [4] = {
        { type = "item", name = "5d-power-armor-03", amount = 1 },
        { type = "item", name = "efficiency-module-2", amount = 25 },
        { type = "item", name = "speed-module-2", amount = 25 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 30 }
    },
    [5] = {
        { type = "item", name = "5d-power-armor-04", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 10 },
        { type = "item", name = "speed-module-3", amount = 10 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 30 }
    },
    [6] = {
        { type = "item", name = "5d-power-armor-05", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 10 },
        { type = "item", name = "speed-module-3", amount = 10 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 30 }
    },
    [7] = {
        { type = "item", name = "5d-power-armor-06", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 10 },
        { type = "item", name = "speed-module-3", amount = 10 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 30 }
    },
    [8] = {
        { type = "item", name = "5d-power-armor-07", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 10 },
        { type = "item", name = "speed-module-3", amount = 10 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 30 }
    },
    [9] = {
        { type = "item", name = "5d-power-armor-08", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 10 },
        { type = "item", name = "speed-module-3", amount = 10 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 30 }
    },
    [10] = {
        { type = "item", name = "5d-power-armor-09", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 10 },
        { type = "item", name = "speed-module-3", amount = 10 },
        { type = "item", name = "processing-unit", amount = 60 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "low-density-structure", amount = 30 }
    }
}

return Templates
