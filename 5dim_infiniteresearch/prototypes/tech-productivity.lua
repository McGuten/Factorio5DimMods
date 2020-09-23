data:extend(
    {
        {
            type = "technology",
            name = "research-productivity",
            icon = "__base__/graphics/technology/research-speed.png",
            icon_size = 128,
            effects = {
                {
                    type = "laboratory-productivity",
                    modifier = 0.1
                }
            },
            prerequisites = {"research-speed-6"},
            unit = {
                count_formula = "1000*(L-5)",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1}
                },
                time = 30
            },
            max_level = "infinite",
            order = "c-m-d"
        }
    }
)
