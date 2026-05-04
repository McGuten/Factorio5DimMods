if not mods["space-age"] then
    return
end

local DustCommon = require("prototypes.dust-common")

data:extend({
    {
        type = "item",
        name = "5d-calcite-dust",
        icons = DustCommon.make_dust_icons("__space-age__/graphics/icons/calcite.png", DustCommon.tints.calcite),
        subgroup = "plates-dust",
        order = "n",
        stack_size = 200
    },
    {
        type = "recipe",
        name = "5d-calcite-dust",
        enabled = false,
        subgroup = "vulcanus-metallurgy-tungsten",
        order = "a[melting]-b[5d-calcite-dust]",
        icons = DustCommon.make_dust_icons("__space-age__/graphics/icons/calcite.png", DustCommon.tints.calcite),
        category = "mashering",
        energy_required = 3.2,
        allow_productivity = true,
        ingredients = {
            { type = "item", name = "calcite", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-calcite-dust", amount = 2 }
        }
    },
    {
        type = "recipe",
        name = "5d-molten-iron-from-lava",
        icon = "__space-age__/graphics/icons/fluid/molten-iron-from-lava.png",
        icon_size = 64,
        subgroup = "vulcanus-metallurgy",
        order = "a[melting]-a[lava-a]-b[5d]",
        auto_recycle = false,
        enabled = false,
        category = "metallurgy",
        energy_required = 16,
        allow_productivity = true,
        ingredients = {
            { type = "fluid", name = "lava", amount = 500 },
            { type = "item",  name = "5d-calcite-dust", amount = 1 }
        },
        results = {
            { type = "fluid", name = "molten-iron", amount = 250 },
            { type = "item",  name = "stone", amount = 10 }
        },
        main_product = "molten-iron"
    },
    {
        type = "recipe",
        name = "5d-molten-copper-from-lava",
        icon = "__space-age__/graphics/icons/fluid/molten-copper-from-lava.png",
        icon_size = 64,
        subgroup = "vulcanus-metallurgy",
        order = "a[melting]-a[lava-b]-b[5d]",
        auto_recycle = false,
        enabled = false,
        category = "metallurgy",
        energy_required = 16,
        allow_productivity = true,
        ingredients = {
            { type = "fluid", name = "lava", amount = 500 },
            { type = "item",  name = "5d-calcite-dust", amount = 1 }
        },
        results = {
            { type = "fluid", name = "molten-copper", amount = 250 },
            { type = "item",  name = "stone", amount = 15 }
        },
        main_product = "molten-copper"
    }
})