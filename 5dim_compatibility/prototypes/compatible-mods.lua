-- Orbital Ion Cannon compatibility
if mods["Orbital Ion Cannon"] then
    data.raw["ammo-turret"]["ion-cannon-targeter"].next_upgrade = nil
    data.raw["ammo-turret"]["ion-cannon-targeter"].fast_replaceable_group = nil
end

-- Loader Redux compatibility
if mods["LoaderRedux"] and mods["5dim_transport"] then
    data.raw["loader"]["express-loader"].next_upgrade = "5d-loader-04"
end

-- AAI Industry compatibility
if mods["aai-industry"] then
    data.raw.recipe["power-armor-mk2"].ingredients = {
        {"power-armor", 1},
        {"effectivity-module-2", 25},
        {"speed-module-2", 25},
        {"processing-unit", 60},
        {"electric-engine-unit", 40},
        {"low-density-structure", 30}
    }
    data.raw["offshore-pump"]["offshore-pump"].collision_box = {{-0.6, -1.05}, {0.6, 0.3}}
    data.raw["offshore-pump"]["offshore-pump"].selection_box = {{-0.6, -1.49}, {0.6, 0.49}}
end

-- Krastorio 2 compatibility
if mods["Krastorio2"] then
    for _, pipe in pairs(data.raw["pipe"]) do
        pipe.collision_mask = {"object-layer"}
    end
    for _, pipe in pairs(data.raw["pipe-to-ground"]) do
        pipe.collision_mask = {"object-layer"}
    end
end

-- Cargo Ships compatibility
if mods["cargo-ships"] then
    data.raw["radar"]["or_radar"].next_upgrade = nil
    data.raw["lamp"]["or_lamp"].next_upgrade = nil
    data.raw["mining-drill"]["oil_rig"].next_upgrade = nil
    for _, signal in pairs(data.raw["rail-signal"]) do
        signal.collision_mask = {"object-layer"}
    end
    for _, chain in pairs(data.raw["rail-chain-signal"]) do
        chain.collision_mask = {"object-layer"}
    end
end

-- AAI Industry and Space Exploration compatibility
if mods["aai-industry"] and mods["space-exploration"] then
    data.raw["offshore-pump"]["offshore-pump"].next_upgrade = nil
end

-- Bobs mod compatibility
if mods["bobassembly"] and mods["5dim_resources"] then
    data.raw.furnace["electric-furnace-2"].fast_replaceable_group = "electric-furnace"
    data.raw.furnace["electric-furnace-3"].fast_replaceable_group = "electric-furnace"
end
if mods["bobpower"] and mods["5dim_nuclear"] then
    data.raw.boiler["heat-exchanger"].fast_replaceable_group = "heat-exchanger"
    data.raw.boiler["heat-exchanger-2"].fast_replaceable_group = "heat-exchanger"
    data.raw.boiler["heat-exchanger-3"].fast_replaceable_group = "heat-exchanger"
    data.raw.boiler["heat-exchanger"].fast_replaceable_group = "heat-exchanger"
end
if mods["bobpower"] and mods["5dim_energy"] then
    data.raw["electric-pole"]["big-electric-pole"].fast_replaceable_group = "big-electric-pole"
    data.raw["electric-pole"]["big-electric-pole-2"].fast_replaceable_group = "big-electric-pole"
    data.raw["electric-pole"]["big-electric-pole-3"].fast_replaceable_group = "big-electric-pole"
    data.raw["electric-pole"]["big-electric-pole-4"].fast_replaceable_group = "big-electric-pole"
    data.raw["electric-pole"]["substation"].fast_replaceable_group = "substation"
    data.raw["electric-pole"]["substation-2"].fast_replaceable_group = "substation"
    data.raw["electric-pole"]["substation-3"].fast_replaceable_group = "substation"
    data.raw["electric-pole"]["substation-4"].fast_replaceable_group = "substation"
end
if mods["bobassembly"] and mods["5dim_transport"] then
    data.raw["pump"]["pump"].fast_replaceable_group = "pump"
    data.raw["pump"]["bob-pump-2"].fast_replaceable_group = "pump"
    data.raw["pump"]["bob-pump-3"].fast_replaceable_group = "pump"
    data.raw["pump"]["bob-pump-4"].fast_replaceable_group = "pump"
end
if mods["bobwarfare"] and mods["5dim_battlefield"] then
    data.raw["ammo-turret"]["gun-turret"].fast_replaceable_group = "gun-turret"
    data.raw["electric-turret"]["laser-turret"].fast_replaceable_group = "laser-turret"
end