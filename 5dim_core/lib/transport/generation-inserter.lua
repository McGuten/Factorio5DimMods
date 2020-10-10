function genInserters(inputs)
    -- Copy electric furnace
    local copyName = inputs.copyName
    local item = table.deepcopy(data.raw.item[copyName])
    local recipe = table.deepcopy(data.raw.recipe[copyName])
    local entity = table.deepcopy(data.raw["inserter"][copyName])

    --Item
    if inputs.new then
        item.name = "5d-inserter-" .. inputs.number
    end
    -- item.icon = "__5dim_automatization__/graphics/icon/inserter/inserter-icon-" .. inputs.number .. ".png"
    item.subgroup = "transport-inserter"
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    recipe.ingredients = inputs.ingredients.inserter

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate.inserter or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.extension_speed = inputs.extensionSpeed
    entity.rotation_speed = inputs.rotationSpeed
    entity.energy_per_movement = inputs.energyMovement .. "KJ"
    entity.energy_per_rotation = inputs.energyRotation .. "KJ"
    entity.pickup_position = {0, -1}
    entity.insert_position = {0, 1.2}
    entity.energy_source.drain = inputs.energyDrain .. "kW"
    entity.fast_replaceable_group = "inserter"

    -- Base
    -- entity.animation.layers[1].hr_version.filename =
    --     "__5dim_automatization__/graphics/entities/inserter/inserter-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    local copyName = "filter-inserter"
    local item = table.deepcopy(data.raw.item[copyName])
    local recipe = table.deepcopy(data.raw.recipe[copyName])
    local entity = table.deepcopy(data.raw["inserter"][copyName])

    --Item
    if inputs.number ~= "01" then
        item.name = "5d-filter-inserter-" .. inputs.number
    end
    -- item.icon = "__5dim_automatization__/graphics/icon/filter-inserter/filter-inserter-icon-" .. inputs.number .. ".png"
    item.subgroup = "transport-filter-inserter"
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    recipe.ingredients = inputs.ingredients.filterInserter

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate.filterInserter or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.extension_speed = inputs.extensionSpeed
    entity.rotation_speed = inputs.rotationSpeed
    entity.energy_per_movement = inputs.energyMovement + 1 .. "kW"
    entity.energy_per_rotation = inputs.energyRotation + 1 .. "kW"
    entity.pickup_position = {0, -1}
    entity.insert_position = {0, 1.2}
    entity.energy_source.drain = inputs.energyDrain .. "kW"
    entity.fast_replaceable_group = "filter-inserter"

    -- Base
    -- entity.animation.layers[1].hr_version.filename =
    --     "__5dim_automatization__/graphics/entities/filter-inserter/filter-inserter-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    local copyName = "stack-inserter"
    local item = table.deepcopy(data.raw.item[copyName])
    local recipe = table.deepcopy(data.raw.recipe[copyName])
    local entity = table.deepcopy(data.raw["inserter"][copyName])
    local tech = table.deepcopy(data.raw.technology["stack-inserter"])

    --Item
    if inputs.number ~= "01" then
        item.name = "5d-stack-inserter-" .. inputs.number
    end
    local stackInserter = item.name
    -- item.icon = "__5dim_automatization__/graphics/icon/stack-inserter/stack-inserter-icon-" .. inputs.number .. ".png"
    item.subgroup = "transport-stack-inserter"
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    recipe.ingredients = inputs.ingredients.stackInserter

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate.stackInserter or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.extension_speed = inputs.extensionSpeed
    entity.rotation_speed = inputs.rotationSpeed
    entity.energy_per_movement = inputs.energyMovement * 4 .. "kW"
    entity.energy_per_rotation = inputs.energyRotation * 4 .. "kW"
    entity.pickup_position = {0, -1}
    entity.insert_position = {0, 1.2}
    entity.energy_source.drain = inputs.energyDrain .. "kW"
    entity.fast_replaceable_group = "stack-inserter"

    -- Base
    -- entity.animation.layers[1].hr_version.filename =
    --     "__5dim_automatization__/graphics/entities/stack-inserter/stack-inserter-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    local copyName = "stack-filter-inserter"
    local item = table.deepcopy(data.raw.item[copyName])
    local recipe = table.deepcopy(data.raw.recipe[copyName])
    local entity = table.deepcopy(data.raw["inserter"][copyName])

    --Item
    if inputs.number ~= "01" then
        item.name = "5d-stack-filter-inserter-" .. inputs.number
    end
    local stackFilterInserter = item.name
    -- item.icon = "__5dim_automatization__/graphics/icon/stack-filter-inserter/stack-filter-inserter-icon-" .. inputs.number .. ".png"
    item.subgroup = "transport-stack-filter-inserter"
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    recipe.ingredients = inputs.ingredients.stackFilterInserter

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate.stackFilterInserter or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.extension_speed = inputs.extensionSpeed
    entity.rotation_speed = inputs.rotationSpeed
    entity.energy_per_movement = inputs.energyMovement * 4 .. "kW"
    entity.energy_per_rotation = inputs.energyRotation * 4 .. "kW"
    entity.pickup_position = {0, -1}
    entity.insert_position = {0, 1.2}
    entity.energy_source.drain = inputs.energyDrain .. "kW"
    entity.fast_replaceable_group = "stack-filter-inserter"

    -- Base
    -- entity.animation.layers[1].hr_version.filename =
    --     "__5dim_automatization__/graphics/entities/stack-filter-inserter/stack-filter-inserter-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "stack-inserter-" .. inputs.tech.number
        -- tech.icon = itemTransportBelt.icon
        -- tech.icon_size = 64
        tech.unit.count = inputs.tech.count
        tech.unit.ingredients = inputs.tech.packs
        tech.prerequisites = inputs.tech.prerequisites
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = stackInserter
            },
            {
                type = "unlock-recipe",
                recipe = stackFilterInserter
            }
        }
        data:extend({tech})
    end
end
