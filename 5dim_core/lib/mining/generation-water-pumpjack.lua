function genWaterPumpjacks(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["pumpjack"])
    local recipe = table.deepcopy(data.raw.recipe["pumpjack"])
    local entity = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
    local tech = table.deepcopy(data.raw.technology["advanced-oil-processing"])

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
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
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

    entity.collision_mask = { layers = { item = true, object = true, player = true, water_tile = true, elevated_rail = true, is_object = true, is_lower_object = true } }
    entity.tile_buildability_rules = nil
    entity.adjacent_tile_collision_test = { "ground-tile" }
    entity.fluid_box.filter = "water"
    -- entity.fluid_box.pipe_connections[1].positions = {{1.5, -1.5}, {1.5, -1.5}, {-1.5, 1.5}, {-1.5, 1.5}}
    entity.fluid_box.pipe_connections = {
        {
            direction = defines.direction.north,
            positions = { { 1, -1 }, { 1, -1 }, { -1, 1 }, { -1, 1 } },
            flow_direction = "output"
        }
    }
    entity.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
    entity.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
    entity.drawing_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

    -- North
    -- entity.graphics_set.animation.north.layers[1].filename =
    --     "__5dim_mining__/graphics/entities/water-pumpjack/water-pumpjack-horsehead-" .. inputs.number .. ".png"

    -- -- East
    -- entity.graphics_set.animation.east.layers[1].filename =
    --     "__5dim_mining__/graphics/entities/water-pumpjack/water-pumpjack-horsehead-" .. inputs.number .. ".png"

    -- -- South
    -- entity.graphics_set.animation.south.layers[1].filename =
    --     "__5dim_mining__/graphics/entities/water-pumpjack/water-pumpjack-horsehead-" .. inputs.number .. ".png"

    -- -- West
    -- entity.graphics_set.animation.west.layers[1].filename =
    --     "__5dim_mining__/graphics/entities/water-pumpjack/water-pumpjack-horsehead-" .. inputs.number .. ".png"

    entity.graphics_set.animation.north = {
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

    entity.graphics_set.animation.east = {
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

    entity.graphics_set.animation.south = {
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

    entity.graphics_set.animation.west = {
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

    data:extend({ entity, recipe, item })

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
        data:extend({ tech })
    end
end
