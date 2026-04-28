-------------------------------------------------------------------------------
-- 5Dim's Mod - Fusion Reactor (Building) Generator Function
-- Creates tiered fusion reactor building prototypes for Space Age
-------------------------------------------------------------------------------

function genFusionReactorBuilding(inputs)
    -- Copy fusion reactor
    local item = table.deepcopy(data.raw.item["fusion-reactor"])
    local recipe = table.deepcopy(data.raw.recipe["fusion-reactor"])
    local entity = table.deepcopy(data.raw["fusion-reactor"]["fusion-reactor"])

    --Item
    if inputs.new then
        item.name = "5d-fusion-reactor-building-" .. inputs.number
    end
    item.icon = "__5dim_space_age__/graphics/icon/fusion-reactor/fusion-reactor-" .. string.format("%02d", inputs.number) .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
        recipe.ingredients = inputs.ingredients
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    -- Fusion reactor has power_input and max_fluid_usage
    -- Scale max_fluid_usage proportionally to power (base: 4/second at 500MW ~ 0.008/MW)
    entity.max_fluid_usage = (inputs.power * 4 / 500) / 60 -- convert to per tick
    entity.power_input = (inputs.power / 50) .. "MW"
    entity.fast_replaceable_group = "fusion-reactor"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["fusion-reactor"])
        tech.name = "5d-fusion-reactor-building-" .. inputs.tech.number
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
