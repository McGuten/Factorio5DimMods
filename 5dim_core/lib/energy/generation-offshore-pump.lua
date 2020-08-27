function genOffshorePumps(inputs)
    -- Copy electric furnace
    itemOffshorePump = table.deepcopy(data.raw.item["offshore-pump"])
    recipeOffshorePump = table.deepcopy(data.raw.recipe["offshore-pump"])
    entityOffshorePump = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
    technologyOffshorePump = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        itemOffshorePump.name = "5d-offshore-pump-" .. inputs.number
    end
    -- itemOffshorePump.icon =
    --     "__5dim_mining__/graphics/icon/pumpjack/pumpjack-icon-" .. inputs.number .. ".png"
    itemOffshorePump.subgroup = inputs.subgroup
    itemOffshorePump.order = inputs.order
    itemOffshorePump.place_result = itemOffshorePump.name

    --Recipe
    recipeOffshorePump.name = itemOffshorePump.name
    --recipeOffshorePump.icon = itemOffshorePump.icon
    recipeOffshorePump.result = itemOffshorePump.name
    recipeOffshorePump.icon_size = 64
    if inputs.new then
        recipeOffshorePump.enabled = true
    end
    recipeOffshorePump.ingredients = inputs.ingredients

    --Entity
    entityOffshorePump.name = itemOffshorePump.name
    --entityOffshorePump.icon = itemOffshorePump.icon
    entityOffshorePump.minable.result = itemOffshorePump.name
    entityOffshorePump.mining_speed = inputs.craftingSpeed
    -- entityOffshorePump.module_specification.module_slots = inputs.moduleSlots
    -- entityOffshorePump.energy_usage = inputs.energyUsage .. "kW"
    -- entityOffshorePump.energy_source.emissions_per_minute = inputs.pollution
    -- entityOffshorePump.base_picture.sheets[1].hr_version.filename =
    --     "__5dim_mining__/graphics/entities/pumpjack/pumpjack-" .. inputs.number .. ".png"

    data:extend({entityOffshorePump, recipeOffshorePump, itemOffshorePump})

    -- Technology
    if inputs.tech then
        technologyOffshorePump.name = "5d-offshore-pump-" .. inputs.tech.number
        --technologyOffshorePump.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyOffshorePump.unit.count = inputs.tech.count
        technologyOffshorePump.unit.ingredients = inputs.tech.packs
        technologyOffshorePump.prerequisites = inputs.tech.prerequisites
        technologyOffshorePump.effects = {
            {
                type = "unlock-recipe",
                recipe = itemOffshorePump.name
            }
        }
        data:extend({technologyOffshorePump})
    end
end
