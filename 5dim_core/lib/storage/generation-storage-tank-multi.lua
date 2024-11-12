function genStorageTankMultis(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["storage-tank"])
    local recipe = table.deepcopy(data.raw.recipe["storage-tank"])
    local entity = table.deepcopy(data.raw["storage-tank"]["storage-tank"])
    local tech = table.deepcopy(data.raw.technology["fluid-handling"])

    --Item
    item.name = "5d-storage-tank-multi-" .. inputs.number
    item.icon = "__5dim_storage__/graphics/icon/storage-tank-multi/storage-tank-multi-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.fluid_box.volume = inputs.capacity
    entity.pictures.picture.sheets[1].filename =
        "__5dim_storage__/graphics/entities/storage-tank-multi/storage-tank-multi-" .. inputs.number .. ".png"

    entity.fluid_box.pipe_connections = {
        { direction = defines.direction.north, position = { -1, -1 } },
        { direction = defines.direction.north, position = { 1, -1 } },

        { direction = defines.direction.south, position = { -1, 1 } },
        { direction = defines.direction.south, position = { 1, 1 } },

        { direction = defines.direction.west,  position = { -1, -1 } },
        { direction = defines.direction.west,  position = { -1, 1 } },

        { direction = defines.direction.east,  position = { 1, 1 } },
        { direction = defines.direction.east,  position = { 1, -1 } }
    }

    data:extend(
        {
            entity,
            recipe,
            item
        }
    )

    if inputs.tech then
        -- Technology
        tech.name = "5d-storage-tank-multi-" .. inputs.tech.number
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
        data:extend(
            {
                tech
            }
        )
    end
end
