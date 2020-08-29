function genCentrifuges(inputs)
    -- Copy electric furnace
    itemCentrifuge = table.deepcopy(data.raw.item["centrifuge"])
    recipeCentrifuge = table.deepcopy(data.raw.recipe["centrifuge"])
    entityCentrifuge = table.deepcopy(data.raw["assembling-machine"]["centrifuge"])
    technologyCentrifuge = table.deepcopy(data.raw.technology["electric-energy-accumulators"])

    --Item
    if inputs.new then
        itemCentrifuge.name = "5d-centrifuge-" .. inputs.number
    end
    -- itemCentrifuge.icon =
    --     "__5dim_energy__/graphics/icon/centrifuge/centrifuge-icon-" .. inputs.number .. ".png"
    itemCentrifuge.subgroup = inputs.subgroup
    itemCentrifuge.order = inputs.order
    itemCentrifuge.place_result = itemCentrifuge.name

    --Recipe
    recipeCentrifuge.name = itemCentrifuge.name
    -- recipeCentrifuge.icon = itemCentrifuge.icon
    recipeCentrifuge.result = itemCentrifuge.name
    recipeCentrifuge.icon_size = 64
    if inputs.new then
        recipeCentrifuge.enabled = true
    end

    --Entity
    entityCentrifuge.name = itemCentrifuge.name
    -- entityCentrifuge.icon = itemCentrifuge.icon
    entityCentrifuge.minable.result = itemCentrifuge.name
    entityCentrifuge.crafting_speed = inputs.craftingSpeed
    entityCentrifuge.energy_usage = inputs.energyUsage .. "kW"
    entityCentrifuge.energy_source.emissions_per_minute = inputs.pollution
    entityCentrifuge.module_specification.module_slots = inputs.moduleSlots

    -- Base
    -- entityCentrifuge.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/centrifuge/centrifuge-" .. inputs.number .. ".png"

    data:extend({entityCentrifuge, recipeCentrifuge, itemCentrifuge})

    -- Technology
    if inputs.tech then
        technologyCentrifuge.name = "5d-centrifuge-" .. inputs.tech.number
        --technologyCentrifuge.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyCentrifuge.unit.count = inputs.tech.count
        technologyCentrifuge.unit.ingredients = inputs.tech.packs
        technologyCentrifuge.prerequisites = inputs.tech.prerequisites
        technologyCentrifuge.effects = {
            {
                type = "unlock-recipe",
                recipe = itemCentrifuge.name
            }
        }
        data:extend({technologyCentrifuge})
    end
end