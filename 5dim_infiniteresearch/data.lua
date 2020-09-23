-- Robots cargo size
if mods["5dim_logistic"] and settings.startup["5d-storage"].value then
    require("prototypes.worker-robots-storage")
end

-- Inserters capacity
if settings.startup["5d-stack"].value then
    require("prototypes.stack")
end

-- Laboratoy speed
if settings.startup["5d-speed"].value then
    require("prototypes.tech-speed")
    require("prototypes.tech-productivity")
end

--Speed research for ammo and turrets
if settings.startup["5d-speed-gun-turret"].value then
    require("prototypes.bullet-ammo")
    require("prototypes.laser-turret")
end

--Bracking
if settings.startup["5d-braking"].value then
    require("prototypes.braking")
end

-- Player upgrades
require("prototypes.crafting-speed")
require("prototypes.mining-speed")
