local asteroidUtil = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
local yetersMapGen = require("prototypes.yeters-map-gen")

local yeters = table.deepcopy(data.raw.planet["aquilo"])

yeters.name = "yeters"
yeters.icon = "__5dim_yeters__/graphics/icons/yeters.png"
yeters.icon_size = 64
yeters.starmap_icon = "__5dim_yeters__/graphics/icons/starmap-planet-yeters.png"
yeters.starmap_icon_size = 512
yeters.gravity_pull = 10
yeters.distance = 65
yeters.orientation = 0.285
yeters.magnitude = 1.35
yeters.label_orientation = 0.15
yeters.order = "f[yeters]"
yeters.subgroup = "planets"
yeters.map_gen_settings = yetersMapGen.yeters()
yeters.pollutant_type = nil
yeters.solar_power_in_space = 30
yeters.surface_properties = {
    ["day-night-cycle"] = 30 * minute,
    ["5dim-agriculture"] = 1,
    ["magnetic-field"] = 99,
    ["solar-power"] = 1,
    pressure = 300,
    gravity = 15
}
yeters.entities_require_heating = false
yeters.player_effects = nil
yeters.persistent_ambient_sounds = nil
yeters.asteroid_spawn_influence = 1
yeters.asteroid_spawn_definitions = asteroidUtil.spawn_definitions(asteroidUtil.shattered_planet_trip, 0.8)

data:extend({ yeters })