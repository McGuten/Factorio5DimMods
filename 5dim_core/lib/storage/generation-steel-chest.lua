-------------------------------------------------------------------------------
-- 5Dim's Storage - Steel Chest Generation
-- Generates tiered steel chests with increased inventory size
-------------------------------------------------------------------------------

function genSteelChests(inputs)
    -- Copy steel chest
    local item = table.deepcopy(data.raw.item["steel-chest"])
    local recipe = table.deepcopy(data.raw.recipe["steel-chest"])
    local entity = table.deepcopy(data.raw["container"]["steel-chest"])

    --Item
    if inputs.new then
        item.name = "5d-steel-chest-" .. inputs.number
    end
    -- Use vanilla icon for now (custom icons can be added later)
    -- item.icon = "__5dim_storage__/graphics/icon/steel-chest/steel-chest-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    -- Use vanilla icon for now
    -- recipe.icon = item.icon
    -- recipe.icon_size = 64
    recipe.enabled = false
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    -- Use vanilla icon for now
    -- entity.icon = item.icon
    -- entity.icon_size = 64
    entity.minable.result = item.name
    entity.fast_replaceable_group = "container"
    entity.inventory_size = inputs.inventorySize
    -- Use vanilla sprite for now
    -- entity.picture.layers[1].filename =
    --     "__5dim_storage__/graphics/entities/steel-chest/steel-chest-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    if inputs.tech then
        -- Technology
        local tech = table.deepcopy(data.raw.technology["steel-processing"])
        tech.name = "steel-chest-" .. inputs.tech.number
        tech.localised_name = nil  -- Use locale file instead
        -- Use vanilla icon for now
        tech.icon = "__base__/graphics/icons/steel-chest.png"
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
