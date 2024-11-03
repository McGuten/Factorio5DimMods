function genAssemblingMachines(inputs)
    -- Copy electric furnace
    local copyName = "assembling-machine-3"
    if inputs.copy then
        copyName = inputs.copy.name .. inputs.copy.postName
    end
    local item = table.deepcopy(data.raw.item[copyName])
    local recipe = table.deepcopy(data.raw.recipe[copyName])
    local entity = table.deepcopy(data.raw["assembling-machine"][copyName])
    local tech = table.deepcopy(data.raw.technology["automation-2"])

    --Item
    if inputs.new then
        item.name = "5d-assembling-machine-" .. inputs.number
    end
    item.icon = "__5dim_automation__/graphics/icon/assembling-machine/assembling-machine-icon-" ..
        inputs.number .. ".png"
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
    entity.crafting_speed = inputs.craftingSpeed
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.fast_replaceable_group = "assembling-machine"

    -- Base
    entity.graphics_set.animation.layers[1].filename =
        "__5dim_automation__/graphics/entities/assembling-machine/assembling-machine-" .. inputs.number .. ".png"
    entity.graphics_set.animation.layers[1].width = 214
    entity.graphics_set.animation.layers[1].height = 226

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "automation-" .. inputs.tech.number
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
        data:extend({ tech })
    end
end
