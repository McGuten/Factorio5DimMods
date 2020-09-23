function genHeatPipes(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["heat-pipe"])
    local recipe = table.deepcopy(data.raw.recipe["heat-pipe"])
    local entity = table.deepcopy(data.raw["heat-pipe"]["heat-pipe"])
    local tech = table.deepcopy(data.raw.technology["nuclear-power"])

    --Item
    if inputs.new then
        item.name = "5d-heat-pipe-" .. inputs.number
    end
    -- item.icon =
    --     "__5dim_energy__/graphics/icon/heat-pipe/heat-pipe-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    -- recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    -- entity.icon = item.icon
    entity.minable.result = item.name
    entity.heat_buffer.max_temperature = inputs.craftingSpeed
    entity.heat_buffer.max_transfer = inputs.energyUsage .. "GW"
    entity.fast_replaceable_group = "heat-pipe"

    -- Base
    -- entity.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/heat-pipe/heat-pipe-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-heat-pipe-" .. inputs.tech.number
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