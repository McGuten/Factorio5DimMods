local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genNuclearReactors(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["nuclear-reactor"])
    local recipe = table.deepcopy(data.raw.recipe["nuclear-reactor"])
    local entity = table.deepcopy(data.raw["reactor"]["nuclear-reactor"])
    local tech = table.deepcopy(data.raw.technology["nuclear-power"])

    local tierNumber = tonumber(inputs.number) or 1
    local tieredIcons = TierBadgeIcons.buildTieredIcons(
        "__5dim_nuclear__/graphics/icon/nuclear-reactor/nuclear-reactor-icon-" .. inputs.number .. ".png",
        tierNumber, 64)

    local function setPrototypeIcons(prototype)
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = table.deepcopy(tieredIcons)
    end

    --Item
    if inputs.new then
        item.name = "5d-nuclear-reactor-" .. inputs.number
    end
    setPrototypeIcons(item)
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeIcons(recipe)
    if inputs.recipeCategory then recipe.categories = { inputs.recipeCategory } end
    if inputs.new then
        recipe.enabled = false
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeIcons(entity)
    entity.minable.result = item.name
    entity.energy_source.effectivity = inputs.craftingSpeed
    entity.energy_source.emissions_per_minute = inputs.pollution
    entity.consumption = inputs.energyUsage .. "MW"
    -- entity.heat_buffer.specific_heat = inputs.pollution .. "MJ"
    -- entity.heat_buffer.max_transfer = inputs.pollution .. "MW"
    entity.fast_replaceable_group = "nuclear-reactor"

    -- Base
    entity.picture.layers[1].filename =
        "__5dim_nuclear__/graphics/entities/nuclear-reactor/reactor-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-nuclear-reactor-" .. inputs.tech.number
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
        data:extend({tech})
    end
end
