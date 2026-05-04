-- 5Dim's Mod - Tank Generator Function
-- Creates tiered tank prototypes
-------------------------------------------------------------------------------

local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genTank(inputs)
    local tierNumber = tonumber(inputs.number) or 1
    local tieredIcons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/tank.png", tierNumber, 64)

    local function setPrototypeIcons(prototype)
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = table.deepcopy(tieredIcons)
    end

    if not inputs.new then
        setPrototypeIcons(data.raw["item-with-entity-data"]["tank"])
        setPrototypeIcons(data.raw.recipe["tank"])
        setPrototypeIcons(data.raw["car"]["tank"])
        setPrototypeIcons(data.raw.technology["tank"])
        return
    end

    -- Copy tank
    local item = table.deepcopy(data.raw["item-with-entity-data"]["tank"])
    local recipe = table.deepcopy(data.raw.recipe["tank"])
    local entity = table.deepcopy(data.raw["car"]["tank"])

    -- Item
    item.name = "5d-tank-" .. inputs.number
    setPrototypeIcons(item)
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    -- Recipe
    recipe.name = item.name
    setPrototypeIcons(recipe)
    recipe.enabled = false
    recipe.ingredients = inputs.ingredients
    recipe.results = { { type = "item", name = item.name, amount = 1 } }

    -- Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeIcons(entity)
    entity.minable.result = item.name
    entity.fast_replaceable_group = "tank"
    entity.max_health = inputs.health
    entity.consumption = inputs.consumption
    entity.braking_power = inputs.brakingPower

    -- Update resistances
    if inputs.resistances then
        entity.resistances = inputs.resistances
    end

    -- Equipment grid
    if inputs.equipmentGrid then
        entity.equipment_grid = inputs.equipmentGrid
    end

    -- Inventory size
    if inputs.inventorySize then
        entity.inventory_size = inputs.inventorySize
    end

    -- Apply tier color tint to the entity
    if inputs.tint then
        -- Apply tint to base animation
        if entity.animation then
            if entity.animation.layers then
                for _, layer in ipairs(entity.animation.layers) do
                    if not layer.apply_runtime_tint and not layer.draw_as_shadow then
                        layer.tint = inputs.tint
                    end
                end
            end
        end
        -- Apply tint to turret animation
        if entity.turret_animation then
            if entity.turret_animation.layers then
                for _, layer in ipairs(entity.turret_animation.layers) do
                    if not layer.apply_runtime_tint and not layer.draw_as_shadow then
                        layer.tint = inputs.tint
                    end
                end
            end
        end
    end

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["tank"])
        tech.name = "5d-tank-" .. inputs.tech.number
        setPrototypeIcons(tech)
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
