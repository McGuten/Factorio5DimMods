-- Foundation, ice-platform and landfill restrict placement with an explicit
-- tile_condition whitelist of vanilla tile names (not just a collision mask),
-- so the renamed yeters-* copies of those hazard tiles are invisible to them.

local function appendExistingTiles(tileCondition, additions)
    local seen = {}

    for _, name in ipairs(tileCondition) do
        seen[name] = true
    end

    for _, name in ipairs(additions) do
        if data.raw.tile[name] and not seen[name] then
            tileCondition[#tileCondition + 1] = name
            seen[name] = true
        end
    end
end

local itemTileConditions = {
    -- lava and deep oil ocean: vanilla's own foundation groups
    ["foundation"] = {
        "yeters-lava",
        "yeters-lava-hot",
        "yeters-oil-ocean-shallow",
        "yeters-oil-ocean-deep",
        "yeters-gleba-deep-lake",
        "yeters-wetland-yumako",
        "yeters-wetland-jellynut",
        "yeters-wetland-blue-slime",
        "yeters-wetland-light-green-slime",
        "yeters-wetland-green-slime",
        "yeters-wetland-light-dead-skin",
        "yeters-wetland-dead-skin",
        "yeters-wetland-pink-tentacle",
        "yeters-wetland-red-tentacle"
    },
    ["ice-platform"] = {
        "yeters-ammoniacal-ocean",
        "yeters-ammoniacal-ocean-2"
    }
}

for itemName, additions in pairs(itemTileConditions) do
    local item = data.raw.item and data.raw.item[itemName]
    local tileCondition = item and item.place_as_tile and item.place_as_tile.tile_condition

    if tileCondition then
        appendExistingTiles(tileCondition, additions)
    end
end
