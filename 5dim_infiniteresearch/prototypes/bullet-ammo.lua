data:extend(
    {
        {
            type = "technology",
            name = "weapon-shooting-speed-7",
            icons = util.technology_icon_constant_speed("__base__/graphics/technology/weapon-shooting-speed-1.png"),
            icon_size = 256,
            effects = {
                {
                    type = "gun-speed",
                    ammo_category = "bullet",
                    modifier = 0.4
                },
                {
                    type = "gun-speed",
                    ammo_category = "shotgun-shell",
                    modifier = 0.4
                },
                {
                    type = "gun-speed",
                    ammo_category = "cannon-shell",
                    modifier = 1.5
                },
                {
                    type = "gun-speed",
                    ammo_category = "rocket",
                    modifier = 1.3
                }
            },
            prerequisites = {"weapon-shooting-speed-6"},
            unit = {
                count_formula = "150*(L-4)",
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
            order = "e-l-l"
        }
    }
)
