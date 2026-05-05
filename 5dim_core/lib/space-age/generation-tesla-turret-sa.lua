-------------------------------------------------------------------------------
-- 5Dim's Mod - Tesla Turret (Space Age) Generator Function
-- Creates tiered tesla turret prototypes for Space Age DLC
-- Note: This is different from the 5dim_battlefield tesla turret
-------------------------------------------------------------------------------

function genTeslaTurretSA(inputs)
    -- Copy tesla turret from Space Age
    local item = table.deepcopy(data.raw.item["tesla-turret"])
    local recipe = table.deepcopy(data.raw.recipe["tesla-turret"])
    local entity = table.deepcopy(data.raw["electric-turret"]["tesla-turret"])

    --Item
    if inputs.new then
        item.name = "5d-tesla-turret-sa-" .. inputs.number
    end
    item.icon = "__5dim_space_age__/graphics/icon/tesla-turret/tesla-turret-" .. string.format("%02d", inputs.number) .. ".png"
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
    entity.fast_replaceable_group = "tesla-turret"
    entity.max_health = inputs.health or entity.max_health
    
    -- Update attack parameters
    if entity.attack_parameters then
        entity.attack_parameters.range = inputs.range
        if entity.attack_parameters.ammo_type and inputs.energyPerShot then
            entity.attack_parameters.ammo_type.energy_consumption = inputs.energyPerShot .. "kJ"
        end
    end

    if entity.energy_source then
        if inputs.bufferCapacity then
            entity.energy_source.buffer_capacity = inputs.bufferCapacity .. "kJ"
        end
        if inputs.inputFlowLimit then
            entity.energy_source.input_flow_limit = inputs.inputFlowLimit .. "kW"
        end
        if inputs.energyDrain then
            entity.energy_source.drain = inputs.energyDrain .. "kW"
        end
    end
    
    -- Apply tint to base mask and animations
    if inputs.tint then
        -- Base visualization mask
        if entity.graphics_set and entity.graphics_set.base_visualisation then
            for _, vis in pairs(entity.graphics_set.base_visualisation) do
                if vis.animation and vis.animation.layers then
                    for _, layer in pairs(vis.animation.layers) do
                        if layer.flags and layer.flags[1] == "mask" then
                            layer.tint = inputs.tint
                            layer.apply_runtime_tint = false
                        end
                    end
                end
            end
        end
        -- Folded/preparing animations
        if entity.folded_animation and entity.folded_animation.layers then
            for _, layer in pairs(entity.folded_animation.layers) do
                if layer.flags and layer.flags[1] == "mask" then
                    layer.tint = inputs.tint
                    layer.apply_runtime_tint = false
                end
            end
        end
        if entity.preparing_animation and entity.preparing_animation.layers then
            for _, layer in pairs(entity.preparing_animation.layers) do
                if layer.flags and layer.flags[1] == "mask" then
                    layer.tint = inputs.tint
                    layer.apply_runtime_tint = false
                end
            end
        end
        if entity.prepared_animation and entity.prepared_animation.layers then
            for _, layer in pairs(entity.prepared_animation.layers) do
                if layer.flags and layer.flags[1] == "mask" then
                    layer.tint = inputs.tint
                    layer.apply_runtime_tint = false
                end
            end
        end
        if entity.ending_attack_animation and entity.ending_attack_animation.layers then
            for _, layer in pairs(entity.ending_attack_animation.layers) do
                if layer.flags and layer.flags[1] == "mask" then
                    layer.tint = inputs.tint
                    layer.apply_runtime_tint = false
                end
            end
        end
        if entity.folding_animation and entity.folding_animation.layers then
            for _, layer in pairs(entity.folding_animation.layers) do
                if layer.flags and layer.flags[1] == "mask" then
                    layer.tint = inputs.tint
                    layer.apply_runtime_tint = false
                end
            end
        end
    end

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["tesla-weapons"])
        tech.name = "5d-tesla-turret-sa-" .. inputs.tech.number
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
