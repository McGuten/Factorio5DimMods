require("prototypes.settings")

-- local sounds = require("__base__.prototypes.entity.demo-sounds")

--Copy entities
local experimentalBiterSpawner = table.deepcopy(data.raw["unit-spawner"]["biter-spawner"])
local experimentalBiter = table.deepcopy(data.raw["unit"]["behemoth-biter"])
local experimentalBiterLaser = table.deepcopy(data.raw["unit"]["behemoth-biter"])
local experimentalBiterPhysical = table.deepcopy(data.raw["unit"]["behemoth-biter"])
local experimentalBiterSwimmer = table.deepcopy(data.raw["unit"]["behemoth-biter"])
local experimentalBiterClimber = table.deepcopy(data.raw["unit"]["behemoth-biter"])

-- Experimental biter
experimentalBiter.name = "5d-experimental-biter"
experimentalBiter.attack_parameters.ammo_type = make_unit_melee_ammo_type(biter.damage.experimental)
experimentalBiter.attack_parameters.animation =
    biterattackanimation(biter.scale.experimental, biter.colors.primary.biter, biter.colors.secondary.secondColor)
experimentalBiter.max_health = biter.health.experimental
experimentalBiter.resistances = biter.resistances.basic.experimental
experimentalBiter.run_animation =
    biterrunanimation(biter.scale.experimental, biter.colors.primary.biter, biter.colors.secondary.secondColor)
experimentalBiter.water_reflection = biter_water_reflection(biter.scale.experimental)
experimentalBiter.pollution_to_join_attack = 1000
experimentalBiter.corpse = "5d-experimental-biter-corpse"
local experimentalBiterCorpse =
    add_biter_die_animation(
    biter.scale.experimental,
    biter.colors.primary.biter,
    biter.colors.secondary.secondColor,
    {
        type = "corpse",
        name = "5d-experimental-biter-corpse",
        icon = "__base__/graphics/icons/medium-biter-corpse.png",
        icon_size = 64,
        icon_mipmaps = 4,
        selectable_in_game = false,
        selection_box = {{-1, -1}, {1, 1}},
        subgroup = "corpses",
        order = "c[corpse]-a[biter]-b[medium]",
        flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
    }
)

-- Experimental biter laser
experimentalBiterLaser.name = "5d-experimental-biter-laser"
experimentalBiterLaser.attack_parameters.ammo_type = make_unit_melee_ammo_type(biter.damage.experimental)
experimentalBiterLaser.attack_parameters.animation =
    biterattackanimation(biter.scale.experimental, biter.colors.primary.laser, biter.colors.secondary.secondColor)
experimentalBiterLaser.max_health = biter.health.experimental
experimentalBiterLaser.resistances = biter.resistances.laser.experimental
experimentalBiterLaser.run_animation =
    biterrunanimation(biter.scale.experimental, biter.colors.primary.laser, biter.colors.secondary.secondColor)
experimentalBiterLaser.water_reflection = biter_water_reflection(biter.scale.experimental)
experimentalBiterLaser.pollution_to_join_attack = 1000
experimentalBiterLaser.corpse = "5d-experimental-biter-laser-corpse"
local experimentalBiterLaserCorpse =
    add_biter_die_animation(
    biter.scale.experimental,
    biter.colors.primary.laser,
    biter.colors.secondary.secondColor,
    {
        type = "corpse",
        name = "5d-experimental-biter-laser-corpse",
        icon = "__base__/graphics/icons/medium-biter-corpse.png",
        icon_size = 64,
        icon_mipmaps = 4,
        selectable_in_game = false,
        selection_box = {{-1, -1}, {1, 1}},
        subgroup = "corpses",
        order = "c[corpse]-a[biter]-b[medium]",
        flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
    }
)

-- Experimental biter physical
experimentalBiterPhysical.name = "5d-experimental-biter-physical"
experimentalBiterPhysical.attack_parameters.ammo_type = make_unit_melee_ammo_type(biter.damage.experimental)
experimentalBiterPhysical.attack_parameters.animation =
    biterattackanimation(biter.scale.experimental, biter.colors.primary.physical, biter.colors.secondary.secondColor)
experimentalBiterPhysical.max_health = biter.health.experimental
experimentalBiterPhysical.resistances = biter.resistances.physical.experimental
experimentalBiterPhysical.run_animation =
    biterrunanimation(biter.scale.experimental, biter.colors.primary.physical, biter.colors.secondary.secondColor)
experimentalBiterPhysical.water_reflection = biter_water_reflection(biter.scale.experimental)
experimentalBiterPhysical.pollution_to_join_attack = 1000
experimentalBiterPhysical.corpse = "5d-experimental-biter-physical-corpse"
local experimentalBiterPhysicalCorpse =
    add_biter_die_animation(
    biter.scale.experimental,
    biter.colors.primary.physical,
    biter.colors.secondary.secondColor,
    {
        type = "corpse",
        name = "5d-experimental-biter-physical-corpse",
        icon = "__base__/graphics/icons/medium-biter-corpse.png",
        icon_size = 64,
        icon_mipmaps = 4,
        selectable_in_game = false,
        selection_box = {{-1, -1}, {1, 1}},
        subgroup = "corpses",
        order = "c[corpse]-a[biter]-b[medium]",
        flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
    }
)

