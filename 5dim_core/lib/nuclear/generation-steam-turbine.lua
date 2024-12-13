function genSteamTurbines(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["steam-turbine"])
    local recipe = table.deepcopy(data.raw.recipe["steam-turbine"])
    local entity = table.deepcopy(data.raw["generator"]["steam-turbine"])
    local tech = table.deepcopy(data.raw.technology["nuclear-power"])

    --Item
    if inputs.new then
        item.name = "5d-steam-turbine-" .. inputs.number
    end
    item.icon =
        "__5dim_nuclear__/graphics/icon/steam-turbine/steam-turbine-icon-" .. inputs.number .. ".png"
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
    entity.effectivity = inputs.craftingSpeed
    entity.fluid_usage_per_tick = inputs.energyUsage
    entity.fast_replaceable_group = "steam-turbine"

    -- Base
    entity.horizontal_animation.layers[1].filename =
        "__5dim_nuclear__/graphics/entities/steam-turbine/steam-turbine-H/steam-turbine-H-" .. inputs.number .. ".png"
    entity.vertical_animation.layers[1].filename =
        "__5dim_nuclear__/graphics/entities/steam-turbine/steam-turbine-V/steam-turbine-V-" .. inputs.number .. ".png"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-steam-turbine-" .. inputs.tech.number
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
