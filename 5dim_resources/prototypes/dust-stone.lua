local DustCommon = require("prototypes.dust-common")

data:extend({
    {
        type = "item",
        name = "5d-stone-dust",
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/stone.png", DustCommon.tints.stone),
        subgroup = "plates-dust",
        order = "c",
        stack_size = 200
    },
    {
        type = "recipe",
        name = "5d-stone-dust",
        enabled = false,
        category = "mashering",
        subgroup = "decoration-floor",
        order = "a-a[stone-brick]-a[5d-stone-dust]",
        energy_required = 3.2,
        allow_productivity = true,
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/stone.png", DustCommon.tints.stone),
        ingredients = {
            { type = "item", name = "stone", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-stone-dust", amount = 2 }
        }
    },
    {
        type = "recipe",
        name = "5d-stone-brick",
        icon = "__base__/graphics/icons/stone-brick.png",
        icon_size = 64,
        subgroup = "decoration-floor",
        order = "a-a[stone-brick]-b[5d-stone-brick]",
        category = "smelting",
        energy_required = 3.2,
        allow_productivity = true,
        ingredients = {
            { type = "item", name = "5d-stone-dust", amount = 1 }
        },
        results = {
            { type = "item", name = "stone-brick", amount = 1 }
        }
    }
})