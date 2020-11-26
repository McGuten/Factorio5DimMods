-- local sounds = require ("prototypes.entity.sounds")

function genBiter(inputs)
    -- Copy entities
    local spawner = table.deepcopy(data.raw["unit-spawner"]["biter-spawner"])
    local small = table.deepcopy(data.raw["unit"]["small-biter"])
    local medium = table.deepcopy(data.raw["unit"]["medium-biter"])
    local big = table.deepcopy(data.raw["unit"]["big-biter"])
    local behemoth = table.deepcopy(data.raw["unit"]["behemoth-biter"])

    -- Biter small
    if inputs.new then
        small.name = "5d-small-" .. inputs.category .. "-" .. inputs.name
    else
        small.name = "small-" .. inputs.name
    end
    small.attack_parameters.ammo_type = make_unit_melee_ammo_type(inputs.damage.small)
    small.attack_parameters.animation = biterattackanimation(inputs.scale.small, inputs.tint, inputs.tint2)
    small.max_health = inputs.health.small
    small.resistances = inputs.resistances.small
    small.run_animation = biterrunanimation(inputs.scale.small, inputs.tint, inputs.tint2)
    small.water_reflection = biter_water_reflection(inputs.scale.small)

    --Optional properties
    if inputs.name == "swimmer" then
        small.collision_mask = {"object-layer"}
    end
    if inputs.name == "climber" then
        small.collision_mask = {"item-layer", "water-tile"}
    end
    

    -- Biter medium
    if inputs.new then
        medium.name = "5d-medium-" .. inputs.category .. "-" .. inputs.name
    else
        medium.name = "medium-" .. inputs.name
    end
    medium.attack_parameters.ammo_type = make_unit_melee_ammo_type(inputs.damage.medium)
    medium.attack_parameters.animation = biterattackanimation(inputs.scale.medium, inputs.tint, inputs.tint2)
    medium.max_health = inputs.health.medium
    medium.resistances = inputs.resistances.medium
    medium.run_animation = biterrunanimation(inputs.scale.medium, inputs.tint, inputs.tint2)
    medium.water_reflection = biter_water_reflection(inputs.scale.medium)

    --Optional properties
    if inputs.name == "swimmer" then
        medium.collision_mask = {"object-layer"}
    end
    if inputs.name == "climber" then
        medium.collision_mask = {"item-layer", "water-tile"}
    end

    -- Biter big
    if inputs.new then
        big.name = "5d-big-" .. inputs.category .. "-" .. inputs.name
    else
        big.name = "big-" .. inputs.name
    end
    big.attack_parameters.ammo_type = make_unit_melee_ammo_type(inputs.damage.big)
    big.attack_parameters.animation = biterattackanimation(inputs.scale.big, inputs.tint, inputs.tint2)
    big.max_health = inputs.health.big
    big.resistances = inputs.resistances.big
    big.run_animation = biterrunanimation(inputs.scale.big, inputs.tint, inputs.tint2)
    big.water_reflection = biter_water_reflection(inputs.scale.big)

    --Optional properties
    if inputs.name == "swimmer" then
        big.collision_mask = {"object-layer"}
    end
    if inputs.name == "climber" then
        big.collision_mask = {"item-layer", "water-tile"}
    end

    -- Biter behemoth
    if inputs.new then
        behemoth.name = "5d-behemoth-" .. inputs.category .. "-" .. inputs.name
    else
        behemoth.name = "behemoth-" .. inputs.name
    end
    behemoth.attack_parameters.ammo_type = make_unit_melee_ammo_type(inputs.damage.behemoth)
    behemoth.attack_parameters.animation = biterattackanimation(inputs.scale.behemoth, inputs.tint, inputs.tint2)
    behemoth.max_health = inputs.health.behemoth
    behemoth.resistances = inputs.resistances.behemoth
    behemoth.run_animation = biterrunanimation(inputs.scale.behemoth, inputs.tint, inputs.tint2)
    behemoth.water_reflection = biter_water_reflection(inputs.scale.behemoth)

    --Optional properties
    if inputs.name == "swimmer" then
        behemoth.collision_mask = {"object-layer"}
    end
    if inputs.name == "climber" then
        behemoth.collision_mask = {"item-layer", "water-tile"}
    end

    -- Spawners
    if inputs.new then
        spawner.name = inputs.name .. "-" .. inputs.category .. "-spawner" --laser-biter-spawner
    else
        spawner.name = inputs.category .. "-spawner" --biter-spawner
    end
    spawner.animations = {
        spawner_idle_animation(0, inputs.tint),
        spawner_idle_animation(1, inputs.tint),
        spawner_idle_animation(2, inputs.tint),
        spawner_idle_animation(3, inputs.tint)
    }
    spawner.result_units = (function()
        local res = {}
        if inputs.new then
            res[1] = {"small-biter", {{0.0, 0.3}, {0.7, 0.0}}}
            res[2] = {small.name, inputs.spawnerRating.small}
            res[3] = {medium.name, inputs.spawnerRating.medium}
            res[4] = {big.name, inputs.spawnerRating.big}
            res[5] = {behemoth.name, inputs.spawnerRating.behemoth}
            return res
        else 
            res[1] = {small.name, inputs.spawnerRating.small}
            res[2] = {medium.name, inputs.spawnerRating.medium}
            res[3] = {big.name, inputs.spawnerRating.big}
            res[4] = {behemoth.name, inputs.spawnerRating.behemoth}
            return res
        end
    end)()
    spawner.autoplace = enemy_autoplace.enemy_spawner_autoplace(0)

    --Optional properties
    if inputs.name == "swimmer" then
        spawner.collision_mask = {"item-layer", "object-layer"}
    end
    if inputs.name == "climber" then
        spawner.collision_mask = {"item-layer", "water-tile"}
    end

    -- Update changes
    data:extend({spawner, small, medium, big, behemoth})
end