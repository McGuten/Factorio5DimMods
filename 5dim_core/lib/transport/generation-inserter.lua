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
    item.icon = "__5dim_transport__/graphics/icon/inserter/inserter/inserter-icon-" .. inputs.number .. ".png"
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

    -- Platform
    entity.platform_picture.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-platform-" .. inputs.number .. ".png"

    -- Base hand
    entity.hand_base_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-hand-base.png"

    -- Hand open
    entity.hand_open_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-hand-open.png"

    -- Hand close
    entity.hand_closed_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-hand-closed.png"

    data:extend({entity, recipe, item})

    local copyName = "filter-inserter"
    local item = table.deepcopy(data.raw.item[copyName])
    local recipe = table.deepcopy(data.raw.recipe[copyName])
    local entity = table.deepcopy(data.raw["inserter"][copyName])

    --Item
    if inputs.number ~= "01" then
        item.name = "5d-filter-inserter-" .. inputs.number
    end
    item.icon = "__5dim_transport__/graphics/icon/inserter/filter-inserter/filter-inserter-icon-" .. inputs.number .. ".png"
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
    entity.fast_replaceable_group = "inserter"

    -- Platform
    entity.platform_picture.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-platform-" .. inputs.number .. ".png"

    -- Base hand
    entity.hand_base_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-hand-base.png"

    -- Hand open
    entity.hand_open_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/filter-inserter-hand-open.png"

    -- Hand close
    entity.hand_closed_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/filter-inserter-hand-closed.png"

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
    item.icon = "__5dim_transport__/graphics/icon/inserter/stack-inserter/stack-inserter-icon-" .. inputs.number .. ".png"
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
    entity.fast_replaceable_group = "inserter"

    -- Platform
    entity.platform_picture.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-platform-" .. inputs.number .. ".png"

    -- Base hand
    entity.hand_base_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/stack-inserter-hand-base.png"

    -- Hand open
    entity.hand_open_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-hand-open.png"
    entity.hand_open_picture.hr_version.width = 72
    entity.hand_open_picture.hr_version.height = 164

    -- Hand close
    entity.hand_closed_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-hand-closed.png"
    entity.hand_closed_picture.hr_version.width = 72
    entity.hand_closed_picture.hr_version.height = 164

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
    item.icon = "__5dim_transport__/graphics/icon/inserter/stack-filter-inserter/stack-filter-inserter-icon-" .. inputs.number .. ".png"
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
    entity.fast_replaceable_group = "inserter"

    -- Platform
    entity.platform_picture.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-platform-" .. inputs.number .. ".png"

    -- Base hand
    entity.hand_base_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/stack-inserter-hand-base.png"

    -- Hand open
    entity.hand_open_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/filter-inserter-hand-open.png"
    entity.hand_open_picture.hr_version.width = 72
    entity.hand_open_picture.hr_version.height = 164

    -- Hand close
    entity.hand_closed_picture.hr_version.filename =
        "__5dim_transport__/graphics/entities/inserter/filter-inserter-hand-closed.png"
    entity.hand_closed_picture.hr_version.width = 72
    entity.hand_closed_picture.hr_version.height = 164

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
