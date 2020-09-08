--Changes
require("prototypes.changes")

--Gun turret
require("prototypes.gen-gun-turret-small")
require("prototypes.gen-gun-turret")
require("prototypes.gen-gun-turret-big")
require("prototypes.gen-gun-turret-sniper")

--Laser turret
require("prototypes.gen-laser-turret-small")
require("prototypes.gen-laser-turret")
require("prototypes.gen-laser-turret-big")
require("prototypes.gen-laser-turret-sniper")

-- Tesla turret
require("prototypes.gen-tesla-turret")

-- Flamethrower turret
require("prototypes.gen-flamethrower-turret")

-- Radar
require("prototypes.gen-radar")


-- require("prototypes.wall")
-- require("prototypes.gate")
-- require("prototypes.ammo-category")
-- require("prototypes.tech")

--Worms
if settings.startup["5d-worm"].value then
    require("prototypes.experimental-worm")
end

--Biters
if not mods["5dim_enemies"] then
    require("prototypes.bitter")
    --require("prototypes.bitter-test")
    require("prototypes.physical")
    require("prototypes.laser")

    if settings.startup["5d-swimmer"].value then
        require("prototypes.swimmer")
    end
    if settings.startup["5d-climber"].value then
        require("prototypes.climber")
    end
end

--Spiters
if not mods["5dim_enemies"] then
    require("prototypes.spitter")
    require("prototypes.rocket")
    require("prototypes.fire")

    if settings.startup["5d-suicide"].value then
        require("prototypes.explosive")
    end
end

--Experimental
if not mods["5dim_enemies"] then
    if settings.startup["5d-exp"].value then
        require("prototypes.exp")
    end
end

--FlameThrower turret
-- require("prototypes.flamethrower-turret")

--Laser turret
-- require("prototypes.small-laser")
-- require("prototypes.big-laser")

--Gun turret
-- require("prototypes.small-ammo")
-- require("prototypes.big-ammo")

--Sniper turret
-- require("prototypes.exp-turret")
-- require("prototypes.tesla-turret")

--Electric turret
-- require("prototypes.electric-turret")

--Tank
-- require("prototypes.tank-2")

--Artillery
--require("prototypes.artillery")

--Radar
--require("prototypes.radar-2")
