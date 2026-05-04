-- 5Dim's Mod - Spidertron Generator Function
-- Creates tiered spidertron prototypes
-------------------------------------------------------------------------------

local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genSpidertron(inputs)
    local tierNumber = tonumber(inputs.number) or 1
    local tieredIcons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/spidertron.png", tierNumber, 64)

    local function setPrototypeIcons(prototype)
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = table.deepcopy(tieredIcons)
    end

    if not inputs.new then
        setPrototypeIcons(data.raw["item-with-entity-data"]["spidertron"])
        setPrototypeIcons(data.raw.recipe["spidertron"])
        setPrototypeIcons(data.raw["spider-vehicle"]["spidertron"])
        setPrototypeIcons(data.raw.technology["spidertron"])
        return
    end

    -- Copy spidertron
    local item = table.deepcopy(data.raw["item-with-entity-data"]["spidertron"])
    local recipe = table.deepcopy(data.raw.recipe["spidertron"])
    local entity = table.deepcopy(data.raw["spider-vehicle"]["spidertron"])

    -- Item
    item.name = "5d-spidertron-" .. inputs.number
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
    entity.fast_replaceable_group = "spidertron"
    entity.max_health = inputs.health
    entity.movement_energy_consumption = inputs.movementEnergy

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
            if inputs.legResistances then
                leg.resistances = table.deepcopy(inputs.legResistances)
            end
            data:extend({ leg })
        end
    end

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["spidertron"])
        tech.name = "5d-spidertron-" .. inputs.tech.number
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
