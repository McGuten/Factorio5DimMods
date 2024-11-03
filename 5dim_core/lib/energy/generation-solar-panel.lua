function genSolarPanels(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["solar-panel"])
    local recipe = table.deepcopy(data.raw.recipe["solar-panel"])
    local entity = table.deepcopy(data.raw["solar-panel"]["solar-panel"])
    local tech = table.deepcopy(data.raw.technology["solar-energy"])

    --Item
    if inputs.new then
        item.name = "5d-solar-panel-" .. inputs.number
    end
    item.icon =
        "__5dim_energy__/graphics/icon/solar-panel/solar-panel-icon-" .. inputs.number .. ".png"
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
    entity.production = inputs.craftingSpeed .. "kW"
    entity.fast_replaceable_group = "solar-panel"

    -- North
    entity.picture.layers[1].filename =
        "__5dim_energy__/graphics/entities/solar-panel/solar-panel-" .. inputs.number .. ".png"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "solar-energy-" .. inputs.tech.number
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
        data:extend({ tech })
    end
end
