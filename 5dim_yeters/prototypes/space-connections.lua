local asteroidUtil = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")

data:extend({
    {
        type = "space-connection",
        name = "solar-system-edge-yeters",
        subgroup = "planet-connections",
        from = "solar-system-edge",
        to = "yeters",
        order = "ha",
        length = 300000,
        asteroid_spawn_definitions = asteroidUtil.spawn_definitions(asteroidUtil.shattered_planet_trip)
    },
    {
        type = "space-connection",
        name = "yeters-shattered-planet",
        subgroup = "planet-connections",
        from = "yeters",
        to = "shattered-planet",
        order = "hb",
        length = 4000000,
        asteroid_spawn_definitions = asteroidUtil.spawn_definitions(asteroidUtil.shattered_planet_trip)
    }
})