-------------------------------------------------------------------------------
-- 5Dim's Storage - Steel Chest Generation
-- Generates tiered steel chests with increased inventory size
-------------------------------------------------------------------------------

local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

local function setPrototypeTierIcon(prototype, baseIconPath, tier, customIconPath, iconSize)
    if customIconPath then
        prototype.icon = customIconPath
        prototype.icon_size = iconSize or 64
        prototype.icons = nil
        return
    end

    prototype.icon = nil
    prototype.icon_size = nil
    prototype.icons = TierBadgeIcons.buildTieredIcons(baseIconPath, tier, iconSize or 64)
end

function genSteelChests(inputs)
    local tier = tonumber(inputs.number)
    local baseIconPath = "__base__/graphics/icons/steel-chest.png"
    -- Copy steel chest
    local item = table.deepcopy(data.raw.item["steel-chest"])
    local recipe = table.deepcopy(data.raw.recipe["steel-chest"])
    local entity = table.deepcopy(data.raw["container"]["steel-chest"])

    --Item
    if inputs.new then
        item.name = "5d-steel-chest-" .. inputs.number
    end
    setPrototypeTierIcon(item, baseIconPath, tier, inputs.iconPath, 64)
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeTierIcon(recipe, baseIconPath, tier, inputs.iconPath, 64)
    recipe.enabled = false
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeTierIcon(entity, baseIconPath, tier, inputs.iconPath, 64)
    entity.minable.result = item.name
    entity.fast_replaceable_group = "container"
    entity.inventory_size = inputs.inventorySize

    if inputs.entityPicturePath then
        entity.picture.layers[1].filename = inputs.entityPicturePath
    end

    data:extend({entity, recipe, item})

    if inputs.tech then
        -- Technology
        local tech = table.deepcopy(data.raw.technology["steel-processing"])
        tech.name = "steel-chest-" .. inputs.tech.number
        tech.localised_name = nil  -- Use locale file instead
        setPrototypeTierIcon(tech, baseIconPath, tier, inputs.techIconPath, 64)
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
