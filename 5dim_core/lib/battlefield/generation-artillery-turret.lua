-------------------------------------------------------------------------------
-- 5Dim's Mod - Artillery Turret Generator Function
-- Creates tiered artillery turret prototypes
-------------------------------------------------------------------------------

function genArtilleryTurret(inputs)
    -- Skip vanilla tier (when new = false) - don't modify base game prototypes
    if not inputs.new then
        return
    end

    -- Copy artillery turret
    local item = table.deepcopy(data.raw.item["artillery-turret"])
    local recipe = table.deepcopy(data.raw.recipe["artillery-turret"])
    local entity = table.deepcopy(data.raw["artillery-turret"]["artillery-turret"])

    --Item
    item.name = "5d-artillery-turret-" .. inputs.number
    item.icon = "__base__/graphics/icons/artillery-turret.png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    recipe.ingredients = inputs.ingredients
    recipe.results = { { type = "item", name = item.name, amount = 1 } }

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.fast_replaceable_group = "artillery-turret"
    entity.turret_rotation_speed = inputs.rotationSpeed
    entity.manual_range_modifier = inputs.manualRangeModifier

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["artillery"])
        tech.name = "5d-artillery-turret-" .. inputs.tech.number
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
