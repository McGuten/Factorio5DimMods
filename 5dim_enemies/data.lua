-- =============================================================================
-- 5dim_enemies - Main Data File
-- =============================================================================

-- =============================================================================
-- CUSTOM PROJECTILES (must load before enemies!)
-- =============================================================================
require("prototypes.projectiles.poison-clouds")  -- Optimized poison clouds (load first!)
require("prototypes.projectiles.poison-streams")

-- =============================================================================
-- TIERED SYSTEM (10 Tiers per enemy type + Boss)
-- =============================================================================
-- Generates T1-T10 biters, spitters and worms for each type, plus tier-11 bosses
-- Configuration in: prototypes/config/
-- =============================================================================
require("prototypes.tiered-loader")
-- =============================================================================
-- TIPS AND TRICKS
-- =============================================================================
-- In-game documentation for all enemy types
-- =============================================================================
require("prototypes.tips-and-tricks")