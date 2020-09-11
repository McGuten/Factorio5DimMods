function genSubstations(inputs)
    -- Copy electric furnace
    local itemSubstation = table.deepcopy(data.raw.item["substation"])
    local recipeSubstation = table.deepcopy(data.raw.recipe["substation"])
    local entitySubstation = table.deepcopy(data.raw["electric-pole"]["substation"])
    local technologySubstation = table.deepcopy(data.raw.technology["electric-energy-distribution-1"])

    --Item
    if inputs.new then
        itemSubstation.name = "5d-substation-" .. inputs.number
    end
    itemSubstation.icon =
        "__5dim_energy__/graphics/icon/substation/substation-icon-" .. inputs.number .. ".png"
    itemSubstation.subgroup = inputs.subgroup
    itemSubstation.order = inputs.order
    itemSubstation.place_result = itemSubstation.name

    --Recipe
    recipeSubstation.name = itemSubstation.name
    -- recipeSubstation.icon = itemSubstation.icon
    recipeSubstation.result = itemSubstation.name
    recipeSubstation.icon_size = 64
    if inputs.new then
        recipeSubstation.enabled = false
    end
    recipeSubstation.ingredients = inputs.ingredients

    --Entity
    entitySubstation.name = itemSubstation.name
    -- entitySubstation.icon = itemSubstation.icon
    entitySubstation.minable.result = itemSubstation.name
    entitySubstation.maximum_wire_distance = inputs.craftingSpeed
    entitySubstation.supply_area_distance = inputs.energyUsage
    entitySubstation.fast_replaceable_group = "substation"

    -- Base
    entitySubstation.pictures.layers[1].hr_version.filename =
        "__5dim_energy__/graphics/entities/substation/substation-" .. inputs.number .. ".png"

    data:extend({entitySubstation, recipeSubstation, itemSubstation})

    -- Technology
    if inputs.tech then
        technologySubstation.name = "5d-substation-" .. inputs.tech.number
        technologySubstation.icon = itemSubstation.icon
        technologySubstation.icon_size = 64
        technologySubstation.unit.count = inputs.tech.count
        technologySubstation.unit.ingredients = inputs.tech.packs
        technologySubstation.prerequisites = inputs.tech.prerequisites
        technologySubstation.effects = {
            {
                type = "unlock-recipe",
                recipe = itemSubstation.name
            }
        }
        data:extend({technologySubstation})
    end
end