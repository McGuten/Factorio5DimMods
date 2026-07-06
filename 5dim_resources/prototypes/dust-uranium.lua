local DustCommon = require("prototypes.dust-common")

data:extend({
    {
        type = "item",
        name = "5d-uranium-dust",
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/uranium-ore.png", DustCommon.tints.uranium),
        subgroup = "plates-dust",
        order = "e",
        stack_size = 200
    },
    {
        type = "recipe",
        name = "5d-uranium-dust",
        enabled = false,
        categories = { "mashering" },
        subgroup = "nuclear-recipe",
        order = "a[uranium-processing]-a[5d-uranium-dust]",
        energy_required = 3.2,
        allow_productivity = true,
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/uranium-ore.png", DustCommon.tints.uranium),
        ingredients = {
            { type = "item", name = "uranium-ore", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-uranium-dust", amount = 2 }
        }
    },
    {
        type = "recipe",
        name = "5d-uranium-processing",
        allow_quality = false,
        energy_required = 12,
        enabled = false,
        auto_recycle = false,
        categories = { "centrifuging" },
        ingredients = {
            { type = "item", name = "5d-uranium-dust", amount = 10 }
        },
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/uranium-processing.png", DustCommon.tints.uranium),
        subgroup = "nuclear-recipe",
        order = "a[uranium-processing]-b[5d-uranium-processing]",
        results = {
            {
                type = "item",
                name = "uranium-235",
                independent_probability = 0.007,
                amount = 1
            },
            {
                type = "item",
                name = "uranium-238",
                independent_probability = 0.993,
                amount = 1
            }
        },
        allow_productivity = true
    }
})
