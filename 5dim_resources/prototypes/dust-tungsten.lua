if not mods["space-age"] then
    return
end

local DustCommon = require("prototypes.dust-common")

data:extend({
    {
        type = "item",
        name = "5d-tungsten-dust",
        icons = DustCommon.make_dust_icons("__space-age__/graphics/icons/tungsten-ore.png", DustCommon.tints.tungsten),
        subgroup = "plates-dust",
        order = "k",
        stack_size = 200
    },
    {
        type = "recipe",
        name = "5d-tungsten-dust",
        enabled = false,
        subgroup = "vulcanus-metallurgy-tungsten",
        order = "c[tungsten]-b[5d-tungsten-dust]",
        icons = DustCommon.make_dust_icons("__space-age__/graphics/icons/tungsten-ore.png", DustCommon.tints.tungsten),
        category = "mashering",
        energy_required = 3.2,
        allow_productivity = true,
        ingredients = {
            { type = "item", name = "tungsten-ore", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-tungsten-dust", amount = 2 }
        }
    },
    {
        type = "recipe",
        name = "5d-tungsten-plate",
        icon = "__space-age__/graphics/icons/tungsten-plate.png",
        icon_size = 64,
        subgroup = "vulcanus-metallurgy-tungsten",
        order = "c[tungsten]-d[5d-tungsten-plate]",
        enabled = false,
        category = "metallurgy",
        energy_required = 10,
        allow_productivity = true,
        ingredients = {
            { type = "item",  name = "5d-tungsten-dust", amount = 4 },
            { type = "fluid", name = "molten-iron", amount = 10 }
        },
        results = {
            { type = "item", name = "tungsten-plate", amount = 1 }
        }
    }
})