require("tint-laser-turret")

function genLaserTurrets(inputs)
    -- Copy electric furnace
    local itemLaserTurret = table.deepcopy(data.raw.item["laser-turret"])
    local recipeLaserTurret = table.deepcopy(data.raw.recipe["laser-turret"])
    local entityLaserTurret = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
    local technologyLaserTurret = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        itemLaserTurret.name = "5d-laser-turret-" .. inputs.number
    end
    -- itemLaserTurret.icon =
    --     "__5dim_energy__/graphics/icon/laser-turret/laser-turret-icon-" .. inputs.number .. ".png"
    itemLaserTurret.subgroup = inputs.subgroup
    itemLaserTurret.order = inputs.order
    itemLaserTurret.place_result = itemLaserTurret.name

    --Recipe
    recipeLaserTurret.name = itemLaserTurret.name
    -- recipeLaserTurret.icon = itemLaserTurret.icon
    recipeLaserTurret.result = itemLaserTurret.name
    recipeLaserTurret.icon_size = 64
    if inputs.new then
        recipeLaserTurret.enabled = true
    end
    recipeLaserTurret.ingredients = inputs.ingredients

    --Entity
    entityLaserTurret.name = itemLaserTurret.name
    -- entityLaserTurret.icon = itemLaserTurret.icon
    entityLaserTurret.minable.result = itemLaserTurret.name
    entityLaserTurret.attack_parameters.cooldown = inputs.attackSpeed
    entityLaserTurret.attack_parameters.range = inputs.range
    entityLaserTurret.attack_parameters.damage_modifier = inputs.cooldown
    entityLaserTurret.attack_parameters.ammo_type.action.action_delivery.max_length = inputs.range + 1
    entityLaserTurret.folded_animation.layers[3] =
        dim_laser_turret_extension_mask {
        frame_count = 1,
        line_length = 1,
        tint = inputs.tint
    }
    entityLaserTurret.preparing_animation.layers[3] = dim_laser_turret_extension_mask {tint = inputs.tint}
    entityLaserTurret.prepared_animation.layers[3] = dim_laser_turret_shooting_mask {tint = inputs.tint}
    entityLaserTurret.folding_animation.layers[3] =
        dim_laser_turret_extension_mask {
        run_mode = "backward",
        tint = inputs.tint
    }
    entityLaserTurret.max_health = inputs.health or 1000
    entityLaserTurret.fast_replaceable_group = "laser-turret"

    -- Base
    -- entityLaserTurret.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/laser-turret/laser-turret-" .. inputs.number .. ".png"

    data:extend({entityLaserTurret, recipeLaserTurret, itemLaserTurret})

    -- Technology
    if inputs.tech then
        technologyLaserTurret.name = "electric-energy-LaserTurret-" .. inputs.tech.number
        --technologyLaserTurret.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyLaserTurret.unit.count = inputs.tech.count
        technologyLaserTurret.unit.ingredients = inputs.tech.packs
        technologyLaserTurret.prerequisites = inputs.tech.prerequisites
        technologyLaserTurret.effects = {
            {
                type = "unlock-recipe",
                recipe = itemLaserTurret.name
            }
        }
        data:extend({technologyLaserTurret})
    end
end
