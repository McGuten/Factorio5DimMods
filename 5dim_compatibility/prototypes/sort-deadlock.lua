-- Loaders
data.raw.item["transport-belt-loader"].subgroup = "transport-dead-loader"
data.raw.item["transport-belt-loader"].order = "a"
data.raw.item["fast-transport-belt-loader"].subgroup = "transport-dead-loader"
data.raw.item["fast-transport-belt-loader"].order = "b"
data.raw.item["express-transport-belt-loader"].subgroup = "transport-dead-loader"
data.raw.item["express-transport-belt-loader"].order = "c"

data.raw.recipe["transport-belt-loader"].subgroup = "transport-dead-loader"
data.raw.recipe["transport-belt-loader"].order = "a"
data.raw.recipe["fast-transport-belt-loader"].subgroup = "transport-dead-loader"
data.raw.recipe["fast-transport-belt-loader"].order = "b"
data.raw.recipe["express-transport-belt-loader"].subgroup = "transport-dead-loader"
data.raw.recipe["express-transport-belt-loader"].order = "c"

-- Beltbox
data.raw.item["transport-belt-beltbox"].subgroup = "transport-dead-beltbox"
data.raw.item["transport-belt-beltbox"].order = "a"
data.raw.item["fast-transport-belt-beltbox"].subgroup = "transport-dead-beltbox"
data.raw.item["fast-transport-belt-beltbox"].order = "b"
data.raw.item["express-transport-belt-beltbox"].subgroup = "transport-dead-beltbox"
data.raw.item["express-transport-belt-beltbox"].order = "c"

data.raw.recipe["transport-belt-beltbox"].subgroup = "transport-dead-beltbox"
data.raw.recipe["transport-belt-beltbox"].order = "a"
data.raw.recipe["fast-transport-belt-beltbox"].subgroup = "transport-dead-beltbox"
data.raw.recipe["fast-transport-belt-beltbox"].order = "b"
data.raw.recipe["express-transport-belt-beltbox"].subgroup = "transport-dead-beltbox"
data.raw.recipe["express-transport-belt-beltbox"].order = "c"

--Space age
if mods["space-age"] then
    data.raw.item["turbo-transport-belt-loader"].subgroup = "transport-turbo-belt"
    data.raw.item["turbo-transport-belt-loader"].order = "d"
    data.raw.recipe["turbo-transport-belt-loader"].subgroup = "transport-turbo-belt"
    data.raw.recipe["turbo-transport-belt-loader"].order = "d"

    data.raw.item["turbo-transport-belt-beltbox"].subgroup = "transport-turbo-belt"
    data.raw.item["turbo-transport-belt-beltbox"].order = "d"
    data.raw.recipe["turbo-transport-belt-beltbox"].subgroup = "transport-turbo-belt"
    data.raw.recipe["turbo-transport-belt-beltbox"].order = "d"
end