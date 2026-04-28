-------------------------------------------------------------------------------
-- 5Dim's Mod - Fusion Generator Generator Function
-- Creates tiered fusion generator prototypes for Space Age
-------------------------------------------------------------------------------

function genFusionGenerator(inputs)
    -- Copy fusion generator
    local item = table.deepcopy(data.raw.item["fusion-generator"])
    local recipe = table.deepcopy(data.raw.recipe["fusion-generator"])
    local entity = table.deepcopy(data.raw["fusion-generator"]["fusion-generator"])

    --Item
    if inputs.new then
        item.name = "5d-fusion-generator-" .. inputs.number
    end
    item.icon = "__5dim_space_age__/graphics/icon/fusion-generator/fusion-generator-" .. string.format("%02d", inputs.number) .. ".png"
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
    -- Fusion generator uses output_flow_limit in energy_source for power output
    entity.energy_source.output_flow_limit = inputs.power .. "MW"
    entity.fast_replaceable_group = "fusion-generator"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["fusion-reactor"])
        tech.name = "5d-fusion-generator-" .. inputs.tech.number
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
