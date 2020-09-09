function genMiningDrills(inputs)
    -- Copy electric furnace
    local itemMiningDrill = table.deepcopy(data.raw.item["electric-mining-drill"])
    local recipeMiningDrill = table.deepcopy(data.raw.recipe["electric-mining-drill"])
    local entityMiningDrill = table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])
    local technologyMiningDrill = table.deepcopy(data.raw.technology["advanced-material-processing"])

    --Item
    if inputs.new then
        itemMiningDrill.name = "5d-electric-mining-drill-" .. inputs.number
    end
    itemMiningDrill.icon =
        "__5dim_mining__/graphics/icon/electric-mining-drill/electric-mining-drill-icon-" .. inputs.number .. ".png"
    itemMiningDrill.subgroup = inputs.subgroup
    itemMiningDrill.order = inputs.order
    itemMiningDrill.place_result = itemMiningDrill.name

    --Recipe
    recipeMiningDrill.name = itemMiningDrill.name
    recipeMiningDrill.icon = itemMiningDrill.icon
    recipeMiningDrill.icon_size = 64
    if recipeMiningDrill.normal == nil then
        recipeMiningDrill.result = itemMiningDrill.name
        if inputs.new then
            recipeMiningDrill.enabled = false
        end
        recipeMiningDrill.ingredients = inputs.ingredients
    else
        recipeMiningDrill.normal.result = itemMiningDrill.name
        if inputs.new then
            recipeMiningDrill.normal.enabled = false
        end
        recipeMiningDrill.normal.ingredients = inputs.ingredients
        recipeMiningDrill.expensive.result = itemMiningDrill.name
        if inputs.new then
            recipeMiningDrill.normal.enabled = false
        end
        recipeMiningDrill.expensive.ingredients = inputs.ingredients
    end

    --Entity
    entityMiningDrill.name = itemMiningDrill.name
    entityMiningDrill.icon = itemMiningDrill.icon
    entityMiningDrill.minable.result = itemMiningDrill.name
    entityMiningDrill.mining_speed = inputs.craftingSpeed
    entityMiningDrill.module_specification.module_slots = inputs.moduleSlots
    entityMiningDrill.energy_usage = inputs.energyUsage .. "kW"
    entityMiningDrill.energy_source.emissions_per_minute = inputs.pollution

    --North
    entityMiningDrill.graphics_set.animation.north.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-N/electric-mining-drill-N-" ..
        inputs.number .. ".png"
    entityMiningDrill.wet_mining_graphics_set.animation.north.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-N/electric-mining-drill-N-wet-" ..
        inputs.number .. ".png"

    --East
    entityMiningDrill.graphics_set.animation.east.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E/electric-mining-drill-E-" ..
        inputs.number .. ".png"
    entityMiningDrill.graphics_set.working_visualisations[7].east_animation.hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E/electric-mining-drill-E-front-" ..
        inputs.number .. ".png"
    entityMiningDrill.wet_mining_graphics_set.animation.east.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E/electric-mining-drill-E-wet-" ..
        inputs.number .. ".png"
    entityMiningDrill.wet_mining_graphics_set.working_visualisations[13].east_animation.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E/electric-mining-drill-E-wet-front-" ..
        inputs.number .. ".png"

    --South
    entityMiningDrill.graphics_set.working_visualisations[7].south_animation.layers[2].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-S/electric-mining-drill-S-front-" ..
        inputs.number .. ".png"
    entityMiningDrill.wet_mining_graphics_set.working_visualisations[13].south_animation.layers[2].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-S/electric-mining-drill-S-wet-front-" ..
        inputs.number .. ".png"

    --West
    entityMiningDrill.graphics_set.animation.west.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W/electric-mining-drill-W-" ..
        inputs.number .. ".png"
    entityMiningDrill.graphics_set.working_visualisations[7].west_animation.hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W/electric-mining-drill-W-front-" ..
        inputs.number .. ".png"
    entityMiningDrill.wet_mining_graphics_set.animation.west.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W/electric-mining-drill-W-wet-" ..
        inputs.number .. ".png"
    entityMiningDrill.wet_mining_graphics_set.working_visualisations[13].west_animation.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W/electric-mining-drill-W-wet-front-" ..
        inputs.number .. ".png"

    data:extend({entityMiningDrill, recipeMiningDrill, itemMiningDrill})

    -- Technology
    if inputs.tech then
        technologyMiningDrill.name = "5d-mining-" .. inputs.tech.number
        technologyMiningDrill.icon = itemMiningDrill.icon
        technologyMiningDrill.icon_size = 64
        technologyMiningDrill.unit.count = inputs.tech.count
        technologyMiningDrill.unit.ingredients = inputs.tech.packs
        technologyMiningDrill.prerequisites = inputs.tech.prerequisites
        technologyMiningDrill.effects = {
            {
                type = "unlock-recipe",
                recipe = itemMiningDrill.name
            }
        }
        data:extend({technologyMiningDrill})
    end
end