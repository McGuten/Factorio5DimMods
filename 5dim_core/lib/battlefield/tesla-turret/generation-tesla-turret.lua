require("tint-tesla-turret")

function genTeslaTurrets(inputs)
    -- Copy electric furnace
    local itemTeslaTurret = table.deepcopy(data.raw.item["laser-turret"])
    local recipeTeslaTurret = table.deepcopy(data.raw.recipe["laser-turret"])
    local entityTeslaTurret = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
    local technologyTeslaTurret = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        itemTeslaTurret.name = "5d-tesla-turret-" .. inputs.number
    end
    -- itemTeslaTurret.icon =
    --     "__5dim_energy__/graphics/icon/tesla-turret/tesla-turret-icon-" .. inputs.number .. ".png"
    itemTeslaTurret.subgroup = inputs.subgroup
    itemTeslaTurret.order = inputs.order
    itemTeslaTurret.place_result = itemTeslaTurret.name

    --Recipe
    recipeTeslaTurret.name = itemTeslaTurret.name
    -- recipeTeslaTurret.icon = itemTeslaTurret.icon
    recipeTeslaTurret.result = itemTeslaTurret.name
    recipeTeslaTurret.icon_size = 64
    if inputs.new then
        recipeTeslaTurret.enabled = true
    end
    recipeTeslaTurret.ingredients = inputs.ingredients

    --Entity
    entityTeslaTurret.name = itemTeslaTurret.name
    -- entityTeslaTurret.icon = itemTeslaTurret.icon
    entityTeslaTurret.minable.result = itemTeslaTurret.name
    entityTeslaTurret.folded_animation.layers[3] =
        tesla_turret_extension_mask {
        frame_count = 1,
        line_length = 1,
        tint = inputs.tint
    }
    entityTeslaTurret.preparing_animation.layers[3] = tesla_turret_extension_mask {tint = inputs.tint}
    entityTeslaTurret.prepared_animation.layers[3] = tesla_turret_shooting_mask {tint = inputs.tint}
    entityTeslaTurret.folding_animation.layers[3] =
        tesla_turret_extension_mask {
        run_mode = "backward",
        tint = inputs.tint
    }
    entityTeslaTurret.attack_parameters.cooldown = inputs.attackSpeed
    entityTeslaTurret.attack_parameters.range = inputs.range
    entityTeslaTurret.attack_parameters.damage_modifier = inputs.cooldown
    entityTeslaTurret.attack_parameters.ammo_type.action.action_delivery.max_length = inputs.range + 1
    entityTeslaTurret.attack_parameters.ammo_type.action.action_delivery.beam = "electric-beam"
    entityTeslaTurret.max_health = inputs.health or 1500
    entityTeslaTurret.fast_replaceable_group = "tesla-turret"

    -- Base
    -- entityTeslaTurret.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/laser-turret/laser-turret-" .. inputs.number .. ".png"

    data:extend({entityTeslaTurret, recipeTeslaTurret, itemTeslaTurret})

    -- Technology
    if inputs.tech then
        technologyTeslaTurret.name = "5d-tesla-turrets-" .. inputs.tech.number
        --technologyTeslaTurret.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyTeslaTurret.unit.count = inputs.tech.count
        technologyTeslaTurret.unit.ingredients = inputs.tech.packs
        technologyTeslaTurret.prerequisites = inputs.tech.prerequisites
        technologyTeslaTurret.effects = {
            {
                type = "unlock-recipe",
                recipe = itemTeslaTurret.name
            }
        }
        data:extend({technologyTeslaTurret})
    end
end
