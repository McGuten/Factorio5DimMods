function genStackInserters(inputs)
    local item = table.deepcopy(data.raw.item[inputs.copyName])
    local recipe = table.deepcopy(data.raw.recipe[inputs.copyName])
    local entity = table.deepcopy(data.raw["inserter"][inputs.copyName])
    local tech = table.deepcopy(data.raw.technology["stack-inserter"])

    --Item
    if inputs.number ~= "01" then
        item.name = "5d-stack-inserter-" .. inputs.number
    end
    local stackInserter = item.name
    item.icon = "__5dim_transport__/graphics/icon/inserter/stack-filter-inserter/stack-filter-inserter-icon-" ..
        inputs.number .. ".png"
    item.subgroup = "transport-stack-inserter"
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.extension_speed = inputs.extensionSpeed
    entity.rotation_speed = inputs.rotationSpeed
    entity.energy_per_movement = inputs.energyMovement * 4 .. "kJ"
    entity.energy_per_rotation = inputs.energyRotation * 4 .. "kJ"
    entity.pickup_position = { 0, -1 }
    entity.insert_position = { 0, 1.2 }
    entity.energy_source.drain = inputs.energyDrain .. "kW"
    entity.fast_replaceable_group = "inserter"

    -- Platform
    entity.platform_picture.sheet.filename =
        "__5dim_transport__/graphics/entities/inserter/inserter-platform-" .. inputs.number .. ".png"

    -- Base hand
    -- entity.hand_base_picture.filename =
    -- "__5dim_transport__/graphics/entities/inserter/stack-inserter-hand-base.png"

    -- Hand open
    entity.hand_open_picture.filename =
    "__5dim_transport__/graphics/entities/inserter/filter-inserter-hand-open.png"
    entity.hand_open_picture.width = 72
    entity.hand_open_picture.height = 164

    -- Hand close
    entity.hand_closed_picture.filename =
    "__5dim_transport__/graphics/entities/inserter/filter-inserter-hand-closed.png"
    entity.hand_closed_picture.width = 72
    entity.hand_closed_picture.height = 164

    data:extend({ entity, recipe, item })

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
        }
        data:extend({ tech })
    end
end
