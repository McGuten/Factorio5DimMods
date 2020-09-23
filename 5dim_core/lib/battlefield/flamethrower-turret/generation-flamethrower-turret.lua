require("tint-laser-turret")

function genFlamethrowerTurrets(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["flamethrower-turret"])
    local recipe = table.deepcopy(data.raw.recipe["flamethrower-turret"])
    local entity = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"])
    local tech = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        item.name = "5d-flamethrower-turret-" .. inputs.number
    end
    -- item.icon =
    --     "__5dim_energy__/graphics/icon/flamethrower-turret/flamethrower-turret-icon-" .. inputs.number .. ".png"
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
    entity.attack_parameters.min_range = inputs.minRange
    entity.prepare_range = inputs.range + 5
    entity.max_health = inputs.health or 1400
    entity.fast_replaceable_group = "flamethrower-turret"
    -- entity.base_picture.north.layers[2].tint = inputs.tint
    -- entity.base_picture.north.layers[2].apply_runtime_tint = false
    -- entity.base_picture.east.layers[2].tint = inputs.tint
    -- entity.base_picture.east.layers[2].apply_runtime_tint = false
    -- entity.base_picture.south.layers[2].tint = inputs.tint
    -- entity.base_picture.south.layers[2].apply_runtime_tint = false
    -- entity.base_picture.west.layers[2].tint = inputs.tint
    -- entity.base_picture.west.layers[2].apply_runtime_tint = false

    -- Base
    -- entity.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/flamethrower-turret/flamethrower-turret-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-flamethrower-turrets-" .. inputs.tech.number
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

    -- Changes to add turrets to vanilla tech for damage

    table.insert(
        data.raw.technology["refined-flammables-1"].effects,
        {type = "turret-attack", turret_id = item.name, modifier = 0.2}
    )
    table.insert(
        data.raw.technology["refined-flammables-2"].effects,
        {type = "turret-attack", turret_id = item.name, modifier = 0.2}
    )
    table.insert(
        data.raw.technology["refined-flammables-3"].effects,
        {type = "turret-attack", turret_id = item.name, modifier = 0.3}
    )
    table.insert(
        data.raw.technology["refined-flammables-4"].effects,
        {type = "turret-attack", turret_id = item.name, modifier = 0.3}
    )
    table.insert(
        data.raw.technology["refined-flammables-5"].effects,
        {type = "turret-attack", turret_id = item.name, modifier = 0.4}
    )
    table.insert(
        data.raw.technology["refined-flammables-6"].effects,
        {type = "turret-attack", turret_id = item.name, modifier = 0.2}
    )
    table.insert(
        data.raw.technology["refined-flammables-7"].effects,
        {type = "turret-attack", turret_id = item.name, modifier = 0.2}
    )
end
