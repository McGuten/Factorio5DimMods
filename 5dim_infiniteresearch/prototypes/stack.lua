data:extend(
    {
        {
            type = "technology",
            name = "inserter-capacity-bonus-8",
            icons = util.technology_icon_constant_stack_size("__base__/graphics/technology/inserter-capacity.png"),
            icon_size = 256,
            effects = {
                {
                    type = "stack-inserter-capacity-bonus",
                    modifier = 1
                }
            },
            prerequisites = {"inserter-capacity-bonus-7"},
            unit = {
                count_formula = "1000*(L-7)",
                ingredients = {
                    {"automation-science-pack", 4},
                    {"logistic-science-pack", 4},
                    {"chemical-science-pack", 3},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1}
                },
                time = 30
            },
            max_level = "infinite",
            upgrade = true,
            order = "c-o-h"
        }
    }
)
