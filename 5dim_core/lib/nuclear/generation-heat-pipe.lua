function genHeatPipes(inputs)
    -- Copy electric furnace
    itemHeatPipe = table.deepcopy(data.raw.item["heat-pipe"])
    recipeHeatPipe = table.deepcopy(data.raw.recipe["heat-pipe"])
    entityHeatPipe = table.deepcopy(data.raw["heat-pipe"]["heat-pipe"])
    technologyHeatPipe = table.deepcopy(data.raw.technology["electric-energy-accumulators"])

    --Item
    if inputs.new then
        itemHeatPipe.name = "5d-heat-pipe-" .. inputs.number
    end
    -- itemHeatPipe.icon =
    --     "__5dim_energy__/graphics/icon/heat-pipe/heat-pipe-icon-" .. inputs.number .. ".png"
    itemHeatPipe.subgroup = inputs.subgroup
    itemHeatPipe.order = inputs.order
    itemHeatPipe.place_result = itemHeatPipe.name

    --Recipe
    recipeHeatPipe.name = itemHeatPipe.name
    -- recipeHeatPipe.icon = itemHeatPipe.icon
    recipeHeatPipe.result = itemHeatPipe.name
    recipeHeatPipe.icon_size = 64
    if inputs.new then
        recipeHeatPipe.enabled = true
    end

    --Entity
    entityHeatPipe.name = itemHeatPipe.name
    -- entityHeatPipe.icon = itemHeatPipe.icon
    entityHeatPipe.minable.result = itemHeatPipe.name
    entityHeatPipe.heat_buffer.max_temperature = inputs.craftingSpeed
    entityHeatPipe.heat_buffer.max_transfer = inputs.energyUsage .. "GW"

    -- Base
    -- entityHeatPipe.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/heat-pipe/heat-pipe-" .. inputs.number .. ".png"

    data:extend({entityHeatPipe, recipeHeatPipe, itemHeatPipe})

    -- Technology
    if inputs.tech then
        technologyHeatPipe.name = "5d-heat-pipe-" .. inputs.tech.number
        --technologyHeatPipe.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyHeatPipe.unit.count = inputs.tech.count
        technologyHeatPipe.unit.ingredients = inputs.tech.packs
        technologyHeatPipe.prerequisites = inputs.tech.prerequisites
        technologyHeatPipe.effects = {
            {
                type = "unlock-recipe",
                recipe = itemHeatPipe.name
            }
        }
        data:extend({technologyHeatPipe})
    end
end