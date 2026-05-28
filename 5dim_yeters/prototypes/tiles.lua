local tileGroups = {
    {
        biome = "aquilo",
        sources = {
            "snow-flat",
            "snow-crests",
            "snow-lumpy",
            "snow-patchy",
            "ice-rough",
            "ice-smooth",
            "ammoniacal-ocean",
            "ammoniacal-ocean-2"
        },
        hazards = {
            ["ammoniacal-ocean"] = true,
            ["ammoniacal-ocean-2"] = true
        }
    },
    {
        biome = "vulcanus",
        sources = {
            "volcanic-soil-dark",
            "volcanic-soil-light",
            "volcanic-ash-soil",
            "volcanic-ash-flats",
            "volcanic-ash-light",
            "volcanic-ash-dark",
            "volcanic-cracks",
            "volcanic-cracks-warm",
            "volcanic-folds",
            "volcanic-folds-flat",
            "lava",
            "lava-hot",
            "volcanic-folds-warm",
            "volcanic-pumice-stones",
            "volcanic-cracks-hot",
            "volcanic-jagged-ground",
            "volcanic-smooth-stone",
            "volcanic-smooth-stone-warm",
            "volcanic-ash-cracks"
        },
        hazards = {
            ["lava"] = true,
            ["lava-hot"] = true
        }
    },
    {
        biome = "fulgora",
        sources = {
            "oil-ocean-shallow",
            "oil-ocean-deep",
            "fulgoran-rock",
            "fulgoran-dust",
            "fulgoran-sand",
            "fulgoran-dunes",
            "fulgoran-walls",
            "fulgoran-paving",
            "fulgoran-conduit",
            "fulgoran-machinery"
        },
        hazards = {
            ["oil-ocean-shallow"] = true,
            ["oil-ocean-deep"] = true
        }
    },
    {
        biome = "gleba",
        sources = {
            "natural-yumako-soil",
            "natural-jellynut-soil",
            "wetland-yumako",
            "wetland-jellynut",
            "wetland-blue-slime",
            "wetland-light-green-slime",
            "wetland-green-slime",
            "wetland-light-dead-skin",
            "wetland-dead-skin",
            "wetland-pink-tentacle",
            "wetland-red-tentacle",
            "gleba-deep-lake",
            "lowland-brown-blubber",
            "lowland-olive-blubber",
            "lowland-olive-blubber-2",
            "lowland-olive-blubber-3",
            "lowland-pale-green",
            "lowland-cream-cauliflower",
            "lowland-cream-cauliflower-2",
            "lowland-dead-skin",
            "lowland-dead-skin-2",
            "lowland-cream-red",
            "lowland-red-vein",
            "lowland-red-vein-2",
            "lowland-red-vein-3",
            "lowland-red-vein-4",
            "lowland-red-vein-dead",
            "lowland-red-infection",
            "midland-turquoise-bark",
            "midland-turquoise-bark-2",
            "midland-cracked-lichen",
            "midland-cracked-lichen-dull",
            "midland-cracked-lichen-dark",
            "midland-yellow-crust",
            "midland-yellow-crust-2",
            "midland-yellow-crust-3",
            "midland-yellow-crust-4",
            "highland-dark-rock",
            "highland-dark-rock-2",
            "highland-yellow-rock",
            "pit-rock"
        },
        hazards = {
            ["gleba-deep-lake"] = true
        }
    }
}

local function sanitize(name)
    return string.gsub(name, "[^%w]", "_")
end

local function sourceProbabilityExpression(source)
    local expression = source.autoplace and source.autoplace.probability_expression

    if type(expression) == "string" or type(expression) == "number" then
        return tostring(expression)
    end

    return "0"
end

local function yetersTileName(sourceName)
    return "yeters-" .. sourceName
end

local yetersAquiloTileExpressions = {
    ["snow-flat"] = "yeters_aquilo_snow_flat",
    ["snow-crests"] = "yeters_aquilo_snow_crests",
    ["snow-lumpy"] = "yeters_aquilo_snow_lumpy",
    ["snow-patchy"] = "yeters_aquilo_snow_patchy",
    ["ice-rough"] = "yeters_aquilo_ice_rough",
    ["ice-smooth"] = "yeters_aquilo_ice_smooth",
    ["ammoniacal-ocean"] = "yeters_aquilo_ammoniacal_ocean",
    ["ammoniacal-ocean-2"] = "yeters_aquilo_ammoniacal_ocean_2"
}

local yetersGlebaTileExpressionBoosts = {
    ["natural-yumako-soil"] = "yeters_gleba_yumako_soil_probability",
    ["natural-jellynut-soil"] = "yeters_gleba_jellynut_soil_probability",
    ["wetland-yumako"] = "yeters_gleba_yumako_wetland_probability",
    ["wetland-jellynut"] = "yeters_gleba_jellynut_wetland_probability"
}

local prototypes = {}
local baseSource = data.raw.tile["dirt-4"]

if baseSource then
    local baseTile = table.deepcopy(baseSource)
    baseTile.name = "yeters-base-ground"
    baseTile.order = "z[yeters]-yeters-base-ground"
    baseTile.map_color = { 98, 92, 82 }
    baseTile.autoplace = baseTile.autoplace or {}
    baseTile.autoplace.probability_expression = "yeters_base_ground_probability"
    prototypes[#prototypes + 1] = baseTile
end

for _, group in ipairs(tileGroups) do
    local mask = "yeters_" .. group.biome .. "_tile_mask"

    for _, sourceName in ipairs(group.sources) do
        local source = data.raw.tile[sourceName]

        if source then
            local tileName = yetersTileName(sourceName)
            local probabilityName = "yeters_tile_" .. sanitize(sourceName) .. "_probability"
            local sourceExpression = sourceProbabilityExpression(source)

            if group.biome == "aquilo" and yetersAquiloTileExpressions[sourceName] then
                sourceExpression = yetersAquiloTileExpressions[sourceName]
            end

            if group.biome == "gleba" and yetersGlebaTileExpressionBoosts[sourceName] then
                sourceExpression = "max(" .. sourceExpression .. ", " .. yetersGlebaTileExpressionBoosts[sourceName] .. ")"
            end

            local probabilityExpression = "if(" .. mask .. " > 0.5, " .. sourceExpression .. ", -1)"

            if group.hazards[sourceName] then
                if group.biome == "vulcanus" or group.biome == "fulgora" then
                    probabilityExpression = "if(" .. mask .. " > 0.5, " .. sourceExpression .. ", -1)"
                else
                    probabilityExpression = "if(" .. mask .. " > 0.5, (1 - yeters_hazard_safe_zone) * (" .. sourceExpression .. "), -1)"
                end
            end

            local tile = table.deepcopy(source)
            tile.name = tileName
            tile.order = "z[yeters]-" .. tileName
            tile.autoplace = tile.autoplace or {}
            tile.autoplace.probability_expression = probabilityName

            prototypes[#prototypes + 1] = {
                type = "noise-expression",
                name = probabilityName,
                expression = probabilityExpression
            }
            prototypes[#prototypes + 1] = tile
        end
    end
end

data:extend(prototypes)