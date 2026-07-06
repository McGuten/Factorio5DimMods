function genSolarPanels(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["solar-panel-equipment"])
    local recipe = table.deepcopy(data.raw.recipe["solar-panel-equipment"])
    local equipment = table.deepcopy(data.raw["solar-panel-equipment"]["solar-panel-equipment"])
    local tech = table.deepcopy(data.raw.technology["solar-panel-equipment"])

    --Item
    if inputs.new then
        item.name = "5d-solar-panel-equipment-" .. inputs.number
    end
    item.icon = "__5dim_equipment__/graphics/icon/solar-panel/solar-panel-equipment-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_as_equipment_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end
    if inputs.recipeCategory then recipe.categories = { inputs.recipeCategory } end

    -- Equipment
    equipment.name = item.name
    equipment.take_result = item.name
    equipment.power = inputs.power .. "kW"
    equipment.sprite.filename =
        "__5dim_equipment__/graphics/equipment/solar-panel/solar-panel-equipment-" .. inputs.number .. ".png"
    -- The 5Dim sprites are 32x32; the vanilla copy declares 64x64 @ scale 0.5,
    -- so match the real image size (and keep the same on-screen size at scale 1).
    equipment.sprite.width = 32
    equipment.sprite.height = 32
    equipment.sprite.size = nil
    equipment.sprite.scale = 1
    -- log("equipment.take_result: " .. equipment.take_result)

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "solar-panel-equipment-" .. inputs.tech.number
        if tech.icons and tech.icons[2] then
            tech.icons[1] = {
                icon = item.icon,
                icon_size = 64
            }
        else
            tech.icons = {
                {
                    icon = item.icon,
                    icon_size = 64
                }
            }
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
