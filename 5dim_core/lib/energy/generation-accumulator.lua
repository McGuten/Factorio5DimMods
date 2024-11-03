function genAccumulators(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["accumulator"])
    local recipe = table.deepcopy(data.raw.recipe["accumulator"])
    local entity = table.deepcopy(data.raw["accumulator"]["accumulator"])
    local tech = table.deepcopy(data.raw.technology["electric-energy-accumulators"])

    --Item
    if inputs.new then
        item.name = "5d-accumulator-" .. inputs.number
    end
    item.icon =
        "__5dim_energy__/graphics/icon/accumulator/accumulator-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
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
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.energy_source.buffer_capacity = inputs.craftingSpeed .. "MJ"
    entity.energy_source.input_flow_limit = inputs.energyUsage .. "kW"
    entity.energy_source.output_flow_limit = inputs.energyUsage .. "kW"
    entity.fast_replaceable_group = "accumulator"

    -- Base
    entity.chargable_graphics.picture.layers[1].filename =
        "__5dim_energy__/graphics/entities/accumulator/accumulator-" .. inputs.number .. ".png"
    -- Charge animation
    entity.chargable_graphics.charge_animation.layers[1].layers[1].filename =
        "__5dim_energy__/graphics/entities/accumulator/accumulator-" .. inputs.number .. ".png"
    -- Discharge animation
    entity.chargable_graphics.discharge_animation.layers[1].layers[1].filename =
        "__5dim_energy__/graphics/entities/accumulator/accumulator-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "electric-energy-accumulators-" .. inputs.tech.number
        --tech.icon = "__base__/graphics/technology/oil-refinery.png"
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
