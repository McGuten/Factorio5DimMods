function genPumpjacks(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["pumpjack"])
    local recipe = table.deepcopy(data.raw.recipe["pumpjack"])
    local entity = table.deepcopy(data.raw["mining-drill"]["pumpjack"])
    local tech = table.deepcopy(data.raw.technology["advanced-oil-processing"])
    local pumpjackIcon = "__5dim_mining__/graphics/icon/pumpjack/pumpjack-icon-" .. inputs.number .. ".png"

    --Item
    if inputs.new then
        item.name = "5d-pumpjack-" .. inputs.number
    end
    item.icon = pumpjackIcon
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
    if inputs.recipeCategory then recipe.categories = { inputs.recipeCategory } end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.mining_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution

    --Base (Factorio 2.x moved the pumpjack base from base_picture into
    -- graphics_set.working_visualisations; the flipped set keeps the vanilla
    -- base because the mod has no recolor of pumpjack-base-flipped.png)
    for _, vis in pairs(entity.graphics_set.working_visualisations or {}) do
        for _, dir in pairs({ "north_animation", "east_animation", "south_animation", "west_animation" }) do
            local layers = vis[dir] and vis[dir].layers
            if layers and layers[1].filename == "__base__/graphics/entity/pumpjack/pumpjack-base.png" then
                layers[1].filename = "__5dim_mining__/graphics/entities/pumpjack/pumpjack-base.png"
            end
        end
    end

    -- Animation (5dim sheets are 1.1-era art: 1648x1010, frames 206x202; vanilla 2.0 is 206x172)
    local horsehead = "__5dim_mining__/graphics/entities/pumpjack/pumpjack-horsehead-" .. inputs.number .. ".png"
    for _, gs in pairs({ entity.graphics_set, entity.graphics_set_flipped }) do
        local layer = gs.animation.north.layers[1]
        layer.filename = horsehead
        layer.height = 202
        layer.shift = util.by_pixel(-4, -24)
    end

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-pumpjack-" .. inputs.tech.number
        tech.icon = pumpjackIcon
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
