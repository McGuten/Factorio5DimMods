function genLabs(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["lab"])
    local recipe = table.deepcopy(data.raw.recipe["lab"])
    local entity = table.deepcopy(data.raw["lab"]["lab"])
    local tech = table.deepcopy(data.raw.technology["advanced-oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-lab-" .. inputs.number
    end
    item.icon =
        "__5dim_automation__/graphics/icon/lab/lab-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    recipe.ingredients = inputs.ingredients
    recipe.results = { { type = "item", name = item.name, amount = 1 } }

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.researching_speed = inputs.craftingSpeed
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.module_slots = inputs.moduleSlots
    entity.fast_replaceable_group = "lab"
    
    entity.on_animation.layers[1].filename =
        "__5dim_automation__/graphics/entities/lab/lab-" .. inputs.number .. ".png"
    
    entity.off_animation.layers[1].filename =
        "__5dim_automation__/graphics/entities/lab/lab-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-lab-" .. inputs.tech.number
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