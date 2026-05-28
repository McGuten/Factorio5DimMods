data:extend({
    {
        type = "technology",
        name = "yeters-discovery",
        icon = "__space-age__/graphics/technology/promethium-science-pack.png",
        icon_size = 256,
        effects = {
            {
                type = "unlock-space-location",
                space_location = "yeters"
            }
        },
        prerequisites = { "promethium-science-pack" },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 },
                { "metallurgic-science-pack", 1 },
                { "agricultural-science-pack", 1 },
                { "electromagnetic-science-pack", 1 },
                { "cryogenic-science-pack", 1 },
                { "promethium-science-pack", 1 }
            },
            time = 60
        },
        order = "n[yeters-discovery]"
    }
})