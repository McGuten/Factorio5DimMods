-------------------------------------------------------------------------------
-- 5Dim's Storage - Logistic Chest Generation
-- Generates tiered logistic chests with increased inventory size
-- Types: passive-provider, active-provider, storage, buffer, requester
-------------------------------------------------------------------------------

local logisticChestTypes = {
    ["passive-provider"] = {
        logisticMode = "passive-provider",
        subgroup = "logistic-pasive",
        techPrefix = "logistic-chest-passive-provider"
    },
    ["active-provider"] = {
        logisticMode = "active-provider",
        subgroup = "logistic-active",
        techPrefix = "logistic-chest-active-provider"
    },
    ["storage"] = {
        logisticMode = "storage",
        subgroup = "logistic-storage",
        techPrefix = "logistic-chest-storage",
        maxLogisticSlots = 1
    },
    ["buffer"] = {
        logisticMode = "buffer",
        subgroup = "logistic-buffer",
        techPrefix = "logistic-chest-buffer",
        trashInventorySize = 20
    },
    ["requester"] = {
        logisticMode = "requester",
        subgroup = "logistic-requester",
        techPrefix = "logistic-chest-requester"
    }
}

function genLogisticChests(inputs)
    local chestType = inputs.chestType
    local typeConfig = logisticChestTypes[chestType]
    
    if not typeConfig then
        error("Unknown logistic chest type: " .. tostring(chestType))
    end
    
    local baseName = chestType .. "-chest"
    
    -- Copy base logistic chest
    local item = table.deepcopy(data.raw.item[baseName])
    local recipe = table.deepcopy(data.raw.recipe[baseName])
    local entity = table.deepcopy(data.raw["logistic-container"][baseName])

    --Item
    if inputs.new then
        item.name = "5d-" .. baseName .. "-" .. inputs.number
    end
    -- Use vanilla icon for now (custom icons can be added later)
    -- item.icon = "__5dim_storage__/graphics/icon/logistic-chest/" .. chestType .. "-chest-icon-" .. inputs.number .. ".png"
    -- item.icon_size = 64
    item.subgroup = typeConfig.subgroup
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
    entity.logistic_mode = typeConfig.logisticMode
    
    -- Set type-specific properties
    if typeConfig.maxLogisticSlots then
        entity.max_logistic_slots = typeConfig.maxLogisticSlots
    end
    if typeConfig.trashInventorySize then
        entity.trash_inventory_size = typeConfig.trashInventorySize
    end
    
    -- Use vanilla sprite for now
    -- entity.animation.layers[1].filename =
    --     "__5dim_storage__/graphics/icon/logistic-chest/" .. chestType .. "-chest-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    if inputs.tech then
        -- Technology
        local tech = table.deepcopy(data.raw.technology["logistic-system"])
        tech.name = typeConfig.techPrefix .. "-" .. inputs.tech.number
        tech.localised_name = nil  -- Use locale file instead
        -- Use vanilla icon for now
        tech.icon = "__base__/graphics/icons/" .. baseName .. ".png"
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
