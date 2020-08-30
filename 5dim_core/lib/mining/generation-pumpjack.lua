function genPumpjacks(inputs)
    -- Copy electric furnace
    local itemPumpjack = table.deepcopy(data.raw.item["pumpjack"])
    local recipePumpjack = table.deepcopy(data.raw.recipe["pumpjack"])
    local entityPumpjack = table.deepcopy(data.raw["mining-drill"]["pumpjack"])
    local technologyPumpjack = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        itemPumpjack.name = "5d-pumpjack-" .. inputs.number
    end
    itemPumpjack.icon =
        "__5dim_mining__/graphics/icon/pumpjack/pumpjack-icon-" .. inputs.number .. ".png"
    itemPumpjack.subgroup = inputs.subgroup
    itemPumpjack.order = inputs.order
    itemPumpjack.place_result = itemPumpjack.name

    --Recipe
    recipePumpjack.name = itemPumpjack.name
    recipePumpjack.icon = itemPumpjack.icon
    recipePumpjack.result = itemPumpjack.name
    recipePumpjack.icon_size = 64
    recipePumpjack.enabled = false
    recipePumpjack.ingredients = inputs.ingredients

    --Entity
    entityPumpjack.name = itemPumpjack.name
    entityPumpjack.icon = itemPumpjack.icon
    entityPumpjack.minable.result = itemPumpjack.name
    entityPumpjack.mining_speed = inputs.craftingSpeed
    entityPumpjack.module_specification.module_slots = inputs.moduleSlots
    entityPumpjack.energy_usage = inputs.energyUsage .. "kW"
    entityPumpjack.energy_source.emissions_per_minute = inputs.pollution

    --Base
    entityPumpjack.base_picture.sheets[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/pumpjack/pumpjack-base.png"

    -- Animation
    entityPumpjack.animations.north.layers[1].hr_version.filename =
        "__5dim_mining__/graphics/entities/pumpjack/pumpjack-horsehead-" .. inputs.number .. ".png"

    data:extend({entityPumpjack, recipePumpjack, itemPumpjack})

    -- Technology
    if inputs.tech then
        technologyPumpjack.name = "5d-pumpjack-" .. inputs.tech.number
        --technologyPumpjack.icon = "__base__/graphics/technology/mining-productivity.png"
        technologyPumpjack.unit.count = inputs.tech.count
        technologyPumpjack.unit.ingredients = inputs.tech.packs
        technologyPumpjack.prerequisites = inputs.tech.prerequisites
        technologyPumpjack.effects = {
            {
                type = "unlock-recipe",
                recipe = itemPumpjack.name
            }
        }
        data:extend({technologyPumpjack})
    end
end
