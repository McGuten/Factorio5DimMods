-- =============================================================================
-- 5dim_enemies - Shared Configuration (SINGLE SOURCE OF TRUTH)
-- =============================================================================
-- This file contains ALL configuration data for ALL enemy types.
-- ALL type-specific data MUST come from this file - no exceptions!
--
-- Used by:
--   - Data stage (prototypes/config/tiers.lua, *-types.lua)
--   - Control stage (control.lua)
--
-- TO ADD A NEW ENEMY TYPE:
--   1. Add entry to TypeDefinitions with ALL required fields
--   2. Add entry to TypeCategories
--   3. That's it! Everything else reads from here automatically.
-- =============================================================================

local SharedConfig = {}

-- =============================================================================
-- COMPLETE TYPE DEFINITIONS (SINGLE SOURCE OF TRUTH)
-- =============================================================================
-- Each type has ALL its configuration here:
--   - stats: health, healing, speed, damage multipliers
--   - evolution: min/max evolution range
--   - autoplace: distance_factor (0=near spawn, higher=farther)
--   - colors: primary and secondary tints
--   - spawner_tint: tint for the spawner
--   - resistances: base resistances and per-tier increments
--   - special fields: damage_type, attack_type, special_behavior, etc.
-- =============================================================================

SharedConfig.TypeDefinitions = {
    -- =========================================================================
    -- NORMAL (Vanilla-like, early game baseline)
    -- =========================================================================
    normal = {
        -- Stats
        health = 1.0, healing = 1.0, speed = 1.0, damage = 1.0,
        evolution_min = 0.0, evolution_max = 0.8,
        -- Autoplace: appears from the start, near spawn
        distance_factor = 0,
        -- Visual
        order = "a",
        display_name = "Normal",
        display_color = "white",
        colors = {
            primary   = {r = 0.60, g = 0.58, b = 0.51, a = 1},
            secondary = {r = 0.62, g = 0.55, b = 0.20, a = 0.7}
        },
        spawner_tint = {0.92, 0.54, 0, 0.5},
        -- Damage & Attack
        damage_type = "physical",
        attack_type = "acid",  -- For spitters
        -- Resistances (biters)
        biter_resistances = {
            base = {{ type = "physical", decrease = 0, percent = 0 }},
            per_tier = {
                { type = "physical", decrease_increment = 1, percent_increment = 1 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            }
        },
        -- Resistances (spitters)
        spitter_resistances = {
            base = {{ type = "explosion", decrease = 0, percent = 0 }},
            per_tier = {{ type = "explosion", decrease_increment = 1, percent_increment = 1 }}
        },
        -- Flags
        is_vanilla_override = true
    },

    -- =========================================================================
    -- LASER (Resistant to laser damage)
    -- =========================================================================
    laser = {
        health = 1.0, healing = 1.0, speed = 1.0, damage = 1.0,
        evolution_min = 0.1, evolution_max = 1.0,
        distance_factor = 0,  -- Was 1, now spawns near start
        order = "b",
        display_name = "Laser",
        display_color = "blue",
        colors = {
            primary   = {r = 0.30, g = 0.50, b = 1.00, a = 1},
            secondary = {r = 0.20, g = 0.30, b = 0.70, a = 1}
        },
        spawner_tint = {0.2, 0.4, 1.0, 1.0},
        damage_type = "physical",
        attack_type = "laser",
        requires_setting_biter = "5d-laser-biter",
        requires_setting_spitter = "5d-laser-spitter",
        biter_resistances = {
            base = {{ type = "laser", decrease = 5, percent = 50 }},
            per_tier = {
                { type = "laser", decrease_increment = 4.5, percent_increment = 4.5 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 95, max_decrease = 50
        },
        spitter_resistances = {
            base = {{ type = "laser", decrease = 0, percent = 85 }},
            per_tier = {
                { type = "laser", decrease_increment = 0, percent_increment = 1.5 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 98
        }
    },

    -- =========================================================================
    -- PHYSICAL (Armored, resistant to bullets)
    -- =========================================================================
    physical = {
        health = 1.0, healing = 1.0, speed = 1.0, damage = 1.0,
        evolution_min = 0.1, evolution_max = 1.0,
        distance_factor = 0,  -- Was 1, now spawns near start
        display_name = "Armored",
        display_color = "gray",
        colors = {
            primary   = {r = 0.85, g = 0.85, b = 0.80, a = 1},
            secondary = {r = 0.60, g = 0.60, b = 0.55, a = 1}
        },
        spawner_tint = {0.8, 0.8, 0.75, 1.0},
        damage_type = "physical",
        attack_type = "physical",
        requires_setting_biter = "5d-physical-biter",
        requires_setting_spitter = "5d-physical-spitter",
        biter_resistances = {
            base = {{ type = "physical", decrease = 5, percent = 50 }},
            per_tier = {
                { type = "physical", decrease_increment = 4.5, percent_increment = 4.5 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 95, max_decrease = 50
        },
        spitter_resistances = {
            base = {{ type = "physical", decrease = 5, percent = 85 }},
            per_tier = {
                { type = "physical", decrease_increment = 1, percent_increment = 1.5 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 98
        }
    },

    -- =========================================================================
    -- IMPACT (Heavy hitters, slower but stronger)
    -- =========================================================================
    impact = {
        health = 1.3, healing = 1.0, speed = 0.85, damage = 1.5,
        evolution_min = 0.1, evolution_max = 1.0,
        distance_factor = 0,  -- Was 2, now spawns near start
        order = "d",
        display_name = "Impact",
        display_color = "orange",
        colors = {
            primary   = {r = 0.30, g = 0.25, b = 0.20, a = 1},
            secondary = {r = 0.15, g = 0.10, b = 0.05, a = 1}
        },
        spawner_tint = {0.35, 0.25, 0.15, 1.0},
        damage_type = "impact",
        attack_type = "impact",
        requires_setting_biter = "5d-impact-biter",
        biter_resistances = {
            base = {
                { type = "impact", decrease = 5, percent = 50 },
                { type = "physical", decrease = 3, percent = 25 }
            },
            per_tier = {
                { type = "impact", decrease_increment = 4.5, percent_increment = 4.5 },
                { type = "physical", decrease_increment = 2, percent_increment = 2.5 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 95, max_decrease = 50
        }
    },

    -- =========================================================================
    -- RAILGUN (Space Age - high armor piercing resistance)
    -- =========================================================================
    railgun = {
        health = 0.9, healing = 1.0, speed = 1.15, damage = 1.4,
        evolution_min = 0.2, evolution_max = 1.0,
        distance_factor = 0,  -- Was 2, slightly farther for space-age content
        order = "e",
        display_name = "Railgun",
        display_color = "cyan",
        colors = {
            primary   = {r = 0.20, g = 0.40, b = 0.50, a = 1},
            secondary = {r = 0.10, g = 0.25, b = 0.35, a = 1}
        },
        spawner_tint = {0.15, 0.45, 0.65, 1.0},
        damage_type = "physical",
        attack_type = "railgun",
        requires_mod = "space-age",
        requires_setting_biter = "5d-railgun-biter",
        requires_setting_spitter = "5d-railgun-spitter",
        requires_setting_worm = "5d-railgun-worm",
        biter_resistances = {
            base = {{ type = "physical", decrease = 5, percent = 50 }},
            per_tier = {
                { type = "physical", decrease_increment = 4.5, percent_increment = 4.5 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 95, max_decrease = 50
        },
        spitter_resistances = {
            base = {{ type = "physical", decrease = 10, percent = 85 }},
            per_tier = {
                { type = "physical", decrease_increment = 1, percent_increment = 1.5 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 98
        },
        worm_resistances = {
            { type = "physical", decrease = 15, percent = 85 },
            { type = "explosion", decrease = 10, percent = 50 }
        }
    },

    -- =========================================================================
    -- FIRE (Spitters/worms with fire attacks)
    -- =========================================================================
    fire = {
        health = 0.75, healing = 0.75, speed = 1.0, damage = 1.0,
        evolution_min = 0.2, evolution_max = 1.0,
        distance_factor = 0,  -- Was 1, now spawns near start
        display_name = "Fire",
        display_color = "red",
        colors = {
            primary   = {r = 1.00, g = 0.50, b = 0.00, a = 1},
            secondary = {r = 1.00, g = 0.20, b = 0.00, a = 1}
        },
        spawner_tint = {1.0, 0.5, 0.1, 1.0},
        damage_type = "fire",
        attack_type = "fire",
        requires_setting_spitter = "5d-fire-spitter",
        requires_setting_worm = "5d-worm",
        spitter_resistances = {
            base = {{ type = "fire", decrease = 5, percent = 70 }},
            per_tier = {
                { type = "fire", decrease_increment = 1, percent_increment = 2 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 95
        },
        worm_resistances = {
            { type = "fire", decrease = 10, percent = 90 },
            { type = "acid", percent = 20 }
        },
        worm_damage_multiplier = 1.1
    },

    -- =========================================================================
    -- ROCKET (Explosive projectiles)
    -- =========================================================================
    rocket = {
        health = 0.75, healing = 0.75, speed = 1.0, damage = 1.0,
        evolution_min = 0.3, evolution_max = 1.0,
        distance_factor = 0,  -- Was 2
        display_name = "Rocket",
        display_color = "yellow",
        colors = {
            primary   = {r = 0.80, g = 0.30, b = 0.70, a = 1},
            secondary = {r = 0.50, g = 0.15, b = 0.45, a = 1}
        },
        spawner_tint = {0.8, 0.3, 0.7, 1.0},
        damage_type = "explosion",
        attack_type = "rocket",
        requires_setting_spitter = "5d-rocket-spitter",
        spitter_resistances = {
            base = {{ type = "explosion", decrease = 5, percent = 50 }},
            per_tier = {{ type = "explosion", decrease_increment = 2, percent_increment = 3 }},
            max_percent = 85
        }
    },

    -- =========================================================================
    -- SUICIDE (Explodes on death - glass cannon)
    -- =========================================================================
    suicide = {
        health = 0.5, healing = 0.5, speed = 1.5, damage = 5.0,
        evolution_min = 0.3, evolution_max = 1.0,
        distance_factor = 0,  -- Was 2
        display_name = "Suicide",
        display_color = "purple",
        colors = {
            primary   = {r = 0.90, g = 0.20, b = 0.15, a = 1},
            secondary = {r = 0.60, g = 0.10, b = 0.10, a = 1}
        },
        spawner_tint = {0.95, 0.2, 0.15, 1.0},
        damage_type = "explosion",
        attack_type = "explosive",
        requires_setting_spitter = "5d-suicide",
        special_behavior = "suicide",
        spitter_resistances = {
            base = {{ type = "explosion", decrease = 0, percent = 30 }},
            per_tier = {{ type = "explosion", decrease_increment = 1, percent_increment = 2 }},
            max_percent = 60
        }
    },

    -- =========================================================================
    -- POISON (DoT attacks with poison clouds)
    -- =========================================================================
    poison = {
        health = 0.9, healing = 0.9, speed = 1.0, damage = 1.0,
        evolution_min = 0.2, evolution_max = 1.0,
        distance_factor = 0,  -- Was 1, now spawns near start
        display_name = "Poison",
        display_color = "green",
        colors = {
            primary   = {r = 0.30, g = 0.90, b = 0.20, a = 1},
            secondary = {r = 0.15, g = 0.60, b = 0.10, a = 1}
        },
        spawner_tint = {0.3, 0.95, 0.2, 1.0},
        damage_type = "poison",
        attack_type = "poison",
        requires_setting_spitter = "5d-poison-spitter",
        requires_setting_worm = "5d-worm",
        spitter_resistances = {
            base = {{ type = "poison", decrease = 10, percent = 90 }},
            per_tier = {
                { type = "poison", decrease_increment = 1, percent_increment = 1 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 99
        },
        worm_resistances = {
            { type = "poison", decrease = 15, percent = 95 }
        },
        worm_damage_multiplier = 0.8,
        lingering_damage = true
    },

    -- =========================================================================
    -- ELECTRIC (Chain lightning attacks)
    -- =========================================================================
    electric = {
        health = 1.0, healing = 1.0, speed = 1.0, damage = 1.0,
        evolution_min = 0.3, evolution_max = 1.0,
        distance_factor = 0,  -- Was 2
        display_name = "Electric",
        display_color = "cyan",
        colors = {
            primary   = {r = 0.40, g = 0.80, b = 1.00, a = 1},
            secondary = {r = 0.20, g = 0.60, b = 0.90, a = 1}
        },
        spawner_tint = {0.4, 0.8, 1.0, 1.0},
        damage_type = "electric",
        attack_type = "electric",
        requires_setting_spitter = "5d-electric-spitter",
        requires_setting_worm = "5d-worm",
        spitter_resistances = {
            base = {{ type = "electric", decrease = 5, percent = 85 }},
            per_tier = {
                { type = "electric", decrease_increment = 1, percent_increment = 1.5 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 98
        },
        worm_resistances = {
            { type = "electric", decrease = 10, percent = 85 },
            { type = "laser", percent = 40 }
        },
        worm_damage_multiplier = 1.1
    },

    -- =========================================================================
    -- BROODMOTHER (Spawns offspring on death)
    -- =========================================================================
    broodmother = {
        health = 1.5, healing = 0.8, speed = 0.7, damage = 0.8,
        evolution_min = 0.25, evolution_max = 1.0,
        distance_factor = 0,  -- Was 2
        display_name = "Broodmother",
        display_color = "purple",
        colors = {
            primary   = {r = 0.60, g = 0.20, b = 0.50, a = 1},
            secondary = {r = 0.40, g = 0.10, b = 0.35, a = 1}
        },
        spawner_tint = {0.6, 0.2, 0.5, 1.0},
        damage_type = "physical",
        attack_type = "acid",
        requires_setting_biter = "5d-broodmother-biter",
        requires_setting_spitter = "5d-broodmother-spitter",
        special_behavior = "broodmother",
        biter_resistances = {
            base = {{ type = "physical", decrease = 5, percent = 30 }},
            per_tier = {
                { type = "physical", decrease_increment = 1, percent_increment = 2 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1.5 }
            },
            max_percent = 70
        },
        spitter_resistances = {
            base = {{ type = "physical", decrease = 3, percent = 25 }},
            per_tier = {
                { type = "physical", decrease_increment = 1, percent_increment = 1.5 },
                { type = "explosion", decrease_increment = 1, percent_increment = 1 }
            },
            max_percent = 65
        }
    },

    -- =========================================================================
    -- SWARM (Tiny, fast, weak but numerous)
    -- =========================================================================
    swarm = {
        health = 0.25, healing = 0.5, speed = 1.5, damage = 0.5,
        scale = 0.7,
        evolution_min = 0.1, evolution_max = 1.0,
        distance_factor = 0,  -- Same as normal, appears from start
        spawner_cooldown = 0.5,  -- 2x faster spawning
        spawner_max_count = 2.0, -- 2x more units
        order = "l",
        display_name = "Swarm",
        display_color = "brown",
        colors = {
            primary   = {r = 0.55, g = 0.40, b = 0.25, a = 1},
            secondary = {r = 0.40, g = 0.30, b = 0.20, a = 1}
        },
        spawner_tint = {0.55, 0.4, 0.25, 1.0},
        damage_type = "physical",
        attack_type = "physical",
        requires_setting_biter = "5d-swarm-biter",
        biter_resistances = {
            base = {{ type = "physical", decrease = 0, percent = 0 }},
            per_tier = {{ type = "physical", decrease_increment = 0.5, percent_increment = 1 }},
            max_percent = 30
        }
    },

    -- =========================================================================
    -- REGENERATOR (Heals extremely fast)
    -- =========================================================================
    regenerator = {
        health = 0.75, healing = 5.0, speed = 0.9, damage = 0.8,
        evolution_min = 0.2, evolution_max = 1.0,
        distance_factor = 0,  -- Was 1, now spawns near start
        display_name = "Regenerator",
        display_color = "green",
        colors = {
            primary   = {r = 0.20, g = 0.70, b = 0.30, a = 1},
            secondary = {r = 0.10, g = 0.50, b = 0.20, a = 1}
        },
        spawner_tint = {0.2, 0.7, 0.3, 1.0},
        damage_type = "physical",
        attack_type = "acid",
        requires_setting_biter = "5d-regenerator-biter",
        requires_setting_spitter = "5d-regenerator-spitter",
        biter_resistances = {
            base = {{ type = "fire", decrease = 0, percent = -25 }},
            per_tier = {{ type = "physical", decrease_increment = 1, percent_increment = 1.5 }},
            max_percent = 50
        },
        spitter_resistances = {
            base = {{ type = "fire", decrease = 0, percent = -25 }},
            per_tier = {{ type = "physical", decrease_increment = 1, percent_increment = 1.5 }},
            max_percent = 50
        }
    },

    -- =========================================================================
    -- BERSERKER (Glass cannon - high damage, low HP, no healing)
    -- =========================================================================
    berserker = {
        health = 0.5, healing = 0.0, speed = 1.3, damage = 2.0,
        evolution_min = 0.25, evolution_max = 1.0,
        distance_factor = 0,  -- Was 2
        display_name = "Berserker",
        display_color = "red",
        colors = {
            primary   = {r = 0.80, g = 0.10, b = 0.10, a = 1},
            secondary = {r = 0.60, g = 0.05, b = 0.05, a = 1}
        },
        spawner_tint = {0.8, 0.1, 0.1, 1.0},
        damage_type = "physical",
        attack_type = "physical",
        requires_setting_biter = "5d-berserker-biter",
        biter_resistances = {
            base = {{ type = "physical", decrease = 0, percent = -10 }},
            per_tier = {{ type = "physical", decrease_increment = 0.5, percent_increment = 0.5 }},
            max_percent = 20
        }
    },

    -- =========================================================================
    -- TANK (50% resistance to ALL damage types, very tanky but low damage)
    -- =========================================================================
    tank = {
        health = 2.0, healing = 1.0, speed = 0.8, damage = 0.35,
        evolution_min = 0.15, evolution_max = 1.0,
        distance_factor = 0,  -- Was 1, now spawns near start
        display_name = "Tank",
        display_color = "olive",
        colors = {
            primary   = {r = 0.35, g = 0.45, b = 0.35, a = 1},
            secondary = {r = 0.25, g = 0.35, b = 0.25, a = 1}
        },
        spawner_tint = {0.35, 0.45, 0.35, 1.0},
        damage_type = "physical",
        attack_type = "acid",
        requires_setting_biter = "5d-tank-biter",
        requires_setting_spitter = "5d-tank-spitter",
        requires_setting_worm = "5d-tank-worm",
        -- 50% to ALL damage types - NO SCALING
        biter_resistances = {
            base = {
                { type = "physical", decrease = 0, percent = 50 },
                { type = "explosion", decrease = 0, percent = 50 },
                { type = "fire", decrease = 0, percent = 50 },
                { type = "laser", decrease = 0, percent = 50 },
                { type = "acid", decrease = 0, percent = 50 },
                { type = "poison", decrease = 0, percent = 50 },
                { type = "electric", decrease = 0, percent = 50 },
                { type = "impact", decrease = 0, percent = 50 }
            },
            per_tier = {},  -- No scaling
            max_percent = 50
        },
        spitter_resistances = {
            base = {
                { type = "physical", decrease = 0, percent = 50 },
                { type = "explosion", decrease = 0, percent = 50 },
                { type = "fire", decrease = 0, percent = 50 },
                { type = "laser", decrease = 0, percent = 50 },
                { type = "acid", decrease = 0, percent = 50 },
                { type = "poison", decrease = 0, percent = 50 },
                { type = "electric", decrease = 0, percent = 50 },
                { type = "impact", decrease = 0, percent = 50 }
            },
            per_tier = {},
            max_percent = 50
        },
        worm_resistances = {
            { type = "physical", decrease = 0, percent = 50 },
            { type = "explosion", decrease = 0, percent = 50 },
            { type = "fire", decrease = 0, percent = 50 },
            { type = "laser", decrease = 0, percent = 50 },
            { type = "acid", decrease = 0, percent = 50 },
            { type = "poison", decrease = 0, percent = 50 },
            { type = "electric", decrease = 0, percent = 50 },
            { type = "impact", decrease = 0, percent = 50 }
        },
        worm_damage_multiplier = 0.35,
        worm_health_multiplier = 2.0
    },

    -- =========================================================================
    -- ACID (Worms only - enhanced corrosive)
    -- =========================================================================
    acid = {
        health = 1.0, healing = 1.0, speed = 1.0, damage = 1.0,
        evolution_min = 0.2, evolution_max = 1.0,
        distance_factor = 0,  -- Was 1, now spawns near start
        display_name = "Acid",
        display_color = "green",
        colors = {
            primary   = {r = 0.3, g = 1.0, b = 0.2, a = 0.8},
            secondary = {r = 0.2, g = 0.9, b = 0.1, a = 0.8}
        },
        spawner_tint = {0.3, 1.0, 0.2, 0.8},
        damage_type = "acid",
        attack_type = "acid",
        requires_setting_worm = "5d-worm",
        worm_resistances = {
            { type = "acid", decrease = 10, percent = 90 }
        },
        worm_damage_multiplier = 1.2,
        lingering_damage = true
    },

    -- =========================================================================
    -- EXPLOSION (Worms only - explosive projectiles)
    -- =========================================================================
    explosion = {
        health = 1.0, healing = 1.0, speed = 1.0, damage = 1.3,
        evolution_min = 0.3, evolution_max = 1.0,
        distance_factor = 0,  -- Was 2
        display_name = "Bomber",
        display_color = "purple",
        colors = {
            primary   = {r = 0.8, g = 0.3, b = 0.6, a = 0.8},
            secondary = {r = 0.7, g = 0.2, b = 0.5, a = 0.8}
        },
        spawner_tint = {0.8, 0.3, 0.6, 0.8},
        damage_type = "explosion",
        attack_type = "explosion",
        requires_setting_worm = "5d-worm",
        worm_resistances = {
            { type = "explosion", decrease = 15, percent = 80 },
            { type = "fire", percent = 50 }
        },
        worm_damage_multiplier = 1.3
    }
}

-- =============================================================================
-- TYPE MULTIPLIERS (Backwards compatibility wrapper)
-- =============================================================================
-- This provides the old TypeMultipliers interface for existing code

SharedConfig.TypeMultipliers = {}
for typeName, typeDef in pairs(SharedConfig.TypeDefinitions) do
    SharedConfig.TypeMultipliers[typeName] = {
        health = typeDef.health or 1.0,
        healing = typeDef.healing or 1.0,
        speed = typeDef.speed or 1.0,
        damage = typeDef.damage or 1.0,
        scale = typeDef.scale,
        evolution_min = typeDef.evolution_min or 0.0,
        evolution_max = typeDef.evolution_max or 1.0,
        spawner_cooldown = typeDef.spawner_cooldown,
        spawner_max_count = typeDef.spawner_max_count
    }
end
-- Add default fallback
SharedConfig.TypeMultipliers.default = { health = 1.0, healing = 1.0, speed = 1.0, damage = 1.0, evolution_min = 0.0, evolution_max = 1.0 }

-- =============================================================================
-- TYPE DISPLAY INFO (for GUI) - Generated from TypeDefinitions
-- =============================================================================

SharedConfig.TypeDisplay = {}
for typeName, typeDef in pairs(SharedConfig.TypeDefinitions) do
    SharedConfig.TypeDisplay[typeName] = {
        name = typeDef.display_name or typeName,
        color = typeDef.display_color or "white"
    }
end

-- =============================================================================
-- TYPE ORDER (for GUI dropdowns) - Sorted by order field
-- =============================================================================

SharedConfig.TypeOrder = {}
local sortedTypes = {}
for typeName, typeDef in pairs(SharedConfig.TypeDefinitions) do
    table.insert(sortedTypes, {name = typeName, order = typeDef.order or "z"})
end
table.sort(sortedTypes, function(a, b) return a.order < b.order end)
for _, t in ipairs(sortedTypes) do
    table.insert(SharedConfig.TypeOrder, t.name)
end

-- =============================================================================
-- TYPE CATEGORIES (which enemy categories each type supports)
-- =============================================================================
-- Generated from TypeDefinitions based on requires_setting_* fields

SharedConfig.TypeCategories = {}
for typeName, typeDef in pairs(SharedConfig.TypeDefinitions) do
    local categories = {}
    
    -- Check which categories this type supports
    if typeDef.is_vanilla_override then
        -- Vanilla types support all categories
        categories = {"biter", "spitter", "worm"}
    else
        if typeDef.requires_setting_biter or typeDef.biter_resistances then
            table.insert(categories, "biter")
        end
        if typeDef.requires_setting_spitter or typeDef.spitter_resistances then
            table.insert(categories, "spitter")
        end
        if typeDef.requires_setting_worm or typeDef.worm_resistances then
            table.insert(categories, "worm")
        end
    end
    
    -- Default to all if no specific settings
    if #categories == 0 then
        categories = {"biter", "spitter", "worm"}
    end
    
    SharedConfig.TypeCategories[typeName] = categories
end

-- =============================================================================
-- AUTOPLACE CONFIGURATION
-- =============================================================================
-- Controls spawner placement probability and distance from spawn.
-- 
-- How enemy_autoplace_base(distance_factor, seed) works:
--   - distance_factor: Higher = enemies appear farther from spawn
--   - seed: Just changes the random pattern, NOT probability
--
-- Current distance_factor distribution (v2.0 - more aggressive):
--   0 = Near spawn (normal, swarm, laser, physical, impact, fire, poison, 
--                   regenerator, tank, acid)
--   1 = Slightly farther (railgun, rocket, suicide, electric, broodmother, 
--                         berserker, explosion)
--
-- NOTE: Changes only affect newly generated chunks!
-- =============================================================================

SharedConfig.AutoplaceConfig = {
    -- Base probability divisor: divides spawner probability by number of active types
    -- This ensures total spawner count stays similar to vanilla
    divide_by_active_types = true,
    
    -- Get distance_factor for a type
    getDistanceFactor = function(typeName)
        local typeDef = SharedConfig.TypeDefinitions[typeName]
        if typeDef and typeDef.distance_factor then
            return typeDef.distance_factor
        end
        return 0  -- Default: spawn anywhere
    end
}

-- =============================================================================
-- BOSS CONFIGURATION
-- =============================================================================

SharedConfig.BossConfig = {
    health_multiplier = 3.0,
    damage_multiplier = 3.0,
    scale_multiplier = 2.0,
    speed_multiplier = 0.6,
    healing_time = 125
}

-- =============================================================================
-- BASE STATS PER CATEGORY
-- =============================================================================

SharedConfig.BaseStats = {
    biter = {
        [1]  = { scale = 0.50, health = 20,    damage = 7,   speed = 0.22, healing = 0.013 },
        [2]  = { scale = 0.60, health = 40,    damage = 11,  speed = 0.21, healing = 0.017 },
        [3]  = { scale = 0.70, health = 80,    damage = 16,  speed = 0.20, healing = 0.027 },
        [4]  = { scale = 0.85, health = 160,   damage = 24,  speed = 0.19, healing = 0.042 },
        [5]  = { scale = 1.00, health = 320,   damage = 36,  speed = 0.18, healing = 0.075 },
        [6]  = { scale = 1.15, health = 640,   damage = 54,  speed = 0.17, healing = 0.128 },
        [7]  = { scale = 1.30, health = 1280,  damage = 81,  speed = 0.16, healing = 0.213 },
        [8]  = { scale = 1.50, health = 2560,  damage = 122, speed = 0.15, healing = 0.388 },
        [9]  = { scale = 1.80, health = 5120,  damage = 182, speed = 0.14, healing = 0.717 },
        [10] = { scale = 2.20, health = 10240, damage = 274, speed = 0.13, healing = 1.422 }
    },
    spitter = {
        [1]  = { scale = 0.50, health = 13,   damage = 10,  range = 13, speed = 0.18, healing = 0.009 },
        [2]  = { scale = 0.60, health = 26,   damage = 15,  range = 14, speed = 0.17, healing = 0.011 },
        [3]  = { scale = 0.70, health = 52,   damage = 22,  range = 15, speed = 0.16, healing = 0.017 },
        [4]  = { scale = 0.85, health = 104,  damage = 34,  range = 16, speed = 0.15, healing = 0.028 },
        [5]  = { scale = 1.00, health = 208,  damage = 50,  range = 17, speed = 0.14, healing = 0.049 },
        [6]  = { scale = 1.15, health = 416,  damage = 76,  range = 18, speed = 0.13, healing = 0.084 },
        [7]  = { scale = 1.30, health = 832,  damage = 114, range = 19, speed = 0.12, healing = 0.139 },
        [8]  = { scale = 1.50, health = 1664, damage = 170, range = 20, speed = 0.11, healing = 0.252 },
        [9]  = { scale = 1.80, health = 3328, damage = 256, range = 22, speed = 0.10, healing = 0.466 },
        [10] = { scale = 2.20, health = 6656, damage = 384, range = 25, speed = 0.09, healing = 0.924 }
    },
    worm = {
        [1]  = { scale = 0.55, health = 200,  damage = 25,  range = 22, speed = 0, healing = 0.044 },
        [2]  = { scale = 0.62, health = 300,  damage = 35,  range = 24, speed = 0, healing = 0.056 },
        [3]  = { scale = 0.70, health = 450,  damage = 49,  range = 26, speed = 0, healing = 0.075 },
        [4]  = { scale = 0.78, health = 675,  damage = 69,  range = 28, speed = 0, healing = 0.102 },
        [5]  = { scale = 0.88, health = 1013, damage = 96,  range = 30, speed = 0, healing = 0.141 },
        [6]  = { scale = 0.98, health = 1519, damage = 135, range = 33, speed = 0, healing = 0.195 },
        [7]  = { scale = 1.10, health = 2278, damage = 189, range = 36, speed = 0, healing = 0.271 },
        [8]  = { scale = 1.25, health = 3418, damage = 264, range = 40, speed = 0, healing = 0.380 },
        [9]  = { scale = 1.45, health = 5127, damage = 370, range = 45, speed = 0, healing = 0.534 },
        [10] = { scale = 1.70, health = 7690, damage = 518, range = 52, speed = 0, healing = 0.754 }
    }
}

-- =============================================================================
-- HELPER FUNCTIONS
-- =============================================================================

-- Get a type definition
function SharedConfig.getType(typeName)
    return SharedConfig.TypeDefinitions[typeName]
end

-- Get resistances for a specific category
function SharedConfig.getResistances(typeName, category)
    local typeDef = SharedConfig.TypeDefinitions[typeName]
    if not typeDef then return nil end
    
    if category == "biter" then
        return typeDef.biter_resistances
    elseif category == "spitter" then
        return typeDef.spitter_resistances
    elseif category == "worm" then
        return typeDef.worm_resistances
    end
    return nil
end

-- Get colors for a type
function SharedConfig.getColors(typeName)
    local typeDef = SharedConfig.TypeDefinitions[typeName]
    if typeDef then
        return typeDef.colors, typeDef.spawner_tint
    end
    return nil, nil
end

-- Check if type requires a specific mod
function SharedConfig.requiresMod(typeName)
    local typeDef = SharedConfig.TypeDefinitions[typeName]
    return typeDef and typeDef.requires_mod
end

-- Get setting name for a category
function SharedConfig.getSettingName(typeName, category)
    local typeDef = SharedConfig.TypeDefinitions[typeName]
    if not typeDef then return nil end
    
    local settingKey = "requires_setting_" .. category
    return typeDef[settingKey]
end

-- Check if a type is enabled for a category
function SharedConfig.isTypeEnabled(typeName, category)
    local typeDef = SharedConfig.TypeDefinitions[typeName]
    if not typeDef then return false end
    
    -- Check mod requirement
    if typeDef.requires_mod then
        if not (mods and mods[typeDef.requires_mod]) then
            return false
        end
    end
    
    -- Check setting
    local settingName = SharedConfig.getSettingName(typeName, category)
    if settingName then
        local setting = settings.startup[settingName]
        return setting and setting.value
    end
    
    -- Vanilla override or no setting = always enabled
    return typeDef.is_vanilla_override or true
end

-- Get all enabled types for a category
function SharedConfig.getEnabledTypes(category)
    local enabled = {}
    for typeName, typeDef in pairs(SharedConfig.TypeDefinitions) do
        -- Check if this type supports this category
        local categories = SharedConfig.TypeCategories[typeName] or {}
        local supportsCategory = false
        for _, cat in ipairs(categories) do
            if cat == category then
                supportsCategory = true
                break
            end
        end
        
        if supportsCategory and SharedConfig.isTypeEnabled(typeName, category) then
            table.insert(enabled, typeName)
        end
    end
    return enabled
end

-- Count enabled types for a category (for probability division)
function SharedConfig.countEnabledTypes(category)
    return #SharedConfig.getEnabledTypes(category)
end

-- Deep copy a table, excluding functions (for remote interface serialization)
local function deepCopySerializable(orig)
    if type(orig) ~= "table" then
        if type(orig) == "function" then
            return nil  -- Skip functions
        end
        return orig
    end
    
    local copy = {}
    for k, v in pairs(orig) do
        if type(k) ~= "function" and type(v) ~= "function" then
            copy[k] = deepCopySerializable(v)
        end
    end
    return copy
end

function SharedConfig.getFullConfig()
    -- Return serializable copy (no functions) for remote interface
    return {
        TypeDefinitions = deepCopySerializable(SharedConfig.TypeDefinitions),
        TypeMultipliers = deepCopySerializable(SharedConfig.TypeMultipliers),
        TypeDisplay = deepCopySerializable(SharedConfig.TypeDisplay),
        TypeOrder = deepCopySerializable(SharedConfig.TypeOrder),
        TypeCategories = deepCopySerializable(SharedConfig.TypeCategories),
        AutoplaceConfig = deepCopySerializable(SharedConfig.AutoplaceConfig),
        BossConfig = deepCopySerializable(SharedConfig.BossConfig),
        BaseStats = deepCopySerializable(SharedConfig.BaseStats)
    }
end

return SharedConfig
