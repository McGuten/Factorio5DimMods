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
        { type = "item", name = "battery", amount = 10 }
    },
    [3] = {
        { type = "item", name = "battery-mk2-equipment", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 15 }
    },
    [4] = {
        { type = "item", name = batteryTier3Name, amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [5] = {
        { type = "item", name = "5d-battery-equipment-04", amount = 2 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-battery-equipment-05", amount = 2 },
        { type = "item", name = "speed-module", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-battery-equipment-06", amount = 2 },
        { type = "item", name = "speed-module-2", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-battery-equipment-07", amount = 2 },
        { type = "item", name = "efficiency-module-2", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-battery-equipment-08", amount = 2 },
        { type = "item", name = "speed-module-3", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-battery-equipment-09", amount = 2 },
        { type = "item", name = "efficiency-module-3", amount = 4 }
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
        { type = "item", name = "battery", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-solar-panel-equipment-02", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-solar-panel-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-solar-panel-equipment-04", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-solar-panel-equipment-05", amount = 1 },
        { type = "item", name = "speed-module", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-solar-panel-equipment-06", amount = 1 },
        { type = "item", name = "efficiency-module-2", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-solar-panel-equipment-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-solar-panel-equipment-08", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-solar-panel-equipment-09", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 2 }
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
        { type = "item", name = "battery", amount = 40 }
    },
    [3] = {
        { type = "item", name = "5d-fission-reactor-equipment-02", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 60 }
    },
    [4] = {
        { type = "item", name = "5d-fission-reactor-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 100 }
    },
    [5] = {
        { type = "item", name = "5d-fission-reactor-equipment-04", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 40 }
    },
    [6] = {
        { type = "item", name = "5d-fission-reactor-equipment-05", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 8 }
    },
    [7] = {
        { type = "item", name = "5d-fission-reactor-equipment-06", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 8 }
    },
    [8] = {
        { type = "item", name = "5d-fission-reactor-equipment-07", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 8 }
    },
    [9] = {
        { type = "item", name = "5d-fission-reactor-equipment-08", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 8 }
    },
    [10] = {
        { type = "item", name = "5d-fission-reactor-equipment-09", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 8 }
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
        { type = "item", name = "battery", amount = 10 }
    },
    [3] = {
        { type = "item", name = "energy-shield-mk2-equipment", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 15 }
    },
    [4] = {
        { type = "item", name = "5d-energy-shield-equipment-03", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [5] = {
        { type = "item", name = "5d-energy-shield-equipment-04", amount = 2 },
        { type = "item", name = "low-density-structure", amount = 8 }
    },
    [6] = {
        { type = "item", name = "5d-energy-shield-equipment-05", amount = 2 },
        { type = "item", name = "efficiency-module", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-energy-shield-equipment-06", amount = 2 },
        { type = "item", name = "speed-module-2", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-energy-shield-equipment-07", amount = 2 },
        { type = "item", name = "efficiency-module-2", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-energy-shield-equipment-08", amount = 2 },
        { type = "item", name = "speed-module-3", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-energy-shield-equipment-09", amount = 2 },
        { type = "item", name = "efficiency-module-3", amount = 4 }
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
        { type = "item", name = "battery", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-02", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-04", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 8 }
    },
    [6] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-05", amount = 1 },
        { type = "item", name = "speed-module", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-06", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-07", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-08", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-personal-laser-defense-equipment-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 4 }
    }
}

-- Personal Tesla Defense Equipment templates
local function teslaTurretIngredientName(tier)
    if mods and mods["5dim_battlefield"] then
        return "5d-tesla-turret-" .. string.format("%02d", tier)
    end

    return "laser-turret"
end

Templates.personalTeslaDefenseEquipment = {
    [1] = {
        { type = "item", name = "processing-unit", amount = 20 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = teslaTurretIngredientName(1), amount = mods and mods["5dim_battlefield"] and 2 or 5 }
    },
    [2] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-01", amount = 1 },
        { type = "item", name = "battery", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-02", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-03", amount = 1 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-04", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 8 }
    },
    [6] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-05", amount = 1 },
        { type = "item", name = "speed-module", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-06", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-07", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-08", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-personal-tesla-defense-equipment-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 4 }
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
        { type = "item", name = "steel-plate", amount = 20 }
    },
    [3] = {
        { type = "item", name = "5d-exoskeleton-equipment-02", amount = 1 },
        { type = "item", name = "battery", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-exoskeleton-equipment-03", amount = 1 },
        { type = "item", name = "engine-unit", amount = 20 }
    },
    [5] = {
        { type = "item", name = "5d-exoskeleton-equipment-04", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 30 }
    },
    [6] = {
        { type = "item", name = "5d-exoskeleton-equipment-05", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-exoskeleton-equipment-06", amount = 1 },
        { type = "item", name = "speed-module", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-exoskeleton-equipment-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-exoskeleton-equipment-08", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-exoskeleton-equipment-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 4 }
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
        { type = "item", name = "battery", amount = 10 }
    },
    [3] = {
        { type = "item", name = "personal-roboport-mk2-equipment", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 15 }
    },
    [4] = {
        { type = "item", name = "5d-personal-roboport-equipment-03", amount = 2 },
        { type = "item", name = "electric-engine-unit", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-personal-roboport-equipment-04", amount = 2 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [6] = {
        { type = "item", name = "5d-personal-roboport-equipment-05", amount = 2 },
        { type = "item", name = "low-density-structure", amount = 8 }
    },
    [7] = {
        { type = "item", name = "5d-personal-roboport-equipment-06", amount = 2 },
        { type = "item", name = "speed-module", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-personal-roboport-equipment-07", amount = 2 },
        { type = "item", name = "speed-module-2", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-personal-roboport-equipment-08", amount = 2 },
        { type = "item", name = "productivity-module-2", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-personal-roboport-equipment-09", amount = 2 },
        { type = "item", name = "speed-module-3", amount = 4 }
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
        { type = "item", name = "power-armor", amount = 1 },
        { type = "item", name = "battery", amount = 20 }
    },
    [3] = {
        { type = "item", name = "power-armor-mk2", amount = 1 },
        { type = "item", name = "steel-plate", amount = 60 }
    },
    [4] = {
        { type = "item", name = "5d-power-armor-03", amount = 1 },
        { type = "item", name = "battery", amount = 40 }
    },
    [5] = {
        { type = "item", name = "5d-power-armor-04", amount = 1 },
        { type = "item", name = "processing-unit", amount = 60 }
    },
    [6] = {
        { type = "item", name = "5d-power-armor-05", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 30 }
    },
    [7] = {
        { type = "item", name = "5d-power-armor-06", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 6 }
    },
    [8] = {
        { type = "item", name = "5d-power-armor-07", amount = 1 },
        { type = "item", name = "productivity-module-2", amount = 6 }
    },
    [9] = {
        { type = "item", name = "5d-power-armor-08", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 6 }
    },
    [10] = {
        { type = "item", name = "5d-power-armor-09", amount = 1 },
        { type = "item", name = "productivity-module-3", amount = 6 }
    }
}

return Templates
