data:extend(
    {
        {
            type = "recipe",
            name = "5d-iron-plate-industrial-dust",
            icon = "__base__/graphics/icons/iron-plate.png",
            icon_size = 64,
            subgroup = "plates-industrial-dust",
            order = "aa",
            category = "industrial-furnace",
            energy_required = 65,
            ingredients = {
                { type = "item", name = "5d-iron-dust", amount = 85 }
            },
            results = {
                { type = "item", name = "iron-plate", amount = 100 }
            }
        },
        {
            type = "recipe",
            name = "5d-iron-plate-industrial",
            icon = "__base__/graphics/icons/iron-plate.png",
            icon_size = 64,
            subgroup = "plates-industrial-ore",
            order = "aa",
            category = "industrial-furnace",
            energy_required = 65,
            ingredients = {
                { type = "item", name = "iron-ore", amount = 85 }
            },
            results = {
                { type = "item", name = "iron-plate", amount = 100 }
            }
        },
        {
            type = "recipe",
            name = "5d-copper-plate-industrial-dust",
            icon = "__base__/graphics/icons/copper-plate.png",
            icon_size = 64,
            subgroup = "plates-industrial-ore",
            order = "ab",
            category = "industrial-furnace",
            energy_required = 65,
            ingredients = {
                { type = "item", name = "copper-ore", amount = 85 }
            },
            results = {
                { type = "item", name = "copper-plate", amount = 100 }
            }
        },
        {
            type = "recipe",
            name = "5d-copper-plate-industrial",
            icon = "__base__/graphics/icons/copper-plate.png",
            icon_size = 64,
            subgroup = "plates-industrial-dust",
            order = "ab",
            category = "industrial-furnace",
            energy_required = 65,
            ingredients = {
                { type = "item", name = "5d-copper-dust", amount = 85 }
            },
            results = {
                { type = "item", name = "copper-plate", amount = 100 }
            }
        },
        {
            type = "recipe",
            name = "5d-steel-plate-industrial",
            icon = "__base__/graphics/icons/steel-plate.png",
            icon_size = 64,
            subgroup = "plates-industrial-ore",
            order = "zz",
            category = "industrial-furnace",
            energy_required = 90,
            ingredients = {
                { type = "item", name = "iron-plate", amount = 80 }
            },
            results = {
                { type = "item", name = "steel-plate", amount = 20 }
            }
        }
    }
)