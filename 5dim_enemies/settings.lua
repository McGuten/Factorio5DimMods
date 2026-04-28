-- =============================================================================
-- 5dim_enemies Settings
-- =============================================================================
-- All enemy-related settings are defined here for better organization
-- =============================================================================

data:extend({
    -- =========================================================================
    -- BITER TYPES
    -- =========================================================================
    {
        type = "bool-setting",
        name = "5d-laser-biter",
        order = "a-aa",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-physical-biter",
        order = "a-ab",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-impact-biter",
        order = "a-ac",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },

    -- =========================================================================
    -- SPITTER TYPES
    -- =========================================================================
    {
        type = "bool-setting",
        name = "5d-fire-spitter",
        order = "b-aa",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-rocket-spitter",
        order = "b-ab",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-suicide",
        order = "b-ac",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-laser-spitter",
        order = "b-ad",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-physical-spitter",
        order = "b-ae",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-poison-spitter",
        order = "b-af",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-electric-spitter",
        order = "b-ag",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-broodmother-biter",
        order = "a-af",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-broodmother-spitter",
        order = "b-ah",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-swarm-biter",
        order = "a-ai",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-regenerator-biter",
        order = "a-aj",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-regenerator-spitter",
        order = "b-ak",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-berserker-biter",
        order = "a-al",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-tank-biter",
        order = "a-am",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-tank-spitter",
        order = "b-al",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-tank-worm",
        order = "c-ab",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },

    -- =========================================================================
    -- WORMS
    -- =========================================================================
    {
        type = "bool-setting",
        name = "5d-worm",
        order = "c-aa",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },

    -- =========================================================================
    -- BOSS (Tier 11 - Super powerful enemies)
    -- =========================================================================
    {
        type = "bool-setting",
        name = "5d-boss",
        order = "z-aa",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },

    -- =========================================================================
    -- DEATH EFFECTS CONFIGURATION
    -- =========================================================================
    {
        type = "bool-setting",
        name = "5d-death-effects",
        order = "d-aa",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "double-setting",
        name = "5d-death-effect-scale",
        order = "d-ab",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.25,
        maximum_value = 3.0,
        per_user = false
    },

    -- =========================================================================
    -- SPECIAL ATTACKS CONFIGURATION
    -- =========================================================================
    {
        type = "bool-setting",
        name = "5d-typed-damage",
        order = "e-aa",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },
    {
        type = "bool-setting",
        name = "5d-attack-stickers",
        order = "e-ab",
        setting_type = "startup",
        default_value = true,
        per_user = false
    },

    -- =========================================================================
    -- DIFFICULTY SCALING
    -- =========================================================================
    {
        type = "double-setting",
        name = "5d-health-multiplier",
        order = "f-aa",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.25,
        maximum_value = 5.0,
        per_user = false
    },
    {
        type = "double-setting",
        name = "5d-damage-multiplier",
        order = "f-ab",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.25,
        maximum_value = 5.0,
        per_user = false
    },
    {
        type = "double-setting",
        name = "5d-speed-multiplier",
        order = "f-ac",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.5,
        maximum_value = 2.0,
        per_user = false
    }
})

-- =============================================================================
-- SPACE AGE EXCLUSIVE TYPES (Railgun)
-- =============================================================================
-- These enemy types only appear when Space Age DLC is installed

if mods["space-age"] then
    data:extend({
        -- Railgun Biter (high-velocity physical damage, armor piercing)
        {
            type = "bool-setting",
            name = "5d-railgun-biter",
            order = "a-sa-a",
            setting_type = "startup",
            default_value = true,
            per_user = false
        },
        -- Railgun Spitter (shoots railgun beam)
        {
            type = "bool-setting",
            name = "5d-railgun-spitter",
            order = "b-sa-a",
            setting_type = "startup",
            default_value = true,
            per_user = false
        },
        -- Railgun Worm
        {
            type = "bool-setting",
            name = "5d-railgun-worm",
            order = "c-sa-a",
            setting_type = "startup",
            default_value = true,
            per_user = false
        }
    })
end