function genCaptiveBiterSpawner(inputs)
    -- Copy captive-biter-spawner (type is assembling-machine)
    local item = table.deepcopy(data.raw.item["captive-biter-spawner"])
    local recipe = table.deepcopy(data.raw.recipe["captive-biter-spawner"])
    local entity = table.deepcopy(data.raw["assembling-machine"]["captive-biter-spawner"])
    -- Use a technology with unit field as base
    local tech = table.deepcopy(data.raw.technology["production-science-pack"])

    --Item
    if inputs.new then
        item.name = "5d-captive-biter-spawner-" .. inputs.number
    end
    item.icon = "__space-age__/graphics/icons/captive-biter-spawner.png"
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
    -- Original entity doesn't have minable, add it for our tiers
    entity.minable = { mining_time = 0.5, result = item.name }
    -- Remove flags that prevent deconstruction
    entity.flags = {"placeable-neutral", "placeable-player", "player-creation"}
    entity.crafting_speed = inputs.craftingSpeed
    entity.fast_replaceable_group = "captive-biter-spawner"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-captive-biter-spawner-" .. inputs.tech.number
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
