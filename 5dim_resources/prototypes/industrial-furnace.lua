-- Copy electric furnace
local item = table.deepcopy(data.raw.item["electric-furnace"])
local recipe = table.deepcopy(data.raw.recipe["electric-furnace"])
local entity = table.deepcopy(data.raw["furnace"]["electric-furnace"])
local tech = table.deepcopy(data.raw.technology["advanced-material-processing-2"])

--Item
item.name = "5d-industrial-furnace"
item.icon = "__5dim_resources__/graphics/icon/industrial-furnace/industrial-furnace-icon.png"
item.icon_size = 32
item.subgroup = "furnace-industrial"
item.order = "a"
item.place_result = item.name

--Recipe
recipe.name = item.name
recipe.results = { { type = "item", name = item.name, amount = 1 } }
recipe.icon = item.icon
recipe.icon_size = 32
recipe.enabled = false
recipe.ingredients = {
    { type = "item", name = "5d-electric-furnace-10", amount = 2 },
    { type = "item", name = "steel-plate",            amount = 10 },
    { type = "item", name = "refined-concrete",       amount = 10 },
    { type = "item", name = "advanced-circuit",       amount = 10 }
}

--Entity
entity.name = item.name
entity.next_upgrade = nil
entity.icon = item.icon
entity.icon_size = 32
entity.minable.result = item.name
entity.crafting_speed = 7
entity.module_slots = 4
entity.energy_usage = 7500 .. "kW"
entity.graphics_set.animation = {
    filename = "__5dim_resources__/graphics/entities/industrial-furnace/industrial-furnace.png",
    priority = "high",
    width = 224,
    height = 224,
    frame_count = 1,
    shift = {0, 0}
}
-- entity.energy_source.emissions_per_minute = 35
entity.collision_box = { { -2.2, -2.2 }, { 2.2, 2.2 } }
entity.selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } }
entity.crafting_categories = { "industrial-furnace" }

-- Technology
tech.name = "advanced-material-processing-12"
tech.unit.count = 1500
tech.unit.ingredients = {
    { type = "item", name = "automation-science-pack", amount = 1 },
    { type = "item", name = "logistic-science-pack",   amount = 1 },
    { type = "item", name = "chemical-science-pack",   amount = 1 },
    { type = "item", name = "production-science-pack", amount = 1 },
    { type = "item", name = "utility-science-pack",    amount = 1 },
    { type = "item", name = "space-science-pack",      amount = 1 }
}
tech.prerequisites = {
    "advanced-material-processing-11",
    "space-science-pack"
}
tech.effects = {
    {
        type = "unlock-recipe",
        recipe = item.name
    }
}

data:extend({ entity, recipe, item, tech })
