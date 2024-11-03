function genLamps(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["small-lamp"])
    local recipe = table.deepcopy(data.raw.recipe["small-lamp"])
    local entity = table.deepcopy(data.raw["lamp"]["small-lamp"])
    local tech = table.deepcopy(data.raw.technology["lamp"])

    --Item
    if inputs.new then
        item.name = "5d-lamp-" .. inputs.number
    end
    item.icon = "__5dim_energy__/graphics/icon/lamp/lamp-icon-" .. inputs.number .. ".png"
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
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.light.size = inputs.lightSize
    entity.fast_replaceable_group = "lamp"

    -- Base
    entity.picture_off.layers[1].filename =
        "__5dim_energy__/graphics/entities/lamp/lamp-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "lamp-" .. inputs.tech.number
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
