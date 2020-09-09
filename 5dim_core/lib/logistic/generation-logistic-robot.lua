function genLogisticRobots(inputs)
    -- Copy electric furnace
    local itemLogisticRobot = table.deepcopy(data.raw.item["logistic-robot"])
    local recipeLogisticRobot = table.deepcopy(data.raw.recipe["logistic-robot"])
    local entityLogisticRobot = table.deepcopy(data.raw["logistic-robot"]["logistic-robot"])
    local technologyLogisticRobot = table.deepcopy(data.raw.technology["logistic-robotics"])

    --Item
    if inputs.new then
        itemLogisticRobot.name = "5d-logistic-robot-" .. inputs.number
    end
    -- itemLogisticRobot.icon = "__5dim_mining__/graphics/icon/logistic-robot/logistic-robot-icon-" .. inputs.number .. ".png"
    itemLogisticRobot.subgroup = inputs.subgroup
    itemLogisticRobot.order = inputs.order
    itemLogisticRobot.place_result = itemLogisticRobot.name

    --Recipe
    recipeLogisticRobot.name = itemLogisticRobot.name
    recipeLogisticRobot.icon = itemLogisticRobot.icon
    recipeLogisticRobot.result = itemLogisticRobot.name
    recipeLogisticRobot.icon_size = 64
    recipeLogisticRobot.ingredients = inputs.ingredients
    recipeLogisticRobot.enabled = true

    --Entity
    entityLogisticRobot.name = itemLogisticRobot.name
    -- entityLogisticRobot.icon = itemLogisticRobot.icon
    entityLogisticRobot.minable.result = itemLogisticRobot.name
    entityLogisticRobot.speed = inputs.craftingSpeed
    entityLogisticRobot.max_energy = inputs.energyUsage .. "MJ"

    data:extend({entityLogisticRobot, recipeLogisticRobot, itemLogisticRobot})

    -- Technology
    if inputs.tech then
        technologyLogisticRobot.name = "5d-logistic-robot-" .. inputs.tech.number
        technologyLogisticRobot.icon = itemLogisticRobot.icon
        technologyLogisticRobot.icon_size = 64
        technologyLogisticRobot.unit.count = inputs.tech.count
        technologyLogisticRobot.unit.ingredients = inputs.tech.packs
        technologyLogisticRobot.prerequisites = inputs.tech.prerequisites
        technologyLogisticRobot.effects = {
            {
                type = "unlock-recipe",
                recipe = itemLogisticRobot.name
            }
        }
        data:extend({technologyLogisticRobot})
    end
end
