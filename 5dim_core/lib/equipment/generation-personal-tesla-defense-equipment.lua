function genPersonalLaserDefenses(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["personal-laser-defense-equipment"])
    local recipe = table.deepcopy(data.raw.recipe["personal-laser-defense-equipment"])
    local equipment = table.deepcopy(data.raw["active-defense-equipment"]["personal-laser-defense-equipment"])
    local tech = table.deepcopy(data.raw.technology["personal-laser-defense-equipment"])

    --Item
    if inputs.new then
        item.name = "5d-personal-tesla-defense-equipment-" .. inputs.number
    end
    item.icon = "__5dim_equipment__/graphics/icon/personal-tesla-defense/personal-tesla-defense-equipment-icon-" .. inputs.number .. ".png"
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
    equipment.attack_parameters.cooldown = inputs.cooldown
    equipment.attack_parameters.range = inputs.range
    equipment.attack_parameters.ammo_type.action.action_delivery.max_length = inputs.range + 1
    equipment.attack_parameters.damage_modifier = inputs.damage
    equipment.attack_parameters.ammo_type.energy_consumption = inputs.energyConsumption .. "kJ"
    equipment.energy_source.buffer_capacity = inputs.energyConsumption * 4 .. "kJ"
    equipment.attack_parameters.ammo_type.action.action_delivery.beam = "electric-beam"
    equipment.sprite.filename =
        "__5dim_equipment__/graphics/equipment/personal-tesla-defense/personal-tesla-defense-equipment-" .. inputs.number .. ".png"

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-personal-tesla-defense-equipment-" .. inputs.tech.number
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
