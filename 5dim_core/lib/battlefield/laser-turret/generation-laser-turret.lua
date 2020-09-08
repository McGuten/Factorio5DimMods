require("tint-laser-turret")

function genLaserTurrets(inputs)
    -- Copy electric furnace
    local itemLaserTurretSmall = table.deepcopy(data.raw.item["laser-turret"])
    local recipeLaserTurretSmall = table.deepcopy(data.raw.recipe["laser-turret"])
    local entityLaserTurretSmall = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
    local technologyLaserTurretSmall = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        itemLaserTurretSmall.name = "5d-laser-turret-" .. inputs.number
    end
    -- itemLaserTurretSmall.icon =
    --     "__5dim_energy__/graphics/icon/laser-turret/laser-turret-icon-" .. inputs.number .. ".png"
    itemLaserTurretSmall.subgroup = inputs.subgroup
    itemLaserTurretSmall.order = inputs.order
    itemLaserTurretSmall.place_result = itemLaserTurretSmall.name

    --Recipe
    recipeLaserTurretSmall.name = itemLaserTurretSmall.name
    -- recipeLaserTurretSmall.icon = itemLaserTurretSmall.icon
    recipeLaserTurretSmall.result = itemLaserTurretSmall.name
    recipeLaserTurretSmall.icon_size = 64
    if inputs.new then
        recipeLaserTurretSmall.enabled = true
    end
    recipeLaserTurretSmall.ingredients = inputs.ingredients

    --Entity
    entityLaserTurretSmall.name = itemLaserTurretSmall.name
    -- entityLaserTurretSmall.icon = itemLaserTurretSmall.icon
    entityLaserTurretSmall.minable.result = itemLaserTurretSmall.name
    entityLaserTurretSmall.attack_parameters.cooldown = inputs.attackSpeed
    entityLaserTurretSmall.attack_parameters.range = inputs.range
    entityLaserTurretSmall.attack_parameters.damage_modifier = inputs.cooldown
    entityLaserTurretSmall.attack_parameters.ammo_type.action.action_delivery.max_length = inputs.range + 1
    entityLaserTurretSmall.folded_animation.layers[3] =
        dim_laser_turret_extension_mask {
        frame_count = 1,
        line_length = 1,
        tint = inputs.tint
    }
    entityLaserTurretSmall.preparing_animation.layers[3] = dim_laser_turret_extension_mask {tint = inputs.tint}
    entityLaserTurretSmall.prepared_animation.layers[3] = dim_laser_turret_shooting_mask {tint = inputs.tint}
    entityLaserTurretSmall.folding_animation.layers[3] =
        dim_laser_turret_extension_mask {
        run_mode = "backward",
        tint = inputs.tint
    }
    entityLaserTurretSmall.max_health = inputs.health or 1000

    -- Base
    -- entityLaserTurretSmall.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/laser-turret/laser-turret-" .. inputs.number .. ".png"

    data:extend({entityLaserTurretSmall, recipeLaserTurretSmall, itemLaserTurretSmall})

    -- Technology
    if inputs.tech then
        technologyLaserTurretSmall.name = "electric-energy-LaserTurretSmalls-" .. inputs.tech.number
        --technologyLaserTurretSmall.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyLaserTurretSmall.unit.count = inputs.tech.count
        technologyLaserTurretSmall.unit.ingredients = inputs.tech.packs
        technologyLaserTurretSmall.prerequisites = inputs.tech.prerequisites
        technologyLaserTurretSmall.effects = {
            {
                type = "unlock-recipe",
                recipe = itemLaserTurretSmall.name
            }
        }
        data:extend({technologyLaserTurretSmall})
    end
end
