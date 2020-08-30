function genMediumPoles(inputs)
    -- Copy electric furnace
    local itemMediumPole = table.deepcopy(data.raw.item["medium-electric-pole"])
    local recipeMediumPole = table.deepcopy(data.raw.recipe["medium-electric-pole"])
    local entityMediumPole = table.deepcopy(data.raw["electric-pole"]["medium-electric-pole"])
    local technologyMediumPole = table.deepcopy(data.raw.technology["electric-energy-accumulators"])

    --Item
    if inputs.new then
        itemMediumPole.name = "5d-medium-electric-pole-" .. inputs.number
    end
    -- itemMediumPole.icon =
    --     "__5dim_energy__/graphics/icon/medium-electric-pole/medium-electric-pole-icon-" .. inputs.number .. ".png"
    itemMediumPole.subgroup = inputs.subgroup
    itemMediumPole.order = inputs.order
    itemMediumPole.place_result = itemMediumPole.name

    --Recipe
    recipeMediumPole.name = itemMediumPole.name
    -- recipeMediumPole.icon = itemMediumPole.icon
    recipeMediumPole.result = itemMediumPole.name
    recipeMediumPole.icon_size = 64
    if inputs.new then
        recipeMediumPole.enabled = false
    end
    recipeMediumPole.ingredients = inputs.ingredients

    --Entity
    entityMediumPole.name = itemMediumPole.name
    -- entityMediumPole.icon = itemMediumPole.icon
    entityMediumPole.minable.result = itemMediumPole.name
    entityMediumPole.maximum_wire_distance = inputs.craftingSpeed
    entityMediumPole.supply_area_distance = inputs.energyUsage

    -- Base
    -- entityMediumPole.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/medium-electric-pole/medium-electric-pole-" .. inputs.number .. ".png"

    data:extend({entityMediumPole, recipeMediumPole, itemMediumPole})

    -- Technology
    if inputs.tech then
        technologyMediumPole.name = "5d-medium-electric-pole-" .. inputs.tech.number
        --technologyMediumPole.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyMediumPole.unit.count = inputs.tech.count
        technologyMediumPole.unit.ingredients = inputs.tech.packs
        technologyMediumPole.prerequisites = inputs.tech.prerequisites
        technologyMediumPole.effects = {
            {
                type = "unlock-recipe",
                recipe = itemMediumPole.name
            }
        }
        data:extend({technologyMediumPole})
    end
end