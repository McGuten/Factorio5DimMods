function genStoneWalls(inputs)
    -- Copy electric furnace
    local itemStoneWall = table.deepcopy(data.raw.item["stone-wall"])
    local recipeStoneWall = table.deepcopy(data.raw.recipe["stone-wall"])
    local entityStoneWall = table.deepcopy(data.raw["wall"]["stone-wall"])
    local technologyStoneWall = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        itemStoneWall.name = "5d-stone-wall-" .. inputs.number
    end
    -- itemStoneWall.icon =
    --     "__5dim_energy__/graphics/icon/stone-wall/stone-wall-icon-" .. inputs.number .. ".png"
    itemStoneWall.subgroup = inputs.subgroup
    itemStoneWall.order = inputs.order
    itemStoneWall.place_result = itemStoneWall.name

    --Recipe
    recipeStoneWall.name = itemStoneWall.name
    -- recipeStoneWall.icon = itemStoneWall.icon
    recipeStoneWall.result = itemStoneWall.name
    recipeStoneWall.icon_size = 64
    if inputs.new then
        recipeStoneWall.enabled = true
    end
    recipeStoneWall.ingredients = inputs.ingredients

    --Entity
    entityStoneWall.name = itemStoneWall.name
    -- entityStoneWall.icon = itemStoneWall.icon
    entityStoneWall.minable.result = itemStoneWall.name
    entityStoneWall.max_health = inputs.health

    -- Base
    -- entityStoneWall.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/laser-turret/laser-turret-" .. inputs.number .. ".png"

    data:extend({entityStoneWall, recipeStoneWall, itemStoneWall})

    -- Technology
    if inputs.tech then
        technologyStoneWall.name = "StoneWalls-" .. inputs.tech.number
        --technologyStoneWall.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyStoneWall.unit.count = inputs.tech.count
        technologyStoneWall.unit.ingredients = inputs.tech.packs
        technologyStoneWall.prerequisites = inputs.tech.prerequisites
        technologyStoneWall.effects = {
            {
                type = "unlock-recipe",
                recipe = itemStoneWall.name
            }
        }
        data:extend({technologyStoneWall})
    end
end
