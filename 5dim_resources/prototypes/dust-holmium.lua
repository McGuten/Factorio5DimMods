if not mods["space-age"] then
    return
end

local DustCommon = require("prototypes.dust-common")

data:extend({
    {
        type = "item",
        name = "5d-holmium-dust",
        icons = DustCommon.make_dust_icons("__space-age__/graphics/icons/holmium-ore.png", DustCommon.tints.holmium),
        subgroup = "plates-dust",
        order = "m",
        stack_size = 200
    },
    {
        type = "recipe",
        name = "5d-holmium-dust",
        enabled = false,
        subgroup = "fulgora-resources",
        order = "b[holmium]-b[5d-holmium-dust]",
        icons = DustCommon.make_dust_icons("__space-age__/graphics/icons/holmium-ore.png", DustCommon.tints.holmium),
        category = "mashering",
        energy_required = 3.2,
        allow_productivity = true,
        ingredients = {
            { type = "item", name = "holmium-ore", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-holmium-dust", amount = 2 }
        }
    },
    {
        type = "recipe",
        name = "5d-holmium-solution",
        icon = "__space-age__/graphics/icons/fluid/holmium-solution.png",
        icon_size = 64,
        subgroup = "fulgora-liquids",
        order = "b[holmium]-c[5d-holmium-solution]",
        enabled = false,
        category = "chemistry",
        energy_required = 10,
        allow_productivity = true,
        ingredients = {
            { type = "item",  name = "5d-holmium-dust", amount = 2 },
            { type = "item",  name = "stone", amount = 1 },
            { type = "fluid", name = "water", amount = 10 }
        },
        results = {
            { type = "fluid", name = "holmium-solution", amount = 100 }
        },
        main_product = "holmium-solution"
    }
})