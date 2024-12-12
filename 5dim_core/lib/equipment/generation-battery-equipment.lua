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
    item.icon = "__5dim_equipment__/graphics/icon/battery/battery-equipment-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_as_equipment_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    -- Equipment
    equipment.name = item.name
    equipment.take_result = item.name
    equipment.energy_source.buffer_capacity = inputs.capacity .. "MJ"
    equipment.sprite.filename =
        "__5dim_equipment__/graphics/equipment/battery/battery-equipment-" .. inputs.number .. ".png"
    equipment.sprite.width = 32
    equipment.sprite.height = 64

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
