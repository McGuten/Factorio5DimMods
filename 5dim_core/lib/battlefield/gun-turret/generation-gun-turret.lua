require("tint-gun-turret")

local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")
local RepairSpeedScaling = require("__5dim_core__.lib.repair-speed-scaling")

local function setPrototypeIcon(prototype, iconPath, iconSize, icons)
    if icons then
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = icons
        return
    end

    prototype.icon = iconPath
    prototype.icon_size = iconSize
    prototype.icons = nil
end

local function applyGunTurretTints(entity, baseTint, turretTint)
    if not entity or not baseTint or not turretTint then
        return
    end

    entity.folded_animation.layers[2] =
        dim_gun_turret_extension_mask {
            frame_count = 1,
            line_length = 1,
            tint = turretTint
        }
    entity.preparing_animation.layers[2] = dim_gun_turret_extension_mask { tint = turretTint }
    entity.folding_animation.layers[2] =
        dim_gun_turret_extension_mask {
            run_mode = "backward",
            tint = turretTint
        }
    entity.graphics_set.base_visualisation.animation.layers[2].apply_runtime_tint = false
    entity.graphics_set.base_visualisation.animation.layers[2].tint = baseTint
    entity.attacking_animation.layers[2].apply_runtime_tint = false
    entity.attacking_animation.layers[2].tint = turretTint
    entity.prepared_animation.layers[2].apply_runtime_tint = false
    entity.prepared_animation.layers[2].tint = turretTint
end

function genGunTurrets(inputs)
    local split = {}
    local separator = string.find(inputs.number, "-", 1, true)
    if separator then
        split[1] = string.sub(inputs.number, 1, separator - 1)
        split[2] = string.sub(inputs.number, separator + 1)
    else
        split[1] = inputs.number
    end
    
    local iconSize = inputs.iconSize or 64
    local isSniper = string.find(inputs.number, "sniper") ~= nil
    local tierNumber = tonumber(split[2] or split[1])

    local iconPath = inputs.iconPath or "__base__/graphics/icons/gun-turret.png"
    local techIconPath = inputs.techIconPath or iconPath
    local techIconSize = inputs.techIconSize or iconSize
    local tieredIcons = nil
    local tieredTechIcons = nil
    local baseTint = inputs.baseTint or inputs.tint
    local turretTint = inputs.turretTint or inputs.tint
    if tierNumber then
        tieredIcons = TierBadgeIcons.buildTieredIcons(iconPath, tierNumber, iconSize)
        tieredTechIcons = TierBadgeIcons.buildTieredIcons(techIconPath, tierNumber, techIconSize)
    end
    
    -- For vanilla tier (new = false), only update icon of base entity
    if not inputs.new then
        if isSniper then
            return
        end

        setPrototypeIcon(data.raw.item["gun-turret"], iconPath, iconSize, table.deepcopy(tieredIcons))
        setPrototypeIcon(data.raw.recipe["gun-turret"], iconPath, iconSize, table.deepcopy(tieredIcons))
        setPrototypeIcon(data.raw["ammo-turret"]["gun-turret"], iconPath, iconSize, table.deepcopy(tieredIcons))
        setPrototypeIcon(data.raw.technology["gun-turret"], techIconPath, techIconSize, table.deepcopy(tieredTechIcons or tieredIcons))
        applyGunTurretTints(data.raw["ammo-turret"]["gun-turret"], baseTint, turretTint)
        return
    end
    
    -- Copy gun turret
    local item = table.deepcopy(data.raw.item["gun-turret"])
    local recipe = table.deepcopy(data.raw.recipe["gun-turret"])
    local entity = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])
    local tech = table.deepcopy(data.raw.technology["gun-turret"])

    --Item
    item.name = "5d-gun-turret-" .. inputs.number
    setPrototypeIcon(item, iconPath, iconSize, tieredIcons)

    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeIcon(recipe, iconPath, iconSize, tieredIcons)
    recipe.enabled = false
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeIcon(entity, iconPath, iconSize, tieredIcons)
    entity.minable.result = item.name
    entity.automated_ammo_count = inputs.ammoCount
    -- Modify attack_parameters - keep original structure, just update allowed values
    if entity.attack_parameters then
        if inputs.ammoCategory then
            entity.attack_parameters.ammo_category = inputs.ammoCategory
        end
        entity.attack_parameters.range = inputs.range
        if inputs.attackSpeed then
            entity.attack_parameters.cooldown = inputs.attackSpeed
        elseif inputs.cooldown then
            entity.attack_parameters.cooldown = inputs.cooldown
        end

        local damageModifier = inputs.damageModifier
        if damageModifier == nil and inputs.cooldown and not inputs.attackSpeed then
            damageModifier = inputs.cooldown
        end
        if damageModifier ~= nil then
            entity.attack_parameters.damage_modifier = damageModifier
        end
    end
    
    applyGunTurretTints(entity, baseTint, turretTint)
    entity.max_health = inputs.health or 480
    entity.repair_speed_modifier = inputs.repairSpeedModifier or RepairSpeedScaling.linear(inputs.repairBaseHealth or 480, entity.max_health)
    entity.fast_replaceable_group = "gun-turret"
    entity.resistances = inputs.resistances or nil
    data:extend(
        {
            entity,
            recipe,
            item
        }
    )

    -- Technology
    if inputs.tech then
        tech.name = inputs.tech.number
        setPrototypeIcon(tech, techIconPath, techIconSize, tieredTechIcons or tieredIcons)
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
    if inputs.new then
        table.insert(
            data.raw.technology["physical-projectile-damage-1"].effects,
            { type = "turret-attack", turret_id = item.name, modifier = 0.1 }
        )

        table.insert(
            data.raw.technology["physical-projectile-damage-2"].effects,
            { type = "turret-attack", turret_id = item.name, modifier = 0.1 }
        )

        table.insert(
            data.raw.technology["physical-projectile-damage-3"].effects,
            { type = "turret-attack", turret_id = item.name, modifier = 0.2 }
        )

        table.insert(
            data.raw.technology["physical-projectile-damage-4"].effects,
            { type = "turret-attack", turret_id = item.name, modifier = 0.2 }
        )

        table.insert(
            data.raw.technology["physical-projectile-damage-5"].effects,
            { type = "turret-attack", turret_id = item.name, modifier = 0.2 }
        )
        if mods['space-age'] then
            table.insert(
                data.raw.technology["physical-projectile-damage-6"].effects,
                { type = "turret-attack", turret_id = item.name, modifier = 0.2 }
            )

            table.insert(
                data.raw.technology["physical-projectile-damage-7"].effects,
                { type = "turret-attack", turret_id = item.name, modifier = 0.2 }
            )
        else
            table.insert(
                data.raw.technology["physical-projectile-damage-6"].effects,
                { type = "turret-attack", turret_id = item.name, modifier = 0.4 }
            )

            table.insert(
                data.raw.technology["physical-projectile-damage-7"].effects,
                { type = "turret-attack", turret_id = item.name, modifier = 0.7 }
            )
        end
    end
end
