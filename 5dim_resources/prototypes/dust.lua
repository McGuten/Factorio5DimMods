data:extend(
    {
        -- Item
        {
            type = "item",
            name = "5d-iron-dust",
            icon_size = 32,
            subgroup = "plates-dust",
            order = "a",
            icon = "__5dim_resources__/graphics/icon/resources/5d-iron-dust.png",
            stack_size = 100
        },
        --Recipe
        {
            type = "recipe",
            name = "5d-iron-plate",
            icon = "__base__/graphics/icons/iron-plate.png",
            icon_size = 64,
            subgroup = "plates-plates2",
            order = "a",
            category = "smelting",
            energy_required = 3.2,
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
            enabled = true,
            category = "mashering",
            energy_required = 3.2,
            ingredients = {
                { type = "item", name = "iron-ore", amount = 1 }
            },
            results = {
                { type = "item", name = "5d-iron-dust", amount = 2 }
            }
        },
        -- Item
        {
            type = "item",
            name = "5d-copper-dust",
            icon_size = 32,
            subgroup = "plates-dust",
            order = "b",
            icon = "__5dim_resources__/graphics/icon/resources/5d-copper-dust.png",
            stack_size = 100
        },
        --Recipe
        {
            type = "recipe",
            name = "5d-copper-plate",
            icon = "__base__/graphics/icons/copper-plate.png",
            icon_size = 64,
            subgroup = "plates-plates2",
            order = "b",
            category = "smelting",
            energy_required = 3.2,
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
            enabled = true,
            category = "mashering",
            energy_required = 3.2,
            ingredients = {
                { type = "item", name = "copper-ore", amount = 1 }
            },
            results = {
                { type = "item", name = "5d-copper-dust", amount = 2 }
            }
        }
    }
)