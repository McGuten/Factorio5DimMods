-------------------------------------------------------------------------------
-- 5Dim's Resources - Space Age planetary techs
-- Four techs (one per planet) unlocking dust-sa.lua recipes.
-------------------------------------------------------------------------------

if not mods["space-age"] then
    return
end

data:extend({
    {
        type = "technology",
        name = "5d-vulcanus-resources",
        icons = {
            {
                icon = "__space-age__/graphics/icons/tungsten-ore.png",
                icon_size = 64
            },
            {
                icon = "__5dim_resources__/graphics/icon/resources/5d-iron-dust.png",
                icon_size = 32,
                scale = 0.85,
                shift = { 10, 10 }
            },
            {
                icon = "__space-age__/graphics/icons/calcite.png",
                icon_size = 64,
                scale = 0.35,
                shift = { -12, -12 }
            }
        },
        prerequisites = { "foundry", "tungsten-steel" },
        effects = {
            { type = "unlock-recipe", recipe = "5d-tungsten-dust" },
            { type = "unlock-recipe", recipe = "5d-tungsten-plate" },
            { type = "unlock-recipe", recipe = "5d-calcite-dust" },
            { type = "unlock-recipe", recipe = "5d-molten-iron-from-lava" },
            { type = "unlock-recipe", recipe = "5d-molten-copper-from-lava" }
        },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 },
                { "metallurgic-science-pack", 1 }
            },
            time = 30
        },
        order = "c-c-c"
    },
    {
        type = "technology",
        name = "5d-fulgora-resources",
        icons = {
            {
                icon = "__space-age__/graphics/icons/holmium-ore.png",
                icon_size = 64
            },
            {
                icon = "__5dim_resources__/graphics/icon/resources/5d-iron-dust.png",
                icon_size = 32,
                scale = 0.85,
                shift = { 10, 10 }
            },
            {
                icon = "__space-age__/graphics/icons/scrap.png",
                icon_size = 64,
                scale = 0.35,
                shift = { -12, -12 }
            }
        },
        prerequisites = { "recycling", "holmium-processing" },
        effects = {
            { type = "unlock-recipe", recipe = "5d-holmium-dust" },
            { type = "unlock-recipe", recipe = "5d-holmium-solution" },
            { type = "unlock-recipe", recipe = "5d-scrap-compact" },
            { type = "unlock-recipe", recipe = "5d-compacted-scrap-recycling" }
        },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 },
                { "electromagnetic-science-pack", 1 }
            },
            time = 30
        },
        order = "c-c-d"
    },
    {
        type = "technology",
        name = "5d-gleba-resources",
        icons = {
            {
                icon = "__space-age__/graphics/icons/yumako-processing.png",
                icon_size = 64
            },
            {
                icon = "__space-age__/graphics/icons/jellynut-processing.png",
                icon_size = 64,
                scale = 0.45,
                shift = { -12, -12 }
            }
        },
        prerequisites = { "yumako", "jellynut" },
        effects = {
            { type = "unlock-recipe", recipe = "5d-yumako-processing" },
            { type = "unlock-recipe", recipe = "5d-jellynut-processing" }
        },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 },
                { "agricultural-science-pack", 1 }
            },
            time = 30
        },
        order = "c-c-e"
    },
    {
        type = "technology",
        name = "5d-aquilo-resources",
        icon = "__space-age__/graphics/technology/lithium-processing.png",
        icon_size = 256,
        prerequisites = { "lithium-processing" },
        effects = {
            { type = "unlock-recipe", recipe = "5d-ammoniacal-solution-separation" },
            { type = "unlock-recipe", recipe = "5d-lithium" }
        },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 },
                { "cryogenic-science-pack",  1 }
            },
            time = 30
        },
        order = "c-c-f"
    }
})
