require("tint-gun-turret")

function genGunTurrets(inputs)
    -- Copy electric furnace
    local itemGunTurret = table.deepcopy(data.raw.item["gun-turret"])
    local recipeGunTurret = table.deepcopy(data.raw.recipe["gun-turret"])
    local entityGunTurret = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])
    local technologyGunTurret = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        itemGunTurret.name = "5d-gun-turret-" .. inputs.number
    end
    -- itemGunTurret.icon =
    --     "__5dim_energy__/graphics/icon/gun-turret/gun-turret-icon-" .. inputs.number .. ".png"
    itemGunTurret.subgroup = inputs.subgroup
    itemGunTurret.order = inputs.order
    itemGunTurret.place_result = itemGunTurret.name

    --Recipe
    recipeGunTurret.name = itemGunTurret.name
    -- recipeGunTurret.icon = itemGunTurret.icon
    recipeGunTurret.result = itemGunTurret.name
    recipeGunTurret.icon_size = 64
    -- if inputs.new then
    recipeGunTurret.enabled = true
    -- end
    recipeGunTurret.ingredients = inputs.ingredients

    --Entity
    entityGunTurret.name = itemGunTurret.name
    -- entityGunTurret.icon = itemGunTurret.icon
    entityGunTurret.minable.result = itemGunTurret.name
    entityGunTurret.automated_ammo_count = inputs.ammoCount
    entityGunTurret.attack_parameters.cooldown = inputs.attackSpeed
    entityGunTurret.attack_parameters.range = inputs.range
    entityGunTurret.attack_parameters.damage_modifier = inputs.cooldown
    entityGunTurret.folded_animation.layers[2] =
        dim_gun_turret_extension_mask {
        frame_count = 1,
        line_length = 1,
        tint = inputs.tint
    }
    entityGunTurret.preparing_animation.layers[2] = dim_gun_turret_extension_mask {tint = inputs.tint}
    entityGunTurret.folding_animation.layers[2] =
        dim_gun_turret_extension_mask {
        run_mode = "backward",
        tint = inputs.tint
    }
    entityGunTurret.base_picture.layers[2].apply_runtime_tint = false
    entityGunTurret.base_picture.layers[2].tint = inputs.tint
    entityGunTurret.base_picture.layers[2].hr_version.apply_runtime_tint = false
    entityGunTurret.base_picture.layers[2].hr_version.tint = inputs.tint
    entityGunTurret.attacking_animation.layers[2].apply_runtime_tint = false
    entityGunTurret.attacking_animation.layers[2].tint = inputs.tint
    entityGunTurret.attacking_animation.layers[2].hr_version.apply_runtime_tint = false
    entityGunTurret.attacking_animation.layers[2].hr_version.tint = inputs.tint
    entityGunTurret.prepared_animation.layers[2].apply_runtime_tint = false
    entityGunTurret.prepared_animation.layers[2].tint = inputs.tint
    entityGunTurret.prepared_animation.layers[2].hr_version.apply_runtime_tint = false
    entityGunTurret.prepared_animation.layers[2].hr_version.tint = inputs.tint
    entityGunTurret.max_health = inputs.health or 480
    entityGunTurret.fast_replaceable_group = "gun-turret"

    -- Base
    -- entityGunTurret.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/gun-turret/gun-turret-" .. inputs.number .. ".png"

    data:extend(
        {
            entityGunTurret,
            recipeGunTurret,
            itemGunTurret
        }
    )

    -- Technology
    if inputs.tech then
        technologyGunTurret.name = inputs.tech.number
        -- technologyGunTurret.icon = itemGunTurret.icon
        technologyGunTurret.unit.count = inputs.tech.count
        technologyGunTurret.unit.ingredients = inputs.tech.packs
        technologyGunTurret.prerequisites = inputs.tech.prerequisites
        technologyGunTurret.effects = {
            {
                type = "unlock-recipe",
                recipe = itemGunTurret.name
            }
        }
        data:extend({technologyGunTurret})
    end
end
