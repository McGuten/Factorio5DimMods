require("tint-tesla-turret")

function genTeslaTurrets(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["laser-turret"])
    local recipe = table.deepcopy(data.raw.recipe["laser-turret"])
    local entity = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
    local tech = table.deepcopy(data.raw.technology["laser-turret"])

    local tint = {r = 1, g = 1, b = 0.1, a = 1}

    --Item
    if inputs.new then
        item.name = "5d-tesla-turret-" .. inputs.number
    end
    item.icon =
        "__5dim_battlefield__/graphics/icon/tesla-turret/tesla-turret-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    recipe.ingredients = inputs.ingredients

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.folded_animation.layers[3] =
        tesla_turret_extension_mask {
        frame_count = 1,
        line_length = 1,
        tint = inputs.tint
    }
    entity.preparing_animation.layers[3] = tesla_turret_extension_mask {tint = inputs.tint}
    entity.prepared_animation.layers[3] = tesla_turret_shooting_mask {tint = inputs.tint}
    entity.folding_animation.layers[3] =
        tesla_turret_extension_mask {
        run_mode = "backward",
        tint = inputs.tint
    }
    entity.attack_parameters.cooldown = inputs.attackSpeed
    entity.attack_parameters.range = inputs.range
    entity.attack_parameters.damage_modifier = inputs.cooldown
    entity.attack_parameters.ammo_type.action.action_delivery.max_length = inputs.range + 1
    entity.attack_parameters.ammo_type.action.action_delivery.beam = "electric-beam"
    entity.max_health = inputs.health or 1500
    entity.fast_replaceable_group = "tesla-turret"
    entity.resistances = inputs.resistances or nil
    entity.energy_source.buffer_capacity = 801 * 6 .. "kJ"
    entity.energy_source.input_flow_limit = 9600 * 6 .. "kW"
    entity.energy_source.drain = 24 * 6 .. "kW"
    entity.attack_parameters.ammo_type.energy_consumption = 800 * 6 .. "kJ"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-tesla-turrets-" .. inputs.tech.number
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
        data:extend({tech})
    end
end
