function genConstructionRobots(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["construction-robot"])
    local recipe = table.deepcopy(data.raw.recipe["construction-robot"])
    local entity = table.deepcopy(data.raw["construction-robot"]["construction-robot"])
    local tech = table.deepcopy(data.raw.technology["construction-robotics"])

    --Item
    if inputs.new then
        item.name = "5d-construction-robot-" .. inputs.number
    end
    item.icon = "__5dim_logistic__/graphics/icon/construction-robot/construction-robot-icon-" .. inputs.number .. ".png"
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
    -- entity.icon = item.icon
    entity.minable.result = item.name
    entity.speed = inputs.craftingSpeed
    entity.max_energy = inputs.energyUsage .. "MJ"

    -- Idle
    entity.idle.hr_version.filename =
        "__5dim_logistic__/graphics/entities/construction-robot/construction-robot/construction-robot-" .. inputs.number .. ".png"
    -- Idle
    entity.in_motion.hr_version.filename =
        "__5dim_logistic__/graphics/entities/construction-robot/construction-robot/construction-robot-" .. inputs.number .. ".png"
    -- Working
    entity.working.hr_version.filename =
        "__5dim_logistic__/graphics/entities/construction-robot/construction-robot-working/construction-robot-working-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-construction-robot-" .. inputs.tech.number
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
