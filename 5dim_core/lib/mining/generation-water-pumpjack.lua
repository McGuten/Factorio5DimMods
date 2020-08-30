function genWaterPumpjacks(inputs)
    -- Copy electric furnace
    local itemWaterPumpjack = table.deepcopy(data.raw.item["pumpjack"])
    local recipeWaterPumpjack = table.deepcopy(data.raw.recipe["pumpjack"])
    local entityWaterPumpjack = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
    local technologyWaterPumpjack = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        itemWaterPumpjack.name = "5d-water-pumpjack-" .. inputs.number
    end
    itemWaterPumpjack.icon =
        "__5dim_mining__/graphics/icon/water-pumpjack/water-pumpjack-icon-" .. inputs.number .. ".png"
    itemWaterPumpjack.subgroup = inputs.subgroup
    itemWaterPumpjack.order = inputs.order
    itemWaterPumpjack.place_result = itemWaterPumpjack.name

    --Recipe
    recipeWaterPumpjack.name = itemWaterPumpjack.name
    recipeWaterPumpjack.icon = itemWaterPumpjack.icon
    recipeWaterPumpjack.result = itemWaterPumpjack.name
    recipeWaterPumpjack.icon_size = 64
    recipeWaterPumpjack.enabled = false
    recipeWaterPumpjack.ingredients = inputs.ingredients

    --Entity
    entityWaterPumpjack.name = itemWaterPumpjack.name
    entityWaterPumpjack.icon = itemWaterPumpjack.icon
    entityWaterPumpjack.minable.result = itemWaterPumpjack.name
    entityWaterPumpjack.pumping_speed = inputs.craftingSpeed

    entityWaterPumpjack.picture.north = {
        priority = "high",
        filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead.png",
        line_length = 8,
        width = 104,
        height = 102,
        frame_count = 40,
        shift = util.by_pixel(-4, -24),
        animation_speed = 0.5,
        hr_version = {
            priority = "high",
            filename = "__5dim_mining__/graphics/entities/water-pumpjack/water-pumpjack-horsehead-" ..
                inputs.number .. ".png",
            animation_speed = 0.5,
            scale = 0.5,
            line_length = 8,
            width = 206,
            height = 202,
            frame_count = 40,
            shift = util.by_pixel(-4, -24)
        }
    }
    entityWaterPumpjack.picture.east = {
        priority = "high",
        filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead.png",
        line_length = 8,
        width = 104,
        height = 102,
        frame_count = 40,
        shift = util.by_pixel(-4, -24),
        animation_speed = 0.5,
        hr_version = {
            priority = "high",
            filename = "__5dim_mining__/graphics/entities/water-pumpjack/water-pumpjack-horsehead-" ..
                inputs.number .. ".png",
            animation_speed = 0.5,
            scale = 0.5,
            line_length = 8,
            width = 206,
            height = 202,
            frame_count = 40,
            shift = util.by_pixel(-4, -24)
        }
    }
    entityWaterPumpjack.picture.south = {
        priority = "high",
        filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead.png",
        line_length = 8,
        width = 104,
        height = 102,
        frame_count = 40,
        shift = util.by_pixel(-4, -24),
        animation_speed = 0.5,
        hr_version = {
            priority = "high",
            filename = "__5dim_mining__/graphics/entities/water-pumpjack/water-pumpjack-horsehead-" ..
                inputs.number .. ".png",
            animation_speed = 0.5,
            scale = 0.5,
            line_length = 8,
            width = 206,
            height = 202,
            frame_count = 40,
            shift = util.by_pixel(-4, -24)
        }
    }
    entityWaterPumpjack.picture.west = {
        priority = "high",
        filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead.png",
        line_length = 8,
        width = 104,
        height = 102,
        frame_count = 40,
        shift = util.by_pixel(-4, -24),
        animation_speed = 0.5,
        hr_version = {
            priority = "high",
            filename = "__5dim_mining__/graphics/entities/water-pumpjack/water-pumpjack-horsehead-" ..
                inputs.number .. ".png",
            animation_speed = 0.5,
            scale = 0.5,
            line_length = 8,
            width = 206,
            height = 202,
            frame_count = 40,
            shift = util.by_pixel(-4, -24)
        }
    }
    entityWaterPumpjack.collision_mask = {"ground-tile"}
    entityWaterPumpjack.adjacent_tile_collision_mask = nil
    entityWaterPumpjack.adjacent_tile_collision_test = {"ground-tile"}
    entityWaterPumpjack.graphics_set = nil
    entityWaterPumpjack.water_reflection = nil
    entityWaterPumpjack.animation = nil
    entityWaterPumpjack.placeable_position_visualization = nil
    entityWaterPumpjack.collision_box = {{-1.2, -1.2}, {1.2, 1.2}}
    entityWaterPumpjack.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
    entityWaterPumpjack.collision_mask = {"water-tile", "object-layer", "player-layer", "item-layer"}
    entityWaterPumpjack.adjacent_tile_collision_test = {"ground-tile"}
    entityWaterPumpjack.adjacent_tile_collision_mask = nil
    entityWaterPumpjack.fluid_box.pipe_connections[1].position = {0, 2}
    circuit_wire_connection_points = circuit_connector_definitions["pumpjack"].points
    circuit_connector_sprites = circuit_connector_definitions["pumpjack"].sprites
    data:extend({entityWaterPumpjack, recipeWaterPumpjack, itemWaterPumpjack})

    -- Technology
    if inputs.tech then
        technologyWaterPumpjack.name = "5d-water-pumpjack-" .. inputs.tech.number
        technologyWaterPumpjack.icon = "__5dim_mining__/graphics/technology/water-pumpjack-tech.png"
        technologyWaterPumpjack.unit.count = inputs.tech.count
        technologyWaterPumpjack.unit.ingredients = inputs.tech.packs
        technologyWaterPumpjack.prerequisites = inputs.tech.prerequisites
        technologyWaterPumpjack.effects = {
            {
                type = "unlock-recipe",
                recipe = itemWaterPumpjack.name
            }
        }
        data:extend({technologyWaterPumpjack})
    end
end
