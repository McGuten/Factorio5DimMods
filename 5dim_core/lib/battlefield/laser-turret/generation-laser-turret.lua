require("tint-laser-turret")

function string:split(delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(self, delimiter, from)
    while delim_from do
        table.insert(result, string.sub(self, from, delim_from - 1))
        from = delim_to + 1
        delim_from, delim_to = string.find(self, delimiter, from)
    end
    table.insert(result, string.sub(self, from))
    return result
end

function genLaserTurrets(inputs)
    local split = inputs.number:split("-")
    local multiplier = 1
    
    -- Determine icon path and multiplier based on variant type
    local iconPath
    if string.find(inputs.number, "small") ~= nil then
        iconPath = "__5dim_battlefield__/graphics/icon/laser-turret/small/laser-turret-small-" .. split[2] .. ".png"
        multiplier = 0.5
    elseif string.find(inputs.number, "big") ~= nil then
        iconPath = "__5dim_battlefield__/graphics/icon/laser-turret/big/laser-turret-big-" .. split[2] .. ".png"
        multiplier = 2
    elseif string.find(inputs.number, "sniper") ~= nil then
        iconPath = "__5dim_battlefield__/graphics/icon/laser-turret/sniper/laser-turret-sniper-" .. split[2] .. ".png"
        multiplier = 4
    else
        iconPath = "__5dim_battlefield__/graphics/icon/laser-turret/normal/laser-turret-normal-" .. split[1] .. ".png"
        multiplier = 1
    end
    
    -- For vanilla tier (new = false), only update icon of base entity
    if not inputs.new then
        data.raw.item["laser-turret"].icon = iconPath
        data.raw.item["laser-turret"].icon_size = 64
        data.raw.recipe["laser-turret"].icon = iconPath
        data.raw.recipe["laser-turret"].icon_size = 64
        data.raw["electric-turret"]["laser-turret"].icon = iconPath
        data.raw["electric-turret"]["laser-turret"].icon_size = 64
        return
    end
    
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["laser-turret"])
    local recipe = table.deepcopy(data.raw.recipe["laser-turret"])
    local entity = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
    local tech = table.deepcopy(data.raw.technology["laser-turret"])

    local tint = { r = 1, g = 1, b = 0.1, a = 1 }

    --Item
    item.name = "5d-laser-turret-" .. inputs.number
    item.icon = iconPath

    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
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
    
    entity.folded_animation.layers[3] =
        dim_laser_turret_extension_mask {
            frame_count = 1,
            line_length = 1,
            tint = inputs.turretTint or inputs.tint
        }
    entity.preparing_animation.layers[3] = dim_laser_turret_extension_mask { tint = inputs.turretTint or inputs.tint }
    entity.prepared_animation.layers[3] = dim_laser_turret_shooting_mask { tint = inputs.turretTint or inputs.tint }
    entity.folding_animation.layers[3] =
        dim_laser_turret_extension_mask {
            run_mode = "backward",
            tint = inputs.turretTint or inputs.tint
        }
    
    -- Apply tint to base visualization (tier color)
    entity.graphics_set.base_visualisation.animation.layers[1].tint = inputs.baseTint or inputs.tint
    
    entity.max_health = inputs.health or 1000
    entity.fast_replaceable_group = "laser-turret"
    entity.resistances = inputs.resistances or nil
    entity.energy_source.buffer_capacity = 801 * multiplier .. "kJ"
    entity.energy_source.input_flow_limit = 9600 * multiplier .. "kW"
    entity.energy_source.drain = 24 * multiplier .. "kW"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = inputs.tech.number
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
