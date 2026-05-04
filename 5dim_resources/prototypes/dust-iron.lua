local DustCommon = require("prototypes.dust-common")

data:extend({
    {
        type = "item",
        name = "5d-iron-dust",
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/iron-ore.png", DustCommon.tints.iron),
        subgroup = "plates-dust",
        order = "a",
        stack_size = 200
    },
    {
        type = "recipe",
        name = "5d-iron-plate",
        icon = "__base__/graphics/icons/iron-plate.png",
        icon_size = 64,
        subgroup = "plates-plates2",
        order = "a",
        category = "smelting",
        energy_required = 3.2,
        allow_productivity = true,
        ingredients = {
            { type = "item", name = "5d-iron-dust", amount = 1 }
        },
        results = {
            { type = "item", name = "iron-plate", amount = 1 }
        }
    },
    {
        type = "recipe",
        name = "5d-iron-dust",
        enabled = false,
        category = "mashering",
        energy_required = 3.2,
        allow_productivity = true,
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/iron-ore.png", DustCommon.tints.iron),
        ingredients = {
            { type = "item", name = "iron-ore", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-iron-dust", amount = 2 }
        }
    }
})