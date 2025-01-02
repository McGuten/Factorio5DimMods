function genBeacons(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["beacon"])
    local recipe = table.deepcopy(data.raw.recipe["beacon"])
    local entity = table.deepcopy(data.raw["beacon"]["beacon"])
    local tech = table.deepcopy(data.raw.technology["effect-transmission"])

    --Item
    if inputs.new then
        item.name = "5d-beacon-" .. inputs.number
    end
    item.icon = "__5dim_module__/graphics/icons/beacon/beacon-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    if mods['space-age'] then
        recipe.category = "electronics"
    end
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.fast_replaceable_group = "beacon"
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.supply_area_distance = inputs.area or 3
    entity.distribution_effectivity = inputs.efficiency or 1.5
    entity.module_slots = inputs.moduleSlots or 2
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.graphics_set.animation_list[1].animation.layers[1].filename =
        "__5dim_module__/graphics/entities/beacon/beacon-bottom-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "effect-transmission-" .. inputs.tech.number
        -- tech.icon = item.icon
        -- tech.icon_size = 64
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
