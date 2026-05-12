function genPersonalRoboports(inputs)
    local item
    local equipment
    local recipe
    local tech
    -- Copy electric furnace
    if inputs.number == "01" then
        item = table.deepcopy(data.raw.item["personal-roboport-equipment"])
        recipe = table.deepcopy(data.raw.recipe["personal-roboport-equipment"])
        equipment = table.deepcopy(data.raw["roboport-equipment"]["personal-roboport-equipment"])
        tech = table.deepcopy(data.raw.technology["personal-roboport-equipment"])
    else
        item = table.deepcopy(data.raw.item["personal-roboport-mk2-equipment"])
        recipe = table.deepcopy(data.raw.recipe["personal-roboport-mk2-equipment"])
        equipment = table.deepcopy(data.raw["roboport-equipment"]["personal-roboport-mk2-equipment"])
        tech = table.deepcopy(data.raw.technology["personal-roboport-mk2-equipment"])
    end

    --Item
    if inputs.new then
        item.name = "5d-personal-roboport-equipment-" .. inputs.number
    end
    item.icon = "__5dim_equipment__/graphics/icon/personal-roboport/personal-roboport-equipment-icon-" .. inputs.number .. ".png"
    item.icon_size = 64
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
    if inputs.recipeCategory then
        recipe.category = inputs.recipeCategory
    end

    -- Equipment
    equipment.name = item.name
    equipment.take_result = item.name
    equipment.robot_limit = inputs.robotLimit
    equipment.construction_radius = inputs.constructionRadius
    equipment.energy_source.input_flow_limit = inputs.inputFlow .. "kW"
    equipment.energy_source.buffer_capacity = inputs.capacity .. "MJ"
    equipment.charging_energy = inputs.charging .. "kW"
    equipment.sprite.filename =
        "__5dim_equipment__/graphics/equipment/personal-roboport/personal-roboport-equipment-" .. inputs.number .. ".png"
    equipment.sprite.width = 64
    equipment.sprite.height = 64

    data:extend({equipment, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-personal-roboport-equipment-" .. inputs.tech.number
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
