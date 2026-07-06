-- Add recipe unlocks to an existing technology, guarding against the tech being
-- absent (e.g. an overhaul mod that renames or removes vanilla logistics techs),
-- which would otherwise crash data-stage. Mirrors the helper in
-- 5dim_resources/prototypes/tech.lua and dust-coal.lua.
local function add_unlocks(technology_name, recipe_names)
    local technology = data.raw.technology[technology_name]

    if technology == nil or technology.effects == nil then
        return
    end

    for _, recipe_name in pairs(recipe_names) do
        table.insert(technology.effects, { type = "unlock-recipe", recipe = recipe_name })
    end
end

-- Logistics
add_unlocks("logistics", {
    "5d-underground-belt-30-01",
    "5d-underground-belt-50-01",
    "loader",
    "5d-pipe-to-ground-mk1-30",
    "5d-pipe-to-ground-mk1-50",
    "5d-loader-1x1-01"
})

-- Logistics 2
add_unlocks("logistics-2", {
    "5d-fast-underground-belt-30-02",
    "5d-fast-underground-belt-50-02",
    "fast-loader",
    "5d-loader-1x1-02"
})

-- Logistics 3
add_unlocks("logistics-3", {
    "5d-express-underground-belt-30-03",
    "5d-express-underground-belt-50-03",
    "express-loader",
    "5d-loader-1x1-03"
})

-- Tier 4 handling
-- With Space Age: tier 4 is turbo-transport-belt (vanilla), only extended variants (30, 50, 1x1) are generated
-- Without Space Age: tier 4 uses logistics-4 with 5d naming for all items
if mods["space-age"] then
    -- Add extended tier 4 variants to turbo-transport-belt technology
    -- Note: With Space Age, tier 4 uses turbo-loader (vanilla), not 5d-loader-04
    -- Only underground-30, underground-50, and loader-1x1 variants are generated with 5d naming
    add_unlocks("turbo-transport-belt", {
        "turbo-loader",
        "5d-underground-belt-30-04",
        "5d-underground-belt-50-04",
        "5d-loader-1x1-04"
    })
end

-- Misc
data.raw["loader-1x1"]["loader-1x1"].hidden = false

data.raw["pipe-to-ground"]["pipe-to-ground"].fast_replaceable_group = "pipe-to-ground"
data.raw["pipe-to-ground"]["pipe-to-ground"].collision_mask = { layers = { item = true, object = true, water_tile = true } }

data.raw["pipe"]["pipe"].fast_replaceable_group = "pipe"
data.raw["pipe"]["pipe"].collision_mask = { layers = { item = true, object = true, water_tile = true } }
