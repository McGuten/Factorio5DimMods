function genElectricFurnaces(inputs)
    -- Copy electric furnace
    itemElectricFurnace = table.deepcopy(data.raw.item["electric-furnace"])
    recipeElectricFurnace = table.deepcopy(data.raw.recipe["electric-furnace"])
    entityElectricFurnace = table.deepcopy(data.raw["furnace"]["electric-furnace"])

    --Item
    if inputs.new then
        itemElectricFurnace.name = "5d-electric-furnace-" .. inputs.number
    end
    --itemElectricFurnace.icon = ""
    itemElectricFurnace.subgroup = inputs.subgroup
    itemElectricFurnace.order = inputs.number
    itemElectricFurnace.place_result = itemElectricFurnace.name

    --Recipe
    recipeElectricFurnace.name = itemElectricFurnace.name
    recipeElectricFurnace.result = itemElectricFurnace.name
    --recipeElectricFurnace.icon = itemElectricFurnace.icon
    recipeElectricFurnace.enabled = true
    recipeElectricFurnace.ingredients = {
        {"roboport", 1},
        {"steel-plate", 20},
        {"iron-gear-wheel", 20},
        {"advanced-circuit", 20}
    }

    --Entity
    entityElectricFurnace.name = itemElectricFurnace.name
    --entityElectricFurnace.icon = itemElectricFurnace.icon
    entityElectricFurnace.minable.result = itemElectricFurnace.name
    entityElectricFurnace.crafting_speed = inputs.craftingSpeed
    entityElectricFurnace.energy_usage = inputs.energyUsage .. "kW"
    entityElectricFurnace.animation.layers[1].hr_version.filename =
        "__5dim_resources__/graphics/entities/electric-furnace/hr-electric-furnace-" .. inputs.number .. ".png"

    data:extend({entityElectricFurnace, recipeElectricFurnace, itemElectricFurnace})
end
