-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Artillery Special Ammunition
-- Creates special ammunition types for artillery
-- Uses 5dim_core subgroup 'defense-ammo-artillery' for ammo items
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- HELPER FUNCTION FOR PROJECTILES
-------------------------------------------------------------------------------

local function createArtilleryProjectile(name, action)
    local base = table.deepcopy(data.raw["artillery-projectile"]["artillery-projectile"])
    base.name = name .. "-projectile"
    base.action = action
    return base
end

-------------------------------------------------------------------------------
-- POISON ARTILLERY SHELL
-- Base: 1000 dmg vanilla shell + poison effect
-- Design: 500 impact + poison cloud (~750 DoT) = ~1250 total
-------------------------------------------------------------------------------

local poisonShellAction = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "create-entity",
                entity_name = "poison-cloud"
            },
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 6,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 500, type = "explosion" }
                            }
                        }
                    }
                }
            },
            {
                type = "create-entity",
                entity_name = "big-explosion"
            }
        }
    }
}

data:extend({
    createArtilleryProjectile("5d-artillery-shell-poison", poisonShellAction),
    {
        type = "ammo",
        name = "5d-artillery-shell-poison",
        icons = {
            { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/poison-capsule.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        ammo_category = "artillery-shell",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "artillery",
                    projectile = "5d-artillery-shell-poison-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        subgroup = "defense-ammo-artillery",
        order = "b[poison]",
        stack_size = 1,
        weight = 100000
    },
    {
        type = "recipe",
        name = "5d-artillery-shell-poison",
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = "artillery-shell", amount = 1 },
            { type = "item", name = "poison-capsule", amount = 5 }
        },
        results = { { type = "item", name = "5d-artillery-shell-poison", amount = 1 } }
    },
    {
        type = "technology",
        name = "5d-artillery-shell-poison",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = "5d-artillery-shell-poison" }
        },
        prerequisites = { "artillery" },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            time = 30
        }
    }
})

-------------------------------------------------------------------------------
-- INCENDIARY ARTILLERY SHELL
-- Base: 1000 dmg vanilla shell + fire effect
-- Design: 500 impact + 350 fire + fire DoT = ~1200 total
-------------------------------------------------------------------------------

local incendiaryShellAction = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "create-fire",
                entity_name = "fire-flame",
                initial_ground_flame_count = 10
            },
            {
                type = "create-entity",
                entity_name = "big-explosion"
            },
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 6,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 500, type = "explosion" }
                            },
                            {
                                type = "damage",
                                damage = { amount = 350, type = "fire" }
                            }
                        }
                    }
                }
            }
        }
    }
}

data:extend({
    createArtilleryProjectile("5d-artillery-shell-incendiary", incendiaryShellAction),
    {
        type = "ammo",
        name = "5d-artillery-shell-incendiary",
        icons = {
            { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/flamethrower-ammo.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        ammo_category = "artillery-shell",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "artillery",
                    projectile = "5d-artillery-shell-incendiary-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        subgroup = "defense-ammo-artillery",
        order = "c[incendiary]",
        stack_size = 1,
        weight = 100000
    },
    {
        type = "recipe",
        name = "5d-artillery-shell-incendiary",
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = "artillery-shell", amount = 1 },
            { type = "item", name = "rocket-fuel", amount = 5 },
            { type = "item", name = "sulfur", amount = 10 }
        },
        results = { { type = "item", name = "5d-artillery-shell-incendiary", amount = 1 } }
    },
    {
        type = "technology",
        name = "5d-artillery-shell-incendiary",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = "5d-artillery-shell-incendiary" }
        },
        prerequisites = { "artillery" },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            time = 30
        }
    }
})

-------------------------------------------------------------------------------
-- CLUSTER ARTILLERY SHELL
-- Base: 1000 dmg vanilla shell + cluster effect
-- Design: 300 center + 250 per cluster hit (wide area) = ~1250 total
-------------------------------------------------------------------------------

local clusterShellAction = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "damage",
                damage = { amount = 300, type = "explosion" }
            },
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 8,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 250, type = "explosion" }
                            },
                            {
                                type = "create-entity",
                                entity_name = "explosion"
                            }
                        }
                    }
                }
            },
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            }
        }
    }
}

data:extend({
    createArtilleryProjectile("5d-artillery-shell-cluster", clusterShellAction),
    {
        type = "ammo",
        name = "5d-artillery-shell-cluster",
        icons = {
            { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/cluster-grenade.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        ammo_category = "artillery-shell",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "artillery",
                    projectile = "5d-artillery-shell-cluster-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        subgroup = "defense-ammo-artillery",
        order = "d[cluster]",
        stack_size = 1,
        weight = 100000
    },
    {
        type = "recipe",
        name = "5d-artillery-shell-cluster",
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = "artillery-shell", amount = 1 },
            { type = "item", name = "cluster-grenade", amount = 5 }
        },
        results = { { type = "item", name = "5d-artillery-shell-cluster", amount = 1 } }
    },
    {
        type = "technology",
        name = "5d-artillery-shell-cluster",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = "5d-artillery-shell-cluster" }
        },
        prerequisites = { "artillery" },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            time = 30
        }
    }
})

