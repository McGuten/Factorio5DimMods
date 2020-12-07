function genSteamEngines(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["steam-engine"])
    local recipe = table.deepcopy(data.raw.recipe["steam-engine"])
    local entity = table.deepcopy(data.raw["generator"]["steam-engine"])
    local tech = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-steam-engine-" .. inputs.number
    end
    item.icon =
        "__5dim_energy__/graphics/icon/steam-engine/steam-engine-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
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
            recipe.expensive.enabled = false
        end
        recipe.expensive.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    --entity.effectivity = inputs.craftingSpeed
    entity.fluid_usage_per_tick = inputs.energyUsage

    -- Horizontal
    entity.horizontal_animation.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/steam-engine/steam-engine-H/steam-engine-H-" .. inputs.number .. ".png"
    -- Vertical
    entity.vertical_animation.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/steam-engine/steam-engine-V/steam-engine-V-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-steam-engine-" .. inputs.tech.number
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