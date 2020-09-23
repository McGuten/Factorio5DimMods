require("tint-gun-turret")

function genGunTurrets(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["gun-turret"])
    local recipe = table.deepcopy(data.raw.recipe["gun-turret"])
    local entity = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])
    local tech = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        item.name = "5d-gun-turret-" .. inputs.number
    end
    -- item.icon =
    --     "__5dim_energy__/graphics/icon/gun-turret/gun-turret-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    -- recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    -- if inputs.new then
    recipe.enabled = true
    -- end
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    -- entity.icon = item.icon
    entity.minable.result = item.name
    entity.automated_ammo_count = inputs.ammoCount
    entity.attack_parameters.cooldown = inputs.attackSpeed
    entity.attack_parameters.range = inputs.range
    entity.attack_parameters.damage_modifier = inputs.cooldown
    entity.folded_animation.layers[2] =
        dim_gun_turret_extension_mask {
        frame_count = 1,
        line_length = 1,
        tint = inputs.tint
    }
    entity.preparing_animation.layers[2] = dim_gun_turret_extension_mask {tint = inputs.tint}
    entity.folding_animation.layers[2] =
        dim_gun_turret_extension_mask {
        run_mode = "backward",
        tint = inputs.tint
    }
    entity.base_picture.layers[2].apply_runtime_tint = false
    entity.base_picture.layers[2].tint = inputs.tint
    entity.base_picture.layers[2].hr_version.apply_runtime_tint = false
    entity.base_picture.layers[2].hr_version.tint = inputs.tint
    entity.attacking_animation.layers[2].apply_runtime_tint = false
    entity.attacking_animation.layers[2].tint = inputs.tint
    entity.attacking_animation.layers[2].hr_version.apply_runtime_tint = false
    entity.attacking_animation.layers[2].hr_version.tint = inputs.tint
    entity.prepared_animation.layers[2].apply_runtime_tint = false
    entity.prepared_animation.layers[2].tint = inputs.tint
    entity.prepared_animation.layers[2].hr_version.apply_runtime_tint = false
    entity.prepared_animation.layers[2].hr_version.tint = inputs.tint
    entity.max_health = inputs.health or 480
    entity.fast_replaceable_group = "gun-turret"

    -- Base
    -- entity.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/gun-turret/gun-turret-" .. inputs.number .. ".png"

    data:extend(
        {
            entity,
            recipe,
            item
        }
    )

    -- Technology
    if inputs.tech then
        tech.name = inputs.tech.number
        -- tech.icon = item.icon
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
