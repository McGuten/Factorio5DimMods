-- =============================================================================
-- 5dim_enemies - Tiered Enemies Loader
-- =============================================================================
-- This file loads all tiered enemy components in the correct order.
-- It ensures configurations are loaded before generators.
-- =============================================================================

-- Note: Configuration files are loaded via require() in the generator files
-- This loader just executes the generators in order

-- =============================================================================
-- VANILLA SPAWNERS (Normal biters/spitters T1-T10)
-- =============================================================================

-- Generate normal tiered biters/spitters and modify vanilla spawners
require("prototypes.vanilla.vanilla-spawner-modifier")

-- =============================================================================
-- BITERS
-- =============================================================================

-- Generate all tiered biters (T1-T10)
require("prototypes.biter.gen-biters-tiered")

-- Generate boss biters (tier 11, if enabled)
require("prototypes.boss.boss-biters")

-- =============================================================================
-- SPITTERS
-- =============================================================================

-- Generate all tiered spitters (T1-T10)
require("prototypes.spitter.gen-spitters-tiered")

-- Generate boss spitters (tier 11, if enabled)
require("prototypes.boss.boss-spitters")

-- =============================================================================
-- WORMS
-- =============================================================================

-- Generate normal tiered worms (T1-T10)
require("prototypes.worm.vanilla-worm-modifier")

-- Generate special typed worms (fire, laser, physical, acid)
require("prototypes.worm.gen-worms-tiered")

-- Generate boss worms (tier 11, if enabled)
require("prototypes.boss.boss-worms")
