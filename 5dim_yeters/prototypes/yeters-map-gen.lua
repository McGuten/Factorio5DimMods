local spaceAgePlanetMapGen = require("__space-age__.prototypes.planet.planet-map-gen")
local nauvisPlanetMapGen = require("__base__.prototypes.planet.planet-map-gen")

local yetersMapGen = {}
local generatedExpressions = {}
local generatedExpressionNames = {}
local yetersResourceControls = {
    { entity = "stone", control = "yeters_stone", expression = "yeters_stone" },
    { entity = "coal", control = "yeters_coal", expression = "yeters_coal" },
    { entity = "crude-oil", control = "yeters_crude_oil", expression = "yeters_crude_oil" },
    { entity = "uranium-ore", control = "yeters_uranium_ore", expression = "yeters_uranium_ore" },
    { entity = "calcite", control = "yeters_calcite", expression = "yeters_calcite" },
    { entity = "tungsten-ore", control = "yeters_tungsten_ore", expression = "yeters_tungsten_ore" },
    { entity = "scrap", control = "yeters_scrap", expression = "yeters_scrap" },
    { entity = "lithium-brine", control = "yeters_lithium_brine", expression = "yeters_lithium_brine" },
    { entity = "fluorine-vent", control = "yeters_fluorine_vent", expression = "yeters_fluorine_vent" },
    { entity = "sulfuric-acid-geyser", control = "yeters_sulfuric_acid_geyser", expression = "yeters_sulfuric_acid_geyser" }
}
local nauvisControlNames = {
    "iron-ore", "copper-ore", "stone", "coal", "uranium-ore", "crude-oil",
    "water", "trees", "enemy-base", "rocks", "starting_area_moisture"
}
local nauvisDecorativeNames = {
    "brown-hairy-grass", "green-hairy-grass", "brown-carpet-grass", "green-carpet-grass", "green-small-grass", "green-asterisk",
    "brown-asterisk-mini", "green-asterisk-mini", "brown-asterisk", "red-asterisk", "dark-mud-decal", "light-mud-decal",
    "cracked-mud-decal", "red-desert-decal", "sand-decal", "sand-dune-decal", "green-pita", "red-pita", "green-croton",
    "red-croton", "green-pita-mini", "brown-fluff", "brown-fluff-dry", "green-desert-bush", "red-desert-bush",
    "white-desert-bush", "garballo-mini-dry", "garballo", "green-bush-mini", "medium-rock", "small-rock", "tiny-rock",
    "medium-sand-rock", "small-sand-rock"
}
local nauvisEntityNames = {
    "iron-ore", "copper-ore", "stone", "coal", "crude-oil", "uranium-ore", "fish", "big-sand-rock", "huge-rock", "big-rock"
}
local nauvisVisualEntityNames = { "big-sand-rock", "huge-rock", "big-rock" }
local nauvisEnemyEntityNames = {
    "biter-spawner", "spitter-spawner"
}
local vulcanusDecorativeNames = {
    "v-brown-carpet-grass", "v-green-hairy-grass", "v-brown-hairy-grass", "v-red-pita",
    "vulcanus-rock-decal-large", "vulcanus-crack-decal-large", "vulcanus-crack-decal-huge-warm",
    "vulcanus-dune-decal", "vulcanus-sand-decal", "calcite-stain", "calcite-stain-small",
    "sulfur-stain", "sulfur-stain-small", "sulfuric-acid-puddle", "sulfuric-acid-puddle-small",
    "crater-small", "crater-large", "pumice-relief-decal",
    "small-volcanic-rock", "medium-volcanic-rock", "tiny-volcanic-rock", "tiny-rock-cluster",
    "small-sulfur-rock", "tiny-sulfur-rock", "sulfur-rock-cluster"
}
local vulcanusVisualEntityNames = {
    "huge-volcanic-rock", "big-volcanic-rock", "crater-cliff", "vulcanus-chimney", "vulcanus-chimney-faded",
    "vulcanus-chimney-cold", "vulcanus-chimney-short", "vulcanus-chimney-truncated", "ashland-lichen-tree", "ashland-lichen-tree-flaming"
}
local yetersVulcanusDecorativeProbabilityExpressions = {
    ["calcite-stain"] = "min(0.2, min(0.5, 3 * (yeters_calcite_region + 0.1)) - 0.8 - 0.6 * vulcanus_decorative_knockout)",
    ["calcite-stain-small"] = "min(0.2, min(0.5, 3 * (yeters_calcite_region + 0.2)) - 0.4 + 0.6 * vulcanus_decorative_knockout)",
    ["sulfur-stain"] = "min(0.2, min(0.5, 3 * (yeters_sulfuric_acid_geyser_region_patchy + 0.1)) - 0.8 - 0.6 * vulcanus_decorative_knockout)",
    ["sulfur-stain-small"] = "max(min(0.1, vulcanus_chimney_main), min(0.2, min(0.5, 3 * (yeters_sulfuric_acid_geyser_region_patchy + 0.2)) - 0.4 + 0.6 * vulcanus_decorative_knockout))",
    ["sulfuric-acid-puddle"] = "min(0.2, min(0.5, 3 * (yeters_sulfuric_acid_geyser_region_patchy + 0.1)) - 0.6 - 0.6 * vulcanus_decorative_knockout)",
    ["sulfuric-acid-puddle-small"] = "min(0.25, min(0.5, 3 * (yeters_sulfuric_acid_geyser_region_patchy + 0.15)) - 0.6 - 0.6 * vulcanus_decorative_knockout)",
    ["small-sulfur-rock"] = "min(0.4, min(0.5, 3 * (yeters_sulfuric_acid_geyser_region_patchy + 0.1)) - 0.7 + 0.6 * vulcanus_decorative_knockout)",
    ["tiny-sulfur-rock"] = "min(0.5, min(0.5, 3 * (yeters_sulfuric_acid_geyser_region_patchy + 0.2)) - 0.4 + 0.6 * vulcanus_decorative_knockout)",
    ["sulfur-rock-cluster"] = "min(0.1, min(0.5, 3 * yeters_sulfuric_acid_geyser_region_patchy) - 0.6 + 0.6 * vulcanus_decorative_knockout)"
}
local yetersVulcanusEntityProbabilityExpressions = {
    ["vulcanus-chimney"] = "-random_penalty_between(0, 1, 1) + 10 * min(0.2, clamp(vulcanus_chimney_main, 0.017, 0.05)) * (yeters_sulfuric_acid_geyser_region_patchy > 0)"
}
local fulgoraControlNames = { "scrap", "fulgora_islands" }
local fulgoraDecorativeNames = {
    "fulgoran-ruin-tiny", "fulgoran-gravewort", "urchin-cactus", "medium-fulgora-rock", "small-fulgora-rock", "tiny-fulgora-rock"
}
local fulgoraEntityNames = {
    "scrap", "fulgoran-ruin-vault", "fulgoran-ruin-attractor", "fulgoran-ruin-colossal", "fulgoran-ruin-huge",
    "fulgoran-ruin-big", "fulgoran-ruin-stonehenge", "fulgoran-ruin-medium", "fulgoran-ruin-small", "fulgurite", "big-fulgora-rock"
}
local fulgoraNonResourceEntityNames = {
    "fulgoran-ruin-vault", "fulgoran-ruin-attractor", "fulgoran-ruin-colossal", "fulgoran-ruin-huge",
    "fulgoran-ruin-big", "fulgoran-ruin-stonehenge", "fulgoran-ruin-medium", "fulgoran-ruin-small", "fulgurite", "big-fulgora-rock"
}
local glebaControlNames = { "gleba_stone", "gleba_plants", "gleba_enemy_base", "gleba_water" }
local glebaDecorativeNames = {
    "yellow-lettuce-lichen-1x1", "yellow-lettuce-lichen-3x3", "yellow-lettuce-lichen-cups-1x1",
    "green-lettuce-lichen-1x1", "green-lettuce-lichen-3x3", "green-lettuce-lichen-water-1x1",
    "honeycomb-fungus", "honeycomb-fungus-1x1", "split-gill-1x1", "split-gill-2x2",
    "veins", "veins-small", "mycelium", "coral-land", "black-sceptre", "pink-phalanges",
    "pink-lichen-decal", "red-lichen-decal", "green-cup", "brown-cup", "blood-grape", "brambles",
    "polycephalum-slime", "polycephalum-balloon", "fuchsia-pita", "wispy-lichen", "grey-cracked-mud-decal",
    "coral-stunted", "coral-stunted-grey", "yellow-coral", "solo-barnacle", "curly-roots-orange",
    "knobbly-roots", "knobbly-roots-orange", "white-carpet-grass", "green-carpet-grass", "green-hairy-grass"
}
local glebaVisualEntityNames = { "iron-stromatolite", "copper-stromatolite" }
local glebaPlantEntityNames = { "yumako-tree", "jellystem" }
local glebaCollectableTreeNames = {
    "cuttlepop", "slipstack", "funneltrunk", "hairyclubnub", "teflilly",
    "lickmaw", "stingfrond", "boompuff", "sunnycomb", "water-cane"
}
local glebaEnemyEntityNames = { "gleba-spawner", "gleba-spawner-small" }
local yetersGlebaVisualEntityProbabilityExpressions = {
    ["iron-stromatolite"] = "max(gleba_select(gleba_iron_stromatolite - clamp(gleba_decorative_knockout, 0, 1), 1.3, 2, 0.2, 0, 1), yeters_gleba_iron_stromatolite_probability)",
    ["copper-stromatolite"] = "max(gleba_select(gleba_copper_stromatolite - clamp(gleba_decorative_knockout, 0, 1), 1.3, 2, 0.2, 0, 1), yeters_gleba_copper_stromatolite_probability)"
}
local yetersGlebaPlantProbabilityExpressions = {
    ["yumako-tree"] = "max(min(0.2, 0.3 * (1 - gleba_plants_noise) * control:gleba_plants:size), yeters_gleba_yumako_tree_probability)",
    ["jellystem"] = "max(min(0.2, 0.3 * (1 - gleba_plants_noise) * control:gleba_plants:size), yeters_gleba_jellystem_probability)"
}
local aquiloControlNames = { "lithium_brine", "fluorine_vent", "aquilo_crude_oil" }
local aquiloDecorativeNames = {
    "floating-iceberg-large", "floating-iceberg-small"
}
local aquiloEntityNames = { "lithium-brine", "fluorine-vent", "lithium-iceberg-huge", "lithium-iceberg-big" }
local aquiloVisualEntityNames = { "lithium-iceberg-huge", "lithium-iceberg-big" }
local yetersAquiloDecorativeProbabilityExpressions = {
    ["floating-iceberg-large"] = "yeters_aquilo_icebergs * 0.015 * (yeters_aquilo_elevation < -1)",
    ["floating-iceberg-small"] = "yeters_aquilo_icebergs * 0.02 * (yeters_aquilo_elevation < -1)"
}
local yetersAquiloEntityProbabilityExpressions = {
    ["lithium-iceberg-huge"] = "(aquilo_high_frequency_peaks - 0.8) * 0.1 * (yeters_aquilo_elevation > -1)",
    ["lithium-iceberg-big"] = "(aquilo_high_frequency_peaks - 0.7) * 0.8 * (yeters_aquilo_elevation > -1)"
}
local yetersEntityNames = {
    "stone", "coal", "crude-oil", "uranium-ore",
    "calcite", "tungsten-ore", "scrap", "lithium-brine", "fluorine-vent", "sulfuric-acid-geyser"
}
local yetersResourceEntitySet = {}
for _, name in ipairs(yetersEntityNames) do
    yetersResourceEntitySet[name] = true
