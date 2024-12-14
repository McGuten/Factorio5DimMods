function genMasher(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["electric-furnace"])
    local recipe = table.deepcopy(data.raw.recipe["electric-furnace"])
    local entity = table.deepcopy(data.raw["furnace"]["electric-furnace"])
    local tech = table.deepcopy(data.raw.technology["advanced-material-processing"])

    --Item
    item.name = "5d-masher-" .. inputs.number
    item.icon = "__5dim_resources__/graphics/icon/masher/masher-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.crafting_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.graphics_set.animation.layers[1].filename =
        "__5dim_resources__/graphics/entities/masher/masher-" .. inputs.number .. ".png"
    entity.graphics_set.animation.layers[1].width = 160
    entity.graphics_set.animation.layers[1].height = 160
    entity.graphics_set.animation.layers[1].shift = {0, -0.421875}
    entity.graphics_set.animation.layers[1].scale = 1
    entity.crafting_categories = {"mashering"}
    entity.energy_source.emissions_per_minute = inputs.pollution
    entity.fast_replaceable_group = "5d-masher"

    data:extend({entity, recipe, item})

    if inputs.tech then
        -- Technology
        tech.name = "5d-masher-" .. inputs.tech.number
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
