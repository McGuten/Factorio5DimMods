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

    entity.collision_mask = {layers={item=true, object=true, player=true, water_tile=true, elevated_rail=true, is_object=true, is_lower_object=true}}
    entity.tile_buildability_rules = nil

    -- North
    entity.graphics_set.animation.north.layers[1].filename =
        "__5dim_mining__/graphics/entities/offshore-pump/north/offshore-pump-north-" .. inputs.number .. ".png"

    -- East
    entity.graphics_set.animation.east.layers[1].filename =
        "__5dim_mining__/graphics/entities/offshore-pump/east/offshore-pump-east-" .. inputs.number .. ".png"

    -- South
    entity.graphics_set.animation.south.layers[1].filename =
        "__5dim_mining__/graphics/entities/offshore-pump/south/offshore-pump-south-" .. inputs.number .. ".png"

    -- West
    entity.graphics_set.animation.west.layers[1].filename =
        "__5dim_mining__/graphics/entities/offshore-pump/west/offshore-pump-west-" .. inputs.number .. ".png"
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
