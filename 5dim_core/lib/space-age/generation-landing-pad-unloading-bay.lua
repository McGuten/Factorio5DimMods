local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genLandingPadUnloadingBay(inputs)
    local tierNumber = tonumber(inputs.number) or 1
    local tieredIcons = TierBadgeIcons.buildTieredIcons("__space-age__/graphics/icons/cargo-unloading-bay.png", tierNumber, 64)

    local function setPrototypeIcons(prototype)
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = table.deepcopy(tieredIcons)
    end

    -- Copy landing-pad-unloading-bay (entity is of type cargo-bay)
    local item = table.deepcopy(data.raw.item["landing-pad-unloading-bay"])
    local recipe = table.deepcopy(data.raw.recipe["landing-pad-unloading-bay"])
    local entity = table.deepcopy(data.raw["cargo-bay"]["landing-pad-unloading-bay"])
    -- Use a technology with unit field as base
    local tech = table.deepcopy(data.raw.technology["production-science-pack"])

    --Item
    if inputs.new then
        item.name = "5d-landing-pad-unloading-bay-" .. inputs.number
    end
    setPrototypeIcons(item)
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeIcons(recipe)
    if inputs.new and inputs.recipeCategory then
        if inputs.recipeCategory then recipe.categories = { inputs.recipeCategory } end
    end
    if inputs.new then
        recipe.enabled = false
    end
    if inputs.new and inputs.surfaceConditions then
        recipe.surface_conditions = inputs.surfaceConditions
    end
    if inputs.new then
        recipe.ingredients = inputs.ingredients
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeIcons(entity)
    entity.minable.result = item.name
    entity.inventory_size_bonus = inputs.inventoryBonus
    entity.fast_replaceable_group = "landing-pad-unloading-bay"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-landing-pad-unloading-bay-" .. inputs.tech.number
        setPrototypeIcons(tech)
        tech.unit.count = inputs.tech.count
        tech.unit.ingredients = inputs.tech.packs
        tech.prerequisites = inputs.tech.prerequisites
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = item.name
            }
        }
        if inputs.tech.unloadingDistance then
            table.insert(tech.effects, {
                type = "max-cargo-bay-unloading-distance",
                modifier = inputs.tech.unloadingDistance
            })
        end
        data:extend({ tech })
    end
end
