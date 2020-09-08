require("tint-gun-turret")

function genGunTurrets(inputs)
    -- Copy electric furnace
    local itemGunTurretSmall = table.deepcopy(data.raw.item["gun-turret"])
    local recipeGunTurretSmall = table.deepcopy(data.raw.recipe["gun-turret"])
    local entityGunTurretSmall = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])
    local technologyGunTurretSmall = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        itemGunTurretSmall.name = "5d-gun-turret-" .. inputs.number
    end
    -- itemGunTurretSmall.icon =
    --     "__5dim_energy__/graphics/icon/gun-turret/gun-turret-icon-" .. inputs.number .. ".png"
    itemGunTurretSmall.subgroup = inputs.subgroup
    itemGunTurretSmall.order = inputs.order
    itemGunTurretSmall.place_result = itemGunTurretSmall.name

    --Recipe
    recipeGunTurretSmall.name = itemGunTurretSmall.name
    -- recipeGunTurretSmall.icon = itemGunTurretSmall.icon
    recipeGunTurretSmall.result = itemGunTurretSmall.name
    recipeGunTurretSmall.icon_size = 64
    -- if inputs.new then
    recipeGunTurretSmall.enabled = true
    -- end
    recipeGunTurretSmall.ingredients = inputs.ingredients

    --Entity
    entityGunTurretSmall.name = itemGunTurretSmall.name
    -- entityGunTurretSmall.icon = itemGunTurretSmall.icon
    entityGunTurretSmall.minable.result = itemGunTurretSmall.name
    entityGunTurretSmall.automated_ammo_count = inputs.ammoCount
    entityGunTurretSmall.attack_parameters.cooldown = inputs.attackSpeed
    entityGunTurretSmall.attack_parameters.range = inputs.range
    entityGunTurretSmall.attack_parameters.damage_modifier = inputs.cooldown
    entityGunTurretSmall.folded_animation.layers[2] =
        dim_gun_turret_extension_mask {
        frame_count = 1,
        line_length = 1,
        tint = inputs.tint
    }
    entityGunTurretSmall.preparing_animation.layers[2] = dim_gun_turret_extension_mask {tint = inputs.tint}
    entityGunTurretSmall.folding_animation.layers[2] =
        dim_gun_turret_extension_mask {
        run_mode = "backward",
        tint = inputs.tint
    }
    entityGunTurretSmall.base_picture.layers[2].apply_runtime_tint = false
    entityGunTurretSmall.base_picture.layers[2].tint = inputs.tint
    entityGunTurretSmall.base_picture.layers[2].hr_version.apply_runtime_tint = false
    entityGunTurretSmall.base_picture.layers[2].hr_version.tint = inputs.tint
    entityGunTurretSmall.attacking_animation.layers[2].apply_runtime_tint = false
    entityGunTurretSmall.attacking_animation.layers[2].tint = inputs.tint
    entityGunTurretSmall.attacking_animation.layers[2].hr_version.apply_runtime_tint = false
    entityGunTurretSmall.attacking_animation.layers[2].hr_version.tint = inputs.tint
    entityGunTurretSmall.prepared_animation.layers[2].apply_runtime_tint = false
    entityGunTurretSmall.prepared_animation.layers[2].tint = inputs.tint
    entityGunTurretSmall.prepared_animation.layers[2].hr_version.apply_runtime_tint = false
    entityGunTurretSmall.prepared_animation.layers[2].hr_version.tint = inputs.tint
    entityGunTurretSmall.max_health = inputs.health or 480

    -- Base
    -- entityGunTurretSmall.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/gun-turret/gun-turret-" .. inputs.number .. ".png"

    data:extend(
        {
            entityGunTurretSmall,
            recipeGunTurretSmall,
            itemGunTurretSmall
        }
    )

    -- Technology
    if inputs.tech then
        technologyGunTurretSmall.name = "electric-energy-GunTurretSmalls-" .. inputs.tech.number
        --technologyGunTurretSmall.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyGunTurretSmall.unit.count = inputs.tech.count
        technologyGunTurretSmall.unit.ingredients = inputs.tech.packs
        technologyGunTurretSmall.prerequisites = inputs.tech.prerequisites
        technologyGunTurretSmall.effects = {
            {
                type = "unlock-recipe",
                recipe = itemGunTurretSmall.name
            }
        }
        data:extend({technologyGunTurretSmall})
    end
end
