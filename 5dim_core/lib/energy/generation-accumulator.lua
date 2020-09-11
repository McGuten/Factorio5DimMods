function genAccumulators(inputs)
    -- Copy electric furnace
    local itemAccumulator = table.deepcopy(data.raw.item["accumulator"])
    local recipeAccumulator = table.deepcopy(data.raw.recipe["accumulator"])
    local entityAccumulator = table.deepcopy(data.raw["accumulator"]["accumulator"])
    local technologyAccumulator = table.deepcopy(data.raw.technology["electric-energy-accumulators"])

    --Item
    if inputs.new then
        itemAccumulator.name = "5d-accumulator-" .. inputs.number
    end
    itemAccumulator.icon =
        "__5dim_energy__/graphics/icon/accumulator/accumulator-icon-" .. inputs.number .. ".png"
    itemAccumulator.subgroup = inputs.subgroup
    itemAccumulator.order = inputs.order
    itemAccumulator.place_result = itemAccumulator.name

    --Recipe
    recipeAccumulator.name = itemAccumulator.name
    -- recipeAccumulator.icon = itemAccumulator.icon
    recipeAccumulator.result = itemAccumulator.name
    recipeAccumulator.icon_size = 64
    if inputs.new then
        recipeAccumulator.enabled = false
    end
    recipeAccumulator.ingredients = inputs.ingredients

    --Entity
    entityAccumulator.name = itemAccumulator.name
    -- entityAccumulator.icon = itemAccumulator.icon
    entityAccumulator.minable.result = itemAccumulator.name
    entityAccumulator.energy_source.buffer_capacity = inputs.craftingSpeed .. "MJ"
    entityAccumulator.energy_source.input_flow_limit = inputs.energyUsage .. "kW"
    entityAccumulator.energy_source.output_flow_limit = inputs.energyUsage .. "kW"
    entityAccumulator.fast_replaceable_group = "accumulator"

    -- Base
    entityAccumulator.picture.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/accumulator/accumulator-" .. inputs.number .. ".png"
    -- Charge animation
    entityAccumulator.charge_animation.layers[1].layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/accumulator/accumulator-" .. inputs.number .. ".png"
    -- Discharge animation
    entityAccumulator.discharge_animation.layers[1].layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/accumulator/accumulator-" .. inputs.number .. ".png"

    data:extend({entityAccumulator, recipeAccumulator, itemAccumulator})

    -- Technology
    if inputs.tech then
        technologyAccumulator.name = "electric-energy-accumulators-" .. inputs.tech.number
        --technologyAccumulator.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyAccumulator.unit.count = inputs.tech.count
        technologyAccumulator.unit.ingredients = inputs.tech.packs
        technologyAccumulator.prerequisites = inputs.tech.prerequisites
        technologyAccumulator.effects = {
            {
                type = "unlock-recipe",
                recipe = itemAccumulator.name
            }
        }
        data:extend({technologyAccumulator})
    end
end
