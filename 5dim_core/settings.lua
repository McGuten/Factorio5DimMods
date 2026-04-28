-- 5Dim's Mod - Settings
-- This file defines the startup settings for cost multipliers and Space Age integration

data:extend({
    -- Space Age Materials Integration (adds planetary materials to high-tier recipes)
    -- Only visible when Space Age DLC is installed
    {
        type = "bool-setting",
        name = "5d-space-age-materials",
        order = "a-aa",
        setting_type = "startup",
        default_value = true,
        hidden = not mods["space-age"]
    },
    -- Space Age Science Packs Integration (adds planetary science packs to high-tier technologies)
    -- Only visible when Space Age DLC is installed
    {
        type = "bool-setting",
        name = "5d-space-age-science-packs",
        order = "a-ab",
        setting_type = "startup",
        default_value = true,
        hidden = not mods["space-age"]
    },
    -- Technology Cost Multiplier
    {
        type = "double-setting",
        name = "5d-tech-cost-multiplier",
        order = "a-ba",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.1,
        maximum_value = 10.0
    },
    -- Recipe Cost Multiplier
    {
        type = "double-setting",
        name = "5d-recipe-cost-multiplier",
        order = "a-bb",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.1,
        maximum_value = 10.0
    },
    -- Crafting Time Multiplier
    {
        type = "double-setting",
        name = "5d-crafting-time-multiplier",
        order = "a-bc",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.1,
        maximum_value = 10.0
    }
})
