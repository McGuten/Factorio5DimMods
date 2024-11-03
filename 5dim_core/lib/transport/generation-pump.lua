function genPumps(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["pump"])
    local recipe = table.deepcopy(data.raw.recipe["pump"])
    local entity = table.deepcopy(data.raw["pump"]["pump"])
    local tech = table.deepcopy(data.raw.technology["advanced-oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-pump-" .. inputs.number
    end
    item.icon =
        "__5dim_transport__/graphics/icon/pump/pump-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
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
    entity.pumping_speed = inputs.craftingSpeed
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.fast_replaceable_group = "pump"

    -- North
    entity.animations.north.filename =
        "__5dim_transport__/graphics/entities/pump/pump-north/pump-north-" .. inputs.number .. ".png"

    -- -- East
    entity.animations.east.filename =
        "__5dim_transport__/graphics/entities/pump/pump-east/pump-east-" .. inputs.number .. ".png"

    -- -- South
    entity.animations.south.filename =
        "__5dim_transport__/graphics/entities/pump/pump-south/pump-south-" .. inputs.number .. ".png"

    -- -- West
    entity.animations.west.filename =
        "__5dim_transport__/graphics/entities/pump/pump-west/pump-west-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-pump-" .. inputs.tech.number
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
