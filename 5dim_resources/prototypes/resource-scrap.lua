if not mods["space-age"] then
    return
end

data:extend({
    {
        type = "item",
        name = "5d-compacted-scrap",
        icons = {
            {
                icon = "__space-age__/graphics/icons/scrap.png",
                icon_size = 64
            },
            {
                icon = "__quality__/graphics/icons/recycling-top.png",
                icon_size = 64,
                scale = 0.45,
                shift = { 8, 8 }
            }
        },
        subgroup = "fulgora-resources",
        order = "a[scrap]-b[5d-compacted-scrap]",
        stack_size = 50
    },
    {
        type = "recipe",
        name = "5d-scrap-compact",
        enabled = false,
        subgroup = "fulgora-resources",
        order = "a[trash]-a[5d-scrap-compact]",
        icons = {
            {
                icon = "__space-age__/graphics/icons/scrap.png",
                icon_size = 64
            },
            {
                icon = "__quality__/graphics/icons/recycling-top.png",
                icon_size = 64,
                scale = 0.45,
                shift = { 8, 8 }
            }
        },
        category = "mashering",
        energy_required = 1,
        allow_productivity = true,
        ingredients = {
            { type = "item", name = "scrap", amount = 2 }
        },
        results = {
            { type = "item", name = "5d-compacted-scrap", amount = 1 }
        }
    },
    {
        type = "recipe",
        name = "5d-compacted-scrap-recycling",
        icons = {
            { icon = "__quality__/graphics/icons/recycling.png" },
            { icon = "__space-age__/graphics/icons/scrap.png", scale = 0.4 },
            { icon = "__quality__/graphics/icons/recycling-top.png" }
        },
        subgroup = "fulgora-resources",
        order = "a[trash]-b[5d-compacted-scrap-recycling]",
        enabled = false,
        auto_recycle = false,
        category = "recycling-or-hand-crafting",
        energy_required = 0.4,
        ingredients = {
            { type = "item", name = "5d-compacted-scrap", amount = 1 }
        },
        results = {
            { type = "item", name = "iron-gear-wheel", amount = 4, probability = 0.20, show_details_in_recipe_tooltip = false },
            { type = "item", name = "solid-fuel", amount = 4, probability = 0.07, show_details_in_recipe_tooltip = false },
            { type = "item", name = "concrete", amount = 4, probability = 0.06, show_details_in_recipe_tooltip = false },
            { type = "item", name = "ice", amount = 4, probability = 0.05, show_details_in_recipe_tooltip = false },
            { type = "item", name = "steel-plate", amount = 4, probability = 0.04, show_details_in_recipe_tooltip = false },
            { type = "item", name = "battery", amount = 4, probability = 0.04, show_details_in_recipe_tooltip = false },
            { type = "item", name = "stone", amount = 4, probability = 0.04, show_details_in_recipe_tooltip = false },
            { type = "item", name = "advanced-circuit", amount = 4, probability = 0.03, show_details_in_recipe_tooltip = false },
            { type = "item", name = "copper-cable", amount = 4, probability = 0.03, show_details_in_recipe_tooltip = false },
            { type = "item", name = "processing-unit", amount = 4, probability = 0.02, show_details_in_recipe_tooltip = false },
            { type = "item", name = "low-density-structure", amount = 4, probability = 0.01, show_details_in_recipe_tooltip = false },
            { type = "item", name = "holmium-ore", amount = 4, probability = 0.01, show_details_in_recipe_tooltip = false }
        }
    }
})