-------------------------------------------------------------------------------
-- ACID ARTILLERY SHELL
-- Base: 1000 dmg vanilla shell + acid effect
-- Design: 400 impact + 500 acid (ignores some armor) = ~1300 total
-------------------------------------------------------------------------------

local acidShellAction = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 7,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 400, type = "explosion" }
                            },
                            {
                                type = "damage",
                                damage = { amount = 500, type = "acid" }
                            }
                        }
                    }
                }
            },
            {
                type = "create-entity",
                entity_name = "big-explosion"
            }
        }
    }
}

data:extend({
    createArtilleryProjectile("5d-artillery-shell-acid", acidShellAction),
    {
        type = "ammo",
        name = "5d-artillery-shell-acid",
        icons = {
            { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/fluid/sulfuric-acid.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        ammo_category = "artillery-shell",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "artillery",
                    projectile = "5d-artillery-shell-acid-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        subgroup = "defense-ammo-artillery",
        order = "e[acid]",
        stack_size = 1,
        weight = 100000
    },
    {
        type = "recipe",
        name = "5d-artillery-shell-acid",
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = "artillery-shell", amount = 1 },
            { type = "fluid", name = "sulfuric-acid", amount = 100 }
        },
        results = { { type = "item", name = "5d-artillery-shell-acid", amount = 1 } },
        category = "crafting-with-fluid"
    },
    {
        type = "technology",
        name = "5d-artillery-shell-acid",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = "5d-artillery-shell-acid" }
        },
        prerequisites = { "artillery" },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            time = 30
        }
    }
})

-------------------------------------------------------------------------------
-- FRAGMENTATION ARTILLERY SHELL
-- Base: 1000 dmg vanilla shell + wide shrapnel
-- Design: 600 physical + 400 explosion in large radius = ~1200 total (spread)
-------------------------------------------------------------------------------

local fragmentationShellAction = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 12,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 600, type = "physical" }
                            },
                            {
                                type = "damage",
                                damage = { amount = 400, type = "explosion" }
                            }
                        }
                    }
                }
            },
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            }
        }
    }
}

data:extend({
    createArtilleryProjectile("5d-artillery-shell-fragmentation", fragmentationShellAction),
    {
        type = "ammo",
        name = "5d-artillery-shell-fragmentation",
        icons = {
            { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/piercing-shotgun-shell.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        ammo_category = "artillery-shell",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "artillery",
                    projectile = "5d-artillery-shell-fragmentation-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        subgroup = "defense-ammo-artillery",
        order = "f[fragmentation]",
        stack_size = 1,
        weight = 100000
    },
    {
        type = "recipe",
        name = "5d-artillery-shell-fragmentation",
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = "artillery-shell", amount = 1 },
            { type = "item", name = "piercing-shotgun-shell", amount = 20 }
        },
        results = { { type = "item", name = "5d-artillery-shell-fragmentation", amount = 1 } }
    },
    {
        type = "technology",
        name = "5d-artillery-shell-fragmentation",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = "5d-artillery-shell-fragmentation" }
        },
        prerequisites = { "artillery" },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            time = 30
        }
    }
})

-------------------------------------------------------------------------------
-- ARMOR PIERCING ARTILLERY SHELL
-- Base: 1000 dmg vanilla shell + penetration
-- Design: 1500 physical concentrated (anti-behemoth) = ~1500 total
-------------------------------------------------------------------------------

local armorPiercingShellAction = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 3,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 1500, type = "physical" }
                            }
                        }
                    }
                }
            },
            {
                type = "create-entity",
                entity_name = "big-explosion"
            }
        }
    }
}

data:extend({
    createArtilleryProjectile("5d-artillery-shell-armor-piercing", armorPiercingShellAction),
    {
        type = "ammo",
        name = "5d-artillery-shell-armor-piercing",
        icons = {
            { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/uranium-238.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        ammo_category = "artillery-shell",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "artillery",
                    projectile = "5d-artillery-shell-armor-piercing-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        subgroup = "defense-ammo-artillery",
        order = "g[armor-piercing]",
        stack_size = 1,
        weight = 100000
    },
    {
        type = "recipe",
        name = "5d-artillery-shell-armor-piercing",
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = "artillery-shell", amount = 1 },
            { type = "item", name = "uranium-238", amount = 10 }
        },
        results = { { type = "item", name = "5d-artillery-shell-armor-piercing", amount = 1 } }
    },
    {
        type = "technology",
        name = "5d-artillery-shell-armor-piercing",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = "5d-artillery-shell-armor-piercing" }
        },
        prerequisites = { "artillery", "uranium-processing" },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            time = 30
        }
    }
})

