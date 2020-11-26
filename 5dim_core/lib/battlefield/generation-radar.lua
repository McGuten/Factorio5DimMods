function genRadars(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["radar"])
    local recipe = table.deepcopy(data.raw.recipe["radar"])
    local entity = table.deepcopy(data.raw["radar"]["radar"])
    local tech = table.deepcopy(data.raw.technology["gun-turret"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        item.name = "5d-radar-" .. inputs.number
    end
    item.icon =
        "__5dim_battlefield__/graphics/icon/radar/radar-icon-" .. inputs.number .. ".png"
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
    entity.max_distance_of_sector_revealed = inputs.scan
    entity.max_distance_of_nearby_sector_revealed = inputs.reveal
    entity.energy_usage = inputs.energy .. "kW"
    entity.fast_replaceable_group = "radar"

    -- Base
    entity.pictures.layers[1].hr_version.filename =
        "__5dim_battlefield__/graphics/entities/radar/radar-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-radars-" .. inputs.tech.number
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
