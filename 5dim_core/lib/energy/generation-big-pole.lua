function genBigPoles(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["big-electric-pole"])
    local recipe = table.deepcopy(data.raw.recipe["big-electric-pole"])
    local entity = table.deepcopy(data.raw["electric-pole"]["big-electric-pole"])
    local tech = table.deepcopy(data.raw.technology["electric-energy-distribution-1"])

    --Item
    if inputs.new then
        item.name = "5d-big-electric-pole-" .. inputs.number
    end
    item.icon =
        "__5dim_energy__/graphics/icon/big-electric-pole/big-electric-pole-icon-" .. inputs.number .. ".png"
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
    entity.fast_replaceable_group = "big-electric-pole"
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.maximum_wire_distance = inputs.craftingSpeed
    entity.supply_area_distance = inputs.energyUsage

    -- Base
    entity.pictures.layers[1].filename =
        "__5dim_energy__/graphics/entities/big-electric-pole/big-electric-pole-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-big-electric-pole-" .. inputs.tech.number
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