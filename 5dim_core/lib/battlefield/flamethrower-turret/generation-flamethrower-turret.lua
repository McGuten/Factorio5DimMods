-- require("tint-laser-turret")

function genFlamethrowerTurrets(inputs)
    -- Determine icon path
    local iconPath = "__5dim_battlefield__/graphics/icon/flamethrower-turret/flamethrower-turret-icon-" .. inputs.number .. ".png"
    
    -- For vanilla tier (new = false), only update icon of base entity
    if not inputs.new then
        data.raw.item["flamethrower-turret"].icon = iconPath
        data.raw.item["flamethrower-turret"].icon_size = 64
        data.raw.recipe["flamethrower-turret"].icon = iconPath
        data.raw.recipe["flamethrower-turret"].icon_size = 64
        data.raw["fluid-turret"]["flamethrower-turret"].icon = iconPath
        data.raw["fluid-turret"]["flamethrower-turret"].icon_size = 64
        return
    end
    
    -- Copy flamethrower turret
    local item = table.deepcopy(data.raw.item["flamethrower-turret"])
    local recipe = table.deepcopy(data.raw.recipe["flamethrower-turret"])
    local entity = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"])
    local tech = table.deepcopy(data.raw.technology["flamethrower"])

    local tint = { r = 1, g = 1, b = 0.1, a = 1 }

    --Item
    item.name = "5d-flamethrower-turret-" .. inputs.number
    item.icon = iconPath
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    -- Modify attack_parameters - keep original structure, just update allowed values
    if entity.attack_parameters then
        entity.attack_parameters.range = inputs.range
        entity.attack_parameters.min_range = inputs.minRange
    end
    entity.prepare_range = inputs.range + 5
    entity.max_health = inputs.health or 1400
    entity.fast_replaceable_group = "flamethrower-turret"
    
    -- Apply tint to base masks for all directions
    if inputs.tint then
        entity.graphics_set.base_visualisation.animation.north.layers[2].tint = inputs.tint
        entity.graphics_set.base_visualisation.animation.north.layers[2].apply_runtime_tint = false
        entity.graphics_set.base_visualisation.animation.east.layers[2].tint = inputs.tint
        entity.graphics_set.base_visualisation.animation.east.layers[2].apply_runtime_tint = false
        entity.graphics_set.base_visualisation.animation.south.layers[2].tint = inputs.tint
        entity.graphics_set.base_visualisation.animation.south.layers[2].apply_runtime_tint = false
        entity.graphics_set.base_visualisation.animation.west.layers[2].tint = inputs.tint
        entity.graphics_set.base_visualisation.animation.west.layers[2].apply_runtime_tint = false
    end

    data:extend({ entity, recipe, item })

    -- Technology - extends vanilla flamethrower as flamethrower-2, flamethrower-3, etc.
    if inputs.tech then
        tech.name = "flamethrower-" .. inputs.tech.number
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
        data:extend({ tech })
    end

    -- Changes to add turrets to vanilla tech for damage

    table.insert(
        data.raw.technology["refined-flammables-1"].effects,
        { type = "turret-attack", turret_id = item.name, modifier = 0.2 }
    )
    table.insert(
        data.raw.technology["refined-flammables-2"].effects,
        { type = "turret-attack", turret_id = item.name, modifier = 0.2 }
    )
    table.insert(
        data.raw.technology["refined-flammables-3"].effects,
        { type = "turret-attack", turret_id = item.name, modifier = 0.3 }
    )
    table.insert(
        data.raw.technology["refined-flammables-4"].effects,
        { type = "turret-attack", turret_id = item.name, modifier = 0.3 }
    )
    table.insert(
        data.raw.technology["refined-flammables-5"].effects,
        { type = "turret-attack", turret_id = item.name, modifier = 0.4 }
    )
    table.insert(
        data.raw.technology["refined-flammables-6"].effects,
        { type = "turret-attack", turret_id = item.name, modifier = 0.2 }
    )
    table.insert(
        data.raw.technology["refined-flammables-7"].effects,
        { type = "turret-attack", turret_id = item.name, modifier = 0.2 }
    )
end
