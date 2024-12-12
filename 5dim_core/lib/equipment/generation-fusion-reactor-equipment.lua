function genFusionReactors(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["fusion-reactor-equipment"])
    local recipe = table.deepcopy(data.raw.recipe["fusion-reactor-equipment"])
    local equipment = table.deepcopy(data.raw["generator-equipment"]["fusion-reactor-equipment"])
    local tech = table.deepcopy(data.raw.technology["fusion-reactor-equipment"])

    -- log("item Name: " .. item.name)

    --Item
    if inputs.new then
        item.name = "5d-fusion-reactor-equipment-" .. inputs.number
    end
    item.icon = "__5dim_equipment__/graphics/icon/fusion-reactor/fusion-reactor-equipment-icon-" .. inputs.number .. ".png"
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
    equipment.power = inputs.power .. "kW"
    equipment.sprite.filename =
        "__5dim_equipment__/graphics/equipment/fusion-reactor/fusion-reactor-equipment-" .. inputs.number .. ".png"

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "fusion-reactor-equipment-" .. inputs.tech.number
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
