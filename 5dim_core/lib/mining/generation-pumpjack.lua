function genPumpjacks(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["pumpjack"])
    local recipe = table.deepcopy(data.raw.recipe["pumpjack"])
    local entity = table.deepcopy(data.raw["mining-drill"]["pumpjack"])
    local tech = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-pumpjack-" .. inputs.number
    end
    item.icon =
        "__5dim_mining__/graphics/icon/pumpjack/pumpjack-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    recipe.enabled = false
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.mining_speed = inputs.craftingSpeed
    entity.module_specification.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution

    --Base
    entity.base_picture.sheets[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/pumpjack/pumpjack-base.png"

    -- Animation
    entity.animations.north.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/pumpjack/pumpjack-horsehead-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-pumpjack-" .. inputs.tech.number
        --tech.icon = "__base__/graphics/technology/mining-productivity.png"
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
