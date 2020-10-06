-- Logistics
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "5d-underground-belt-30-01"})
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "5d-underground-belt-50-01"})
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "loader"})
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk1-30"})
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk1-50"})

-- Logistics 2
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-fast-underground-belt-30-02"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-fast-underground-belt-50-02"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "fast-loader"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-pipe-mk2"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk2"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk2-30"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk2-50"})

-- Logistics 3
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-express-underground-belt-30-03"})
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-express-underground-belt-50-03"})
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "express-loader"})
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-pipe-mk3"})
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk3"})
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk3-30"})
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk3-50"})

data.raw["pipe-to-ground"]["pipe-to-ground"].fast_replaceable_group = "pipe-to-ground"
data.raw["pipe-to-ground"]["pipe-to-ground"].collision_mask = {"object-layer"}
data.raw["pipe"]["pipe"].fast_replaceable_group = "pipe"
data.raw["pipe"]["pipe"].collision_mask = {"object-layer"}