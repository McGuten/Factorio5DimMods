function genStoneWalls(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["stone-wall"])
    local recipe = table.deepcopy(data.raw.recipe["stone-wall"])
    local entity = table.deepcopy(data.raw["wall"]["stone-wall"])
    local tech = table.deepcopy(data.raw.technology["stone-walls"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        item.name = "5d-stone-wall-" .. inputs.number
    end
    item.icon =
        "__5dim_battlefield__/graphics/icon/stone-wall/stone-wall-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.result = item.name
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = true
    end
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.max_health = inputs.health
    entity.fast_replaceable_group = "stone-wall"

    -- Base
    -- entity.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/laser-turret/laser-turret-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "stone-walls-" .. inputs.tech.number
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
