if mods["Orbital Ion Cannon"] then
    data.raw["ammo-turret"]["ion-cannon-targeter"].next_upgrade = nil
    data.raw["ammo-turret"]["ion-cannon-targeter"].fast_replaceable_group = nil
end
if mods["LoaderRedux"] and mods["5dim_transport"] then
    data.raw["loader"]["express-loader"].next_upgrade = "5d-loader-04"
end