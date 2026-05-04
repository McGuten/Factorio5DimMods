data:extend(
    {
        {
            type = "technology",
            name = "advanced-material-processing-12",
            icons = {
                {
                    icon = "__base__/graphics/technology/advanced-material-processing.png",
                    icon_size = 256
                },
                {
                    icon = "__5dim_resources__/graphics/icon/industrial-furnace/industrial-furnace-icon.png",
                    icon_size = 32,
                    scale = 4,
                    shift = { 56, 56 }
                }
            },
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

local function add_unlocks(technology_name, recipe_names)
    local technology = data.raw.technology[technology_name]

    if technology == nil or technology.effects == nil then
        return
    end

    for _, recipe_name in pairs(recipe_names) do
        table.insert(technology.effects, {
            type = "unlock-recipe",
            recipe = recipe_name
        })
    end
end

add_unlocks("concrete", {"5d-stone-dust", "5d-stone-brick"})
add_unlocks("sulfur-processing", {"5d-coal-dust", "5d-refined-coal"})
add_unlocks("uranium-processing", {"5d-uranium-dust", "5d-uranium-processing"})
