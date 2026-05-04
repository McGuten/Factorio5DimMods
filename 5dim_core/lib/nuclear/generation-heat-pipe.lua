local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genHeatPipes(inputs)
    local tierNumber = tonumber(inputs.number) or 1
    local tieredIcons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/heat-pipe.png", tierNumber, 64)

    local function setPrototypeIcons(prototype)
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = table.deepcopy(tieredIcons)
    end

    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["heat-pipe"])
    local recipe = table.deepcopy(data.raw.recipe["heat-pipe"])
    local entity = table.deepcopy(data.raw["heat-pipe"]["heat-pipe"])
    local tech = table.deepcopy(data.raw.technology["nuclear-power"])

    --Item
    if inputs.new then
        item.name = "5d-heat-pipe-" .. inputs.number
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
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeIcons(entity)
    entity.minable.result = item.name
    entity.heat_buffer.max_temperature = inputs.maxTemperature
    entity.heat_buffer.max_transfer = inputs.maxTransfer .. "GW"
    entity.fast_replaceable_group = "heat-pipe"

    -- Base
    -- entity.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/heat-pipe/heat-pipe-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-heat-pipe-" .. inputs.tech.number
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