function genBoilers(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["boiler"])
    local recipe = table.deepcopy(data.raw.recipe["boiler"])
    local entity = table.deepcopy(data.raw["boiler"]["boiler"])
    local tech = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-boiler-" .. inputs.number
    end
    item.icon =
        "__5dim_energy__/graphics/icon/boiler/boiler-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.energy_consumption = inputs.craftingSpeed .. "MW"
    entity.energy_source.effectivity = inputs.energyUsage
    entity.energy_source.emissions_per_minute = inputs.pollution
    entity.fast_replaceable_group = "boiler"

    -- North
    entity.structure.north.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-N-idle/boiler-N-idle-" .. inputs.number .. ".png"
    -- East
    entity.structure.east.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-E-idle/boiler-E-idle-" .. inputs.number .. ".png"
    -- South
    entity.structure.south.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-S-idle/boiler-S-idle-" .. inputs.number .. ".png"
    -- West
    entity.structure.west.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-W-idle/boiler-W-idle-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-boiler-" .. inputs.tech.number
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