require("prototypes.settings")

local sounds = require("__base__.prototypes.entity.demo-sounds")

-- Copy entities
local experimentalSpitterSpawner = table.deepcopy(data.raw["unit-spawner"]["spitter-spawner"])
local experimentalSpitter = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
local experimentalSpitterLaser = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
local experimentalSpitterPhysical = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
local experimentalSpitterSwimmer = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
local experimentalSpitterClimber = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
local experimentalSpitterFire = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
local experimentalSpitterRocket = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
local experimentalSpitterExplosive = table.deepcopy(data.raw["unit"]["behemoth-spitter"])

-- Spitter
experimentalSpitter.name = "5d-experimental-spitter"
experimentalSpitter.alternative_attacking_frame_sequence = nil
experimentalSpitter.max_health = spitter.health.experimental
experimentalSpitter.resistances = spitter.resistances.basic.experimental
experimentalSpitter.run_animation =
    spitterrunanimation(spitter.scale.experimental, spitter.colors.primary.spiter, spitter.colors.secondary.secondColor)
experimentalSpitter.water_reflection = spitter_water_reflection(spitter.scale.experimental)
experimentalSpitter.attack_parameters =
    spitter_behemoth_attack_parameters(
    {
        acid_stream_name = "acid-stream-spitter-behemoth",
        range = spitter.range.experimental,
        min_attack_distance = 10,
        cooldown = 100,
        cooldown_deviation = 0.15,
        damage_modifier = spitter.damage.experimental,
        scale = spitter.scale.experimental,
        tint1 = spitter.colors.primary.spiter,
        tint2 = spitter.colors.secondary.secondColor,
        roarvolume = 0.8,
        animation = spitterattackanimation(
            spitter.scale.experimental,
            spitter.colors.primary.spiter,
            spitter.colors.secondary.secondColor
        )
    }
)

-- Laser
experimentalSpitterLaser.name = "5d-experimental-spitter-laser"
experimentalSpitterLaser.alternative_attacking_frame_sequence = nil
experimentalSpitterLaser.max_health = spitter.health.experimental
experimentalSpitterLaser.resistances = spitter.resistances.laser.experimental
experimentalSpitterLaser.run_animation =
    spitterrunanimation(spitter.scale.experimental, biter.colors.primary.laser, spitter.colors.secondary.secondColor)
experimentalSpitterLaser.water_reflection = spitter_water_reflection(spitter.scale.experimental)
experimentalSpitterLaser.attack_parameters =
    spitter_behemoth_attack_parameters(
    {
        acid_stream_name = "acid-stream-spitter-behemoth",
        range = spitter.range.experimental,
        min_attack_distance = 10,
        cooldown = 100,
        cooldown_deviation = 0.15,
        damage_modifier = spitter.damage.experimental,
        scale = spitter.scale.experimental,
        tint1 = biter.colors.primary.laser,
        tint2 = spitter.colors.secondary.secondColor,
        roarvolume = 0.8
    }
)

-- Physical
experimentalSpitterPhysical.name = "5d-experimental-spitter-physical"
experimentalSpitterPhysical.alternative_attacking_frame_sequence = nil
experimentalSpitterPhysical.max_health = spitter.health.experimental
experimentalSpitterPhysical.resistances = spitter.resistances.physical.experimental
experimentalSpitterPhysical.run_animation =
    spitterrunanimation(spitter.scale.experimental, biter.colors.primary.physical, spitter.colors.secondary.secondColor)
experimentalSpitterPhysical.water_reflection = spitter_water_reflection(spitter.scale.experimental)
experimentalSpitterPhysical.attack_parameters =
    spitter_behemoth_attack_parameters(
    {
        acid_stream_name = "acid-stream-spitter-behemoth",
        range = spitter.range.experimental,
        min_attack_distance = 10,
        cooldown = 100,
        cooldown_deviation = 0.15,
        damage_modifier = spitter.damage.experimental,
        scale = spitter.scale.experimental,
        tint1 = biter.colors.primary.physical,
        tint2 = spitter.colors.secondary.secondColor,
        roarvolume = 0.8
    }
)

