local applyTierArt = require("__5dim_core__.lib.space-age.tier-art")

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
    if inputs.recipeCategory then recipe.categories = { inputs.recipeCategory } end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.crafting_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution

    -- Tier art: overlay de recolor sobre la columna central, como las maquinas
    -- de Space Age. La refineria no tiene hoja propia por tier que encaje con el
    -- arte de 2.0, asi que la region la genera mods/scripts/make-region-overlays.py
    -- a partir del sprite vanilla.
    applyTierArt(entity, "oil-refinery", tonumber(inputs.number))

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
