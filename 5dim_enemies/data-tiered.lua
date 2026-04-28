-- =============================================================================
-- 5dim_enemies - Tiered Data Loader
-- =============================================================================
-- This file loads the tiered enemy system.
--
-- System generates:
--   - Biters: T1-T10 for each type + Boss (T11)
--   - Spitters: T1-T10 for each type + Boss (T11)
--   - Worms: T1-T10 for each type + Boss (T11)
--   - Spawners: One per enemy type
--
-- Configuration files:
--   - prototypes/config/tiers.lua         - Tier stats, TypeMultipliers, boss config
--   - prototypes/config/biter-types.lua   - Biter type definitions
--   - prototypes/config/spitter-types.lua - Spitter type definitions
--   - prototypes/config/spawner-config.lua - Spawner evolution curves
-- =============================================================================

require("prototypes.tiered-loader")
