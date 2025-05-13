function genLocomotives(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
    local recipe = table.deepcopy(data.raw.recipe["locomotive"])
    local entity = table.deepcopy(data.raw["locomotive"]["locomotive"])
    local tech = table.deepcopy(data.raw.technology["railway"])

    --Item
    if inputs.new then
        item.name = "5d-locomotive-" .. inputs.number
    end
    item.icon =
        "__5dim_trains__/graphics/icon/locomotive/locomotive-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    -- entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.max_speed = inputs.maxSpeed or 1.2
    entity.max_power = (inputs.maxPower .. "kW") or (600 .. "kW")
    entity.weight = inputs.weight or 2000
    entity.max_health = inputs.health or 1000
    entity.fast_replaceable_group = "locomotive"
    if mods["Krastorio2"] then
        entity.equipment_grid = "kr-locomotive-grid"
    end

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-locomotive-" .. inputs.tech.number
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
