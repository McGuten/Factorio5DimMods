--Gun turret
require("prototypes.gen-gun-turret")
require("prototypes.gen-sniper-ammo")
require("prototypes.gen-sniper-gun")
require("prototypes.gen-gun-turret-sniper")

--Laser turret
require("prototypes.gen-laser-turret")
require("prototypes.gen-laser-turret-sniper")

-- Tesla turret
require("prototypes.gen-tesla-turret")

-- Flamethrower turret
require("prototypes.gen-flamethrower-turret")

-- Radar
require("prototypes.gen-radar")

-- Wall
require("prototypes.gen-wall")
require("prototypes.gen-gate")

-- Artillery
require("prototypes.gen-artillery-turret")
require("prototypes.gen-artillery-ammo")

-- Artillery Wagon (requires 5dim_trains)
if mods["5dim_trains"] then
    require("prototypes.gen-artillery-wagon")
end

-- Mines
require("prototypes.gen-land-mine")
if settings.startup["5d-special-mines"].value then
    require("prototypes.gen-poison-mine")
    require("prototypes.gen-acid-mine")
end

-- Decoy Structure (commented out temporarily)
-- require("prototypes.gen-decoy")

-- Combat Capsules
require("prototypes.gen-combat-capsules")
require("prototypes.gen-combat-robots")

-- New turret types
if settings.startup["5d-special-turrets"].value then
    require("prototypes.gen-poison-turret")
    require("prototypes.gen-acid-turret")
    require("prototypes.gen-mortar-turret")
    require("prototypes.gen-robot-deployer")
    require("prototypes.gen-flare-turret")
end

require("prototypes.gen-slow-turret")