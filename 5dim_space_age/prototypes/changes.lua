-- Changes to vanilla Space Age items for sorting purposes
-- Uses subgroups defined in 5dim_core

-- Add fast_replaceable_group to vanilla entities and set next_upgrade
-- Foundry (vulcanus)
data.raw["assembling-machine"]["foundry"].fast_replaceable_group = "foundry"
data.raw["assembling-machine"]["foundry"].next_upgrade = "5d-foundry-02"

-- Electromagnetic Plant (fulgora)
data.raw["assembling-machine"]["electromagnetic-plant"].fast_replaceable_group = "electromagnetic-plant"
data.raw["assembling-machine"]["electromagnetic-plant"].next_upgrade = "5d-electromagnetic-plant-02"

-- Cryogenic Plant (aquilo)
data.raw["assembling-machine"]["cryogenic-plant"].fast_replaceable_group = "cryogenic-plant"
data.raw["assembling-machine"]["cryogenic-plant"].next_upgrade = "5d-cryogenic-plant-02"

-- Biochamber (gleba)
data.raw["assembling-machine"]["biochamber"].fast_replaceable_group = "biochamber"
data.raw["assembling-machine"]["biochamber"].next_upgrade = "5d-biochamber-02"

-- Cargo Bay (orbit)
data.raw["cargo-bay"]["cargo-bay"].fast_replaceable_group = "cargo-bay"
data.raw["cargo-bay"]["cargo-bay"].next_upgrade = "5d-cargo-bay-02"

-- Cargo Landing Pad (orbit)
data.raw["cargo-landing-pad"]["cargo-landing-pad"].fast_replaceable_group = "cargo-landing-pad"
data.raw["cargo-landing-pad"]["cargo-landing-pad"].next_upgrade = "5d-cargo-landing-pad-02"

-- Asteroid Collector (orbit)
data.raw["asteroid-collector"]["asteroid-collector"].fast_replaceable_group = "asteroid-collector"
data.raw["asteroid-collector"]["asteroid-collector"].next_upgrade = "5d-asteroid-collector-02"

-- Crusher (orbit) - type is "assembling-machine"
data.raw["assembling-machine"]["crusher"].fast_replaceable_group = "crusher"
data.raw["assembling-machine"]["crusher"].next_upgrade = "5d-crusher-02"

-- Thruster (orbit)
data.raw["thruster"]["thruster"].fast_replaceable_group = "thruster"
data.raw["thruster"]["thruster"].next_upgrade = "5d-thruster-02"

-- Agricultural Tower (gleba)
data.raw["agricultural-tower"]["agricultural-tower"].fast_replaceable_group = "agricultural-tower"
data.raw["agricultural-tower"]["agricultural-tower"].next_upgrade = "5d-agricultural-tower-02"

-- Captive Biter Spawner (gleba) - type is "assembling-machine"
data.raw["assembling-machine"]["captive-biter-spawner"].fast_replaceable_group = "captive-biter-spawner"
data.raw["assembling-machine"]["captive-biter-spawner"].next_upgrade = "5d-captive-biter-spawner-02"

-- Recycler (fulgora) - type is "furnace" (from quality mod)
data.raw["furnace"]["recycler"].fast_replaceable_group = "recycler"
data.raw["furnace"]["recycler"].next_upgrade = "5d-recycler-02"

-- Big Mining Drill (vulcanus)
data.raw["mining-drill"]["big-mining-drill"].fast_replaceable_group = "big-mining-drill"
data.raw["mining-drill"]["big-mining-drill"].next_upgrade = "5d-big-mining-drill-02"

-- Heating Tower (aquilo) - type is "reactor"
data.raw["reactor"]["heating-tower"].fast_replaceable_group = "heating-tower"
data.raw["reactor"]["heating-tower"].next_upgrade = "5d-heating-tower-02"

-- Fusion Reactor (aquilo) - type is "fusion-reactor"
data.raw["fusion-reactor"]["fusion-reactor"].fast_replaceable_group = "fusion-reactor"
data.raw["fusion-reactor"]["fusion-reactor"].next_upgrade = "5d-fusion-reactor-building-02"

-- Fusion Generator (aquilo) - type is "fusion-generator"
data.raw["fusion-generator"]["fusion-generator"].fast_replaceable_group = "fusion-generator"
data.raw["fusion-generator"]["fusion-generator"].next_upgrade = "5d-fusion-generator-02"

-- Biolab (Space Age) - type is "lab"
data.raw["lab"]["biolab"].fast_replaceable_group = "biolab"
data.raw["lab"]["biolab"].next_upgrade = "5d-biolab-02"

-- Space Age turrets (only when 5dim_battlefield is active)
if mods["5dim_battlefield"] then
    -- Tesla Turret (Space Age) - type is "electric-turret"
    data.raw["electric-turret"]["tesla-turret"].fast_replaceable_group = "tesla-turret"
    data.raw["electric-turret"]["tesla-turret"].next_upgrade = "5d-tesla-turret-sa-02"

    -- Railgun Turret (Space Age) - type is "ammo-turret"
    data.raw["ammo-turret"]["railgun-turret"].fast_replaceable_group = "railgun-turret"
    data.raw["ammo-turret"]["railgun-turret"].next_upgrade = "5d-railgun-turret-02"

    -- Rocket Turret (Space Age) - type is "ammo-turret"
    data.raw["ammo-turret"]["rocket-turret"].fast_replaceable_group = "rocket-turret"
    data.raw["ammo-turret"]["rocket-turret"].next_upgrade = "5d-rocket-turret-02"
end
