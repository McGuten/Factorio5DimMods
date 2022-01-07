require("spitter-attack-parameters")

-- local sounds = require("__base__.prototypes.entity.demo-sounds")

function genSpitter(inputs)
    -- Copy entities
    local spawner = table.deepcopy(data.raw["unit-spawner"]["spitter-spawner"])
    local small = table.deepcopy(data.raw["unit"]["small-spitter"])
    local medium = table.deepcopy(data.raw["unit"]["medium-spitter"])
    local big = table.deepcopy(data.raw["unit"]["big-spitter"])
    local behemoth = table.deepcopy(data.raw["unit"]["behemoth-spitter"])

    -- Biter small
    if inputs.new then
        small.name = "5d-small-" .. inputs.category .. "-" .. inputs.name
    else
        small.name = "small-" .. inputs.name
    end
    small.alternative_attacking_frame_sequence = nil
    small.max_health = inputs.health.small
    small.resistances = inputs.resistances.small
    small.run_animation = spitterrunanimation(inputs.scale.small, inputs.tint, inputs.tint2)
    small.water_reflection = spitter_water_reflection(inputs.scale.small)
    small.attack_parameters =
        selectAttackParams(
        "small",
        inputs.name,
        {
            range = inputs.range.small,
            damage = inputs.damage.small,
            scale = inputs.scale.small,
            tint = inputs.tint,
            tint2 = inputs.tint2
        }
    )
    small.corpse = small.name .. "-corpse"

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
    medium.alternative_attacking_frame_sequence = nil
    medium.max_health = inputs.health.medium
    medium.resistances = inputs.resistances.medium
    medium.run_animation = spitterrunanimation(inputs.scale.medium, inputs.tint, inputs.tint2)
    medium.water_reflection = spitter_water_reflection(inputs.scale.medium)
    medium.attack_parameters =
        selectAttackParams(
        "medium",
        inputs.name,
        {
            range = inputs.range.medium,
            damage = inputs.damage.medium,
            scale = inputs.scale.medium,
            tint = inputs.tint,
            tint2 = inputs.tint2
        }
    )
    medium.corpse = medium.name .. "-corpse"

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
    big.alternative_attacking_frame_sequence = nil
    big.max_health = inputs.health.big
    big.resistances = inputs.resistances.big
    big.run_animation = spitterrunanimation(inputs.scale.big, inputs.tint, inputs.tint2)
    big.water_reflection = spitter_water_reflection(inputs.scale.big)
    big.attack_parameters =
        selectAttackParams(
        "big",
        inputs.name,
        {
            range = inputs.range.big,
            damage = inputs.damage.big,
            scale = inputs.scale.big,
            tint = inputs.tint,
            tint2 = inputs.tint2
        }
    )
    big.corpse = big.name .. "-corpse"

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
    behemoth.alternative_attacking_frame_sequence = nil
    behemoth.max_health = inputs.health.behemoth
    behemoth.resistances = inputs.resistances.behemoth
    behemoth.run_animation = spitterrunanimation(inputs.scale.behemoth, inputs.tint, inputs.tint2)
    behemoth.water_reflection = spitter_water_reflection(inputs.scale.behemoth)
    behemoth.attack_parameters =
        selectAttackParams(
        "behemoth",
        inputs.name,
        {
            range = inputs.range.behemoth,
            damage = inputs.damage.behemoth,
            scale = inputs.scale.behemoth,
            tint = inputs.tint,
            tint2 = inputs.tint2
        }
    )
    behemoth.corpse = behemoth.name .. "-corpse"

    --Optional properties
    if inputs.name == "swimmer" then
        behemoth.collision_mask = {"item-layer", "object-layer"}
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
            res[1] = {"small-biter", {{0.0, 0.3}, {0.7, 0.0}}}
            res[2] = {small.name, inputs.spawnerRating.small}
            res[3] = {medium.name, inputs.spawnerRating.medium}
            res[4] = {big.name, inputs.spawnerRating.big}
            res[5] = {behemoth.name, inputs.spawnerRating.behemoth}
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

    -- Corpse
    local corpseSmall =
        add_spitter_die_animation(
        inputs.scale.small,
        inputs.tint,
        inputs.tint2,
        {
            type = "corpse",
            name = small.name .. "-corpse",
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
    local corpseMedium =
        add_spitter_die_animation(
        inputs.scale.medium,
        inputs.tint,
        inputs.tint2,
        {
            type = "corpse",
            name = medium.name .. "-corpse",
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
    local corpseBig =
        add_spitter_die_animation(
        inputs.scale.big,
        inputs.tint,
        inputs.tint2,
        {
            type = "corpse",
            name = big.name .. "-corpse",
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
    local corpseBehemoth =
        add_spitter_die_animation(
        inputs.scale.behemoth,
        inputs.tint,
        inputs.tint2,
        {
            type = "corpse",
            name = behemoth.name .. "-corpse",
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

    -- Update changes
    data:extend({spawner, small, medium, big, behemoth, corpseSmall, corpseMedium, corpseBig, corpseBehemoth})
end
