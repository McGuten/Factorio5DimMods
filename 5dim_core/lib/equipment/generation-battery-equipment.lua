local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

function genBatterys(inputs)
    -- Skip vanilla tiers (when new = false) - don't modify base game prototypes
    if not inputs.new then
        return
    end

    local item
    local equipment
    local recipe
    
    -- Copy base prototypes
    if inputs.number == "01" then
        item = table.deepcopy(data.raw.item["battery-equipment"])
        recipe = table.deepcopy(data.raw.recipe["battery-equipment"])
        equipment = table.deepcopy(data.raw["battery-equipment"]["battery-equipment"])
    else
        item = table.deepcopy(data.raw.item["battery-mk2-equipment"])
        recipe = table.deepcopy(data.raw.recipe["battery-mk2-equipment"])
        equipment = table.deepcopy(data.raw["battery-equipment"]["battery-mk2-equipment"])
    end

    local tierNumber = tonumber(inputs.number) or 1
    local baseIcon = "__5dim_equipment__/graphics/icon/battery/battery-equipment-icon-" .. inputs.number .. ".png"
    local tieredIcons = TierBadgeIcons.buildTieredIcons(baseIcon, tierNumber, 64)

    local function setPrototypeIcons(prototype)
        prototype.icon = nil
        prototype.icon_size = nil
        prototype.icons = table.deepcopy(tieredIcons)
    end

    --Item
    item.name = "5d-battery-equipment-" .. inputs.number
    setPrototypeIcons(item)
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_as_equipment_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeIcons(recipe)
    recipe.enabled = false
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.ingredients = inputs.ingredients
    if inputs.recipeCategory then recipe.categories = { inputs.recipeCategory } end

    -- Equipment
    equipment.name = item.name
    equipment.take_result = item.name
    equipment.energy_source.buffer_capacity = inputs.capacity .. "MJ"
    equipment.sprite.filename =
        "__5dim_equipment__/graphics/equipment/battery/battery-equipment-" .. inputs.number .. ".png"
    equipment.sprite.width = 32
    equipment.sprite.height = 64
    equipment.sprite.size = nil
    equipment.sprite.scale = 1

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        local tech = table.deepcopy(data.raw.technology["battery-mk2-equipment"])
        tech.name = "5d-battery-equipment-" .. inputs.tech.number
        if tech.icons and tech.icons[2] then
            tech.icons[1] = {
                icon = baseIcon,
                icon_size = 64
            }
            tech.icons = TierBadgeIcons.buildTieredIconsFromIcons(tech.icons, tierNumber)
        else
            tech.icons = TierBadgeIcons.buildTieredIcons(baseIcon, tierNumber, 64)
        end
        tech.icon = nil
        tech.icon_size = nil
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
