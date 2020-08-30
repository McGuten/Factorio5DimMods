function genOffshorePumps(inputs)
    -- Copy electric furnace
    local itemOffshorePump = table.deepcopy(data.raw.item["offshore-pump"])
    local recipeOffshorePump = table.deepcopy(data.raw.recipe["offshore-pump"])
    local entityOffshorePump = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
    local technologyOffshorePump = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        itemOffshorePump.name = "5d-offshore-pump-" .. inputs.number
    end
    itemOffshorePump.icon =
        "__5dim_energy__/graphics/icon/offshore-pump/offshore-pump-icon-" .. inputs.number .. ".png"
    itemOffshorePump.subgroup = inputs.subgroup
    itemOffshorePump.order = inputs.order
    itemOffshorePump.place_result = itemOffshorePump.name

    --Recipe
    recipeOffshorePump.name = itemOffshorePump.name
    recipeOffshorePump.icon = itemOffshorePump.icon
    recipeOffshorePump.result = itemOffshorePump.name
    recipeOffshorePump.icon_size = 64
    if inputs.new then
        recipeOffshorePump.enabled = false
    end
    recipeOffshorePump.ingredients = inputs.ingredients

    --Entity
    entityOffshorePump.name = itemOffshorePump.name
    entityOffshorePump.icon = itemOffshorePump.icon
    entityOffshorePump.minable.result = itemOffshorePump.name
    entityOffshorePump.pumping_speed = inputs.craftingSpeed

    -- North
    entityOffshorePump.graphics_set.animation.north.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/offshore-pump/north/offshore-pump-north-" .. inputs.number .. ".png"

    -- East
    entityOffshorePump.graphics_set.animation.east.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/offshore-pump/east/offshore-pump-east-" .. inputs.number .. ".png"

    -- South
    entityOffshorePump.graphics_set.animation.south.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/offshore-pump/south/offshore-pump-south-" .. inputs.number .. ".png"

    -- West
    entityOffshorePump.graphics_set.animation.west.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/offshore-pump/west/offshore-pump-west-" .. inputs.number .. ".png"

    data:extend({entityOffshorePump, recipeOffshorePump, itemOffshorePump})

    -- Technology
    if inputs.tech then
        technologyOffshorePump.name = "5d-offshore-pump-" .. inputs.tech.number
        technologyOffshorePump.icon = itemOffshorePump.icon
        technologyOffshorePump.icon_size = 64
        technologyOffshorePump.unit.count = inputs.tech.count
        technologyOffshorePump.unit.ingredients = inputs.tech.packs
        technologyOffshorePump.prerequisites = inputs.tech.prerequisites
        technologyOffshorePump.effects = {
            {
                type = "unlock-recipe",
                recipe = itemOffshorePump.name
            }
        }
        data:extend({technologyOffshorePump})
    end
end
