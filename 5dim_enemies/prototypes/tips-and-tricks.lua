-- =============================================================================
-- 5dim_enemies - Tips and Tricks
-- =============================================================================
-- Provides in-game documentation about enemy types and mechanics.
-- Part of the larger 5Dim's mod Tips and Tricks category.
-- =============================================================================

local simulations = require("prototypes.tips-and-tricks-simulations")

data:extend({
    -- =============================================================================
    -- MAIN CATEGORY: 5Dim's Mod
    -- =============================================================================
    {
        type = "tips-and-tricks-item-category",
        name = "5dim",
        order = "z-[5dim]"  -- At the end of the list
    },

    -- =============================================================================
    -- 5DIM ENEMIES - MAIN ENTRY
    -- =============================================================================
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-intro",
        tag = "[entity=biter-spawner]",
        category = "5dim",
        order = "a",
        is_title = true,
        starting_status = "unlocked",
        simulation = simulations.enemies_intro
    },

    -- =============================================================================
    -- TIER SYSTEM EXPLANATION
    -- =============================================================================
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-tiers",
        tag = "[img=utility/danger_icon]",
        category = "5dim",
        order = "a-a",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.tier_system
    },

    -- =============================================================================
    -- FULL BATTLE - All enemies combined
    -- =============================================================================
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-full-battle",
        tag = "[item=submachine-gun]",
        category = "5dim",
        order = "a-b",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.full_battle
    },

    -- =============================================================================
    -- ENEMY TYPES - BITERS
    -- =============================================================================
    
    -- Normal Biters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-normal-biter",
        tag = "[entity=medium-biter]",
        category = "5dim",
        order = "b-a",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.normal_biter
    },

    -- Laser Biters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-laser-biter",
        tag = "[item=laser-turret]",
        category = "5dim",
        order = "b-b",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.laser_biter
    },

    -- Physical/Armored Biters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-physical-biter",
        tag = "[item=piercing-rounds-magazine]",
        category = "5dim",
        order = "b-c",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.physical_biter
    },

    -- Impact Biters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-impact-biter",
        tag = "[item=tank]",
        category = "5dim",
        order = "b-d",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.impact_biter
    },

    -- Broodmother Biters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-broodmother-biter",
        tag = "[entity=biter-spawner]",
        category = "5dim",
        order = "b-e",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.broodmother_biter
    },

    -- Swarm Biters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-swarm-biter",
        tag = "[entity=small-biter]",
        category = "5dim",
        order = "b-f",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.swarm_biter
    },

    -- Regenerator Biters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-regenerator-biter",
        tag = "[item=repair-pack]",
        category = "5dim",
        order = "b-g",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.regenerator_biter
    },

    -- Berserker Biters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-berserker-biter",
        tag = "[item=grenade]",
        category = "5dim",
        order = "b-h",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.berserker_biter
    },

    -- Tank Enemies (biters, spitters, worms)
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-tank",
        tag = "[item=heavy-armor]",
        category = "5dim",
        order = "b-i",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.tank_enemy
    },

    -- =============================================================================
    -- ENEMY TYPES - SPITTERS
    -- =============================================================================

    -- Fire Spitters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-fire-spitter",
        tag = "[item=flamethrower-turret]",
        category = "5dim",
        order = "c-a",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.fire_spitter
    },

    -- Rocket Spitters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-rocket-spitter",
        tag = "[item=rocket-launcher]",
        category = "5dim",
        order = "c-b",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.rocket_spitter
    },

    -- Suicide Spitters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-suicide-spitter",
        tag = "[item=explosive-rocket]",
        category = "5dim",
        order = "c-c",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.suicide_spitter
    },

    -- Poison Spitters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-poison-spitter",
        tag = "[item=poison-capsule]",
        category = "5dim",
        order = "c-d",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.poison_spitter
    },

    -- Electric Spitters
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-electric-spitter",
        tag = "[item=battery]",
        category = "5dim",
        order = "c-e",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.electric_spitter
    },

    -- =============================================================================
    -- SPACE AGE ENEMIES (only if Space Age is active)
    -- =============================================================================
    
    -- Railgun enemies entry (appears if mod has SA dependency)
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-railgun",
        tag = "[item=railgun]",
        category = "5dim",
        order = "d-a",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.railgun_enemies
    },

    -- =============================================================================
    -- BOSS ENEMIES
    -- =============================================================================
    {
        type = "tips-and-tricks-item",
        name = "5dim-enemies-bosses",
        tag = "[entity=behemoth-biter]",
        category = "5dim",
        order = "e",
        indent = 1,
        starting_status = "unlocked",
        simulation = simulations.boss_enemy
    }
})