-- Swimer
experimentalSpitterSwimmer.name = "5d-experimental-spitter-swimmer"
experimentalSpitterSwimmer.alternative_attacking_frame_sequence = nil
experimentalSpitterSwimmer.max_health = spitter.health.experimental
experimentalSpitterSwimmer.resistances = spitter.resistances.basic.experimental
experimentalSpitterSwimmer.run_animation =
    spitterrunanimation(spitter.scale.experimental, biter.colors.primary.swimmer, spitter.colors.secondary.secondColor)
experimentalSpitterSwimmer.water_reflection = spitter_water_reflection(spitter.scale.experimental)
experimentalSpitterSwimmer.collision_mask = {"object-layer"}
experimentalSpitterSwimmer.attack_parameters =
    spitter_behemoth_attack_parameters(
    {
        acid_stream_name = "acid-stream-spitter-behemoth",
        range = spitter.range.experimental,
        min_attack_distance = 10,
        cooldown = 100,
        cooldown_deviation = 0.15,
        damage_modifier = spitter.damage.experimental,
        scale = spitter.scale.experimental,
        tint1 = biter.colors.primary.swimmer,
        tint2 = spitter.colors.secondary.secondColor,
        roarvolume = 0.8
    }
)

-- Climber
experimentalSpitterClimber.name = "5d-experimental-spitter-climber"
experimentalSpitterClimber.alternative_attacking_frame_sequence = nil
experimentalSpitterClimber.max_health = spitter.health.experimental
experimentalSpitterClimber.resistances = spitter.resistances.basic.experimental
experimentalSpitterClimber.run_animation =
    spitterrunanimation(spitter.scale.experimental, biter.colors.primary.climber, spitter.colors.secondary.secondColor)
experimentalSpitterClimber.water_reflection = spitter_water_reflection(spitter.scale.experimental)
experimentalSpitterClimber.collision_mask = {"item-layer", "water-tile"}
experimentalSpitterClimber.attack_parameters =
    spitter_behemoth_attack_parameters(
    {
        acid_stream_name = "acid-stream-spitter-behemoth",
        range = spitter.range.experimental,
        min_attack_distance = 10,
        cooldown = 100,
        cooldown_deviation = 0.15,
        damage_modifier = spitter.damage.experimental,
        scale = spitter.scale.experimental,
        tint1 = biter.colors.primary.climber,
        tint2 = spitter.colors.secondary.secondColor,
        roarvolume = 0.8
    }
)

-- Fire
experimentalSpitterFire.name = "5d-experimental-spitter-fire"
experimentalSpitterFire.alternative_attacking_frame_sequence = nil
experimentalSpitterFire.max_health = spitter.health.experimental
experimentalSpitterFire.resistances = spitter.resistances.basic.experimental
experimentalSpitterFire.run_animation =
    spitterrunanimation(spitter.scale.experimental, spitter.colors.primary.rocket, spitter.colors.secondary.secondColor)
experimentalSpitterFire.water_reflection = spitter_water_reflection(spitter.scale.experimental)
experimentalSpitterFire.attack_parameters = {
    type = "stream",
    cooldown = 4,
    range = spitter.range.experimental,
    min_range = 6,
    turn_range = 1.0 / 3.0,
    fire_penalty = 15,
    gun_barrel_length = 0.4,
    ammo_type = {
        category = "flamethrower",
        action = {
            type = "direct",
            action_delivery = {
                type = "stream",
                stream = "flamethrower-fire-stream",
                source_offset = {0.15, -0.5}
            }
        }
    },
    animation = spitterattackanimation(
        spitter.scale.experimental,
        spitter.colors.primary.fire,
        spitter.colors.secondary.secondColor
    )
}

-- Rocket
experimentalSpitterRocket.name = "5d-experimental-spitter-rocketery"
experimentalSpitterRocket.alternative_attacking_frame_sequence = nil
experimentalSpitterRocket.max_health = spitter.health.experimental
experimentalSpitterRocket.resistances = spitter.resistances.basic.experimental
experimentalSpitterRocket.run_animation =
    spitterrunanimation(spitter.scale.experimental, spitter.colors.primary.rocket, spitter.colors.secondary.secondColor)
