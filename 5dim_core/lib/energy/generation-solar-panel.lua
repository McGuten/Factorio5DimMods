function genSolarPanels(inputs)
    -- Copy electric furnace
    itemSolarPanel = table.deepcopy(data.raw.item["solar-panel"])
    recipeSolarPanel = table.deepcopy(data.raw.recipe["solar-panel"])
    entitySolarPanel = table.deepcopy(data.raw["solar-panel"]["solar-panel"])
    technologySolarPanel = table.deepcopy(data.raw.technology["solar-energy"])

    --Item
    if inputs.new then
        itemSolarPanel.name = "5d-solar-panel-" .. inputs.number
    end
    itemSolarPanel.icon =
        "__5dim_energy__/graphics/icon/solar-panel/solar-panel-icon-" .. inputs.number .. ".png"
    itemSolarPanel.subgroup = inputs.subgroup
    itemSolarPanel.order = inputs.order
    itemSolarPanel.place_result = itemSolarPanel.name

    --Recipe
    recipeSolarPanel.name = itemSolarPanel.name
    recipeSolarPanel.icon = itemSolarPanel.icon
    recipeSolarPanel.result = itemSolarPanel.name
    recipeSolarPanel.icon_size = 64
    if inputs.new then
        recipeSolarPanel.enabled = false
    end
    recipeSolarPanel.ingredients = inputs.ingredients

    --Entity
    entitySolarPanel.name = itemSolarPanel.name
    entitySolarPanel.icon = itemSolarPanel.icon
    entitySolarPanel.minable.result = itemSolarPanel.name
    entitySolarPanel.production = inputs.craftingSpeed .. "kW"

    -- North
    entitySolarPanel.picture.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/solar-panel/solar-panel-" .. inputs.number .. ".png"

    data:extend({entitySolarPanel, recipeSolarPanel, itemSolarPanel})

    -- Technology
    if inputs.tech then
        technologySolarPanel.name = "solar-energy-" .. inputs.tech.number
        --technologySolarPanel.icon = "__base__/graphics/technology/oil-refinery.png"
        technologySolarPanel.unit.count = inputs.tech.count
        technologySolarPanel.unit.ingredients = inputs.tech.packs
        technologySolarPanel.prerequisites = inputs.tech.prerequisites
        technologySolarPanel.effects = {
            {
                type = "unlock-recipe",
                recipe = itemSolarPanel.name
            }
        }
        data:extend({technologySolarPanel})
    end
end
