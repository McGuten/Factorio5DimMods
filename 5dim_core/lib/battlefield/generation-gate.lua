function genGates(inputs)
    -- Copy electric furnace
    local itemGate = table.deepcopy(data.raw.item["gate"])
    local recipeGate = table.deepcopy(data.raw.recipe["gate"])
    local entityGate = table.deepcopy(data.raw["gate"]["gate"])
    local technologyGate = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        itemGate.name = "5d-gate-" .. inputs.number
    end
    -- itemGate.icon =
    --     "__5dim_energy__/graphics/icon/gate/gate-icon-" .. inputs.number .. ".png"
    itemGate.subgroup = inputs.subgroup
    itemGate.order = inputs.order
    itemGate.place_result = itemGate.name

    --Recipe
    recipeGate.name = itemGate.name
    -- recipeGate.icon = itemGate.icon
    recipeGate.result = itemGate.name
    recipeGate.icon_size = 64
    if inputs.new then
        recipeGate.enabled = true
    end
    recipeGate.ingredients = inputs.ingredients

    --Entity
    entityGate.name = itemGate.name
    -- entityGate.icon = itemGate.icon
    entityGate.minable.result = itemGate.name
    entityGate.max_health = inputs.health
    entityGate.fast_replaceable_group = "gate"

    -- Base
    -- entityGate.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/laser-turret/laser-turret-" .. inputs.number .. ".png"

    data:extend({entityGate, recipeGate, itemGate})

    -- Technology
    if inputs.tech then
        technologyGate.name = "Gates-" .. inputs.tech.number
        --technologyGate.icon = "__base__/graphics/technology/oil-refinery.png"
        technologyGate.unit.count = inputs.tech.count
        technologyGate.unit.ingredients = inputs.tech.packs
        technologyGate.prerequisites = inputs.tech.prerequisites
        technologyGate.effects = {
            {
                type = "unlock-recipe",
                recipe = itemGate.name
            }
        }
        data:extend({technologyGate})
    end
end
