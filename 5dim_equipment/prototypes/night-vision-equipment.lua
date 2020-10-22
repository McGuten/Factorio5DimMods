-- Copy electric furnace
local item = table.deepcopy(data.raw.item["night-vision-equipment"])
local recipe = table.deepcopy(data.raw.recipe["night-vision-equipment"])
local equipment = table.deepcopy(data.raw["night-vision-equipment"]["night-vision-equipment"])
local tech = table.deepcopy(data.raw.technology["night-vision-equipment"])

--Item
item.name = "5d-night-vision-equipment-02"
item.icon = "__5dim_equipment__/graphics/icon/night-vision/night-vision-equipment-02.png"
item.subgroup = "armor-util"
item.order = "e"
item.placed_as_equipment_result = item.name

--Recipe
recipe.name = item.name
recipe.result = item.name
recipe.icon = item.icon
recipe.icon_size = 64
recipe.enabled = false
recipe.ingredients = {
    {"night-vision-equipment", 1},
    {"advanced-circuit", 5},
    {"steel-plate", 10}
}

-- Equipment
equipment.name = item.name
equipment.energy_input = 20 .. "kW"
equipment.sprite.filename = "__5dim_equipment__/graphics/equipment/night-vision/night-vision-equipment-02.png"
equipment.color_lookup = {
    {0.5, "__core__/graphics/color_luts/identity-lut.png"}
}

-- Technology
tech.name = "night-vision-equipment-2"
tech.unit.count = 100
tech.unit.ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1}
}
tech.prerequisites = {
    "night-vision-equipment",
    "chemical-science-pack"
}
tech.effects = {
    {
        type = "unlock-recipe",
        recipe = item.name
    }
}

data:extend({equipment, recipe, item, tech})
