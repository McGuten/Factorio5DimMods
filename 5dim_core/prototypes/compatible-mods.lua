if mods["Orbital Ion Cannon"] then
    data.raw["ammo-turret"]["ion-cannon-targeter"].next_upgrade = nil
    data.raw["ammo-turret"]["ion-cannon-targeter"].fast_replaceable_group = nil
end
if mods["LoaderRedux"] and mods["5dim_transport"] then
    data.raw["loader"]["express-loader"].next_upgrade = "5d-loader-04"
end
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
