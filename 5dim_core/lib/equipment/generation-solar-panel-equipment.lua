function genSolarPanels(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["solar-panel-equipment"])
    local recipe = table.deepcopy(data.raw.recipe["solar-panel-equipment"])
    local equipment = table.deepcopy(data.raw["solar-panel-equipment"]["solar-panel-equipment"])
    local tech = table.deepcopy(data.raw.technology["solar-panel-equipment"])

    --Item
    if inputs.new then
        item.name = "5d-solar-panel-equipment-" .. inputs.number
    end
    -- item.icon = "__5dim_logistic__/graphics/icon/solar-panel-equipment/solar-panel-equipment-icon-" .. inputs.number .. ".png"
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
    equipment.power = inputs.power .. "kW"

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "solar-panel-equipment-" .. inputs.tech.number
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
