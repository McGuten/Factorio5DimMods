-------------------------------------------------------------------------------
-- 5Dim's Mod - Rocket Turret Generator Function
-- Creates tiered rocket turret prototypes for Space Age
-------------------------------------------------------------------------------

function genRocketTurret(inputs)
    -- Copy rocket turret from Space Age
    local item = table.deepcopy(data.raw.item["rocket-turret"])
    local recipe = table.deepcopy(data.raw.recipe["rocket-turret"])
    local entity = table.deepcopy(data.raw["ammo-turret"]["rocket-turret"])

    --Item
    if inputs.new then
        item.name = "5d-rocket-turret-" .. inputs.number
    end
    item.icon = "__5dim_space_age__/graphics/icon/rocket-turret/rocket-turret-" .. string.format("%02d", inputs.number) .. ".png"
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
    entity.fast_replaceable_group = "rocket-turret"
    entity.max_health = inputs.health or entity.max_health
    entity.rotation_speed = inputs.rotationSpeed
    
    -- Update attack parameters
    if entity.attack_parameters then
        entity.attack_parameters.range = inputs.range
    end
    
    -- Apply tint to all mask layers
    if inputs.tint then
        -- Helper function to apply tint to mask layers
        local function applyTintToLayers(animation)
            if animation and animation.layers then
                for _, layer in pairs(animation.layers) do
                    if layer.flags and layer.flags[1] == "mask" then
                        layer.tint = inputs.tint
                        layer.apply_runtime_tint = false
                    end
                end
            end
        end
        
        applyTintToLayers(entity.folded_animation)
        applyTintToLayers(entity.preparing_animation)
        applyTintToLayers(entity.prepared_animation)
        applyTintToLayers(entity.attacking_animation)
        applyTintToLayers(entity.folding_animation)
    end

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["rocket-turret"])
        tech.name = "5d-rocket-turret-" .. inputs.tech.number
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
