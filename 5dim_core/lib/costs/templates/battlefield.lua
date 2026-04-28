-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Battlefield)
-- Templates for defensive structures and turrets
-------------------------------------------------------------------------------

local Templates = {}

-- Wall templates
Templates.wall = {
    [1] = {
        { type = "item", name = "stone-brick", amount = 5 }
    },
    [2] = {
        { type = "item", name = "stone-wall", amount = 1 },
        { type = "item", name = "stone-brick", amount = 5 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-stone-wall-02", amount = 1 },
        { type = "item", name = "stone-brick", amount = 5 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-stone-wall-03", amount = 1 },
        { type = "item", name = "concrete", amount = 5 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-stone-wall-04", amount = 1 },
        { type = "item", name = "concrete", amount = 5 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-stone-wall-05", amount = 1 },
        { type = "item", name = "concrete", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-stone-wall-06", amount = 1 },
        { type = "item", name = "concrete", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-stone-wall-07", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-stone-wall-08", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-stone-wall-09", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 2 }
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
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-stone-wall-03", amount = 1 },
        { type = "item", name = "5d-gate-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    [4] = {
        { type = "item", name = "5d-stone-wall-04", amount = 1 },
        { type = "item", name = "5d-gate-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-stone-wall-05", amount = 1 },
        { type = "item", name = "5d-gate-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [6] = {
        { type = "item", name = "5d-stone-wall-06", amount = 1 },
        { type = "item", name = "5d-gate-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-stone-wall-07", amount = 1 },
        { type = "item", name = "5d-gate-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-stone-wall-08", amount = 1 },
        { type = "item", name = "5d-gate-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-stone-wall-09", amount = 1 },
        { type = "item", name = "5d-gate-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-stone-wall-10", amount = 1 },
        { type = "item", name = "5d-gate-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "processing-unit", amount = 2 }
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
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-radar-02", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-radar-03", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-radar-04", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-radar-05", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-radar-06", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 7 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-radar-07", amount = 1 },
        { type = "item", name = "processing-unit", amount = 3 },
        { type = "item", name = "iron-gear-wheel", amount = 5 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-radar-08", amount = 1 },
        { type = "item", name = "processing-unit", amount = 3 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-radar-09", amount = 1 },
        { type = "item", name = "processing-unit", amount = 3 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "steel-plate", amount = 5 }
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
        { type = "item", name = "iron-gear-wheel", amount = 4 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 7 }
    },
    [3] = {
        { type = "item", name = "5d-gun-turret-02", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 4 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 7 }
    },
    [4] = {
        { type = "item", name = "5d-gun-turret-03", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 4 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 7 }
    },
    [5] = {
        { type = "item", name = "5d-gun-turret-04", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 4 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 7 }
    },
    [6] = {
        { type = "item", name = "5d-gun-turret-05", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 4 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 7 }
    },
    [7] = {
        { type = "item", name = "5d-gun-turret-06", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 4 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 7 }
    },
    [8] = {
        { type = "item", name = "5d-gun-turret-07", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 4 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 7 }
    },
    [9] = {
        { type = "item", name = "5d-gun-turret-08", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 4 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 7 }
    },
    [10] = {
        { type = "item", name = "5d-gun-turret-09", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 4 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 7 }
    }
}

-- Gun Turret Big templates
Templates.gunTurretBig = {
    [1] = {
        { type = "item", name = "iron-gear-wheel", amount = 15 },
        { type = "item", name = "copper-plate", amount = 10 },
        { type = "item", name = "iron-plate", amount = 30 }
    },
    [2] = {
        { type = "item", name = "5d-gun-turret-big-01", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-gun-turret-big-02", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-gun-turret-big-03", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-gun-turret-big-04", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-gun-turret-big-05", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-gun-turret-big-06", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-gun-turret-big-07", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [9] = {
        { type = "item", name = "5d-gun-turret-big-08", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-gun-turret-big-09", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "copper-plate", amount = 4 },
        { type = "item", name = "iron-plate", amount = 10 }
    }
}

-- Gun Turret Small templates
Templates.gunTurretSmall = {
    [1] = {
        { type = "item", name = "iron-gear-wheel", amount = 7 },
        { type = "item", name = "copper-plate", amount = 7 },
        { type = "item", name = "iron-plate", amount = 13 }
    },
    [2] = {
        { type = "item", name = "5d-gun-turret-small-01", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 3 },
        { type = "item", name = "copper-plate", amount = 3 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-gun-turret-small-02", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 3 },
        { type = "item", name = "copper-plate", amount = 3 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-gun-turret-small-03", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 3 },
        { type = "item", name = "copper-plate", amount = 3 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-gun-turret-small-04", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 3 },
        { type = "item", name = "copper-plate", amount = 3 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-gun-turret-small-05", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 3 },
        { type = "item", name = "copper-plate", amount = 3 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-gun-turret-small-06", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 3 },
        { type = "item", name = "copper-plate", amount = 3 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-gun-turret-small-07", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 3 },
        { type = "item", name = "copper-plate", amount = 3 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-gun-turret-small-08", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 3 },
        { type = "item", name = "copper-plate", amount = 3 },
        { type = "item", name = "iron-plate", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-gun-turret-small-09", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 3 },
        { type = "item", name = "copper-plate", amount = 3 },
        { type = "item", name = "iron-plate", amount = 5 }
    }
}

-- Gun Turret Sniper templates
Templates.gunTurretSniper = {
    [1] = {
        { type = "item", name = "iron-gear-wheel", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [2] = {
        { type = "item", name = "5d-gun-turret-sniper-01", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 3 }
    },
    [3] = {
        { type = "item", name = "5d-gun-turret-sniper-02", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 3 }
    },
    [4] = {
        { type = "item", name = "5d-gun-turret-sniper-03", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 3 }
    },
    [5] = {
        { type = "item", name = "5d-gun-turret-sniper-04", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 3 }
    },
    [6] = {
        { type = "item", name = "5d-gun-turret-sniper-05", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 3 }
    },
    [7] = {
        { type = "item", name = "5d-gun-turret-sniper-06", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 3 }
    },
    [8] = {
        { type = "item", name = "5d-gun-turret-sniper-07", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 3 }
    },
    [9] = {
        { type = "item", name = "5d-gun-turret-sniper-08", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 3 }
    },
    [10] = {
        { type = "item", name = "5d-gun-turret-sniper-09", amount = 1 },
        { type = "item", name = "iron-gear-wheel", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 6 },
        { type = "item", name = "steel-plate", amount = 3 }
    }
}

-- Laser Turret templates (standard)
Templates.laserTurret = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 20 },
        { type = "item", name = "electronic-circuit", amount = 20 },
        { type = "item", name = "battery", amount = 12 }
    },
    [2] = {
        { type = "item", name = "laser-turret", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery", amount = 4 }
    },
    [3] = {
        { type = "item", name = "5d-laser-turret-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery", amount = 4 }
    },
    [4] = {
        { type = "item", name = "5d-laser-turret-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-laser-turret-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery", amount = 4 }
    },
    [6] = {
        { type = "item", name = "5d-laser-turret-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-laser-turret-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-laser-turret-07", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery", amount = 4 }
    },
    [9] = {
        { type = "item", name = "5d-laser-turret-08", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery", amount = 4 }
    },
    [10] = {
        { type = "item", name = "5d-laser-turret-09", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "electronic-circuit", amount = 5 },
        { type = "item", name = "battery", amount = 4 }
    }
}

-- Laser Turret Big templates
Templates.laserTurretBig = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "electronic-circuit", amount = 30 },
        { type = "item", name = "battery", amount = 15 }
    },
    [2] = {
        { type = "item", name = "5d-laser-turret-big-01", amount = 1 },
        { type = "item", name = "steel-plate", amount = 7 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "battery", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-laser-turret-big-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 7 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "battery", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-laser-turret-big-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 7 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "battery", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-laser-turret-big-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 7 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "battery", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-laser-turret-big-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 7 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "battery", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-laser-turret-big-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 7 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "battery", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-laser-turret-big-07", amount = 1 },
        { type = "item", name = "steel-plate", amount = 7 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "battery", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-laser-turret-big-08", amount = 1 },
        { type = "item", name = "steel-plate", amount = 7 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "battery", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-laser-turret-big-09", amount = 1 },
        { type = "item", name = "steel-plate", amount = 7 },
        { type = "item", name = "electronic-circuit", amount = 7 },
        { type = "item", name = "battery", amount = 5 }
    }
}

-- Laser Turret Small templates
Templates.laserTurretSmall = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 6 }
    },
    [2] = {
        { type = "item", name = "5d-laser-turret-small-01", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-laser-turret-small-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    },
    [4] = {
        { type = "item", name = "5d-laser-turret-small-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    },
    [5] = {
        { type = "item", name = "5d-laser-turret-small-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    },
    [6] = {
        { type = "item", name = "5d-laser-turret-small-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-laser-turret-small-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-laser-turret-small-07", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-laser-turret-small-08", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-laser-turret-small-09", amount = 1 },
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "electronic-circuit", amount = 2 },
        { type = "item", name = "battery", amount = 2 }
    }
}

-- Laser Turret Sniper templates
Templates.laserTurretSniper = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "electronic-circuit", amount = 40 },
        { type = "item", name = "battery", amount = 25 }
    },
    [2] = {
        { type = "item", name = "5d-laser-turret-sniper-01", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 7 }
    },
    [3] = {
        { type = "item", name = "5d-laser-turret-sniper-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 7 }
    },
    [4] = {
        { type = "item", name = "5d-laser-turret-sniper-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 7 }
    },
    [5] = {
        { type = "item", name = "5d-laser-turret-sniper-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 7 }
    },
    [6] = {
        { type = "item", name = "5d-laser-turret-sniper-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 7 }
    },
    [7] = {
        { type = "item", name = "5d-laser-turret-sniper-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 7 }
    },
    [8] = {
        { type = "item", name = "5d-laser-turret-sniper-07", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 7 }
    },
    [9] = {
        { type = "item", name = "5d-laser-turret-sniper-08", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 7 }
    },
    [10] = {
        { type = "item", name = "5d-laser-turret-sniper-09", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 7 }
    }
}

-- Tesla Turret templates
Templates.teslaTurret = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 50 },
        { type = "item", name = "electronic-circuit", amount = 50 },
        { type = "item", name = "battery", amount = 40 }
    },
    [2] = {
        { type = "item", name = "5d-tesla-turret-01", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-tesla-turret-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 10 }
    },
    [4] = {
        { type = "item", name = "5d-tesla-turret-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-tesla-turret-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 10 }
    },
    [6] = {
        { type = "item", name = "5d-tesla-turret-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 10 }
    },
    [7] = {
        { type = "item", name = "5d-tesla-turret-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 10 }
    },
    [8] = {
        { type = "item", name = "5d-tesla-turret-07", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 10 }
    },
    [9] = {
        { type = "item", name = "5d-tesla-turret-08", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 10 }
    },
    [10] = {
        { type = "item", name = "5d-tesla-turret-09", amount = 1 },
        { type = "item", name = "steel-plate", amount = 10 },
        { type = "item", name = "electronic-circuit", amount = 10 },
        { type = "item", name = "battery", amount = 10 }
    }
}

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
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "iron-gear-wheel", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 5 }
    },
    [6] = {
        { type = "item", name = "5d-flamethrower-turret-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "iron-gear-wheel", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 5 }
    },
    [7] = {
        { type = "item", name = "5d-flamethrower-turret-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "iron-gear-wheel", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 5 }
    },
    [8] = {
        { type = "item", name = "5d-flamethrower-turret-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "iron-gear-wheel", amount = 15 },
        { type = "item", name = "advanced-circuit", amount = 4 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 5 }
    },
    [9] = {
        { type = "item", name = "5d-flamethrower-turret-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "processing-unit", amount = 4 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 5 }
    },
    [10] = {
        { type = "item", name = "5d-flamethrower-turret-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "processing-unit", amount = 4 },
        { type = "item", name = "pipe", amount = 10 },
        { type = "item", name = "electric-engine-unit", amount = 5 }
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
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "concrete", amount = 40 },
        { type = "item", name = "iron-gear-wheel", amount = 30 },
        { type = "item", name = "advanced-circuit", amount = 15 }
    },
    [3] = {
        { type = "item", name = "5d-artillery-turret-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 50 },
        { type = "item", name = "concrete", amount = 50 },
        { type = "item", name = "iron-gear-wheel", amount = 35 },
        { type = "item", name = "advanced-circuit", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-artillery-turret-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 60 },
        { type = "item", name = "refined-concrete", amount = 60 },
        { type = "item", name = "iron-gear-wheel", amount = 40 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-artillery-turret-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 70 },
        { type = "item", name = "refined-concrete", amount = 70 },
        { type = "item", name = "electric-engine-unit", amount = 10 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [6] = {
        { type = "item", name = "5d-artillery-turret-05", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 30 },
        { type = "item", name = "refined-concrete", amount = 80 },
        { type = "item", name = "electric-engine-unit", amount = 15 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-artillery-turret-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 40 },
        { type = "item", name = "refined-concrete", amount = 90 },
        { type = "item", name = "electric-engine-unit", amount = 20 },
        { type = "item", name = "processing-unit", amount = 25 }
    },
    [8] = {
        { type = "item", name = "5d-artillery-turret-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 50 },
        { type = "item", name = "refined-concrete", amount = 100 },
        { type = "item", name = "electric-engine-unit", amount = 25 },
        { type = "item", name = "processing-unit", amount = 30 }
    },
    [9] = {
        { type = "item", name = "5d-artillery-turret-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 60 },
        { type = "item", name = "refined-concrete", amount = 110 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "processing-unit", amount = 35 }
    },
    [10] = {
        { type = "item", name = "5d-artillery-turret-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 80 },
        { type = "item", name = "refined-concrete", amount = 120 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "processing-unit", amount = 40 }
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
        { type = "item", name = "engine-unit", amount = 40 },
        { type = "item", name = "steel-plate", amount = 30 },
        { type = "item", name = "advanced-circuit", amount = 15 }
    },
    [3] = {
        { type = "item", name = "5d-artillery-wagon-02", amount = 1 },
        { type = "item", name = "engine-unit", amount = 50 },
        { type = "item", name = "steel-plate", amount = 40 },
        { type = "item", name = "advanced-circuit", amount = 20 }
    },
    [4] = {
        { type = "item", name = "5d-artillery-wagon-03", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 30 },
        { type = "item", name = "steel-plate", amount = 50 },
        { type = "item", name = "processing-unit", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-artillery-wagon-04", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 40 },
        { type = "item", name = "steel-plate", amount = 60 },
        { type = "item", name = "processing-unit", amount = 15 }
    },
    [6] = {
        { type = "item", name = "5d-artillery-wagon-05", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 50 },
        { type = "item", name = "low-density-structure", amount = 30 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    [7] = {
        { type = "item", name = "5d-artillery-wagon-06", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 60 },
        { type = "item", name = "low-density-structure", amount = 40 },
        { type = "item", name = "processing-unit", amount = 25 }
    },
    [8] = {
        { type = "item", name = "5d-artillery-wagon-07", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 70 },
        { type = "item", name = "low-density-structure", amount = 50 },
        { type = "item", name = "processing-unit", amount = 30 }
    },
    [9] = {
        { type = "item", name = "5d-artillery-wagon-08", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 80 },
        { type = "item", name = "low-density-structure", amount = 60 },
        { type = "item", name = "processing-unit", amount = 35 }
    },
    [10] = {
        { type = "item", name = "5d-artillery-wagon-09", amount = 1 },
        { type = "item", name = "electric-engine-unit", amount = 100 },
        { type = "item", name = "low-density-structure", amount = 80 },
        { type = "item", name = "processing-unit", amount = 40 }
    }
}

return Templates
