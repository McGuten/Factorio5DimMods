-- Logistics technologies 4-10 (only created when space-age is enabled)
if mods["space-age"] then
    data:extend({
        {
            type = "technology",
            name = "logistics-4",
            icon = "__base__/graphics/technology/logistics.png",
            icon_size = 256,
            effects = {},
            prerequisites = {"logistics-3", "production-science-pack"},
            unit = {
                count = 800,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1}
                },
                time = 60
            },
            order = "a-f-d"
        },
        {
            type = "technology",
            name = "logistics-5",
            icon = "__base__/graphics/technology/logistics.png",
            icon_size = 256,
            effects = {},
            prerequisites = {"logistics-4", "turbo-transport-belt"},
            unit = {
                count = 1000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1}
                },
                time = 60
            },
            order = "a-f-e"
        },
        {
            type = "technology",
            name = "logistics-6",
            icon = "__base__/graphics/technology/logistics.png",
            icon_size = 256,
            effects = {},
            prerequisites = {"logistics-5"},
            unit = {
                count = 1200,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1}
                },
                time = 60
            },
            order = "a-f-f"
        },
        {
            type = "technology",
            name = "logistics-7",
            icon = "__base__/graphics/technology/logistics.png",
            icon_size = 256,
            effects = {},
            prerequisites = {"logistics-6", "utility-science-pack"},
            unit = {
                count = 1400,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1}
                },
                time = 60
            },
            order = "a-f-g"
        },
        {
            type = "technology",
            name = "logistics-8",
            icon = "__base__/graphics/technology/logistics.png",
            icon_size = 256,
            effects = {},
            prerequisites = {"logistics-7"},
            unit = {
                count = 1600,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1}
                },
                time = 60
            },
            order = "a-f-h"
        },
        {
            type = "technology",
            name = "logistics-9",
            icon = "__base__/graphics/technology/logistics.png",
            icon_size = 256,
            effects = {},
            prerequisites = {"logistics-8", "space-science-pack"},
            unit = {
                count = 1800,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1}
                },
                time = 60
            },
            order = "a-f-i"
        },
        {
            type = "technology",
            name = "logistics-10",
            icon = "__base__/graphics/technology/logistics.png",
            icon_size = 256,
            effects = {},
            prerequisites = {"logistics-9"},
            unit = {
                count = 2000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1}
                },
                time = 60
            },
            order = "a-f-j"
        }
    })
end
