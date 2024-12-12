function genRoboports(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["roboport"])
    local recipe = table.deepcopy(data.raw.recipe["roboport"])
    local entity = table.deepcopy(data.raw["roboport"]["roboport"])
    local tech = table.deepcopy(data.raw.technology["logistic-robotics"])

    --Item
    if inputs.new then
        item.name = "5d-roboport-" .. inputs.number
    end
    item.icon = "__5dim_logistic__/graphics/icons/roboport/roboport-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.charging_energy = inputs.craftingSpeed .. "kW"
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.buffer_capacity = inputs.pollution .. "MJ"
    entity.energy_source.input_flow_limit = inputs.moduleSlots .. "MW"
    entity.logistics_radius = inputs.logistics
    entity.construction_radius = inputs.construction
    entity.robot_slots_count = inputs.botSlots
    entity.recharge_minimum = inputs.recharge .. "MJ"
    entity.fast_replaceable_group = "roboport"
    entity.charging_offsets = nil
    entity.charging_station_count = inputs.rechargeSlots
    entity.charging_distance = 3

    -- Base
    entity.base.layers[1].filename =
        "__5dim_logistic__/graphics/entities/roboport/roboport-base/roboport-base-" .. inputs.number .. ".png"
    -- Base patch
    entity.base_patch.filename =
        "__5dim_logistic__/graphics/entities/roboport/roboport-base-patch/roboport-base-patch-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-roboport-" .. inputs.tech.number
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
