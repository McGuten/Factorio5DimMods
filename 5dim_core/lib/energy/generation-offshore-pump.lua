function genOffshorePumps(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["offshore-pump"])
    local recipe = table.deepcopy(data.raw.recipe["offshore-pump"])
    local entity = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
    local tech = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-offshore-pump-" .. inputs.number
    end
    item.icon =
        "__5dim_energy__/graphics/icon/offshore-pump/offshore-pump-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
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
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.pumping_speed = inputs.craftingSpeed
    entity.fast_replaceable_group = "offshore-pump"

    -- North
    entity.graphics_set.animation.north.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/offshore-pump/north/offshore-pump-north-" .. inputs.number .. ".png"

    -- East
    entity.graphics_set.animation.east.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/offshore-pump/east/offshore-pump-east-" .. inputs.number .. ".png"

    -- South
    entity.graphics_set.animation.south.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/offshore-pump/south/offshore-pump-south-" .. inputs.number .. ".png"

    -- West
    entity.graphics_set.animation.west.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/offshore-pump/west/offshore-pump-west-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-offshore-pump-" .. inputs.tech.number
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
end
