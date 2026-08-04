-------------------------------------------------------------------------------
-- 5Dim's Mod - Fusion Reactor (Building) Generator Function
-- Creates tiered fusion reactor building prototypes for Space Age
-------------------------------------------------------------------------------

local applyTierArt = require("__5dim_core__.lib.space-age.tier-art")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genFusionReactorBuilding(inputs)
    -- Copy fusion reactor
    local item = table.deepcopy(data.raw.item["fusion-reactor"])
    local recipe = table.deepcopy(data.raw.recipe["fusion-reactor"])
    local entity = table.deepcopy(data.raw["fusion-reactor"]["fusion-reactor"])

    local tierNumber = tonumber(inputs.number) or 1
    local tieredIcons = TierBadgeIcons.buildTieredIcons(
        "__5dim_space_age__/graphics/icon/fusion-reactor/fusion-reactor-" ..
        string.format("%02d", inputs.number) .. ".png", tierNumber, 64)

    local function setPrototypeIcons(prototype)
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = table.deepcopy(tieredIcons)
    end

    --Item
    if inputs.new then
        item.name = "5d-fusion-reactor-building-" .. inputs.number
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
        recipe.ingredients = inputs.ingredients
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeIcons(entity)
    entity.minable.result = item.name
    -- Fusion reactor has power_input and max_fluid_usage
    -- Scale max_fluid_usage proportionally to power (base: 4/second at 500MW ~ 0.008/MW)
    entity.max_fluid_usage = (inputs.power * 4 / 500) / 60 -- convert to per tick
    entity.power_input = (inputs.power / 50) .. "MW"
    entity.fast_replaceable_group = "fusion-reactor"

    -- Overlay de recolor del tier sobre el arte vanilla. El tier 1 tambien lo
    -- lleva (amarillo), asi que va fuera del `if inputs.new`.
    applyTierArt(entity, "fusion-reactor", tonumber(inputs.number))

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["fusion-reactor"])
        tech.name = "5d-fusion-reactor-building-" .. inputs.tech.number
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
