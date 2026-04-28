-------------------------------------------------------------------------------
-- 5Dim's Mod - Artillery Wagon Generator Function
-- Creates tiered artillery wagon prototypes
-------------------------------------------------------------------------------

function genArtilleryWagon(inputs)
    -- Skip vanilla tier (when new = false) - don't modify base game prototypes
    if not inputs.new then
        return
    end

    -- Copy artillery wagon (item-with-entity-data type)
    local item = table.deepcopy(data.raw["item-with-entity-data"]["artillery-wagon"])
    local recipe = table.deepcopy(data.raw.recipe["artillery-wagon"])
    local entity = table.deepcopy(data.raw["artillery-wagon"]["artillery-wagon"])

    --Item
    item.name = "5d-artillery-wagon-" .. inputs.number
    item.icon = "__base__/graphics/icons/artillery-wagon.png"
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
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.max_speed = inputs.maxSpeed
    entity.inventory_size = inputs.ammoSlots or 1

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["artillery"])
        tech.name = "5d-artillery-wagon-" .. inputs.tech.number
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
