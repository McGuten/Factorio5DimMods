function genLogisticRobots(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["logistic-robot"])
    local recipe = table.deepcopy(data.raw.recipe["logistic-robot"])
    local entity = table.deepcopy(data.raw["logistic-robot"]["logistic-robot"])
    local tech = table.deepcopy(data.raw.technology["logistic-robotics"])

    --Item
    if inputs.new then
        item.name = "5d-logistic-robot-" .. inputs.number
    end
    item.icon = "__5dim_logistic__/graphics/icon/logistic-robot/logistic-robot-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    recipe.ingredients = inputs.ingredients
    recipe.enabled = true

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    -- entity.icon = item.icon
    entity.minable.result = item.name
    entity.speed = inputs.craftingSpeed
    entity.max_energy = inputs.energyUsage .. "MJ"

    -- Idle
    entity.idle.hr_version.filename =
        "__5dim_logistic__/graphics/entities/logistic-robot/logistic-robot-" .. inputs.number .. ".png"
    -- Idle
    entity.idle_with_cargo.hr_version.filename =
        "__5dim_logistic__/graphics/entities/logistic-robot/logistic-robot-" .. inputs.number .. ".png"
    -- Idle
    entity.in_motion.hr_version.filename =
        "__5dim_logistic__/graphics/entities/logistic-robot/logistic-robot-" .. inputs.number .. ".png"
    -- Idle
    entity.in_motion_with_cargo.hr_version.filename =
        "__5dim_logistic__/graphics/entities/logistic-robot/logistic-robot-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-logistic-robot-" .. inputs.tech.number
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
