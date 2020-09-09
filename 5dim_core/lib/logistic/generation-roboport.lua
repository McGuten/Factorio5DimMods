function genRoboports(inputs)
    -- Copy electric furnace
    local itemRoboport = table.deepcopy(data.raw.item["roboport"])
    local recipeRoboport = table.deepcopy(data.raw.recipe["roboport"])
    local entityRoboport = table.deepcopy(data.raw["roboport"]["roboport"])
    local technologyRoboport = table.deepcopy(data.raw.technology["advanced-material-processing"])

    --Item
    if inputs.new then
        itemRoboport.name = "5d-roboport-" .. inputs.number
    end
    -- itemRoboport.icon = "__5dim_mining__/graphics/icon/roboport/roboport-icon-" .. inputs.number .. ".png"
    itemRoboport.subgroup = inputs.subgroup
    itemRoboport.order = inputs.order
    itemRoboport.place_result = itemRoboport.name

    --Recipe
    recipeRoboport.name = itemRoboport.name
    recipeRoboport.icon = itemRoboport.icon
    recipeRoboport.result = itemRoboport.name
    recipeRoboport.icon_size = 64
    recipeRoboport.ingredients = inputs.ingredients
    recipeRoboport.enabled = true

    --Entity
    entityRoboport.name = itemRoboport.name
    -- entityRoboport.icon = itemRoboport.icon
    entityRoboport.minable.result = itemRoboport.name
    entityRoboport.charging_energy = inputs.craftingSpeed .. "kW"
    entityRoboport.energy_usage = inputs.energyUsage .. "kW"
    entityRoboport.energy_source.buffer_capacity = inputs.pollution .. "MJ"
    entityRoboport.energy_source.input_flow_limit = inputs.moduleSlots .. "MW"
    entityRoboport.logistics_radius = inputs.logistics
    entityRoboport.construction_radius = inputs.construction
    entityRoboport.robot_slots_count = inputs.botSlots
    entityRoboport.recharge_minimum = inputs.recharge .. "MJ"
    entityRoboport.fast_replaceable_group = "roboport"

    data:extend({entityRoboport, recipeRoboport, itemRoboport})

    -- Technology
    if inputs.tech then
        technologyRoboport.name = "5d-mining-" .. inputs.tech.number
        -- technologyRoboport.icon = "__base__/graphics/technology/mining-productivity.png"
        technologyRoboport.unit.count = inputs.tech.count
        technologyRoboport.unit.ingredients = inputs.tech.packs
        technologyRoboport.prerequisites = inputs.tech.prerequisites
        technologyRoboport.effects = {
            {
                type = "unlock-recipe",
                recipe = itemRoboport.name
            }
        }
        data:extend({technologyRoboport})
    end
end
