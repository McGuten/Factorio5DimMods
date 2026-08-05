local applyTierArt = require("__5dim_core__.lib.space-age.tier-art")

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
    entity.fast_replaceable_group = "assembling-machine"

    if mods['space-age'] and inputs.new then
        entity.crafting_categories = { "basic-crafting", "crafting", "advanced-crafting", "crafting-with-fluid",
            "electronics", "electronics-with-fluid", "pressing", "metallurgy-or-assembling", "organic-or-hand-crafting",
            "organic-or-assembling", "electronics-or-assembling", "cryogenics-or-assembling",
            "crafting-with-fluid-or-metallurgy" }
    end

    -- Tier art: overlay de recolor sobre la carcasa (paredes y faldon), como las
    -- maquinas de Space Age; el mecanismo central se queda vanilla. La hoja
    -- legacy de 5dim_automation era arte de 1.1 y dibujaba otro edificio, asi que
    -- la region la genera mods/scripts/make-region-overlays.py desde el sprite
    -- vanilla, una por cada maquina copiada (assembling machine 1, 2 y 3).
    applyTierArt(entity, "assembling-machine", tonumber(inputs.number))

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
