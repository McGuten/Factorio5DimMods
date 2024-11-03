function genExoskeletons(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["exoskeleton-equipment"])
    local recipe = table.deepcopy(data.raw.recipe["exoskeleton-equipment"])
    local equipment = table.deepcopy(data.raw["movement-bonus-equipment"]["exoskeleton-equipment"])
    local tech = table.deepcopy(data.raw.technology["exoskeleton-equipment"])

    --Item
    if inputs.new then
        item.name = "5d-exoskeleton-equipment-" .. inputs.number
    end
    item.icon = "__5dim_equipment__/graphics/icon/exoskeleton/exoskeleton-equipment-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_as_equipment_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.icon_size = 64
    recipe.ingredients = inputs.ingredients
    recipe.enabled = false

    -- Equipment
    equipment.name = item.name
    equipment.take_result = item.name
    equipment.energy_consumption = inputs.energyConsumption .. "kW"
    equipment.movement_bonus = inputs.movementSpeed
    equipment.sprite.filename =
        "__5dim_equipment__/graphics/equipment/exoskeleton/exoskeleton-equipment-" .. inputs.number .. ".png"
    equipment.sprite.width = 64
    equipment.sprite.height = 128

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "exoskeleton-equipment-" .. inputs.tech.number
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
