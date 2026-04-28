function genCryogenicPlant(inputs)
    -- Copy cryogenic-plant
    local item = table.deepcopy(data.raw.item["cryogenic-plant"])
    local recipe = table.deepcopy(data.raw.recipe["cryogenic-plant"])
    local entity = table.deepcopy(data.raw["assembling-machine"]["cryogenic-plant"])
    -- Use a technology with unit field as base (cryogenic-plant tech uses research_trigger)
    local tech = table.deepcopy(data.raw.technology["production-science-pack"])

    --Item
    if inputs.new then
        item.name = "5d-cryogenic-plant-" .. inputs.number
    end
    -- Use vanilla icon (custom icons can be added later)
    item.icon = "__space-age__/graphics/icons/cryogenic-plant.png"
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
    entity.crafting_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.fast_replaceable_group = "cryogenic-plant"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-cryogenic-plant-" .. inputs.tech.number
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
