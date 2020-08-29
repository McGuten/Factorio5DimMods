function genBoilers(inputs)
    -- Copy electric furnace
    itemBoiler = table.deepcopy(data.raw.item["boiler"])
    recipeBoiler = table.deepcopy(data.raw.recipe["boiler"])
    entityBoiler = table.deepcopy(data.raw["boiler"]["boiler"])
    technologyBoiler = table.deepcopy(data.raw.technology["electric-energy-accumulators"])

    --Item
    if inputs.new then
        itemBoiler.name = "5d-boiler-" .. inputs.number
    end
    -- itemBoiler.icon =
    --     "__5dim_energy__/graphics/icon/Boiler/Boiler-icon-" .. inputs.number .. ".png"
    itemBoiler.subgroup = inputs.subgroup
    itemBoiler.order = inputs.order
    itemBoiler.place_result = itemBoiler.name

    --Recipe
    recipeBoiler.name = itemBoiler.name
    -- recipeBoiler.icon = itemBoiler.icon
    recipeBoiler.result = itemBoiler.name
    recipeBoiler.icon_size = 64
    if inputs.new then
        recipeBoiler.enabled = false
    end
    recipeBoiler.ingredients = inputs.ingredients

    --Entity
    entityBoiler.name = itemBoiler.name
    -- entityBoiler.icon = itemBoiler.icon
    entityBoiler.minable.result = itemBoiler.name
    entityBoiler.energy_consumption = inputs.craftingSpeed .. "MW"
    entityBoiler.energy_source.effectivity = inputs.energyUsage
    entityBoiler.energy_source.emissions_per_minute = inputs.pollution

    -- Base
    -- entityBoiler.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/Boiler/Boiler-" .. inputs.number .. ".png"

    data:extend({entityBoiler, recipeBoiler, itemBoiler})

    -- Technology
    if inputs.tech then
        technologyBoiler.name = "boiler-" .. inputs.tech.number
        --technologyBoiler.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyBoiler.unit.count = inputs.tech.count
        technologyBoiler.unit.ingredients = inputs.tech.packs
        technologyBoiler.prerequisites = inputs.tech.prerequisites
        technologyBoiler.effects = {
            {
                type = "unlock-recipe",
                recipe = itemBoiler.name
            }
        }
        data:extend({technologyBoiler})
    end
end