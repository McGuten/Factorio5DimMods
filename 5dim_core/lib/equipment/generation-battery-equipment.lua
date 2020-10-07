function genBatterys(inputs)
        local item = ""
        local equipment = ""
        local recipe = ""
        local tech = ""
    -- Copy electric furnace
    if inputs.number == "01" then
        item = table.deepcopy(data.raw.item["battery-equipment"])
        recipe = table.deepcopy(data.raw.recipe["battery-equipment"])
        equipment = table.deepcopy(data.raw["battery-equipment"]["battery-equipment"])
        tech = table.deepcopy(data.raw.technology["battery-equipment"])
    else
        item = table.deepcopy(data.raw.item["battery-mk2-equipment"])
        recipe = table.deepcopy(data.raw.recipe["battery-mk2-equipment"])
        equipment = table.deepcopy(data.raw["battery-equipment"]["battery-mk2-equipment"])
        tech = table.deepcopy(data.raw.technology["battery-mk2-equipment"])
    end

    --Item
    if inputs.new then
        item.name = "5d-battery-equipment-" .. inputs.number
    end
    -- item.icon = "__5dim_logistic__/graphics/icon/battery-equipment/battery-equipment-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.placed_as_equipment_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    recipe.ingredients = inputs.ingredients
    recipe.enabled = false

    -- Equipment
    equipment.name = item.name
    equipment.energy_source.buffer_capacity = inputs.capacity .. "MJ"

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-battery-equipment-" .. inputs.tech.number
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
