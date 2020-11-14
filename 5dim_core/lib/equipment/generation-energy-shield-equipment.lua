function genEnergyShields(inputs)
        local item = ""
        local equipment = ""
        local recipe = ""
        local tech = ""
    -- Copy electric furnace
    if inputs.number == "01" then
        item = table.deepcopy(data.raw.item["energy-shield-equipment"])
        recipe = table.deepcopy(data.raw.recipe["energy-shield-equipment"])
        equipment = table.deepcopy(data.raw["energy-shield-equipment"]["energy-shield-equipment"])
        tech = table.deepcopy(data.raw.technology["energy-shield-equipment"])
    else
        item = table.deepcopy(data.raw.item["energy-shield-mk2-equipment"])
        recipe = table.deepcopy(data.raw.recipe["energy-shield-mk2-equipment"])
        equipment = table.deepcopy(data.raw["energy-shield-equipment"]["energy-shield-mk2-equipment"])
        tech = table.deepcopy(data.raw.technology["energy-shield-mk2-equipment"])
    end

    --Item
    if inputs.new then
        item.name = "5d-energy-shield-equipment-" .. inputs.number
    end
    item.icon = "__5dim_equipment__/graphics/icon/energy-shield/energy-shield-equipment-icon-" .. inputs.number .. ".png"
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
    equipment.max_shield_value = inputs.shieldCapacity
    equipment.energy_source.buffer_capacity = inputs.capacity .. "kJ"
    equipment.energy_source.input_flow_limit = inputs.inputFlow .. "kW"
    equipment.energy_per_shield = inputs.energyPerShield .. "kJ"
    equipment.sprite.filename =
        "__5dim_equipment__/graphics/equipment/energy-shield/energy-shield-equipment-" .. inputs.number .. ".png"

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-energy-shield-equipment-" .. inputs.tech.number
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