-- Experimental biter swimer
experimentalBiterSwimmer.name = "5d-experimental-biter-swimer"
experimentalBiterSwimmer.attack_parameters.ammo_type = make_unit_melee_ammo_type(biter.damage.experimental)
experimentalBiterSwimmer.attack_parameters.animation =
    biterattackanimation(biter.scale.experimental, biter.colors.primary.swimmer, biter.colors.secondary.secondColor)
experimentalBiterSwimmer.max_health = biter.health.experimental
experimentalBiterSwimmer.resistances = biter.resistances.basic.experimental
experimentalBiterSwimmer.collision_mask = {"object-layer"}
experimentalBiterSwimmer.run_animation =
    biterrunanimation(biter.scale.experimental, biter.colors.primary.swimmer, biter.colors.secondary.secondColor)
experimentalBiterSwimmer.water_reflection = biter_water_reflection(biter.scale.experimental)
experimentalBiterSwimmer.pollution_to_join_attack = 1000
experimentalBiterSwimmer.corpse = "5d-experimental-biter-swimer-corpse"
local experimentalBiterSwimmerCorpse =
    add_biter_die_animation(
    biter.scale.experimental,
    biter.colors.primary.swimmer,
    biter.colors.secondary.secondColor,
    {
        type = "corpse",
        name = "5d-experimental-biter-swimer-corpse",
        icon = "__base__/graphics/icons/medium-biter-corpse.png",
        icon_size = 64,
        icon_mipmaps = 4,
        selectable_in_game = false,
        selection_box = {{-1, -1}, {1, 1}},
        subgroup = "corpses",
        order = "c[corpse]-a[biter]-b[medium]",
        flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
    }
)

-- Experimental biter climber
experimentalBiterClimber.name = "5d-experimental-biter-climber"
experimentalBiterClimber.attack_parameters.ammo_type = make_unit_melee_ammo_type(biter.damage.experimental)
experimentalBiterClimber.attack_parameters.animation =
    biterattackanimation(biter.scale.experimental, biter.colors.primary.climber, biter.colors.secondary.secondColor)
experimentalBiterClimber.max_health = biter.health.experimental
experimentalBiterClimber.resistances = biter.resistances.basic.experimental
experimentalBiterClimber.collision_mask = {"item-layer", "water-tile"}
experimentalBiterClimber.run_animation =
    biterrunanimation(biter.scale.experimental, biter.colors.primary.climber, biter.colors.secondary.secondColor)
experimentalBiterClimber.water_reflection = biter_water_reflection(biter.scale.experimental)
experimentalBiterClimber.pollution_to_join_attack = 1000
experimentalBiterClimber.corpse = "5d-experimental-biter-climber-corpse"
local experimentalBiterClimberCorpse =
    add_biter_die_animation(
    biter.scale.experimental,
    biter.colors.primary.climber,
    biter.colors.secondary.secondColor,
    {
        type = "corpse",
        name = "5d-experimental-biter-climber-corpse",
        icon = "__base__/graphics/icons/medium-biter-corpse.png",
        icon_size = 64,
        icon_mipmaps = 4,
        selectable_in_game = false,
        selection_box = {{-1, -1}, {1, 1}},
        subgroup = "corpses",
        order = "c[corpse]-a[biter]-b[medium]",
        flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
    }
)

-- Spawner
experimentalBiterSpawner.name = "5d-experimental-biter-spawner"
experimentalBiterSpawner.animations = {
    spawner_idle_animation(0, biter.colors.primary.biter),
    spawner_idle_animation(1, biter.colors.primary.biter),
    spawner_idle_animation(2, biter.colors.primary.biter),
    spawner_idle_animation(3, biter.colors.primary.biter)
}
experimentalBiterSpawner.result_units = (function()
    local res = {}
    res[1] = {"small-biter", {{0.0, 0.3}, {0.7, 0.0}}}
    res[2] = {"medium-biter", {{0.2, 0.9}, {0.6, 0.3}, {0.9, 0.0}}}
    res[3] = {"big-biter", {{0.4, 0.9}, {0.9, 0.0}}}
    res[4] = {"behemoth-biter", {{0.6, 0.9}, {0.91, 0.0}}}
    res[5] = {experimentalBiter.name, {{0.9, 0.0}, {1.0, 0.2}}}
    res[6] = {experimentalBiterPhysical.name, {{0.92, 0.0}, {1.0, 0.2}}}
    res[7] = {experimentalBiterLaser.name, {{0.93, 0.0}, {1.0, 0.2}}}
    res[8] = {experimentalBiterSwimmer.name, {{0.99, 0.0}, {1.0, 0.2}}}
    res[9] = {experimentalBiterClimber.name, {{0.99, 0.0}, {1.0, 0.2}}}
    return res
end)()
experimentalBiterSpawner.autoplace = enemy_autoplace.enemy_spawner_autoplace(0)

-- Update changes
data:extend(
    {
        experimentalBiterSpawner,
        experimentalBiter,
        experimentalBiterLaser,
        experimentalBiterPhysical,
        experimentalBiterSwimmer,
        experimentalBiterClimber,
        experimentalBiterCorpse,
        experimentalBiterLaserCorpse,
        experimentalBiterPhysicalCorpse,
        experimentalBiterSwimmerCorpse,
        experimentalBiterClimberCorpse
    }
)