experimentalSpitterRocket.water_reflection = spitter_water_reflection(spitter.scale.experimental)
experimentalSpitterRocket.attack_parameters = {
    type = "projectile",
    ammo_category = "explosive-rocket",
    cooldown = 60,
    range = spitter.range.experimental,
    projectile_creation_distance = 0.5,
    damage_modifier = spitter.damage.experimental,
    ammo_type = {
        category = "biological",
        action = {
            type = "direct",
            action_delivery = {
                type = "projectile",
                projectile = "explosive-rocket",
                starting_speed = 0.1,
                source_effects = {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    animation = biterattackanimation(
        spitter.scale.experimental,
        spitter.colors.primary.rocket,
        spitter.colors.secondary.secondColor
    )
}

-- Suicide
experimentalSpitterRocket.name = "5d-experimental-spitter-suicide"
experimentalSpitterRocket.alternative_attacking_frame_sequence = nil
experimentalSpitterRocket.max_health = spitter.health.experimental
experimentalSpitterRocket.resistances = spitter.resistances.basic.experimental
experimentalSpitterRocket.run_animation =
    spitterrunanimation(
    spitter.scale.experimental,
    spitter.colors.primary.explosive,
    spitter.colors.secondary.secondColor
)
experimentalSpitterRocket.water_reflection = spitter_water_reflection(spitter.scale.experimental)
experimentalSpitterRocket.attack_parameters = {
    type = "projectile",
    ammo_category = "explosive-rocket",
    cooldown = 10,
    range = spitter.range.experimental,
    projectile_creation_distance = 0.5,
    damage_modifier = spitter.damage.experimental,
    ammo_type = {
        category = "biological",
        action = {
            type = "direct",
            action_delivery = {
                type = "projectile",
                projectile = "explosive-rocket",
                starting_speed = 0.1,
                source_effects = {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    animation = biterattackanimation(
        spitter.scale.experimental,
        spitter.colors.primary.explosive,
        spitter.colors.secondary.secondColor
    )
}

-- Spawner
experimentalSpitterSpawner.name = "5d-experimental-spitter-spawner"
experimentalSpitterSpawner.animations = {
    spawner_idle_animation(0, spitter.colors.primary.spitter),
    spawner_idle_animation(1, spitter.colors.primary.spitter),
    spawner_idle_animation(2, spitter.colors.primary.spitter),
    spawner_idle_animation(3, spitter.colors.primary.spitter)
}
experimentalSpitterSpawner.result_units = (function()
    local res = {}
    res[1] = {"small-biter", {{0.0, 0.3}, {0.35, 0}}}
    res[2] = {"small-spitter", {{0.25, 0.9}, {0.5, 0.3}, {0.7, 0.0}}}
    res[3] = {"medium-spitter", {{0.4, 0.9}, {0.7, 0.3}, {0.9, 0.0}}}
    res[4] = {"big-spitter", {{0.5, 0.9}, {0.93, 0.0}}}
    res[5] = {"behemoth-spitter", {{0.7, 0.9}, {0.931, 0.0}}}
    res[6] = {experimentalSpitter.name, {{0.93, 0.0}, {1.0, 0.2}}}
    res[7] = {experimentalSpitterPhysical.name, {{0.95, 0.0}, {1.0, 0.2}}}
    res[8] = {experimentalSpitterLaser.name, {{0.96, 0.0}, {1.0, 0.2}}}
    res[9] = {experimentalSpitterSwimmer.name, {{0.99, 0.0}, {1.0, 0.2}}}
    res[10] = {experimentalSpitterClimber.name, {{0.99, 0.0}, {1.0, 0.2}}}
    res[11] = {experimentalSpitterFire.name, {{0.992, 0.0}, {1.0, 0.2}}}
    res[12] = {experimentalSpitterRocket.name, {{0.998, 0.0}, {1.0, 0.2}}}
    res[13] = {experimentalSpitterExplosive.name, {{0.999, 0.0}, {1.0, 0.2}}}
    return res
end)()
experimentalSpitterSpawner.autoplace = enemy_autoplace.enemy_spawner_autoplace(0)

-- Update changes
data:extend(
    {
        experimentalSpitterSpawner,
        experimentalSpitter,
        experimentalSpitterLaser,
        experimentalSpitterPhysical,
        experimentalSpitterSwimmer,
        experimentalSpitterClimber,
        experimentalSpitterFire,
        experimentalSpitterRocket,
        experimentalSpitterExplosive
    }
)
