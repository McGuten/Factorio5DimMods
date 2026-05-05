require("tint-tesla-turret")

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

function genTeslaTurrets(inputs)
    -- Skip vanilla tier (when new = false) - don't modify base game prototypes
    if not inputs.new then
        return
    end
    
    -- Copy laser turret as base for tesla
    local item = table.deepcopy(data.raw.item["laser-turret"])
    local recipe = table.deepcopy(data.raw.recipe["laser-turret"])
    local entity = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
    local tech = table.deepcopy(data.raw.technology["laser-turret"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    local iconSize = inputs.iconSize or 64
    local techIconSize = inputs.techIconSize or iconSize
    local iconPath = inputs.iconPath or
        ("__5dim_battlefield__/graphics/icon/tesla-turret/tesla-turret-icon-" .. inputs.number .. ".png")
    local techIconPath = inputs.techIconPath or iconPath
    local tierNumber = tonumber(inputs.number)
    local tieredIcons = nil
    local tieredTechIcons = nil
    local energyPerShot = inputs.energyPerShot or (800 * 6)
    local bufferCapacity = inputs.bufferCapacity or (801 * 6)
    local inputFlowLimit = inputs.inputFlowLimit or (9600 * 6)
    local energyDrain = inputs.energyDrain or (24 * 6)

    if tierNumber and inputs.iconPath then
        tieredIcons = TierBadgeIcons.buildTieredIcons(iconPath, tierNumber, iconSize)
    end

    if tierNumber and inputs.techIconPath then
        tieredTechIcons = TierBadgeIcons.buildTieredIcons(techIconPath, tierNumber, techIconSize)
    elseif tierNumber and inputs.iconPath then
        tieredTechIcons = TierBadgeIcons.buildTieredIcons(techIconPath, tierNumber, techIconSize)
    end
    
    -- Support for separate base and turret tints
    local baseTint = inputs.baseTint or inputs.tint
    local turretTint = inputs.turretTint or inputs.tint

    --Item
    item.name = "5d-tesla-turret-" .. inputs.number
    setPrototypeIcon(item, iconPath, iconSize, table.deepcopy(tieredIcons))
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeIcon(recipe, iconPath, iconSize, table.deepcopy(tieredIcons))
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.enabled = false
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeIcon(entity, iconPath, iconSize, table.deepcopy(tieredIcons))
    entity.minable.result = item.name
    entity.folded_animation.layers[3] =
        tesla_turret_extension_mask {
        frame_count = 1,
        line_length = 1,
        tint = turretTint
    }
    entity.preparing_animation.layers[3] = tesla_turret_extension_mask {tint = turretTint}
    entity.prepared_animation.layers[3] = tesla_turret_shooting_mask {tint = turretTint}
    entity.folding_animation.layers[3] =
        tesla_turret_extension_mask {
        run_mode = "backward",
        tint = turretTint
    }
    
    -- Apply tint to base visualization
    entity.graphics_set.base_visualisation.animation.layers[1].tint = baseTint
    
    -- Modify attack_parameters - keep original structure, just update allowed values
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
        if entity.attack_parameters.ammo_type and 
           entity.attack_parameters.ammo_type.action and 
           entity.attack_parameters.ammo_type.action.action_delivery then
            entity.attack_parameters.ammo_type.action.action_delivery.max_length = inputs.range + 1
            entity.attack_parameters.ammo_type.action.action_delivery.beam = "electric-beam"
        end
    end
    entity.max_health = inputs.health or 1500
    entity.repair_speed_modifier = inputs.repairSpeedModifier or RepairSpeedScaling.linear(inputs.repairBaseHealth or 1200, entity.max_health)
    entity.fast_replaceable_group = "tesla-turret"
    entity.resistances = inputs.resistances or nil
    entity.energy_source.buffer_capacity = bufferCapacity .. "kJ"
    entity.energy_source.input_flow_limit = inputFlowLimit .. "kW"
    entity.energy_source.drain = energyDrain .. "kW"
    if entity.attack_parameters and entity.attack_parameters.ammo_type then
        entity.attack_parameters.ammo_type.energy_consumption = energyPerShot .. "kJ"
    end

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-tesla-turrets-" .. inputs.tech.number
        setPrototypeIcon(tech, techIconPath, techIconSize, table.deepcopy(tieredTechIcons))
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
