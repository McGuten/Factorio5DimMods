function genNuclearReactors(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["nuclear-reactor"])
    local recipe = table.deepcopy(data.raw.recipe["nuclear-reactor"])
    local entity = table.deepcopy(data.raw["reactor"]["nuclear-reactor"])
    local tech = table.deepcopy(data.raw.technology["nuclear-power"])

    --Item
    if inputs.new then
        item.name = "5d-nuclear-reactor-" .. inputs.number
    end
    item.icon =
        "__5dim_nuclear__/graphics/icon/nuclear-reactor/nuclear-reactor-icon-" .. inputs.number .. ".png"
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
    entity.energy_source.effectivity = inputs.craftingSpeed
    entity.consumption = inputs.energyUsage .. "MW"
    -- entity.heat_buffer.specific_heat = inputs.pollution .. "MJ"
    -- entity.heat_buffer.max_transfer = inputs.pollution .. "MW"
    entity.fast_replaceable_group = "nuclear-reactor"

    -- Base
    entity.picture.layers[1].filename =
        "__5dim_nuclear__/graphics/entities/nuclear-reactor/reactor-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-nuclear-reactor-" .. inputs.tech.number
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