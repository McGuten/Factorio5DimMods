require("prototypes.enemies.settings")
require("__5dim_core__.lib.enemies.generation-biter")

-- Biter
genBiter {
    tint = biter.colors.primary.biter,
    tint2 = biter.colors.secondary.secondColor,
    scale = biter.scale,
    health = biter.health,
    damage = biter.damage,
    spawnerRating = spawnerRating.biter.basic,
    name = "biter",
    category = "biter",
    resistances = biter.resistances.basic,
    new = false
}

-- Laser
genBiter {
    tint = biter.colors.primary.laser,
    tint2 = biter.colors.secondary.secondColor,
    scale = biter.scale,
    health = biter.health,
    damage = biter.damage,
    spawnerRating = spawnerRating.biter.laser,
    name = "laser",
    category = "biter",
    resistances = biter.resistances.laser,
    new = true
}

-- Physical
genBiter {
    tint = biter.colors.primary.physical,
    tint2 = biter.colors.secondary.secondColor,
    scale = biter.scale,
    health = biter.health,
    damage = biter.damage,
    spawnerRating = spawnerRating.biter.physical,
    name = "physical",
    category = "biter",
    resistances = biter.resistances.physical,
    new = true
}

-- Climber
if settings.startup["5d-swimmer"].value then
    genBiter {
        tint = biter.colors.primary.climber,
        tint2 = biter.colors.secondary.secondColor,
        scale = biter.scale,
        health = biter.health,
        damage = biter.damage,
        spawnerRating = spawnerRating.biter.climber,
        collisionMask = biter.collisionMask.climber,
        name = "climber",
        category = "biter",
        resistances = biter.resistances.basic,
        new = true
    }
end

-- Swimmer
if settings.startup["5d-climber"].value then
    genBiter {
        tint = biter.colors.primary.swimmer,
        tint2 = biter.colors.secondary.secondColor,
        scale = biter.scale,
        health = biter.health,
        damage = biter.damage,
        spawnerRating = spawnerRating.biter.swimer,
        collisionMask = biter.collisionMask.swimer,
        name = "swimmer",
        category = "biter",
        resistances = biter.resistances.basic,
        new = true
    }
end
