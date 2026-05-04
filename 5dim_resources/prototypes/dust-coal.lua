local DustCommon = require("prototypes.dust-common")

data:extend({
    {
        type = "item",
        name = "5d-coal-dust",
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/coal.png", DustCommon.tints.coal),
        subgroup = "plates-dust",
        order = "d",
        stack_size = 200
    },
    {
        type = "item",
        name = "5d-refined-coal",
        icons = DustCommon.make_dust_icons(
            "__base__/graphics/icons/coal.png",
            DustCommon.tints.refined_coal,
            { overlay_scale = 0.72, overlay_shift = { 0, 0 } }
        ),
        subgroup = "plates-fuel",
        order = "b-a",
        fuel_category = "chemical",
        fuel_value = "8MJ",
        stack_size = 50
    },
    {
        type = "recipe",
        name = "5d-coal-dust",
        enabled = false,
        category = "mashering",
        subgroup = "plates-fuel",
        order = "b[coal]-a[5d-coal-dust]",
        energy_required = 3.2,
        allow_productivity = true,
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/coal.png", DustCommon.tints.coal),
        ingredients = {
            { type = "item", name = "coal", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-coal-dust", amount = 2 }
        }
    },
    {
        type = "recipe",
        name = "5d-refined-coal",
        enabled = false,
        category = "chemistry",
        subgroup = "plates-fuel",
        order = "b[coal]-b[5d-refined-coal]",
        energy_required = 2,
        allow_productivity = true,
        icons = DustCommon.make_dust_icons(
            "__base__/graphics/icons/coal.png",
            DustCommon.tints.refined_coal,
            { overlay_scale = 0.72, overlay_shift = { 0, 0 } }
        ),
        ingredients = {
            { type = "item",  name = "5d-coal-dust", amount = 2 },
            { type = "fluid", name = "sulfuric-acid", amount = 10 }
        },
        results = {
            { type = "item", name = "5d-refined-coal", amount = 1 }
        }
    }
})