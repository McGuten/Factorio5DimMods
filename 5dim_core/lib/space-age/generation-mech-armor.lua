-------------------------------------------------------------------------------
-- 5Dim's Mod - Mech Armor Generator Function
-- Creates tiered mech armor prototypes for Space Age
-------------------------------------------------------------------------------

function genMechArmor(inputs)
    -- Copy mech armor
    local item = table.deepcopy(data.raw["armor"]["mech-armor"])
    local recipe = table.deepcopy(data.raw.recipe["mech-armor"])

    --Item (mech armor is an armor, not a regular item)
    if inputs.new then
        item.name = "5d-mech-armor-" .. inputs.number
    end
    
    -- Create custom equipment grid if dimensions provided
    if inputs.gridWidth and inputs.gridHeight then
        local gridName = "5d-mech-armor-grid-" .. inputs.number
        local baseGrid = table.deepcopy(data.raw["equipment-grid"]["huge-equipment-grid"])
        baseGrid.name = gridName
        baseGrid.width = inputs.gridWidth
        baseGrid.height = inputs.gridHeight
        data:extend({ baseGrid })
        item.equipment_grid = gridName
    end
    item.icon = "__5dim_space_age__/graphics/icon/mech-armor/mech-armor-" .. string.format("%02d", inputs.number) .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    -- Scale inventory bonus with tier
    if inputs.inventoryBonus then
        item.inventory_size_bonus = inputs.inventoryBonus
    end

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
        recipe.ingredients = inputs.ingredients
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
    end

    data:extend({ item, recipe })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["mech-armor"])
        tech.name = "5d-mech-armor-" .. inputs.tech.number
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
