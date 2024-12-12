function genMiningDrills(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["electric-mining-drill"])
    local recipe = table.deepcopy(data.raw.recipe["electric-mining-drill"])
    local entity = table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])
    local tech = table.deepcopy(data.raw.technology["advanced-material-processing"])

    --Item
    if inputs.new then
        item.name = "5d-electric-mining-drill-" .. inputs.number
    end
    item.icon =
        "__5dim_mining__/graphics/icon/electric-mining-drill/electric-mining-drill-icon-" .. inputs.number .. ".png"
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
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.mining_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution

    --North
    entity.graphics_set.animation.north.layers[1].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-N/electric-mining-drill-N-" ..
        inputs.number .. ".png"
    entity.wet_mining_graphics_set.animation.north.layers[1].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-N/electric-mining-drill-N-wet-" ..
        inputs.number .. ".png"

    --East
    entity.graphics_set.animation.east.layers[1].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E/electric-mining-drill-E-" ..
        inputs.number .. ".png"
    entity.graphics_set.working_visualisations[7].east_animation.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E/electric-mining-drill-E-front-" ..
        inputs.number .. ".png"
    entity.wet_mining_graphics_set.animation.east.layers[1].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E/electric-mining-drill-E-wet-" ..
        inputs.number .. ".png"
    entity.wet_mining_graphics_set.working_visualisations[13].east_animation.layers[1].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E/electric-mining-drill-E-wet-front-" ..
        inputs.number .. ".png"

    --South
    entity.graphics_set.working_visualisations[7].south_animation.layers[2].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-S/electric-mining-drill-S-front-" ..
        inputs.number .. ".png"
    entity.wet_mining_graphics_set.working_visualisations[13].south_animation.layers[2].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-S/electric-mining-drill-S-wet-front-" ..
        inputs.number .. ".png"

    --West
    entity.graphics_set.animation.west.layers[1].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W/electric-mining-drill-W-" ..
        inputs.number .. ".png"
    entity.graphics_set.working_visualisations[7].west_animation.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W/electric-mining-drill-W-front-" ..
        inputs.number .. ".png"
    entity.wet_mining_graphics_set.animation.west.layers[1].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W/electric-mining-drill-W-wet-" ..
        inputs.number .. ".png"
    entity.wet_mining_graphics_set.working_visualisations[13].west_animation.layers[1].filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W/electric-mining-drill-W-wet-front-" ..
        inputs.number .. ".png"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-mining-" .. inputs.tech.number
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
