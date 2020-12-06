function genChemicalPlants(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["chemical-plant"])
    local recipe = table.deepcopy(data.raw.recipe["chemical-plant"])
    local entity = table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])
    local tech = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-chemical-plant-" .. inputs.number
    end
    item.icon =
        "__5dim_automation__/graphics/icon/chemical-plant/chemical-plant-icon-" .. inputs.number .. ".png"
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
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.crafting_speed = inputs.craftingSpeed
    entity.module_specification.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution

    -- East
    entity.animation.east.layers[1].hr_version.filename =
        "__5dim_automation__/graphics/entities/chemical-plant/chemical-plant-" .. inputs.number .. ".png"

    -- North
    entity.animation.north.layers[1].hr_version.filename =
        "__5dim_automation__/graphics/entities/chemical-plant/chemical-plant-" .. inputs.number .. ".png"

    -- South
    entity.animation.south.layers[1].hr_version.filename =
        "__5dim_automation__/graphics/entities/chemical-plant/chemical-plant-" .. inputs.number .. ".png"

    -- West
    entity.animation.west.layers[1].hr_version.filename =
        "__5dim_automation__/graphics/entities/chemical-plant/chemical-plant-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-chemical-plant-" .. inputs.tech.number
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
