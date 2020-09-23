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
    -- recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = true
    end
    if recipe.normal == nil then
        recipe.result = item.name
        if inputs.new then
            recipe.enabled = false
        end
        recipe.ingredients = inputs.ingredients
    else
        recipe.normal.result = item.name
        if inputs.new then
            recipe.normal.enabled = false
        end
        recipe.normal.ingredients = inputs.ingredients
        recipe.expensive.result = item.name
        if inputs.new then
            recipe.normal.enabled = false
        end
        recipe.expensive.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    -- entity.icon = item.icon
    entity.minable.result = item.name
    entity.effectivity = inputs.craftingSpeed
    entity.fluid_usage_per_tick = inputs.energyUsage
    entity.fast_replaceable_group = "steam-turbine"

    -- Base
    entity.horizontal_animation.layers[1].hr_version.filename =
        "__5dim_nuclear__/graphics/entities/steam-turbine/steam-turbine-H/steam-turbine-H-" .. inputs.number .. ".png"
    entity.vertical_animation.layers[1].hr_version.filename =
        "__5dim_nuclear__/graphics/entities/steam-turbine/steam-turbine-V/steam-turbine-V-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

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
        data:extend({tech})
    end
end