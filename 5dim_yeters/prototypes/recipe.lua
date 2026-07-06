-- 5Dim's Yeters mod
-- Recipes added by Yeters.

data:extend({
    {
        type = "recipe",
        name = "yeters-spoilage",
        categories = { "organic" },
        enabled = false,
        energy_required = 1,
        ingredients = {
            { type = "item", name = "yumako", amount = 1 },
            { type = "item", name = "jellynut", amount = 1 }
        },
        results = {
            { type = "item", name = "spoilage", amount = 2 }
        },
        order = "y[yeters]-s[spoilage]"
    }
})
