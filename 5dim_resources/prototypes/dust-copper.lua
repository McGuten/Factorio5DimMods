local DustCommon = require("prototypes.dust-common")

data:extend({
    {
        type = "item",
        name = "5d-copper-dust",
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/copper-ore.png", DustCommon.tints.copper),
        subgroup = "plates-dust",
        order = "b",
        stack_size = 200
    },
    {
        type = "recipe",
        name = "5d-copper-plate",
        icon = "__base__/graphics/icons/copper-plate.png",
        icon_size = 64,
        subgroup = "plates-plates2",
        order = "b",
        category = "smelting",
        energy_required = 3.2,
        allow_productivity = true,
        ingredients = {
            { type = "item", name = "5d-copper-dust", amount = 1 }
        },
        results = {
            { type = "item", name = "copper-plate", amount = 1 }
        }
    },
    {
        type = "recipe",
        name = "5d-copper-dust",
        enabled = false,
        category = "mashering",
        energy_required = 3.2,
        allow_productivity = true,
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/copper-ore.png", DustCommon.tints.copper),
        ingredients = {
            { type = "item", name = "copper-ore", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-copper-dust", amount = 2 }
        }
    }
})