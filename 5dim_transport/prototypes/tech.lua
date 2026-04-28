-- NOTE: This file is NOT used. Technologies are generated automatically
-- by gen-transport-belt.lua. Keeping this as reference only.
-- If this file is included, it will cause duplicate technology errors.

--[[ DEPRECATED - Technologies are now generated automatically in gen-transport-belt.lua
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
        -- ... more technologies ...
    })
end
--]]
