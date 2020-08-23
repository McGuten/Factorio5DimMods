require("prototypes.enemies.settings")

require("__5dim_core__.lib.generation-spitter")

-- Spiter
genSpitter {
    tint = spitter.colors.primary.spiter,
    tint2 = spitter.colors.secondary.secondColor,
    scale = spitter.scale,
    health = spitter.health,
    damage = spitter.damage,
    range = spitter.range,
    spawnerRating = spawnerRating.physical,
    name = "spitter",
    category = "spitter",
    resistances = spitter.resistances.basic,
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
    spawnerRating = spawnerRating.physical,
    name = "fire",
    category = "spitter",
    resistances = spitter.resistances.basic,
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
    spawnerRating = spawnerRating.physical,
    name = "rocket",
    category = "spitter",
    resistances = spitter.resistances.basic,
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
        spawnerRating = spawnerRating.physical,
        name = "suicide",
        category = "spitter",
        resistances = spitter.resistances.basic,
        new = true
    }
end

-- -- Laser
-- genSpitter {
--     tint = biter.colors.primary.laser,
--     tint2 = biter.colors.secondary.secondColor,
--     scale = spitter.scale,
--     health = spitter.health,
--     damage = spitter.damage,
--     range = spitter.range,
--     spawnerRating = spawnerRating.laser,
--     name = "laser",
--     category = "spitter",
--     resistances = biter.resistances.laser,
--     new = true
-- }

-- -- Physical
-- genSpitter {
--     tint = biter.colors.primary.physical,
--     tint2 = biter.colors.secondary.secondColor,
--     scale = spitter.scale,
--     health = spitter.health,
--     damage = spitter.damage,
--     range = spitter.range,
--     spawnerRating = spawnerRating.physical,
--     name = "physical",
--     category = "spitter",
--     resistances = biter.resistances.physical,
--     new = true
-- }

-- -- Climber
-- genSpitter {
--     tint = biter.colors.primary.climber,
--     tint2 = biter.colors.secondary.secondColor,
--     scale = spitter.scale,
--     health = spitter.health,
--     damage = spitter.damage,
--     range = spitter.range,
--     spawnerRating = spawnerRating.climber,
--     name = "climber",
--     category = "spitter",
--     resistances = biter.resistances.basic,
--     new = true
-- }

-- -- Swimmer
-- genSpitter {
--     tint = biter.colors.primary.swimmer,
--     tint2 = biter.colors.secondary.secondColor,
--     scale = spitter.scale,
--     health = spitter.health,
--     damage = spitter.damage,
--     range = spitter.range,
--     spawnerRating = spawnerRating.swimer,
--     name = "swimmer",
--     category = "spitter",
--     resistances = biter.resistances.basic,
--     new = true
-- }
