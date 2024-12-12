function genOilRefinery(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["oil-refinery"])
    local recipe = table.deepcopy(data.raw.recipe["oil-refinery"])
    local entity = table.deepcopy(data.raw["assembling-machine"]["oil-refinery"])
    local tech = table.deepcopy(data.raw.technology["advanced-oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-oil-refinery-" .. inputs.number
    end
    item.icon =
        "__5dim_automation__/graphics/icon/oil-refinery/oil-refinery-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false

    if inputs.new then
        recipe.ingredients = inputs.ingredients
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.crafting_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution

    -- East
    -- entity.animation.east.layers[1].filename =
    --     "__5dim_automation__/graphics/entities/oil-refinery/oil-refinery-" .. inputs.number .. ".png"

    -- -- North
    -- entity.animation.north.layers[1].filename =
    --     "__5dim_automation__/graphics/entities/oil-refinery/oil-refinery-" .. inputs.number .. ".png"

    -- -- South
    -- entity.animation.south.layers[1].filename =
    --     "__5dim_automation__/graphics/entities/oil-refinery/oil-refinery-" .. inputs.number .. ".png"

    -- -- West
    -- entity.animation.west.layers[1].filename =
    --     "__5dim_automation__/graphics/entities/oil-refinery/oil-refinery-" .. inputs.number .. ".png"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-oil-refinery-" .. inputs.tech.number
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
