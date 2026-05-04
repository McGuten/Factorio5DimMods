if not mods["space-age"] then
    return
end

data:extend({
    {
        type = "recipe",
        name = "5d-ammoniacal-solution-separation",
        icon = "__space-age__/graphics/icons/fluid/ammoniacal-solution-separation.png",
        icon_size = 64,
        subgroup = "aquilo-items",
        order = "a[ammonia]-a[ammoniacal-solution-separation]-b[5d]",
        auto_recycle = false,
        enabled = false,
        category = "chemistry-or-cryogenics",
        energy_required = 1,
        allow_productivity = true,
        always_show_made_in = true,
        always_show_products = true,
        allow_decomposition = false,
        ingredients = {
            { type = "fluid", name = "ammoniacal-solution", amount = 50 }
        },
        results = {
            { type = "item",  name = "ice", amount = 10 },
            { type = "fluid", name = "ammonia", amount = 50 }
        }
    },
    {
        type = "recipe",
        name = "5d-lithium",
        icon = "__space-age__/graphics/icons/lithium.png",
        icon_size = 64,
        subgroup = "aquilo-items",
        order = "c[lithium]-a[lithium]-b[5d]",
        auto_recycle = false,
        enabled = false,
        category = "chemistry-or-cryogenics",
        energy_required = 20,
        allow_productivity = true,
        ingredients = {
            { type = "item",  name = "holmium-plate", amount = 1 },
            { type = "fluid", name = "lithium-brine", amount = 50 },
            { type = "fluid", name = "ammonia", amount = 50 }
        },
        results = {
            { type = "item", name = "lithium", amount = 10 }
        }
    }
})