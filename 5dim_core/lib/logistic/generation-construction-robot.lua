function genConstructionRobots(inputs)
    -- Copy electric furnace
    local itemConstructionRobot = table.deepcopy(data.raw.item["construction-robot"])
    local recipeConstructionRobot = table.deepcopy(data.raw.recipe["construction-robot"])
    local entityConstructionRobot = table.deepcopy(data.raw["construction-robot"]["construction-robot"])
    local technologyConstructionRobot = table.deepcopy(data.raw.technology["advanced-material-processing"])

    --Item
    if inputs.new then
        itemConstructionRobot.name = "5d-construction-robot-" .. inputs.number
    end
    -- itemConstructionRobot.icon = "__5dim_mining__/graphics/icon/construction-robot/construction-robot-icon-" .. inputs.number .. ".png"
    itemConstructionRobot.subgroup = inputs.subgroup
    itemConstructionRobot.order = inputs.order
    itemConstructionRobot.place_result = itemConstructionRobot.name

    --Recipe
    recipeConstructionRobot.name = itemConstructionRobot.name
    recipeConstructionRobot.icon = itemConstructionRobot.icon
    recipeConstructionRobot.result = itemConstructionRobot.name
    recipeConstructionRobot.icon_size = 64
    recipeConstructionRobot.ingredients = inputs.ingredients
    recipeConstructionRobot.enabled = true

    --Entity
    entityConstructionRobot.name = itemConstructionRobot.name
    -- entityConstructionRobot.icon = itemConstructionRobot.icon
    entityConstructionRobot.minable.result = itemConstructionRobot.name
    entityConstructionRobot.speed = inputs.craftingSpeed
    entityConstructionRobot.max_energy = inputs.energyUsage .. "MJ"

    data:extend({entityConstructionRobot, recipeConstructionRobot, itemConstructionRobot})

    -- Technology
    if inputs.tech then
        technologyConstructionRobot.name = "5d-mining-" .. inputs.tech.number
        -- technologyConstructionRobot.icon = "__base__/graphics/technology/mining-productivity.png"
        technologyConstructionRobot.unit.count = inputs.tech.count
        technologyConstructionRobot.unit.ingredients = inputs.tech.packs
        technologyConstructionRobot.prerequisites = inputs.tech.prerequisites
        technologyConstructionRobot.effects = {
            {
                type = "unlock-recipe",
                recipe = itemConstructionRobot.name
            }
        }
        data:extend({technologyConstructionRobot})
    end
end
