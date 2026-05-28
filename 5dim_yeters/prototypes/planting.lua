local function appendExistingTiles(tileNames, additions)
    local seen = {}

    for _, name in ipairs(tileNames) do
        seen[name] = true
    end

    for _, name in ipairs(additions) do
        if data.raw.tile[name] and not seen[name] then
            tileNames[#tileNames + 1] = name
            seen[name] = true
        end
    end
end

local function appendExistingItems(itemNames, additions)
    local seen = {}

    for _, name in ipairs(itemNames) do
        seen[name] = true
    end

    for _, name in ipairs(additions) do
        if data.raw.item[name] and not seen[name] then
            itemNames[#itemNames + 1] = name
            seen[name] = true
        end
    end
end

local function appendBuildableTiles(rules, additions)
    for _, rule in ipairs(rules or {}) do
        if type(rule.required_tiles) == "table" and #rule.required_tiles > 0 then
            appendExistingTiles(rule.required_tiles, additions)
        end
    end
end

local function upsertSurfaceCondition(prototype, property, minValue, maxValue)
    prototype.surface_conditions = prototype.surface_conditions or {}

    for _, condition in ipairs(prototype.surface_conditions) do
        if condition.property == property then
            condition.min = minValue
            condition.max = maxValue
            return
        end
    end

    prototype.surface_conditions[#prototype.surface_conditions + 1] = {
        property = property,
        min = minValue,
        max = maxValue
    }
end

local function allowYetersAgriculture(prototype)
    if not prototype then
        return
    end

    for _, condition in ipairs(prototype.surface_conditions or {}) do
        if condition.property == "pressure" and condition.min and condition.min > 300 then
            condition.min = 300
        end
    end

    upsertSurfaceCondition(prototype, "5dim-agriculture", 1, 1)
end

local gleba = data.raw.planet and data.raw.planet.gleba

if gleba then
    gleba.surface_properties = gleba.surface_properties or {}
    gleba.surface_properties["5dim-agriculture"] = 1
end

local plantTileRestrictions = {
    ["yumako-tree"] = { "yeters-natural-yumako-soil" },
    ["jellystem"] = { "yeters-natural-jellynut-soil" }
}

for plantName, tileNames in pairs(plantTileRestrictions) do
    local plant = data.raw.plant and data.raw.plant[plantName]

    if plant then
        if plant.autoplace then
            plant.autoplace.tile_restriction = plant.autoplace.tile_restriction or {}
            appendExistingTiles(plant.autoplace.tile_restriction, tileNames)
        end

        appendBuildableTiles(plant.tile_buildability_rules, tileNames)
    end
end

local soilTileConditions = {
    ["artificial-yumako-soil"] = { "yeters-wetland-yumako" },
    ["artificial-jellynut-soil"] = { "yeters-wetland-jellynut" },
    ["overgrowth-yumako-soil"] = {
        "yeters-wetland-light-green-slime",
        "yeters-wetland-green-slime",
        "yeters-wetland-yumako",
        "yeters-lowland-olive-blubber",
        "yeters-lowland-olive-blubber-2",
        "yeters-lowland-olive-blubber-3",
        "yeters-lowland-brown-blubber",
        "yeters-lowland-pale-green"
    },
    ["overgrowth-jellynut-soil"] = {
        "yeters-wetland-pink-tentacle",
        "yeters-wetland-red-tentacle",
        "yeters-wetland-jellynut",
        "yeters-lowland-red-vein",
        "yeters-lowland-red-vein-2",
        "yeters-lowland-red-vein-3",
        "yeters-lowland-red-vein-4",
        "yeters-lowland-red-vein-dead",
        "yeters-lowland-red-infection",
        "yeters-lowland-cream-red"
    }
}

for itemName, tileNames in pairs(soilTileConditions) do
    local item = data.raw.item and data.raw.item[itemName]
    local tileCondition = item and item.place_as_tile and item.place_as_tile.tile_condition

    if tileCondition then
        appendExistingTiles(tileCondition, tileNames)
    end
end

local glebaSeedNames = { "yumako-seed", "jellynut-seed" }

for _, tower in pairs(data.raw["agricultural-tower"] or {}) do
    allowYetersAgriculture(tower)

    if tower.accepted_seeds then
        appendExistingItems(tower.accepted_seeds, glebaSeedNames)
    end
end

local soilRecipeNames = {
    "artificial-yumako-soil",
    "overgrowth-yumako-soil",
    "artificial-jellynut-soil",
    "overgrowth-jellynut-soil"
}

for _, recipeName in ipairs(soilRecipeNames) do
    allowYetersAgriculture(data.raw.recipe and data.raw.recipe[recipeName])
end