end
local yetersTileSourceNames = {
    "snow-flat", "snow-crests", "snow-lumpy", "snow-patchy", "ice-rough", "ice-smooth",
    "ammoniacal-ocean", "ammoniacal-ocean-2",
    "volcanic-soil-dark", "volcanic-soil-light", "volcanic-ash-soil", "volcanic-ash-flats", "volcanic-ash-light",
    "volcanic-ash-dark", "volcanic-cracks", "volcanic-cracks-warm", "volcanic-folds", "volcanic-folds-flat",
    "lava", "lava-hot", "volcanic-folds-warm", "volcanic-pumice-stones", "volcanic-cracks-hot",
    "volcanic-jagged-ground", "volcanic-smooth-stone", "volcanic-smooth-stone-warm", "volcanic-ash-cracks",
    "oil-ocean-shallow", "oil-ocean-deep", "fulgoran-rock", "fulgoran-dust", "fulgoran-sand", "fulgoran-dunes",
    "fulgoran-walls", "fulgoran-paving", "fulgoran-conduit", "fulgoran-machinery",
    "natural-yumako-soil", "natural-jellynut-soil", "wetland-yumako", "wetland-jellynut", "wetland-blue-slime",
    "wetland-light-green-slime", "wetland-green-slime", "wetland-light-dead-skin", "wetland-dead-skin",
    "wetland-pink-tentacle", "wetland-red-tentacle", "gleba-deep-lake", "lowland-brown-blubber",
    "lowland-olive-blubber", "lowland-olive-blubber-2", "lowland-olive-blubber-3", "lowland-pale-green",
    "lowland-cream-cauliflower", "lowland-cream-cauliflower-2", "lowland-dead-skin", "lowland-dead-skin-2",
    "lowland-cream-red", "lowland-red-vein", "lowland-red-vein-2", "lowland-red-vein-3", "lowland-red-vein-4",
    "lowland-red-vein-dead", "lowland-red-infection", "midland-turquoise-bark", "midland-turquoise-bark-2",
    "midland-cracked-lichen", "midland-cracked-lichen-dull", "midland-cracked-lichen-dark", "midland-yellow-crust",
    "midland-yellow-crust-2", "midland-yellow-crust-3", "midland-yellow-crust-4", "highland-dark-rock",
    "highland-dark-rock-2", "highland-yellow-rock", "pit-rock"
}
local yetersTileNames = { "yeters-base-ground" }
for _, name in ipairs(yetersTileSourceNames) do
    yetersTileNames[#yetersTileNames + 1] = "yeters-" .. name
end
local yetersTerrainControlNames = { "water", "trees", "rocks", "starting_area_moisture", "vulcanus_volcanism", "yeters_biomes" }

local yetersControlAliases = {
    ["control:vulcanus_coal"] = "control:yeters_coal",
    ["control:calcite"] = "control:yeters_calcite",
    ["control:tungsten_ore"] = "control:yeters_tungsten_ore",
    ["control:scrap"] = "control:yeters_scrap",
    ["control:lithium_brine"] = "control:yeters_lithium_brine",
    ["control:fluorine_vent"] = "control:yeters_fluorine_vent",
    ["control:aquilo_crude_oil"] = "control:yeters_crude_oil",
    ["control:sulfuric_acid_geyser"] = "control:yeters_sulfuric_acid_geyser",
    ["control:gleba_stone"] = "control:yeters_stone"
}

local function ensureAutoplaceSettings(settings, settingType)
    settings.autoplace_settings[settingType] = settings.autoplace_settings[settingType] or { settings = {} }
    settings.autoplace_settings[settingType].treat_missing_as_default = false
    settings.autoplace_settings[settingType].settings = settings.autoplace_settings[settingType].settings or {}

    return settings.autoplace_settings[settingType].settings
end

local function mergeNamedAutoplaceControls(target, source, names)
    target.autoplace_controls = target.autoplace_controls or {}

    for _, name in ipairs(names) do
        if source.autoplace_controls and source.autoplace_controls[name] then
            target.autoplace_controls[name] = target.autoplace_controls[name] or table.deepcopy(source.autoplace_controls[name])
        end
    end
end

local function mergeNamedAutoplaceSettings(target, source, settingType, names)
    local targetSettings = ensureAutoplaceSettings(target, settingType)
    local sourceGroup = source.autoplace_settings and source.autoplace_settings[settingType]

    if not sourceGroup or not sourceGroup.settings then
        return
    end

    for _, name in ipairs(names) do
        if sourceGroup.settings[name] then
            targetSettings[name] = targetSettings[name] or table.deepcopy(sourceGroup.settings[name])
        end
    end
end

-- Raw prototype types backing each autoplace setting type, used to skip names
-- that don't exist in this mod set (the borrowed planet name lists reference a
-- few decoratives/entities that aren't present, e.g. "fulgoran-gravewort").
local autoplaceRawTypes = {
    decorative = { "optimized-decorative" },
    entity = {
        "resource", "simple-entity", "simple-entity-with-owner", "tree", "plant",
        "unit-spawner", "turret", "fish", "cliff", "fire"
    }
}

local function prototypeExists(settingType, name)
    for _, rawType in ipairs(autoplaceRawTypes[settingType] or {}) do
        if data.raw[rawType] and data.raw[rawType][name] then
            return true
        end
    end
    return false
end

local function addAutoplaceSettings(settings, settingType, names)
    local targetSettings = ensureAutoplaceSettings(settings, settingType)

    for _, name in ipairs(names) do
        if prototypeExists(settingType, name) then
            targetSettings[name] = targetSettings[name] or {}
        end
    end
end

local function useProbabilityExpression(settings, settingType, names, expression)
    settings.property_expression_names = settings.property_expression_names or {}

    for _, name in ipairs(names) do
        settings.property_expression_names[settingType .. ":" .. name .. ":probability"] = expression
    end
end

local function sanitize(name)
    return string.gsub(name, "[^%w]", "_")
end

local function replaceYetersControls(expression)
    for source, replacement in pairs(yetersControlAliases) do
        expression = string.gsub(expression, source, replacement)
    end

    return expression
end

local function rawAutoplaceProbability(settingType, name)
    local rawTypes = {
        decorative = { "optimized-decorative" },
        entity = { "resource", "simple-entity", "tree", "unit-spawner", "turret", "plant", "fish" }
    }

    for _, rawType in ipairs(rawTypes[settingType] or {}) do
        local prototype = data.raw[rawType] and data.raw[rawType][name]
        local expression = prototype and prototype.autoplace and prototype.autoplace.probability_expression

        if type(expression) == "string" or type(expression) == "number" then
            return tostring(expression), prototype.autoplace.local_expressions
        end
    end

    return "0"
end

local function replaceLocalExpressionControls(localExpressions)
    if not localExpressions then
        return nil
    end

    local replaced = {}

    for name, expression in pairs(localExpressions) do
        if type(expression) == "string" or type(expression) == "number" then
            replaced[name] = replaceYetersControls(tostring(expression))
        else
            replaced[name] = table.deepcopy(expression)
        end
    end

    return replaced
end

local function sourceProbabilityExpression(sourceSettings, settingType, name)
    local key = settingType .. ":" .. name .. ":probability"
    local expression = sourceSettings.property_expression_names and sourceSettings.property_expression_names[key]

    if type(expression) == "string" or type(expression) == "number" then
        return replaceYetersControls(tostring(expression))
    end

    local rawExpression, localExpressions = rawAutoplaceProbability(settingType, name)
    return replaceYetersControls(rawExpression), replaceLocalExpressionControls(localExpressions)
end

local function addGeneratedExpression(name, expression, localExpressions)
    if generatedExpressionNames[name] then
        return
    end

    generatedExpressionNames[name] = true
    local generatedExpression = {
        type = "noise-expression",
        name = name,
        expression = expression
    }

    if localExpressions then
        generatedExpression.local_expressions = localExpressions
    end

    generatedExpressions[#generatedExpressions + 1] = generatedExpression
end

local function useSourceProbabilityExpression(settings, sourceSettings, settingType, names, mask, overrides)
    settings.property_expression_names = settings.property_expression_names or {}

    for _, name in ipairs(names) do
        local expressionName = "yeters_" .. settingType .. "_" .. sanitize(name) .. "_probability"
        local sourceExpression, localExpressions = sourceProbabilityExpression(sourceSettings, settingType, name)

        if overrides and overrides[name] then
            sourceExpression = overrides[name]
            localExpressions = nil
        end

        local expression = "if(" .. mask .. " > 0.5, " .. sourceExpression .. ", -1)"

        addGeneratedExpression(expressionName, expression, localExpressions)
        settings.property_expression_names[settingType .. ":" .. name .. ":probability"] = expressionName
    end
end

local function tuneControl(settings, name, frequency, size, richness)
    settings.autoplace_controls[name] = settings.autoplace_controls[name] or {}
    settings.autoplace_controls[name].frequency = frequency
    settings.autoplace_controls[name].size = size
    settings.autoplace_controls[name].richness = richness
end

local function boostYetersControls(settings)
    for _, resource in ipairs(yetersResourceControls) do
        tuneControl(settings, resource.control, 1.0, 1.0, 2.0)
    end

    for _, name in ipairs(yetersTerrainControlNames) do
        tuneControl(settings, name, 0.2, 1.5, 1)
    end

    tuneControl(settings, "water", 0.08, 0.35, 1)
    tuneControl(settings, "trees", 0.12, 0.75, 1)
    tuneControl(settings, "rocks", 0.08, 0.35, 1)
    tuneControl(settings, "enemy-base", 0.4, 1.1, 1)
    tuneControl(settings, "gleba_enemy_base", 0.45, 1.1, 1)
    tuneControl(settings, "gleba_plants", 0.8, 1.05, 1)
    tuneControl(settings, "gleba_water", 0.75, 1.0, 1)
    tuneControl(settings, "fulgora_islands", 1.0, 1.12, 1)
end

local function disableYetersCliffs(settings)
    settings.cliff_settings = nil
    settings.autoplace_controls.fulgora_cliff = nil
    settings.autoplace_controls.gleba_cliff = nil
    settings.property_expression_names.cliffiness = nil
    settings.property_expression_names.cliff_elevation = nil
end

local function useYetersSurfaceProperties(settings)
    settings.property_expression_names = settings.property_expression_names or {}
    settings.property_expression_names.elevation = "yeters_elevation"
end

local function useYetersResourceControls(settings)
    local entitySettings = ensureAutoplaceSettings(settings, "entity")

    for name in pairs(entitySettings) do
        entitySettings[name] = nil
    end

    for _, name in ipairs(yetersEntityNames) do
        entitySettings[name] = {}
    end

    for _, resource in ipairs(yetersResourceControls) do
        settings.autoplace_controls[resource.control] = settings.autoplace_controls[resource.control] or {}
        settings.property_expression_names["entity:" .. resource.entity .. ":probability"] = resource.expression .. "_probability"
        settings.property_expression_names["entity:" .. resource.entity .. ":richness"] = resource.expression .. "_richness"
    end

    settings.autoplace_controls["iron-ore"] = nil
    settings.autoplace_controls["copper-ore"] = nil
    settings.autoplace_controls["stone"] = nil
    settings.autoplace_controls["coal"] = nil
    settings.autoplace_controls["crude-oil"] = nil
    settings.autoplace_controls["uranium-ore"] = nil
    settings.autoplace_controls["calcite"] = nil
    settings.autoplace_controls["tungsten_ore"] = nil
    settings.autoplace_controls["scrap"] = nil
    settings.autoplace_controls["lithium_brine"] = nil
    settings.autoplace_controls["fluorine_vent"] = nil
    settings.autoplace_controls["sulfuric_acid_geyser"] = nil
    settings.autoplace_controls["vulcanus_coal"] = nil
    settings.autoplace_controls["gleba_stone"] = nil
    settings.autoplace_controls["aquilo_crude_oil"] = nil
end

local function useYetersBiomeZones(settings, sourceSettings)
    settings.autoplace_controls.yeters_biomes = settings.autoplace_controls.yeters_biomes or {}
    local tileSettings = ensureAutoplaceSettings(settings, "tile")
    local decorativeSettings = ensureAutoplaceSettings(settings, "decorative")

    for name in pairs(tileSettings) do
        tileSettings[name] = nil
    end

    for name in pairs(decorativeSettings) do
        decorativeSettings[name] = nil
    end

    for _, name in ipairs(yetersTileNames) do
        tileSettings[name] = {}
    end

    addAutoplaceSettings(settings, "decorative", aquiloDecorativeNames)
    addAutoplaceSettings(settings, "decorative", vulcanusDecorativeNames)
    addAutoplaceSettings(settings, "decorative", fulgoraDecorativeNames)
    addAutoplaceSettings(settings, "decorative", glebaDecorativeNames)

    useSourceProbabilityExpression(settings, sourceSettings.aquilo, "decorative", aquiloDecorativeNames, "yeters_aquilo_zone", yetersAquiloDecorativeProbabilityExpressions)
    useSourceProbabilityExpression(settings, sourceSettings.vulcanus, "decorative", vulcanusDecorativeNames, "yeters_vulcanus_zone", yetersVulcanusDecorativeProbabilityExpressions)
    useSourceProbabilityExpression(settings, sourceSettings.fulgora, "decorative", fulgoraDecorativeNames, "yeters_fulgora_zone")
    useSourceProbabilityExpression(settings, sourceSettings.gleba, "decorative", glebaDecorativeNames, "yeters_gleba_zone")
end

local function useYetersVisualEntities(settings, sourceSettings)
    addAutoplaceSettings(settings, "entity", nauvisEnemyEntityNames)
    addAutoplaceSettings(settings, "entity", aquiloVisualEntityNames)
    addAutoplaceSettings(settings, "entity", vulcanusVisualEntityNames)
    addAutoplaceSettings(settings, "entity", fulgoraNonResourceEntityNames)
    addAutoplaceSettings(settings, "entity", glebaVisualEntityNames)
    addAutoplaceSettings(settings, "entity", glebaPlantEntityNames)
    addAutoplaceSettings(settings, "entity", glebaCollectableTreeNames)
    addAutoplaceSettings(settings, "entity", glebaEnemyEntityNames)

    useSourceProbabilityExpression(settings, sourceSettings.nauvis, "entity", nauvisEnemyEntityNames, "yeters_nauvis_enemy_zone")
    useSourceProbabilityExpression(settings, sourceSettings.aquilo, "entity", aquiloVisualEntityNames, "yeters_aquilo_zone", yetersAquiloEntityProbabilityExpressions)
    useSourceProbabilityExpression(settings, sourceSettings.vulcanus, "entity", vulcanusVisualEntityNames, "yeters_vulcanus_zone", yetersVulcanusEntityProbabilityExpressions)
    useSourceProbabilityExpression(settings, sourceSettings.fulgora, "entity", fulgoraNonResourceEntityNames, "yeters_fulgora_zone")
    useSourceProbabilityExpression(settings, sourceSettings.gleba, "entity", glebaVisualEntityNames, "yeters_gleba_zone", yetersGlebaVisualEntityProbabilityExpressions)
    useSourceProbabilityExpression(settings, sourceSettings.gleba, "entity", glebaPlantEntityNames, "yeters_gleba_zone", yetersGlebaPlantProbabilityExpressions)
    useSourceProbabilityExpression(settings, sourceSettings.gleba, "entity", glebaCollectableTreeNames, "yeters_gleba_zone")
    useSourceProbabilityExpression(settings, sourceSettings.gleba, "entity", glebaEnemyEntityNames, "yeters_gleba_zone")

    settings.property_expression_names.enemy_base_radius = "yeters_enemy_base_radius"
    settings.property_expression_names.enemy_base_frequency = "yeters_enemy_base_frequency"
    settings.autoplace_controls["enemy-base"] = settings.autoplace_controls["enemy-base"] or {}
    settings.autoplace_controls.gleba_enemy_base = settings.autoplace_controls.gleba_enemy_base or {}
end

local function useYetersDemolisherTerritories(settings)
    settings.territory_settings = {
        units = { "small-demolisher", "medium-demolisher", "big-demolisher" },
        territory_index_expression = "yeters_demolisher_territory_expression",
        territory_variation_expression = "yeters_demolisher_variation_expression",
        minimum_territory_size = 8
    }
end

function yetersMapGen.yeters()
    local settings = table.deepcopy(spaceAgePlanetMapGen.vulcanus())
    local nauvisSettings = nauvisPlanetMapGen.nauvis()
    local fulgoraSettings = spaceAgePlanetMapGen.fulgora()
    local glebaSettings = spaceAgePlanetMapGen.gleba()
    local aquiloSettings = spaceAgePlanetMapGen.aquilo()

    mergeNamedAutoplaceSettings(settings, nauvisSettings, "decorative", nauvisDecorativeNames)
    mergeNamedAutoplaceSettings(settings, nauvisSettings, "entity", nauvisEntityNames)
    mergeNamedAutoplaceControls(settings, nauvisSettings, nauvisControlNames)

    mergeNamedAutoplaceSettings(settings, fulgoraSettings, "decorative", fulgoraDecorativeNames)
    mergeNamedAutoplaceSettings(settings, fulgoraSettings, "entity", fulgoraEntityNames)
    mergeNamedAutoplaceControls(settings, fulgoraSettings, fulgoraControlNames)

    mergeNamedAutoplaceSettings(settings, glebaSettings, "decorative", glebaDecorativeNames)
    mergeNamedAutoplaceSettings(settings, glebaSettings, "entity", glebaVisualEntityNames)
    mergeNamedAutoplaceSettings(settings, glebaSettings, "entity", glebaPlantEntityNames)
    mergeNamedAutoplaceSettings(settings, glebaSettings, "entity", glebaCollectableTreeNames)
    mergeNamedAutoplaceControls(settings, glebaSettings, glebaControlNames)

    mergeNamedAutoplaceSettings(settings, aquiloSettings, "decorative", aquiloDecorativeNames)
    mergeNamedAutoplaceSettings(settings, aquiloSettings, "entity", aquiloEntityNames)
    mergeNamedAutoplaceControls(settings, aquiloSettings, aquiloControlNames)

    disableYetersCliffs(settings)
    useYetersSurfaceProperties(settings)
    useYetersResourceControls(settings)
    useYetersBiomeZones(settings, {
        aquilo = aquiloSettings,
        vulcanus = spaceAgePlanetMapGen.vulcanus(),
        fulgora = fulgoraSettings,
        gleba = glebaSettings
    })
    useYetersVisualEntities(settings, {
        nauvis = nauvisSettings,
        aquilo = aquiloSettings,
        vulcanus = spaceAgePlanetMapGen.vulcanus(),
        fulgora = fulgoraSettings,
        gleba = glebaSettings
    })
    useYetersDemolisherTerritories(settings)
    boostYetersControls(settings)

    if #generatedExpressions > 0 then
        data:extend(generatedExpressions)
    end

    return settings
end

return yetersMapGen