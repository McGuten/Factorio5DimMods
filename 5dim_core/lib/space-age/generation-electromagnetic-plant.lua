local applyTierArt = require("__5dim_core__.lib.space-age.tier-art")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genElectromagneticPlant(inputs)
    -- Copy electromagnetic-plant
    local item = table.deepcopy(data.raw.item["electromagnetic-plant"])
    local recipe = table.deepcopy(data.raw.recipe["electromagnetic-plant"])
    local entity = table.deepcopy(data.raw["assembling-machine"]["electromagnetic-plant"])
    -- Use a technology with unit field as base (electromagnetic-plant tech uses research_trigger)
    local tech = table.deepcopy(data.raw.technology["production-science-pack"])

    local tierNumber = tonumber(inputs.number) or 1
    local tieredIcons = TierBadgeIcons.buildTieredIcons(
        "__5dim_space_age__/graphics/icon/electromagnetic-plant/electromagnetic-plant-" ..
        string.format("%02d", inputs.number) .. ".png", tierNumber, 64)

    local function setPrototypeIcons(prototype)
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = table.deepcopy(tieredIcons)
    end

    --Item
    if inputs.new then
        item.name = "5d-electromagnetic-plant-" .. inputs.number
    end
    setPrototypeIcons(item)
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeIcons(recipe)
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
    setPrototypeIcons(entity)
    entity.minable.result = item.name
    entity.crafting_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.emissions_per_minute = inputs.pollution
    entity.fast_replaceable_group = "electromagnetic-plant"

    -- Overlay de recolor del tier sobre el arte vanilla. El tier 1 tambien lo
    -- lleva (amarillo), asi que va fuera del `if inputs.new`.
    applyTierArt(entity, "electromagnetic-plant", tonumber(inputs.number))

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-electromagnetic-plant-" .. inputs.tech.number
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
        data:extend({ tech })
    end
end
