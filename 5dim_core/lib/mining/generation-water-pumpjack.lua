function genWaterPumpjacks(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["pumpjack"])
    local recipe = table.deepcopy(data.raw.recipe["pumpjack"])
    local entity = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
    local tech = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-water-pumpjack-" .. inputs.number
    end
    item.icon = "__5dim_mining__/graphics/icon/water-pumpjack/water-pumpjack-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    recipe.enabled = false
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.pumping_speed = inputs.craftingSpeed
    entity.fast_replaceable_group = "water-pumpjack"

    entity.picture.north = {
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
    entity.picture.east = {
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
    entity.picture.south = {
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
    entity.picture.west = {
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
    entity.collision_mask = {"ground-tile"}
    entity.adjacent_tile_collision_mask = nil
    entity.adjacent_tile_collision_test = {"ground-tile"}
    entity.graphics_set = nil
    entity.water_reflection = nil
    entity.animation = nil
    entity.placeable_position_visualization = nil
    entity.collision_box = {{-1.2, -1.2}, {1.2, 1.2}}
    entity.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
    entity.collision_mask = {"water-tile", "object-layer", "player-layer", "item-layer"}
    entity.adjacent_tile_collision_test = {"ground-tile"}
    entity.adjacent_tile_collision_mask = nil
    entity.fluid_box.pipe_connections[1].position = {0, 2}
    circuit_wire_connection_points = circuit_connector_definitions["pumpjack"].points
    circuit_connector_sprites = circuit_connector_definitions["pumpjack"].sprites
    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-water-pumpjack-" .. inputs.tech.number
        tech.icon = "__5dim_mining__/graphics/technology/water-pumpjack-tech.png"
        tech.icon_size = 128
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
end
