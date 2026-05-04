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
    item.icon_size = 64
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
    equipment.attack_parameters.cooldown = inputs.cooldown
    equipment.attack_parameters.range = inputs.range
    equipment.attack_parameters.damage_modifier = inputs.damage
    equipment.attack_parameters.ammo_type.energy_consumption = inputs.energyConsumption .. "kJ"
    equipment.energy_source.buffer_capacity = inputs.energyConsumption * 4 .. "kJ"
    if mods["space-age"] then
        equipment.attack_parameters.ammo_category = "tesla"
        equipment.attack_parameters.ammo_type.action.action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "nested-result",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "chain",
                            chain = "chain-tesla-gun-chain"
                        }
                    }
                },
                {
                    type = "nested-result",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "beam",
                            beam = "chain-tesla-gun-beam-start",
                            max_length = inputs.range + 1,
                            duration = 30,
                            add_to_shooter = false,
                            destroy_with_source_or_target = false,
                            source_offset = {0, -1.31439}
                        }
                    }
                }
            }
        }
    else
        equipment.attack_parameters.ammo_type.action.action_delivery.max_length = inputs.range + 1
        equipment.attack_parameters.ammo_type.action.action_delivery.beam = "electric-beam"
    end
    equipment.sprite.filename =
        "__5dim_equipment__/graphics/equipment/personal-tesla-defense/personal-tesla-defense-equipment-" .. inputs.number .. ".png"
    equipment.sprite.width = 64
    equipment.sprite.height = 64

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
