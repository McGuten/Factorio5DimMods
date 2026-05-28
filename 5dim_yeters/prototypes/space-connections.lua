local asteroidUtil = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")

data:extend({
    {
        type = "space-connection",
        name = "solar-system-edge-yeters",
        subgroup = "planet-connections",
        from = "solar-system-edge",
        to = "yeters",
        order = "ha",
        length = 600000,
        asteroid_spawn_definitions = asteroidUtil.spawn_definitions(asteroidUtil.shattered_planet_trip)
    }
})