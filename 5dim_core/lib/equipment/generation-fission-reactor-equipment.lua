local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genFissionReactors(inputs)
    local tierNumber = tonumber(inputs.number) or 1
    local tieredIcons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/fission-reactor-equipment.png", tierNumber, 64)

    local function setPrototypeIcons(prototype)
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = table.deepcopy(tieredIcons)
    end

    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["fission-reactor-equipment"])
    local recipe = table.deepcopy(data.raw.recipe["fission-reactor-equipment"])
    local equipment = table.deepcopy(data.raw["generator-equipment"]["fission-reactor-equipment"])
    local tech = table.deepcopy(data.raw.technology["fission-reactor-equipment"])

    -- log("item Name: " .. item.name)

    --Item
    if inputs.new then
        item.name = "5d-fission-reactor-equipment-" .. inputs.number
    end
    setPrototypeIcons(item)
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_as_equipment_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeIcons(recipe)
    recipe.enabled = false
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end

    -- Equipment
    equipment.name = item.name
    equipment.take_result = item.name
    equipment.power = inputs.power .. "kW"
    equipment.take_result = item.name
    -- equipment.sprite.filename =
    --     "__5dim_equipment__/graphics/equipment/fission-reactor/fission-reactor-equipment-" .. inputs.number .. ".png"

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "fission-reactor-equipment-" .. inputs.tech.number
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
