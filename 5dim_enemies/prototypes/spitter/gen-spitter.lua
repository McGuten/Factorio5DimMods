require("prototypes.settings")

require("__5dim_core__.lib.enemies.generation-spitter")

-- Spiter
genSpitter {
    tint = spitter.colors.primary.spiter,
    tint2 = spitter.colors.secondary.secondColor,
    scale = spitter.scale,
    health = spitter.health,
    damage = spitter.damage,
    range = spitter.range,
    spawnerRating = spawnerRating.spitter.basic,
    name = "spitter",
    category = "spitter",
    resistances = spitter.resistances.basic,
    autoplace = 11,
    new = false
}

-- Flamer
genSpitter {
    tint = spitter.colors.primary.fire,
    tint2 = spitter.colors.secondary.secondColor,
    scale = spitter.scale,
    health = spitter.health,
    damage = spitter.damage,
    range = spitter.range,
    spawnerRating = spawnerRating.spitter.fire,
    name = "fire",
    category = "spitter",
    resistances = spitter.resistances.basic,
    autoplace = 12,
    new = true
}

-- Rocket
genSpitter {
    tint = spitter.colors.primary.rocket,
    tint2 = spitter.colors.secondary.secondColor,
    scale = spitter.scale,
    health = spitter.health,
    damage = spitter.damage,
    range = spitter.range,
    spawnerRating = spawnerRating.spitter.rocket,
    name = "rocket",
    category = "spitter",
    resistances = spitter.resistances.basic,
    autoplace = 13,
    new = true
}

-- Explosive
if settings.startup["5d-suicide"].value then
    genSpitter {
        tint = spitter.colors.primary.explosive,
        tint2 = spitter.colors.secondary.secondColor,
        scale = spitter.scale,
        health = spitter.health,
        damage = spitter.damage,
        range = spitter.range,
        spawnerRating = spawnerRating.spitter.explosive,
        name = "suicide",
        category = "spitter",
        resistances = spitter.resistances.basic,
        autoplace = 14,
        new = true
    }
end

-- Laser
genSpitter {
    tint = biter.colors.primary.laser,
    tint2 = biter.colors.secondary.secondColor,
    scale = spitter.scale,
    health = spitter.health,
    damage = spitter.damage,
    range = spitter.range,
    spawnerRating = spawnerRating.spitter.laser,
    name = "laser",
    category = "spitter",
    resistances = biter.resistances.laser,
    autoplace = 15,
    new = true
}

-- Physical
genSpitter {
    tint = biter.colors.primary.physical,
    tint2 = biter.colors.secondary.secondColor,
    scale = spitter.scale,
    health = spitter.health,
    damage = spitter.damage,
    range = spitter.range,
    spawnerRating = spawnerRating.spitter.physical,
    name = "physical",
    category = "spitter",
    resistances = biter.resistances.physical,
    autoplace = 16,
    new = true
}

-- if settings.startup["5d-climber"].value then
--     -- Climber
--     genSpitter {
--         tint = biter.colors.primary.climber,
--         tint2 = biter.colors.secondary.secondColor,
--         scale = spitter.scale,
--         health = spitter.health,
--         damage = spitter.damage,
--         range = spitter.range,
--         spawnerRating = spawnerRating.spitter.climber,
--         name = "climber",
--         category = "spitter",
--         resistances = biter.resistances.basic,
--         new = true
--     }
-- end

-- if settings.startup["5d-swimmer"].value then
--     -- Swimmer
--     genSpitter {
--         tint = biter.colors.primary.swimmer,
--         tint2 = biter.colors.secondary.secondColor,
--         scale = spitter.scale,
--         health = spitter.health,
--         damage = spitter.damage,
--         range = spitter.range,
--         spawnerRating = spawnerRating.spitter.swimer,
--         name = "swimmer",
--         category = "spitter",
--         resistances = biter.resistances.basic,
--         new = true
--     }
-- end
