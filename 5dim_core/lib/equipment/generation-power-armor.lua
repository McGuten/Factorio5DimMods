function genPowerArmors(inputs)
    local item = ""
    local grid = ""
    local recipe = ""
    local tech = ""
    -- Copy electric furnace
    if inputs.number == "01" then
        item = table.deepcopy(data.raw.armor["power-armor"])
        grid = table.deepcopy(data.raw["equipment-grid"]["medium-equipment-grid"])
        recipe = table.deepcopy(data.raw.recipe["power-armor"])
        tech = table.deepcopy(data.raw.technology["power-armor"])
    else
        item = table.deepcopy(data.raw.armor["power-armor-mk2"])
        grid = table.deepcopy(data.raw["equipment-grid"]["large-equipment-grid"])
        recipe = table.deepcopy(data.raw.recipe["power-armor-mk2"])
        tech = table.deepcopy(data.raw.technology["power-armor-mk2"])
    end

    -- Grid
    if inputs.new then
        grid.name = "5d-grid-power-armor-" .. inputs.number
    end
    grid.width = inputs.width or 10
    grid.height = inputs.height or 10

    --Item
    if inputs.new then
        item.name = "5d-power-armor-" .. inputs.number
    end
    item.icon = "__5dim_equipment__/graphics/icon/power-armor/power-armor-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.equipment_grid = grid.name
    item.inventory_size_bonus = inputs.inventoryBonus

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end
    if not mods['aai-industry'] and not mods['space-age'] and inputs.number == "02" then
        table.insert(recipe.ingredients, { type = "item", name = "power-armor", amount = 1 })
    end
    recipe.enabled = false

    data:extend({ grid, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-power-armor-" .. inputs.tech.number
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
