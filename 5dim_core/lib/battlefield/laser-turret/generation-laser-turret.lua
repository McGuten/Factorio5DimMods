require("tint-laser-turret")

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

local function applyLaserTurretTints(entity, baseTint, turretTint)
    if not entity or not baseTint or not turretTint then
        return
    end

    entity.folded_animation.layers[3] =
        dim_laser_turret_extension_mask {
            frame_count = 1,
            line_length = 1,
            tint = turretTint
        }
    entity.preparing_animation.layers[3] = dim_laser_turret_extension_mask { tint = turretTint }
    entity.prepared_animation.layers[3] = dim_laser_turret_shooting_mask { tint = turretTint }
    entity.folding_animation.layers[3] =
        dim_laser_turret_extension_mask {
            run_mode = "backward",
            tint = turretTint
        }
    entity.graphics_set.base_visualisation.animation.layers[1].tint = baseTint
end

function genLaserTurrets(inputs)
    local split = {}
    local separator = string.find(inputs.number, "-", 1, true)
    if separator then
        split[1] = string.sub(inputs.number, 1, separator - 1)
        split[2] = string.sub(inputs.number, separator + 1)
    else
        split[1] = inputs.number
    end
    local tierNumber = tonumber(split[2] or split[1]) or 1
    local multiplier = 1
    
    -- Only the standard and sniper branches remain.
    local iconPath
    if string.find(inputs.number, "sniper") ~= nil then
        iconPath = "__5dim_battlefield__/graphics/icon/laser-turret/sniper/laser-turret-sniper-" .. split[2] .. ".png"
        multiplier = 4
    else
        iconPath = "__5dim_battlefield__/graphics/icon/laser-turret/normal/laser-turret-normal-" .. split[1] .. ".png"
        multiplier = 1
    end
    local tieredIcons = TierBadgeIcons.buildTieredIcons(iconPath, tierNumber, 64)
    local baseTint = inputs.baseTint or inputs.tint
    local turretTint = inputs.turretTint or inputs.tint
    
    -- For vanilla tier (new = false), only update icon of base entity
    if not inputs.new then
        if string.find(inputs.number, "sniper") ~= nil then
            return
        end

        setPrototypeIcon(data.raw.item["laser-turret"], iconPath, 64, table.deepcopy(tieredIcons))
        setPrototypeIcon(data.raw.recipe["laser-turret"], iconPath, 64, table.deepcopy(tieredIcons))
        setPrototypeIcon(data.raw["electric-turret"]["laser-turret"], iconPath, 64, table.deepcopy(tieredIcons))
        setPrototypeIcon(data.raw.technology["laser-turret"], iconPath, 64, table.deepcopy(tieredIcons))
        applyLaserTurretTints(data.raw["electric-turret"]["laser-turret"], baseTint, turretTint)
        return
    end
    
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["laser-turret"])
    local recipe = table.deepcopy(data.raw.recipe["laser-turret"])
    local entity = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
    local tech = table.deepcopy(data.raw.technology["laser-turret"])

    --Item
    item.name = "5d-laser-turret-" .. inputs.number
    setPrototypeIcon(item, iconPath, 64, table.deepcopy(tieredIcons))

    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeIcon(recipe, iconPath, 64, table.deepcopy(tieredIcons))
    recipe.enabled = false
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeIcon(entity, iconPath, 64, table.deepcopy(tieredIcons))
    entity.minable.result = item.name
    
    -- Modify attack_parameters - keep original structure, just update values
    -- The deepcopy preserves the full structure from the base game
    if entity.attack_parameters then
        entity.attack_parameters.range = inputs.range
        if inputs.cooldown then
            entity.attack_parameters.cooldown = inputs.cooldown
        end
        if inputs.damage then
            local vanillaDamage = 20
            local baseDamageModifier = entity.attack_parameters.damage_modifier or 2
            entity.attack_parameters.damage_modifier = baseDamageModifier * (inputs.damage / vanillaDamage)
        end
        -- Update ammo_type if it exists
        if entity.attack_parameters.ammo_type then
            entity.attack_parameters.ammo_type.energy_consumption = tostring(800 * multiplier) .. "kJ"
            if entity.attack_parameters.ammo_type.action and 
               entity.attack_parameters.ammo_type.action.action_delivery then
                entity.attack_parameters.ammo_type.action.action_delivery.max_length = inputs.range + 1
            end
        end
    end
    
    applyLaserTurretTints(entity, baseTint, turretTint)
    
    entity.max_health = inputs.health or 1000
    entity.repair_speed_modifier = inputs.repairSpeedModifier or RepairSpeedScaling.linear(inputs.repairBaseHealth or 1000, entity.max_health)
    entity.fast_replaceable_group = "laser-turret"
    entity.resistances = inputs.resistances or nil
    entity.energy_source.buffer_capacity = 801 * multiplier .. "kJ"
    entity.energy_source.input_flow_limit = 9600 * multiplier .. "kW"
    entity.energy_source.drain = 24 * multiplier .. "kW"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = inputs.tech.number
        setPrototypeIcon(tech, iconPath, 64, table.deepcopy(tieredIcons))
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
