-- 5Dim's Mod - Settings
-- This file defines the startup settings for cost multipliers and Space Age integration

data:extend({
    -- Space Age planetary integration (adds planetary materials to high-tier recipes
    -- and planetary science packs to high-tier technologies)
    -- Only visible when Space Age DLC is installed
    {
        type = "bool-setting",
        name = "5d-space-age-materials",
        order = "a-aa",
        setting_type = "startup",
        default_value = true,
        hidden = not mods["space-age"]
    },
    -- Spoil time multiplier: scales spoil_ticks of all perishable items (Space Age only)
    {
        type = "double-setting",
        name = "5d-spoil-time-multiplier",
        order = "a-ab",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.1,
        maximum_value = 100,
        hidden = not mods["space-age"]
    },
    {
        type = "bool-setting",
        name = "5d-icon-tier-overlay",
        order = "a-ac",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "5d-icon-tier-overlay-black-background",
        order = "a-ad",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "5d-entity-tier-overlay",
        order = "a-ae",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "5d-entity-tier-overlay-black-background",
        order = "a-af",
        setting_type = "startup",
        default_value = true
    },
    -- Machine Work Progression Factor
    {
        type = "double-setting",
        name = "5d-machine-work-factor",
        order = "a-ba",
        setting_type = "startup",
        default_value = 1.45,
        minimum_value = 1.0,
        maximum_value = 3.0
    },
    -- Machine Energy Progression Factor
    {
        type = "double-setting",
        name = "5d-machine-energy-factor",
        order = "a-bb",
        setting_type = "startup",
        default_value = 1.75,
        minimum_value = 1.0,
        maximum_value = 3.0
    },
    -- Machine Recipe Progression Factor
    {
        type = "double-setting",
        name = "5d-machine-recipe-factor",
        order = "a-bc",
        setting_type = "startup",
        default_value = 1.25,
        minimum_value = 1.0,
        maximum_value = 3.0
    },
    -- Machine Technology Progression Factor
    {
        type = "double-setting",
        name = "5d-machine-tech-factor",
        order = "a-bd",
        setting_type = "startup",
        default_value = 1.3,
        minimum_value = 1.0,
        maximum_value = 3.0
    },
    -- Tier 10 Capstone: Use Next Tier Work Value
    {
        type = "bool-setting",
        name = "5d-machine-t10-next-tier-work",
        order = "a-be",
        setting_type = "startup",
        default_value = true
    },
    -- Tier 10 Capstone: Extra Module Slots
    {
        type = "int-setting",
        name = "5d-machine-t10-extra-module-slots",
        order = "a-bf",
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0,
        maximum_value = 10
    },
    -- Crafting Time Multiplier
    {
        type = "double-setting",
        name = "5d-crafting-time-multiplier",
        order = "a-bg",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.1,
        maximum_value = 10.0
    }
})
