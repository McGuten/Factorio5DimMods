function genElectricFurnaces(inputs)
    -- Copy electric furnace
    local itemElectricFurnace = table.deepcopy(data.raw.item["electric-furnace"])
    local recipeElectricFurnace = table.deepcopy(data.raw.recipe["electric-furnace"])
    local entityElectricFurnace = table.deepcopy(data.raw["furnace"]["electric-furnace"])
    local technologyElectricFurnace = table.deepcopy(data.raw.technology["advanced-material-processing-2"])

    --Item
    if inputs.new then
        itemElectricFurnace.name = "5d-electric-furnace-" .. inputs.number
    end
    itemElectricFurnace.icon =
        "__5dim_resources__/graphics/icon/electric-furnace/electric-furnace-icon-" .. inputs.number .. ".png"
    itemElectricFurnace.subgroup = inputs.subgroup
    itemElectricFurnace.order = inputs.order
    itemElectricFurnace.place_result = itemElectricFurnace.name

    --Recipe
    recipeElectricFurnace.name = itemElectricFurnace.name
    recipeElectricFurnace.result = itemElectricFurnace.name
    recipeElectricFurnace.icon = itemElectricFurnace.icon
    recipeElectricFurnace.icon_size = 64
    recipeElectricFurnace.enabled = false
    recipeElectricFurnace.ingredients = inputs.ingredients

    --Entity
    entityElectricFurnace.name = itemElectricFurnace.name
    entityElectricFurnace.icon = itemElectricFurnace.icon
    entityElectricFurnace.minable.result = itemElectricFurnace.name
    entityElectricFurnace.crafting_speed = inputs.craftingSpeed
    entityElectricFurnace.module_specification.module_slots = inputs.moduleSlots
    entityElectricFurnace.energy_usage = inputs.energyUsage .. "kW"
    entityElectricFurnace.animation.layers[1].hr_version.filename =
        "__5dim_resources__/graphics/entities/electric-furnace/hr-electric-furnace-" .. inputs.number .. ".png"
    entityElectricFurnace.energy_source.emissions_per_minute = inputs.pollution

    data:extend({entityElectricFurnace, recipeElectricFurnace, itemElectricFurnace})

    if inputs.tech then
        -- Technology
        technologyElectricFurnace.name = "advanced-material-processing-" .. inputs.tech.number
        technologyElectricFurnace.unit.count = inputs.tech.count
        technologyElectricFurnace.unit.ingredients = inputs.tech.packs
        technologyElectricFurnace.prerequisites = inputs.tech.prerequisites
        technologyElectricFurnace.effects = {
            {
                type = "unlock-recipe",
                recipe = itemElectricFurnace.name
            }
        }
        data:extend({technologyElectricFurnace})
    end
end
