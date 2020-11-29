data:extend(
    {
        {
            type = "technology",
            name = "laser-shooting-speed-8",
            icons = util.technology_icon_constant_speed("__base__/graphics/technology/energy-weapons-damage.png"),
            icon_size = 256,
            effects = {
                {
                    type = "gun-speed",
                    ammo_category = "laser",
                    modifier = 0.5
                }
            },
            prerequisites = {"laser-shooting-speed-7"},
            unit = {
                count_formula = "150*(L-5)",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"military-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1}
                },
                time = 60
            },
            max_level = "infinite",
            upgrade = true,
            order = "e-n-n"
        }
    }
)
