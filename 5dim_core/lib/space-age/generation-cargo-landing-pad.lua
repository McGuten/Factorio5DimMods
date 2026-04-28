function genCargoLandingPad(inputs)
    -- Copy cargo-landing-pad
    local item = table.deepcopy(data.raw.item["cargo-landing-pad"])
    local recipe = table.deepcopy(data.raw.recipe["cargo-landing-pad"])
    local entity = table.deepcopy(data.raw["cargo-landing-pad"]["cargo-landing-pad"])
    -- Use a technology with unit field as base
    local tech = table.deepcopy(data.raw.technology["production-science-pack"])

    --Item
    if inputs.new then
        item.name = "5d-cargo-landing-pad-" .. inputs.number
    end
    item.icon = "__base__/graphics/icons/cargo-landing-pad.png"
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
    entity.inventory_size = inputs.inventorySize
    entity.fast_replaceable_group = "cargo-landing-pad"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-cargo-landing-pad-" .. inputs.tech.number
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
