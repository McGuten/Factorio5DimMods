-------------------------------------------------------------------------------
-- 5Dim's Mod - Artillery Turret Generator Function
-- Creates tiered artillery turret prototypes
-------------------------------------------------------------------------------

local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genArtilleryTurret(inputs)
    local tier = tonumber(inputs.number)
    local tieredIcons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/artillery-turret.png", tier, 64)

    if not inputs.new then
        local vanillaItem = data.raw.item and data.raw.item["artillery-turret"]
        local vanillaRecipe = data.raw.recipe and data.raw.recipe["artillery-turret"]
        local vanillaEntity = data.raw["artillery-turret"] and data.raw["artillery-turret"]["artillery-turret"]

        if vanillaItem then
            vanillaItem.icon = nil
            vanillaItem.icon_size = nil
            vanillaItem.icons = table.deepcopy(tieredIcons)
        end
        if vanillaRecipe then
            vanillaRecipe.icon = nil
            vanillaRecipe.icon_size = nil
            vanillaRecipe.icons = table.deepcopy(tieredIcons)
        end
        if vanillaEntity then
            vanillaEntity.icon = nil
            vanillaEntity.icon_size = nil
            vanillaEntity.icons = table.deepcopy(tieredIcons)
        end
        return
    end

    -- Copy artillery turret
    local item = table.deepcopy(data.raw.item["artillery-turret"])
    local recipe = table.deepcopy(data.raw.recipe["artillery-turret"])
    local entity = table.deepcopy(data.raw["artillery-turret"]["artillery-turret"])
    local gun = entity.gun and data.raw.gun[entity.gun] and table.deepcopy(data.raw.gun[entity.gun]) or nil

    --Item
    item.name = "5d-artillery-turret-" .. inputs.number
    item.icon = nil
    item.icon_size = nil
    item.icons = table.deepcopy(tieredIcons)
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = nil
    recipe.icon_size = nil
    recipe.icons = table.deepcopy(tieredIcons)
    recipe.enabled = false
    recipe.ingredients = inputs.ingredients
    recipe.results = { { type = "item", name = item.name, amount = 1 } }

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = nil
    entity.icon_size = nil
    entity.icons = table.deepcopy(tieredIcons)
    entity.minable.result = item.name
    entity.fast_replaceable_group = "artillery-turret"
    entity.turret_rotation_speed = inputs.rotationSpeed or entity.turret_rotation_speed
    entity.manual_range_modifier = inputs.manualRangeModifier or entity.manual_range_modifier

    if gun then
        gun.name = item.name .. "-cannon"
        if gun.attack_parameters then
            gun.attack_parameters.range = inputs.automaticRange or gun.attack_parameters.range
        end
        entity.gun = gun.name
    end

    if gun then
        data:extend({ gun, entity, recipe, item })
    else
        data:extend({ entity, recipe, item })
    end

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["artillery"])
        tech.name = "5d-artillery-turret-" .. inputs.tech.number
        tech.icon = nil
        tech.icon_size = nil
        tech.icons = table.deepcopy(tieredIcons)
        tech.unit.count = inputs.tech.count
        tech.unit.ingredients = inputs.tech.packs
        tech.prerequisites = inputs.tech.prerequisites
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = item.name
            }
        }
        if inputs.tech.attackModifier and inputs.tech.attackModifier > 0 then
            table.insert(tech.effects, {
                type = "turret-attack",
                turret_id = item.name,
                modifier = inputs.tech.attackModifier
            })
        end
        data:extend({ tech })
    end
end
