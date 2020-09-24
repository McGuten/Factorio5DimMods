require("tint-laser-turret")

function genLaserTurrets(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["laser-turret"])
    local recipe = table.deepcopy(data.raw.recipe["laser-turret"])
    local entity = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
    local tech = table.deepcopy(data.raw.technology["laser-turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        item.name = "5d-laser-turret-" .. inputs.number
    end

    if string.find(inputs.number, "small") ~= nil then
        item.icon = "__5dim_battlefield__/graphics/icon/laser-turret/laser-turret-small.png"
    elseif string.find(inputs.number, "big") ~= nil then
        item.icon = "__5dim_battlefield__/graphics/icon/laser-turret/laser-turret-big.png"
    elseif string.find(inputs.number, "sniper") ~= nil then
        item.icon = "__5dim_battlefield__/graphics/icon/laser-turret/laser-turret-sniper.png"
    else
        item.icon = "__5dim_battlefield__/graphics/icon/laser-turret/laser-turret-normal.png"
    end

    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    -- recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = true
    end
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    -- entity.icon = item.icon
    entity.minable.result = item.name
    entity.attack_parameters.cooldown = inputs.attackSpeed
    entity.attack_parameters.range = inputs.range
    entity.attack_parameters.damage_modifier = inputs.cooldown
    entity.attack_parameters.ammo_type.action.action_delivery.max_length = inputs.range + 1
    entity.folded_animation.layers[3] =
        dim_laser_turret_extension_mask {
        frame_count = 1,
        line_length = 1,
        tint = inputs.tint
    }
    entity.preparing_animation.layers[3] = dim_laser_turret_extension_mask {tint = inputs.tint}
    entity.prepared_animation.layers[3] = dim_laser_turret_shooting_mask {tint = inputs.tint}
    entity.folding_animation.layers[3] =
        dim_laser_turret_extension_mask {
        run_mode = "backward",
        tint = inputs.tint
    }
    entity.max_health = inputs.health or 1000
    entity.fast_replaceable_group = "laser-turret"

    -- Base
    -- entity.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/laser-turret/laser-turret-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = inputs.tech.number
        tech.icon = item.icon
        tech.icon_size = 64
        tech.unit.count = inputs.tech.count
        tech.unit.ingredients = inputs.tech.packs
        tech.prerequisites = inputs.tech.prerequisites
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = item.name
            }
        }
        data:extend({tech})
    end
end
