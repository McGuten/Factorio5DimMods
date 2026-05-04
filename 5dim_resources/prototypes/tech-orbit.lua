if not mods["space-age"] then
    return
end

local DustCommon = require("prototypes.dust-common")

local asteroidTints = {
    metallic = { r = 0.82, g = 0.80, b = 0.83, a = 1 }
}

local function make_orbit_technology_icons(baseIcon, tint, extraIcon, machineIcon)
    local icons = DustCommon.make_dust_technology_icons(baseIcon, tint, extraIcon)

    if machineIcon ~= nil then
        table.insert(icons, {
            icon = machineIcon,
            icon_size = 64,
            scale = 0.28,
            shift = { 14, 14 }
        })
    end

    return icons
end

data:extend({
    {
        type = "technology",
        name = "5d-orbit-resources",
        icons = make_orbit_technology_icons(
            "__space-age__/graphics/icons/metallic-asteroid-chunk.png",
            asteroidTints.metallic,
            "__space-age__/graphics/icons/oxide-asteroid-chunk.png",
            "__5dim_resources__/graphics/icon/masher/masher-icon-01.png"
        ),
        prerequisites = { "space-platform-thruster", "5d-masher-1" },
        effects = {
            { type = "unlock-recipe", recipe = "5d-metallic-asteroid-mashing" },
            { type = "unlock-recipe", recipe = "5d-carbonic-asteroid-mashing" },
            { type = "unlock-recipe", recipe = "5d-oxide-asteroid-mashing" },
            { type = "unlock-recipe", recipe = "5d-metallic-asteroid-crushing" },
            { type = "unlock-recipe", recipe = "5d-carbonic-asteroid-crushing" },
            { type = "unlock-recipe", recipe = "5d-oxide-asteroid-crushing" }
        },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            time = 60
        },
        order = "c-c-g"
    },
    {
        type = "technology",
        name = "5d-advanced-orbit-resources",
        icons = make_orbit_technology_icons(
            "__space-age__/graphics/icons/advanced-metallic-asteroid-crushing.png",
            asteroidTints.metallic,
            "__space-age__/graphics/icons/advanced-oxide-asteroid-crushing.png",
            "__5dim_resources__/graphics/icon/masher/masher-icon-01.png"
        ),
        prerequisites = { "5d-orbit-resources", "advanced-asteroid-processing" },
        effects = {
            { type = "unlock-recipe", recipe = "5d-advanced-metallic-asteroid-crushing" },
            { type = "unlock-recipe", recipe = "5d-advanced-carbonic-asteroid-crushing" },
            { type = "unlock-recipe", recipe = "5d-advanced-oxide-asteroid-crushing" }
        },
        unit = {
            count = 1000,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 },
                { "agricultural-science-pack", 1 }
            },
            time = 60
        },
        order = "c-c-h"
    }
})