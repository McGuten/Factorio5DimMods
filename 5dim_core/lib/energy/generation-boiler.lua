function genBoilers(inputs)
    -- Copy electric furnace
    local itemBoiler = table.deepcopy(data.raw.item["boiler"])
    local recipeBoiler = table.deepcopy(data.raw.recipe["boiler"])
    local entityBoiler = table.deepcopy(data.raw["boiler"]["boiler"])
    local technologyBoiler = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        itemBoiler.name = "5d-boiler-" .. inputs.number
    end
    itemBoiler.icon =
        "__5dim_energy__/graphics/icon/boiler/boiler-icon-" .. inputs.number .. ".png"
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
    entityBoiler.fast_replaceable_group = "boiler"

    -- North
    entityBoiler.structure.north.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-N-idle/boiler-N-idle-" .. inputs.number .. ".png"
    -- East
    entityBoiler.structure.east.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-E-idle/boiler-E-idle-" .. inputs.number .. ".png"
    -- South
    entityBoiler.structure.south.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-S-idle/boiler-S-idle-" .. inputs.number .. ".png"
    -- West
    entityBoiler.structure.west.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-W-idle/boiler-W-idle-" .. inputs.number .. ".png"

    data:extend({entityBoiler, recipeBoiler, itemBoiler})

    -- Technology
    if inputs.tech then
        technologyBoiler.name = "5d-boiler-" .. inputs.tech.number
        technologyBoiler.icon = itemBoiler.icon
        technologyBoiler.icon_size = 64
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