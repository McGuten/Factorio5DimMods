function genLightningRod(inputs)
    -- Copy lightning-rod (type is lightning-attractor)
    local item = table.deepcopy(data.raw.item["lightning-rod"])
    local recipe = table.deepcopy(data.raw.recipe["lightning-rod"])
    local entity = table.deepcopy(data.raw["lightning-attractor"]["lightning-rod"])
    -- Use a technology with unit field as base
    local tech = table.deepcopy(data.raw.technology["production-science-pack"])

    --Item
    if inputs.new then
        item.name = "5d-lightning-rod-" .. inputs.number
    end
    item.icon = "__space-age__/graphics/icons/lightning-rod.png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
    end
    if inputs.new then
        recipe.ingredients = inputs.ingredients
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.efficiency = inputs.efficiency
    entity.range_elongation = inputs.rangeElongation
    entity.energy_source.buffer_capacity = inputs.bufferCapacity .. "MJ"
    entity.energy_source.output_flow_limit = inputs.outputFlowLimit .. "MJ"
    entity.fast_replaceable_group = "lightning-rod"

    -- Apply tint to graphics if specified
    if inputs.tint then
        -- Apply tint to chargable_graphics
        if entity.chargable_graphics then
            -- Note: Lightning rod uses complex graphics that may need special handling
            -- For now, we maintain vanilla graphics with tinted icon
        end
    end

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-lightning-rod-" .. inputs.tech.number
        tech.icon = "__space-age__/graphics/icons/lightning-rod.png"
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