-------------------------------------------------------------------------------
-- SHOCKWAVE ARTILLERY SHELL
-- Base: 1000 dmg vanilla shell + knockback
-- Design: 400 damage + massive knockback (crowd control) = ~1100 total
-------------------------------------------------------------------------------

local shockwaveShellAction = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 15,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 400, type = "explosion" }
                            },
                            {
                                type = "push-back",
                                distance = 8
                            }
                        }
                    }
                }
            },
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            }
        }
    }
}

data:extend({
    createArtilleryProjectile("5d-artillery-shell-shockwave", shockwaveShellAction),
    {
        type = "ammo",
        name = "5d-artillery-shell-shockwave",
        icons = {
            { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/explosives.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        ammo_category = "artillery-shell",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "artillery",
                    projectile = "5d-artillery-shell-shockwave-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        subgroup = "defense-ammo-artillery",
        order = "h[shockwave]",
        stack_size = 1,
        weight = 100000
    },
    {
        type = "recipe",
        name = "5d-artillery-shell-shockwave",
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = "artillery-shell", amount = 1 },
            { type = "item", name = "explosives", amount = 20 }
        },
        results = { { type = "item", name = "5d-artillery-shell-shockwave", amount = 1 } }
    },
    {
        type = "technology",
        name = "5d-artillery-shell-shockwave",
        icon = "__base__/graphics/icons/artillery-shell.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = "5d-artillery-shell-shockwave" }
        },
        prerequisites = { "artillery" },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            time = 30
        }
    }
})

-------------------------------------------------------------------------------
-- NUCLEAR ARTILLERY SHELL
-- Base: 1000 dmg vanilla shell + 2x atomic bombs
-- Design: MASSIVE damage, should be the ultimate artillery = ~7000+ total
-- 4000 center + 2000 (r25) + 800 (r40) = devastation
-------------------------------------------------------------------------------

local nuclearShellAction = {
    type = "direct",
    action_delivery = {
        type = "instant",
        target_effects = {
            {
                type = "set-tile",
                tile_name = "nuclear-ground",
                radius = 15,
                apply_projection = true,
                tile_collision_mask = { layers = { water_tile = true } }
            },
            {
                type = "destroy-cliffs",
                radius = 12,
                explosion_at_trigger = "explosion"
            },
            {
                type = "create-entity",
                entity_name = "nuke-explosion"
            },
            {
                type = "camera-effect",
                effect = "screen-burn",
                duration = 60,
                ease_in_duration = 5,
                ease_out_duration = 60,
                delay = 0,
                strength = 8,
                full_strength_max_distance = 250,
                max_distance = 1000
            },
            {
                type = "play-sound",
                sound = {
                    aggregation = { max_count = 1, remove = true },
                    variations = {
                        { filename = "__base__/sound/fight/nuclear-explosion-1.ogg", volume = 1.5 },
                        { filename = "__base__/sound/fight/nuclear-explosion-2.ogg", volume = 1.5 },
                        { filename = "__base__/sound/fight/nuclear-explosion-3.ogg", volume = 1.5 }
                    }
                },
                play_on_target_position = false,
                audible_distance_modifier = 3
            },
            {
                type = "damage",
                damage = { amount = 4000, type = "explosion" }
            },
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 25,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 2000, type = "explosion" }
                            },
                            {
                                type = "create-entity",
                                entity_name = "explosion"
                            }
                        }
                    }
                }
            },
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 40,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { amount = 800, type = "explosion" }
                            }
                        }
                    }
                }
            }
        }
    }
}

data:extend({
    createArtilleryProjectile("5d-artillery-shell-nuclear", nuclearShellAction),
    {
        type = "ammo",
        name = "5d-artillery-shell-nuclear",
        icons = {
            { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/atomic-bomb.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        ammo_category = "artillery-shell",
        ammo_type = {
            target_type = "position",
            action = {
                type = "direct",
                action_delivery = {
                    type = "artillery",
                    projectile = "5d-artillery-shell-nuclear-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        subgroup = "defense-ammo-artillery",
        order = "i[nuclear]",
        stack_size = 1,
        weight = 200000
    },
    {
        type = "recipe",
        name = "5d-artillery-shell-nuclear",
        enabled = false,
        energy_required = 60,
        ingredients = {
            { type = "item", name = "artillery-shell", amount = 1 },
            { type = "item", name = "atomic-bomb", amount = 2 },
            { type = "item", name = "uranium-235", amount = 5 }
        },
        results = { { type = "item", name = "5d-artillery-shell-nuclear", amount = 1 } }
    },
    {
        type = "technology",
        name = "5d-artillery-shell-nuclear",
        icons = {
            { icon = "__base__/graphics/icons/artillery-shell.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/atomic-bomb.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        },
        effects = {
            { type = "unlock-recipe", recipe = "5d-artillery-shell-nuclear" }
        },
        prerequisites = { "artillery", "atomic-bomb" },
        unit = {
            count = 2000,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "production-science-pack", 1 }
            },
            time = 60
        }
    }
})


