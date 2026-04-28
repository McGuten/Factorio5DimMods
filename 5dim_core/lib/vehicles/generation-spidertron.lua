-------------------------------------------------------------------------------
-- 5Dim's Mod - Spidertron Generator Function
-- Creates tiered spidertron prototypes
-------------------------------------------------------------------------------

function genSpidertron(inputs)
    -- Skip vanilla tier (when new = false) - don't modify base game prototypes
    if not inputs.new then
        return
    end

    -- Copy spidertron
    local item = table.deepcopy(data.raw["item-with-entity-data"]["spidertron"])
    local recipe = table.deepcopy(data.raw.recipe["spidertron"])
    local entity = table.deepcopy(data.raw["spider-vehicle"]["spidertron"])

    -- Item
    item.name = "5d-spidertron-" .. inputs.number
    item.icon = "__base__/graphics/icons/spidertron.png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    -- Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    recipe.ingredients = inputs.ingredients
    recipe.results = { { type = "item", name = item.name, amount = 1 } }

    -- Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.fast_replaceable_group = "spidertron"
    entity.max_health = inputs.health
    entity.movement_energy_consumption = inputs.movementEnergy

    -- Equipment grid
    if inputs.equipmentGrid then
        entity.equipment_grid = inputs.equipmentGrid
    end

    -- Inventory size
    if inputs.inventorySize then
        entity.inventory_size = inputs.inventorySize
    end

    -- Trash inventory size
    if inputs.trashInventorySize then
        entity.trash_inventory_size = inputs.trashInventorySize
    end

    -- Guns (rocket launchers)
    if inputs.guns then
        entity.guns = inputs.guns
    end

    -- Apply tier color tint to the entity
    if inputs.tint then
        if entity.graphics_set and entity.graphics_set.base_animation then
            if entity.graphics_set.base_animation.layers then
                for _, layer in ipairs(entity.graphics_set.base_animation.layers) do
                    if not layer.apply_runtime_tint and not layer.draw_as_shadow then
                        layer.tint = inputs.tint
                    end
                end
            end
        end
    end

    -- Update legs to match new spidertron name
    if entity.spider_engine and entity.spider_engine.legs then
        for i, leg in ipairs(entity.spider_engine.legs) do
            leg.leg = item.name .. "-leg-" .. i
        end
    end

    data:extend({ entity, recipe, item })

    -- Create legs for the spidertron (copy from vanilla)
    for i = 1, 8 do
        local legName = "spidertron-leg-" .. i
        if data.raw["spider-leg"][legName] then
            local leg = table.deepcopy(data.raw["spider-leg"][legName])
            leg.name = item.name .. "-leg-" .. i
            data:extend({ leg })
        end
    end

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["spidertron"])
        tech.name = "5d-spidertron-" .. inputs.tech.number
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
