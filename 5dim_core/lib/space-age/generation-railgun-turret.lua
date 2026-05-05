-------------------------------------------------------------------------------
-- 5Dim's Mod - Railgun Turret Generator Function
-- Creates tiered railgun turret prototypes for Space Age
-------------------------------------------------------------------------------

function genRailgunTurret(inputs)
    -- Copy railgun turret from Space Age
    local item = table.deepcopy(data.raw.item["railgun-turret"])
    local recipe = table.deepcopy(data.raw.recipe["railgun-turret"])
    local entity = table.deepcopy(data.raw["ammo-turret"]["railgun-turret"])

    --Item
    if inputs.new then
        item.name = "5d-railgun-turret-" .. inputs.number
    end
    item.icon = "__5dim_space_age__/graphics/icon/railgun-turret/railgun-turret-" .. string.format("%02d", inputs.number) .. ".png"
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
    entity.fast_replaceable_group = "railgun-turret"
    entity.max_health = inputs.health or entity.max_health
    entity.rotation_speed = inputs.rotationSpeed
    
    -- Update attack parameters
    if entity.attack_parameters then
        entity.attack_parameters.range = inputs.range
    end
    
    -- Apply tint to all mask layers
    if inputs.tint then
        -- Helper function to apply tint to mask layers in a layers array
        local function applyTintToLayers(layers)
            if layers then
                for _, layer in pairs(layers) do
                    if layer.flags and layer.flags[1] == "mask" then
                        layer.tint = inputs.tint
                        layer.apply_runtime_tint = false
                    end
                end
            end
        end
        
        -- Helper function to handle animations with directions (north, south, east, etc.)
        local function applyTintToDirectionalAnimation(animation)
            if animation then
                local directions = {"north", "north_east", "east", "south_east", "south", "south_west", "west", "north_west"}
                for _, dir in pairs(directions) do
                    if animation[dir] and animation[dir].layers then
                        applyTintToLayers(animation[dir].layers)
                    end
                end
                -- Also check if it has direct layers (non-directional)
                if animation.layers then
                    applyTintToLayers(animation.layers)
                end
            end
        end
        
        -- Apply to graphics_set base_visualisation
        if entity.graphics_set and entity.graphics_set.base_visualisation and entity.graphics_set.base_visualisation.animation then
            applyTintToDirectionalAnimation(entity.graphics_set.base_visualisation.animation)
        end
        
        -- Apply to all animations
        applyTintToDirectionalAnimation(entity.preparing_animation)
        applyTintToDirectionalAnimation(entity.prepared_animation)
        applyTintToDirectionalAnimation(entity.starting_attack_animation)
        applyTintToDirectionalAnimation(entity.attacking_animation)
        applyTintToDirectionalAnimation(entity.ending_attack_animation)
        applyTintToDirectionalAnimation(entity.folding_animation)
        applyTintToDirectionalAnimation(entity.folded_animation)
    end

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["railgun"])
        tech.name = "5d-railgun-turret-" .. inputs.tech.number
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
