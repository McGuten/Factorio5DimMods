data:extend(
    {
        {
            type = "technology",
            name = "advanced-material-processing-12",
            icon = "__base__/graphics/technology/advanced-material-processing.png",
            icon_size = 128,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "5d-industrial-furnace"
                }
            },
            prerequisites = {
                "advanced-material-processing-11",
                "utility-science-pack"
            },
            unit = {
                count = 1500,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1}
                },
                time = 30
            },
            order = "c-c-b"
        }
    }
)
