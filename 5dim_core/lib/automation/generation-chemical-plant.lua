function genChemicalPlants(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["chemical-plant"])
    local recipe = table.deepcopy(data.raw.recipe["chemical-plant"])
    local entity = table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])
    local tech = table.deepcopy(data.raw.technology["advanced-oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-chemical-plant-" .. inputs.number
    end
    item.icon =
        "__5dim_automation__/graphics/icon/chemical-plant/chemical-plant-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.icon_size = 64
    recipe.enabled = false
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.crafting_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution

    if mods['space-age'] then
        entity.crafting_categories = {"chemistry", "chemistry-or-cryogenics", "organic-or-chemistry"}
    end

    -- East
    entity.graphics_set.animation.east.layers[1].filename =
        "__5dim_automation__/graphics/entities/chemical-plant/chemical-plant-" .. inputs.number .. ".png"

    -- North
    entity.graphics_set.animation.north.layers[1].filename =
        "__5dim_automation__/graphics/entities/chemical-plant/chemical-plant-" .. inputs.number .. ".png"

    -- South
    entity.graphics_set.animation.south.layers[1].filename =
        "__5dim_automation__/graphics/entities/chemical-plant/chemical-plant-" .. inputs.number .. ".png"

    -- West
    entity.graphics_set.animation.west.layers[1].filename =
        "__5dim_automation__/graphics/entities/chemical-plant/chemical-plant-" .. inputs.number .. ".png"

    -- make_4way_animation_from_spritesheet({ layers =
    -- {
    --     {
    --         filename = "__base__/graphics/entity/chemical-plant/chemical-plant" .. inputs.number .. ".png",
    --         width = 220,
    --         height = 292,
    --         frame_count = 24,
    --         line_length = 12,
    --         shift = util.by_pixel(0.5, -9),
    --         scale = 0.5
    --     },
    --     {
    --         filename = "__base__/graphics/entity/chemical-plant/chemical-plant-shadow.png",
    --         width = 312,
    --         height = 222,
    --         repeat_count = 24,
    --         shift = util.by_pixel(27, 6),
    --         draw_as_shadow = true,
    --         scale = 0.5
    --     }
    -- }})

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-chemical-plant-" .. inputs.tech.number
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
