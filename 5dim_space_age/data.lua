-- 5Dim's Space Age mod
-- Adds multiple tiers for Space Age machines

-- Changes to vanilla items
require("prototypes.changes")

-- Vulcanus machines
require("prototypes.gen-foundry")           -- Foundry (10 tiers)
require("prototypes.gen-big-mining-drill")  -- Big Mining Drill (10 tiers)

-- Gleba machines
require("prototypes.gen-biochamber")            -- Biochamber (10 tiers)
require("prototypes.gen-agricultural-tower")    -- Agricultural Tower (10 tiers)
require("prototypes.gen-captive-biter-spawner") -- Captive Biter Spawner (10 tiers)

-- Fulgora machines
require("prototypes.gen-electromagnetic-plant") -- Electromagnetic Plant (10 tiers)
require("prototypes.gen-recycler")              -- Recycler (10 tiers)
require("prototypes.gen-lightning-rod")         -- Lightning Rod (10 tiers)
require("prototypes.gen-lightning-collector")   -- Lightning Collector (10 tiers)

-- Aquilo machines
require("prototypes.gen-cryogenic-plant")   -- Cryogenic Plant (10 tiers)
require("prototypes.gen-heating-tower")     -- Heating Tower (10 tiers)

-- Orbit machines
require("prototypes.gen-cargo-bay")         -- Cargo Bay (10 tiers)
require("prototypes.gen-cargo-landing-pad") -- Cargo Landing Pad (10 tiers)
require("prototypes.gen-asteroid-collector") -- Asteroid Collector (10 tiers)
require("prototypes.gen-crusher")           -- Crusher (10 tiers)
require("prototypes.gen-thruster")          -- Thruster (10 tiers)
-- Equipment
require("prototypes.gen-fusion-reactor-equipment") -- Fusion Reactor Equipment (10 tiers)

-- Gleba machines (continued)
require("prototypes.gen-biolab")            -- Biolab (10 tiers)

-- Fusion power
require("prototypes.gen-fusion-reactor-building") -- Fusion Reactor Building (10 tiers)
require("prototypes.gen-fusion-generator")        -- Fusion Generator (10 tiers)

-- Armor
require("prototypes.gen-mech-armor")        -- Mech Armor (10 tiers)

-- Space Age Turrets (requires 5dim_battlefield)
if mods["5dim_battlefield"] then
    require("prototypes.gen-tesla-turret-sa")   -- Tesla Turret SA (10 tiers)
    require("prototypes.gen-railgun-turret")    -- Railgun Turret (10 tiers)
    require("prototypes.gen-rocket-turret")     -- Rocket Turret (10 tiers)
end
