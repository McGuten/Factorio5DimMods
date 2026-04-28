function genHeatingTower(inputs)
    -- Copy heating-tower (type is reactor)
    local item = table.deepcopy(data.raw.item["heating-tower"])
    local recipe = table.deepcopy(data.raw.recipe["heating-tower"])
    local entity = table.deepcopy(data.raw["reactor"]["heating-tower"])
    -- Use a technology with unit field as base
    local tech = table.deepcopy(data.raw.technology["production-science-pack"])

    --Item
    if inputs.new then
        item.name = "5d-heating-tower-" .. inputs.number
    end
    item.icon = "__space-age__/graphics/icons/heating-tower.png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    if inputs.new then
        recipe.ingredients = inputs.ingredients
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.consumption = inputs.consumption .. "MW"
    entity.fast_replaceable_group = "heating-tower"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-heating-tower-" .. inputs.tech.number
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
        data:extend({ tech })
    end
end
