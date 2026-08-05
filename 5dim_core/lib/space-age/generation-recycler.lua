local applyTierArt = require("__5dim_core__.lib.space-age.tier-art")

function genRecycler(inputs)
    -- Copy recycler (type is furnace, from quality mod)
    local item = table.deepcopy(data.raw.item["recycler"])
    local recipe = table.deepcopy(data.raw.recipe["recycler"])
    local entity = table.deepcopy(data.raw["furnace"]["recycler"])
    -- Use a technology with unit field as base
    local tech = table.deepcopy(data.raw.technology["production-science-pack"])

    --Item
    if inputs.new then
        item.name = "5d-recycler-" .. inputs.number
    end
    item.icon = "__5dim_space_age__/graphics/icon/recycler/recycler-" .. string.format("%02d", inputs.number) .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new and inputs.recipeCategory then
        if inputs.recipeCategory then recipe.categories = { inputs.recipeCategory } end
    end
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
    entity.crafting_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution
    entity.fast_replaceable_group = "recycler"

    -- Overlay de recolor del tier sobre el arte vanilla. El tier 1 tambien lo
    -- lleva (amarillo), asi que va fuera del `if inputs.new`.
    applyTierArt(entity, "recycler", tonumber(inputs.number))

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-recycler-" .. inputs.tech.number
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
