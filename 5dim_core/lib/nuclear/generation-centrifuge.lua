function genCentrifuges(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["centrifuge"])
    local recipe = table.deepcopy(data.raw.recipe["centrifuge"])
    local entity = table.deepcopy(data.raw["assembling-machine"]["centrifuge"])
    local tech = table.deepcopy(data.raw.technology["advanced-oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-centrifuge-" .. inputs.number
    end
    item.icon =
        "__5dim_nuclear__/graphics/icon/centrifuge/centrifuge-icon-" .. inputs.number .. ".png"
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
    entity.crafting_speed = inputs.craftingSpeed
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution
    entity.module_slots = inputs.moduleSlots
    entity.fast_replaceable_group = "centrifuge"

    -- Base
    entity.graphics_set.idle_animation.layers[1].filename =
        "__5dim_nuclear__/graphics/entities/centrifuge/centrifuge-C-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-centrifuge-" .. inputs.tech.number
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