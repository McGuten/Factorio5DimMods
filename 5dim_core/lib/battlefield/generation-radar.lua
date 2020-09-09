function genRadars(inputs)
    -- Copy electric furnace
    local itemRadar = table.deepcopy(data.raw.item["radar"])
    local recipeRadar = table.deepcopy(data.raw.recipe["radar"])
    local entityRadar = table.deepcopy(data.raw["radar"]["radar"])
    local technologyRadar = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        itemRadar.name = "5d-radar-" .. inputs.number
    end
    -- itemRadar.icon =
    --     "__5dim_energy__/graphics/icon/radar/radar-icon-" .. inputs.number .. ".png"
    itemRadar.subgroup = inputs.subgroup
    itemRadar.order = inputs.order
    itemRadar.place_result = itemRadar.name

    --Recipe
    recipeRadar.name = itemRadar.name
    -- recipeRadar.icon = itemRadar.icon
    recipeRadar.result = itemRadar.name
    recipeRadar.icon_size = 64
    if inputs.new then
        recipeRadar.enabled = true
    end
    recipeRadar.ingredients = inputs.ingredients

    --Entity
    entityRadar.name = itemRadar.name
    -- entityRadar.icon = itemRadar.icon
    entityRadar.minable.result = itemRadar.name
    entityRadar.max_distance_of_sector_revealed = inputs.scan
    entityRadar.max_distance_of_nearby_sector_revealed = inputs.reveal
    entityRadar.energy_usage = inputs.energy .. "kW"
    entityRadar.fast_replaceable_group = "radar"

    -- Base
    -- entityRadar.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/laser-turret/laser-turret-" .. inputs.number .. ".png"

    data:extend({entityRadar, recipeRadar, itemRadar})

    -- Technology
    if inputs.tech then
        technologyRadar.name = "radars-" .. inputs.tech.number
        --technologyRadar.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyRadar.unit.count = inputs.tech.count
        technologyRadar.unit.ingredients = inputs.tech.packs
        technologyRadar.prerequisites = inputs.tech.prerequisites
        technologyRadar.effects = {
            {
                type = "unlock-recipe",
                recipe = itemRadar.name
            }
        }
        data:extend({technologyRadar})
    end
end
