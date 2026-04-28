-- Logistics
table.insert(data.raw.technology["logistics"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-30-01" })
table.insert(data.raw.technology["logistics"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-50-01" })
table.insert(data.raw.technology["logistics"].effects, { type = "unlock-recipe", recipe = "loader" })
table.insert(data.raw.technology["logistics"].effects, { type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk1-30" })
table.insert(data.raw.technology["logistics"].effects, { type = "unlock-recipe", recipe = "5d-pipe-to-ground-mk1-50" })
table.insert(data.raw.technology["logistics"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-01" })

-- Logistics 2
table.insert(data.raw.technology["logistics-2"].effects,
    { type = "unlock-recipe", recipe = "5d-fast-underground-belt-30-02" })
table.insert(data.raw.technology["logistics-2"].effects,
    { type = "unlock-recipe", recipe = "5d-fast-underground-belt-50-02" })
table.insert(data.raw.technology["logistics-2"].effects, { type = "unlock-recipe", recipe = "fast-loader" })
table.insert(data.raw.technology["logistics-2"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-02" })

-- Logistics 3
table.insert(data.raw.technology["logistics-3"].effects,
    { type = "unlock-recipe", recipe = "5d-express-underground-belt-30-03" })
table.insert(data.raw.technology["logistics-3"].effects,
    { type = "unlock-recipe", recipe = "5d-express-underground-belt-50-03" })
table.insert(data.raw.technology["logistics-3"].effects, { type = "unlock-recipe", recipe = "express-loader" })
table.insert(data.raw.technology["logistics-3"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-03" })

-- Tier 4 handling
-- With Space Age: tier 4 is turbo-transport-belt (vanilla), only extended variants (30, 50, 1x1) are generated
-- Without Space Age: tier 4 uses logistics-4 with 5d naming for all items
if mods["space-age"] then
    -- Add extended tier 4 variants to turbo-transport-belt technology
    -- Note: With Space Age, tier 4 uses turbo-loader (vanilla), not 5d-loader-04
    -- Only underground-30, underground-50, and loader-1x1 variants are generated with 5d naming
    if data.raw.technology["turbo-transport-belt"] then
        table.insert(data.raw.technology["turbo-transport-belt"].effects, { type = "unlock-recipe", recipe = "turbo-loader" })
        table.insert(data.raw.technology["turbo-transport-belt"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-30-04" })
        table.insert(data.raw.technology["turbo-transport-belt"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-50-04" })
        table.insert(data.raw.technology["turbo-transport-belt"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-04" })
    end
else
    -- Without Space Age, use logistics-4 for all tier 4 items
    if data.raw.technology["logistics-4"] then
        table.insert(data.raw.technology["logistics-4"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-30-04" })
        table.insert(data.raw.technology["logistics-4"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-50-04" })
        table.insert(data.raw.technology["logistics-4"].effects, { type = "unlock-recipe", recipe = "5d-loader-04" })
        table.insert(data.raw.technology["logistics-4"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-04" })
    end
end

-- Logistics 5
if data.raw.technology["logistics-5"] then
    table.insert(data.raw.technology["logistics-5"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-30-05" })
    table.insert(data.raw.technology["logistics-5"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-50-05" })
    table.insert(data.raw.technology["logistics-5"].effects, { type = "unlock-recipe", recipe = "5d-loader-05" })
    table.insert(data.raw.technology["logistics-5"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-05" })
end

-- Logistics 6
if data.raw.technology["logistics-6"] then
    table.insert(data.raw.technology["logistics-6"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-30-06" })
    table.insert(data.raw.technology["logistics-6"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-50-06" })
    table.insert(data.raw.technology["logistics-6"].effects, { type = "unlock-recipe", recipe = "5d-loader-06" })
    table.insert(data.raw.technology["logistics-6"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-06" })
end

-- Logistics 7
if data.raw.technology["logistics-7"] then
    table.insert(data.raw.technology["logistics-7"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-30-07" })
    table.insert(data.raw.technology["logistics-7"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-50-07" })
    table.insert(data.raw.technology["logistics-7"].effects, { type = "unlock-recipe", recipe = "5d-loader-07" })
    table.insert(data.raw.technology["logistics-7"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-07" })
end

-- Logistics 8
if data.raw.technology["logistics-8"] then
    table.insert(data.raw.technology["logistics-8"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-30-08" })
    table.insert(data.raw.technology["logistics-8"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-50-08" })
    table.insert(data.raw.technology["logistics-8"].effects, { type = "unlock-recipe", recipe = "5d-loader-08" })
    table.insert(data.raw.technology["logistics-8"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-08" })
end

-- Logistics 9
if data.raw.technology["logistics-9"] then
    table.insert(data.raw.technology["logistics-9"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-30-09" })
    table.insert(data.raw.technology["logistics-9"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-50-09" })
    table.insert(data.raw.technology["logistics-9"].effects, { type = "unlock-recipe", recipe = "5d-loader-09" })
    table.insert(data.raw.technology["logistics-9"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-09" })
end

-- Logistics 10
if data.raw.technology["logistics-10"] then
    table.insert(data.raw.technology["logistics-10"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-30-10" })
    table.insert(data.raw.technology["logistics-10"].effects, { type = "unlock-recipe", recipe = "5d-underground-belt-50-10" })
    table.insert(data.raw.technology["logistics-10"].effects, { type = "unlock-recipe", recipe = "5d-loader-10" })
    table.insert(data.raw.technology["logistics-10"].effects, { type = "unlock-recipe", recipe = "5d-loader-1x1-10" })
end

-- Misc
data.raw["loader-1x1"]["loader-1x1"].hidden = false

data.raw["pipe-to-ground"]["pipe-to-ground"].fast_replaceable_group = "pipe-to-ground"
data.raw["pipe-to-ground"]["pipe-to-ground"].collision_mask = { layers = { item = true, object = true, water_tile = true } }

data.raw["pipe"]["pipe"].fast_replaceable_group = "pipe"
data.raw["pipe"]["pipe"].collision_mask = { layers = { item = true, object = true, water_tile = true } }
