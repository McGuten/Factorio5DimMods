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
if mods["boblogistics"] and mods["5dim_transport"] then
    data.raw["pump"]["pump"].fast_replaceable_group = "pump"
    data.raw["pump"]["bob-pump-2"].fast_replaceable_group = "pump"
    data.raw["pump"]["bob-pump-3"].fast_replaceable_group = "pump"
    data.raw["pump"]["bob-pump-4"].fast_replaceable_group = "pump"
end
if mods["bobwarfare"] and mods["5dim_battlefield"] then
    data.raw["ammo-turret"]["gun-turret"].fast_replaceable_group = "gun-turret"
    data.raw["electric-turret"]["laser-turret"].fast_replaceable_group = "laser-turret"
end
if mods["bobtech"] and mods["5dim_automation"] then
    local inputLab = {
        "automation-science-pack",
        "logistic-science-pack",
        "chemical-science-pack",
        "military-science-pack",
        "production-science-pack",
        "advanced-logistic-science-pack",
        "utility-science-pack",
        "space-science-pack"
    }
    data.raw["lab"]["5d-lab-02"].inputs = inputLab
    data.raw["lab"]["5d-lab-03"].inputs = inputLab
    data.raw["lab"]["5d-lab-04"].inputs = inputLab
    data.raw["lab"]["5d-lab-05"].inputs = inputLab
    data.raw["lab"]["5d-lab-06"].inputs = inputLab
    data.raw["lab"]["5d-lab-07"].inputs = inputLab
    data.raw["lab"]["5d-lab-08"].inputs = inputLab
    data.raw["lab"]["5d-lab-09"].inputs = inputLab
    data.raw["lab"]["5d-lab-10"].inputs = inputLab
end

-- Transport drones
if mods["Transport_Drones"] and mods["5dim_transport"] then
    data.raw["pump"]["transport-depot-writer"].next_upgrade = nil
end

--Bio Industries
if mods["Bio_Industries"] and mods["5dim_decoration"] then
    data.raw.tree["5d-banner-1"].minable = {hardness = 0.2, mining_time = 0.5, result = "5d-banner-1"}
    data.raw.tree["5d-banner-2"].minable = {hardness = 0.2, mining_time = 0.5, result = "5d-banner-2"}
    data.raw.tree["5d-banner-3"].minable = {hardness = 0.2, mining_time = 0.5, result = "5d-banner-3"}
    data.raw.tree["5d-obelisk"].minable = {hardness = 0.2, mining_time = 0.5, result = "5d-obelisk"}
    data.raw.tree["5d-statue"].minable = {hardness = 0.2, mining_time = 0.5, result = "5d-statue"}
end

-- ModSmash
if mods["modmashsplinterlogistics"] and mods["5dim_transport"] then
    -- Logistics 4
    table.insert(data.raw.technology["logistics-4"].effects, {type = "unlock-recipe", recipe = "5d-inserter-04"})
    table.insert(data.raw.technology["logistics-4"].effects, {type = "unlock-recipe", recipe = "5d-filter-inserter-04"})
    table.insert(data.raw.technology["logistics-4"].effects, {type = "unlock-recipe", recipe = "5d-transport-belt-04"})
    table.insert(
        data.raw.technology["logistics-4"].effects,
        {type = "unlock-recipe", recipe = "5d-underground-belt-04"}
    )
    table.insert(
        data.raw.technology["logistics-4"].effects,
        {type = "unlock-recipe", recipe = "5d-underground-belt-30-04"}
    )
    table.insert(
        data.raw.technology["logistics-4"].effects,
        {type = "unlock-recipe", recipe = "5d-underground-belt-50-04"}
    )
    table.insert(data.raw.technology["logistics-4"].effects, {type = "unlock-recipe", recipe = "5d-splitter-04"})
    table.insert(data.raw.technology["logistics-4"].effects, {type = "unlock-recipe", recipe = "5d-loader-04"})

    -- Logistics 5
    table.insert(data.raw.technology["logistics-5"].effects, {type = "unlock-recipe", recipe = "5d-inserter-05"})
    table.insert(data.raw.technology["logistics-5"].effects, {type = "unlock-recipe", recipe = "5d-filter-inserter-05"})
    table.insert(data.raw.technology["logistics-5"].effects, {type = "unlock-recipe", recipe = "5d-transport-belt-05"})
    table.insert(
        data.raw.technology["logistics-5"].effects,
        {type = "unlock-recipe", recipe = "5d-underground-belt-05"}
    )
    table.insert(
        data.raw.technology["logistics-5"].effects,
        {type = "unlock-recipe", recipe = "5d-underground-belt-30-05"}
    )
    table.insert(
        data.raw.technology["logistics-5"].effects,
        {type = "unlock-recipe", recipe = "5d-underground-belt-50-05"}
    )
    table.insert(data.raw.technology["logistics-5"].effects, {type = "unlock-recipe", recipe = "5d-splitter-05"})
    table.insert(data.raw.technology["logistics-5"].effects, {type = "unlock-recipe", recipe = "5d-loader-05"})
end

-- ModSmash
if mods["modmashsplinterassembling"] and mods["5dim_automation"] then
    -- Automation 4
    table.insert(
        data.raw.technology["automation-4"].effects,
        {type = "unlock-recipe", recipe = "5d-assembling-machine-04"}
    )

    -- Automation 5
    table.insert(
        data.raw.technology["automation-5"].effects,
        {type = "unlock-recipe", recipe = "5d-assembling-machine-05"}
    )
end
