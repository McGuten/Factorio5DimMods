if not mods["space-age"] then
    return
end

data:extend({
    {
        type = "recipe",
        name = "5d-yumako-processing",
        allow_quality = false,
        icon = "__space-age__/graphics/icons/yumako-processing.png",
        icon_size = 64,
        subgroup = "gleba-agricultural-processing",
        order = "a[seeds]-a[5d-yumako-processing]",
        enabled = false,
        categories = { "organic-or-hand-crafting" },
        energy_required = 2,
        allow_productivity = true,
        ingredients = {
            { type = "item", name = "yumako", amount = 1 }
        },
        results = {
            { type = "item", name = "yumako-seed", amount = 1, independent_probability = 0.02 },
            { type = "item", name = "yumako-mash", amount = 4 }
        }
    },
    {
        type = "recipe",
        name = "5d-jellynut-processing",
        allow_quality = false,
        icon = "__space-age__/graphics/icons/jellynut-processing.png",
        icon_size = 64,
        subgroup = "gleba-agricultural-processing",
        order = "a[seeds]-b[5d-jellynut-processing]",
        enabled = false,
        categories = { "organic-or-hand-crafting" },
        energy_required = 2,
        allow_productivity = true,
        ingredients = {
            { type = "item", name = "jellynut", amount = 1 }
        },
        results = {
            { type = "item", name = "jellynut-seed", amount = 1, independent_probability = 0.02 },
            { type = "item", name = "jelly", amount = 8 }
        }
    }
})
