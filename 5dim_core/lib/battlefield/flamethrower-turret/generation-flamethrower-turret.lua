require("tint-laser-turret")

function genFlamethrowerTurrets(inputs)
    -- Copy electric furnace
    local itemFlamethrowerTurret = table.deepcopy(data.raw.item["flamethrower-turret"])
    local recipeFlamethrowerTurret = table.deepcopy(data.raw.recipe["flamethrower-turret"])
    local entityFlamethrowerTurret = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"])
    local technologyFlamethrowerTurret = table.deepcopy(data.raw.technology["turrets"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        itemFlamethrowerTurret.name = "5d-flamethrower-turret-" .. inputs.number
    end
    -- itemFlamethrowerTurret.icon =
    --     "__5dim_energy__/graphics/icon/flamethrower-turret/flamethrower-turret-icon-" .. inputs.number .. ".png"
    itemFlamethrowerTurret.subgroup = inputs.subgroup
    itemFlamethrowerTurret.order = inputs.order
    itemFlamethrowerTurret.place_result = itemFlamethrowerTurret.name

    --Recipe
    recipeFlamethrowerTurret.name = itemFlamethrowerTurret.name
    -- recipeFlamethrowerTurret.icon = itemFlamethrowerTurret.icon
    recipeFlamethrowerTurret.result = itemFlamethrowerTurret.name
    recipeFlamethrowerTurret.icon_size = 64
    if inputs.new then
        recipeFlamethrowerTurret.enabled = true
    end
    recipeFlamethrowerTurret.ingredients = inputs.ingredients

    --Entity
    entityFlamethrowerTurret.name = itemFlamethrowerTurret.name
    -- entityFlamethrowerTurret.icon = itemFlamethrowerTurret.icon
    entityFlamethrowerTurret.minable.result = itemFlamethrowerTurret.name
    entityFlamethrowerTurret.attack_parameters.cooldown = inputs.attackSpeed
    entityFlamethrowerTurret.attack_parameters.range = inputs.range
    entityFlamethrowerTurret.attack_parameters.min_range = inputs.minRange
    entityFlamethrowerTurret.prepare_range = inputs.range + 5
    entityFlamethrowerTurret.max_health = inputs.health or 1400
    entityFlamethrowerTurret.fast_replaceable_group = "flamethrower-turret"
    -- entityFlamethrowerTurret.base_picture.north.layers[2].tint = inputs.tint
    -- entityFlamethrowerTurret.base_picture.north.layers[2].apply_runtime_tint = false
    -- entityFlamethrowerTurret.base_picture.east.layers[2].tint = inputs.tint
    -- entityFlamethrowerTurret.base_picture.east.layers[2].apply_runtime_tint = false
    -- entityFlamethrowerTurret.base_picture.south.layers[2].tint = inputs.tint
    -- entityFlamethrowerTurret.base_picture.south.layers[2].apply_runtime_tint = false
    -- entityFlamethrowerTurret.base_picture.west.layers[2].tint = inputs.tint
    -- entityFlamethrowerTurret.base_picture.west.layers[2].apply_runtime_tint = false

    -- Base
    -- entityFlamethrowerTurret.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/flamethrower-turret/flamethrower-turret-" .. inputs.number .. ".png"

    data:extend({entityFlamethrowerTurret, recipeFlamethrowerTurret, itemFlamethrowerTurret})

    -- Technology
    if inputs.tech then
        technologyFlamethrowerTurret.name = "5d-flamethrower-turrets-" .. inputs.tech.number
        technologyFlamethrowerTurret.icon = itemFlamethrowerTurret.icon
        technologyFlamethrowerTurret.icon_size = 64
        technologyFlamethrowerTurret.unit.count = inputs.tech.count
        technologyFlamethrowerTurret.unit.ingredients = inputs.tech.packs
        technologyFlamethrowerTurret.prerequisites = inputs.tech.prerequisites
        technologyFlamethrowerTurret.effects = {
            {
                type = "unlock-recipe",
                recipe = itemFlamethrowerTurret.name
            }
        }
        data:extend({technologyFlamethrowerTurret})
    end
end
