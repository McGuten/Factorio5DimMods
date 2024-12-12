function genHeatExchangers(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["heat-exchanger"])
    local recipe = table.deepcopy(data.raw.recipe["heat-exchanger"])
    local entity = table.deepcopy(data.raw["boiler"]["heat-exchanger"])
    local tech = table.deepcopy(data.raw.technology["nuclear-power"])

    --Item
    if inputs.new then
        item.name = "5d-heat-exchanger-" .. inputs.number
    end
    item.icon =
        "__5dim_nuclear__/graphics/icon/heat-exchanger/heatex-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.energy_consumption = inputs.energyUsage .. "MW"
    entity.energy_source.max_temperature = inputs.pollution
    entity.energy_source.max_transfer = inputs.craftingSpeed .. "GW"
    entity.fast_replaceable_group = "heat-exchanger"

    -- North
    entity.pictures.north.structure.layers[1].filename =
        "__5dim_nuclear__/graphics/entities/heat-exchanger/heatex-N-idle/heatex-N-idle-" .. inputs.number .. ".png"
    -- East
    entity.pictures.east.structure.layers[1].filename =
        "__5dim_nuclear__/graphics/entities/heat-exchanger/heatex-E-idle/heatex-E-idle-" .. inputs.number .. ".png"
    -- South
    entity.pictures.south.structure.layers[1].filename =
        "__5dim_nuclear__/graphics/entities/heat-exchanger/heatex-S-idle/heatex-S-idle-" .. inputs.number .. ".png"
    -- West
    entity.pictures.west.structure.layers[1].filename =
        "__5dim_nuclear__/graphics/entities/heat-exchanger/heatex-W-idle/heatex-W-idle-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-heat-exchanger-" .. inputs.tech.number
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