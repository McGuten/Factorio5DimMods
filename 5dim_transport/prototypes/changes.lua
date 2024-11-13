-- Logistics
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "5d-underground-belt-30-01"})
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "5d-underground-belt-50-01"})
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "loader"})
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk1-30"})
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk1-50"})
table.insert(data.raw.technology["logistics"].effects, {type = "unlock-recipe", recipe = "5d-loader-1x1-01"})

-- Logistics 2
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-fast-underground-belt-30-02"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-fast-underground-belt-50-02"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "fast-loader"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-loader-1x1-02"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "fast-inserter"})
-- table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-pipe-mk2"})
-- table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk2"})
-- table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk2-30"})
-- table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk2-50"})

-- Logistics 3
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-express-underground-belt-30-03"})
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-express-underground-belt-50-03"})
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "express-loader"})
table.insert(data.raw.technology["logistics-2"].effects, {type = "unlock-recipe", recipe = "5d-loader-1x1-03"})
-- table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-pipe-mk3"})
-- table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk3"})
-- table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk3-30"})
-- table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk3-50"})
table.insert(data.raw.technology["logistics-3"].effects, {type = "unlock-recipe", recipe = "5d-inserter-03"})

-- Logistics 4
table.insert(data.raw.technology["logistics-4"].effects, {type = "unlock-recipe", recipe = "5d-inserter-04"})

-- Logistics 5
table.insert(data.raw.technology["logistics-5"].effects, {type = "unlock-recipe", recipe = "5d-inserter-05"})

-- Logistics 6
table.insert(data.raw.technology["logistics-6"].effects, {type = "unlock-recipe", recipe = "5d-inserter-06"})

-- Logistics 7
table.insert(data.raw.technology["logistics-7"].effects, {type = "unlock-recipe", recipe = "5d-inserter-07"})

-- Logistics 8
table.insert(data.raw.technology["logistics-8"].effects, {type = "unlock-recipe", recipe = "5d-inserter-08"})

-- Logistics 9
table.insert(data.raw.technology["logistics-9"].effects, {type = "unlock-recipe", recipe = "5d-inserter-09"})

-- Logistics 10
table.insert(data.raw.technology["logistics-10"].effects, {type = "unlock-recipe", recipe = "5d-inserter-10"})

-- Misc
data.raw["loader-1x1"]["loader-1x1"].hidden = false

data.raw["pipe-to-ground"]["pipe-to-ground"].fast_replaceable_group = "pipe-to-ground"
data.raw["pipe-to-ground"]["pipe-to-ground"].collision_mask = {layers = {item = true, object = true, water_tile = true}}

data.raw["pipe"]["pipe"].fast_replaceable_group = "pipe"
data.raw["pipe"]["pipe"].collision_mask = {layers = {item = true, object = true, water_tile = true}}

