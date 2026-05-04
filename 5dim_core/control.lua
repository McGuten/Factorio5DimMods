local TierColors = require("__5dim_core__.lib.tier-colors")
local TierMarkerConfig = require("__5dim_core__.lib.tier-marker-config")

local TIER_OVERLAY_SCHEMA_VERSION = 1

local runtimeTierFamilies = TierMarkerConfig.runtime_families
local tierOverlayTypeFilters = TierMarkerConfig.runtime_type_filters
local tierOverlayRebuildTypes = TierMarkerConfig.runtime_rebuild_types
local rebuildEntityTierOverlays

local function matchTierFromPatterns(entityName, patterns)
    for _, pattern in ipairs(patterns) do
        local tier = string.match(entityName, pattern)
        if tier then
            return tonumber(tier)
        end
    end

    return nil
end

local function getConfiguredEntityTier(entity)
    for _, family in ipairs(runtimeTierFamilies) do
        if family.draw_runtime_tier and TierMarkerConfig.is_runtime_family_enabled(family, script.active_mods) then
            local baseTier = family.base_names and family.base_names[entity.name]
            if baseTier then
                return baseTier
            end

            local matchedTier = matchTierFromPatterns(entity.name, family.patterns or {})
            if matchedTier then
                return matchedTier
            end
        end
    end

    return nil
end

local function ensureTierOverlayStorage()
    storage.entity_tier_overlays = storage.entity_tier_overlays or {}
    storage.entity_tier_registrations = storage.entity_tier_registrations or {}
end

local function ensureTierOverlaySchemaVersion()
    if storage.tier_overlay_schema_version == TIER_OVERLAY_SCHEMA_VERSION then
        return
    end

    rebuildEntityTierOverlays()
    storage.tier_overlay_schema_version = TIER_OVERLAY_SCHEMA_VERSION
end

local function getTierOverlayLayout(entity)
    if entity.type == "artillery-wagon" then
        return {
            background_center = { -1.14, 0.56 },
            background_half_height = 0.15,
            background_half_width = 0.16,
            background_extra_width_per_digit = 0.08,
            shadow_target = { entity = entity, offset = { -1.12, 0.57 } },
            text_target = { entity = entity, offset = { -1.15, 0.54 } },
            text_scale = 1.45
        }
    end

    if entity.type == "container" or entity.type == "logistic-container" then
        return {
            background_center = { -0.29, 0.29 },
            background_half_height = 0.11,
            background_half_width = 0.10,
            background_extra_width_per_digit = 0.055,
            shadow_target = { entity = entity, offset = { -0.28, 0.30 } },
            text_target = { entity = entity, offset = { -0.30, 0.28 } },
            text_scale = 0.95
        }
    end

    if entity.type == "land-mine" or entity.type == "heat-pipe" then
        return {
            background_center = { -0.18, 0.18 },
            background_half_height = 0.09,
            background_half_width = 0.09,
            background_extra_width_per_digit = 0.05,
            shadow_target = { entity = entity, offset = { -0.17, 0.19 } },
            text_target = { entity = entity, offset = { -0.19, 0.17 } },
            text_scale = 0.82
        }
    end

    if entity.type == "ammo-turret" or entity.type == "electric-turret" then
        return {
            background_center = { -0.73, 0.74 },
            background_half_height = 0.12,
            background_half_width = 0.12,
            background_extra_width_per_digit = 0.06,
            shadow_target = { entity = entity, offset = { -0.72, 0.75 } },
            text_target = { entity = entity, offset = { -0.75, 0.73 } },
            text_scale = 1.12
        }
    end

    if entity.type == "car" then
        return {
            background_center = { -0.82, 0.62 },
            background_half_height = 0.13,
            background_half_width = 0.13,
            background_extra_width_per_digit = 0.065,
            shadow_target = { entity = entity, offset = { -0.81, 0.63 } },
            text_target = { entity = entity, offset = { -0.84, 0.61 } },
            text_scale = 1.18
        }
    end

    if entity.type == "spider-vehicle" then
        return {
            background_center = { -1.18, 1.03 },
            background_half_height = 0.14,
            background_half_width = 0.14,
            background_extra_width_per_digit = 0.07,
            shadow_target = { entity = entity, offset = { -1.17, 1.04 } },
            text_target = { entity = entity, offset = { -1.20, 1.01 } },
            text_scale = 1.28
        }
    end

    if entity.type == "cargo-landing-pad" then
        return {
            background_center = { -1.28, 1.12 },
            background_half_height = 0.16,
            background_half_width = 0.16,
            background_extra_width_per_digit = 0.08,
            shadow_target = { entity = entity, offset = { -1.27, 1.13 } },
            text_target = { entity = entity, offset = { -1.30, 1.10 } },
            text_scale = 1.42
        }
    end

    return {
        background_center = { -1.03, 1.02 },
        background_half_height = 0.15,
        background_half_width = 0.15,
        background_extra_width_per_digit = 0.08,
        shadow_target = { entity = entity, offset = { -1.02, 1.03 } },
        text_target = { entity = entity, offset = { -1.05, 1.00 } },
        text_scale = 1.45
    }
end

local function getEntityTierOverlayConfig(entity)
    if not entity or not entity.valid then
        return nil
    end

    local configuredTier = getConfiguredEntityTier(entity)
    if configuredTier then
        return {
            tier = configuredTier,
            layout = getTierOverlayLayout(entity)
        }
    end

    return nil
end

local function getRenderObject(objectId)
    if not objectId then
        return nil
    end

    local object = rendering.get_object_by_id(objectId)
    if object and object.valid then
        return object
    end

    return nil
end

local function destroyTierOverlay(overlay)
    if not overlay then
        return
    end

    local background = getRenderObject(overlay.background_id)
    if background then
        background.destroy()
    end

    local shadow = getRenderObject(overlay.shadow_id)
    if shadow then
        shadow.destroy()
    end

    local text = getRenderObject(overlay.text_id)
    if text then
        text.destroy()
    end
end

local function createEntityTierOverlay(entity)
    local overlayConfig = getEntityTierOverlayConfig(entity)
    if not overlayConfig or not entity.unit_number then
        return
    end

    ensureTierOverlayStorage()

    local existing = storage.entity_tier_overlays[entity.unit_number]
    if existing
        and getRenderObject(existing.background_id)
        and getRenderObject(existing.shadow_id)
        and getRenderObject(existing.text_id)
    then
        return
    end

    destroyTierOverlay(existing)

    local tier = overlayConfig.tier
    local layout = overlayConfig.layout
    local tierText = tostring(tier)
    local color = TierColors[tier] or TierColors[1]
    local visibilityForce = { entity.force.name }
    local backgroundHalfWidth = layout.background_half_width
        + math.max(#tierText - 1, 0) * layout.background_extra_width_per_digit

    local background = rendering.draw_rectangle({
        color = { r = 0, g = 0, b = 0, a = 0.45 },
        filled = true,
        surface = entity.surface,
        left_top = {
            entity = entity,
            offset = {
                layout.background_center[1] - backgroundHalfWidth,
                layout.background_center[2] - layout.background_half_height
            }
        },
        right_bottom = {
            entity = entity,
            offset = {
                layout.background_center[1] + backgroundHalfWidth,
                layout.background_center[2] + layout.background_half_height
            }
        },
        forces = visibilityForce
    })

    local shadow = rendering.draw_text({
        text = tierText,
        surface = entity.surface,
        target = layout.shadow_target,
        color = { r = 0, g = 0, b = 0, a = 0.85 },
        scale = layout.text_scale,
        alignment = "center",
        vertical_alignment = "middle",
        scale_with_zoom = true,
        forces = visibilityForce
    })

    local text = rendering.draw_text({
        text = tierText,
        surface = entity.surface,
        target = layout.text_target,
        color = color,
        scale = layout.text_scale,
        alignment = "center",
        vertical_alignment = "middle",
        scale_with_zoom = true,
        forces = visibilityForce
    })

    local registrationNumber = script.register_on_object_destroyed(entity)
    storage.entity_tier_overlays[entity.unit_number] = {
        background_id = background.id,
        shadow_id = shadow.id,
        text_id = text.id,
        registration_number = registrationNumber
    }
    storage.entity_tier_registrations[registrationNumber] = entity.unit_number
end

rebuildEntityTierOverlays = function()
    ensureTierOverlayStorage()

    for _, overlay in pairs(storage.entity_tier_overlays) do
        destroyTierOverlay(overlay)
    end

    storage.entity_tier_overlays = {}
    storage.entity_tier_registrations = {}

    for _, surface in pairs(game.surfaces) do
        for _, entityType in ipairs(tierOverlayRebuildTypes) do
            for _, entity in pairs(surface.find_entities_filtered({ type = entityType })) do
                createEntityTierOverlay(entity)
            end
        end
    end
end

local function onTierOverlayEntityBuilt(event)
    ensureTierOverlaySchemaVersion()
    createEntityTierOverlay(event.entity)
end

local function onTierOverlayEntityDestroyed(event)
    ensureTierOverlayStorage()

    local unitNumber = storage.entity_tier_registrations[event.registration_number]
    if not unitNumber then
        return
    end

    storage.entity_tier_registrations[event.registration_number] = nil
    storage.entity_tier_overlays[unitNumber] = nil
end

script.on_init(function()
    rebuildEntityTierOverlays()
    storage.tier_overlay_schema_version = TIER_OVERLAY_SCHEMA_VERSION
end)

script.on_configuration_changed(function()
    rebuildEntityTierOverlays()
    storage.tier_overlay_schema_version = TIER_OVERLAY_SCHEMA_VERSION
end)

script.on_event(defines.events.on_tick, function()
    ensureTierOverlaySchemaVersion()
    script.on_event(defines.events.on_tick, nil)
end)

script.on_event(defines.events.on_object_destroyed, onTierOverlayEntityDestroyed)

script.on_event(defines.events.on_built_entity, onTierOverlayEntityBuilt)
script.set_event_filter(defines.events.on_built_entity, tierOverlayTypeFilters)

script.on_event(defines.events.on_robot_built_entity, onTierOverlayEntityBuilt)
script.set_event_filter(defines.events.on_robot_built_entity, tierOverlayTypeFilters)

script.on_event(defines.events.script_raised_built, onTierOverlayEntityBuilt)
script.set_event_filter(defines.events.script_raised_built, tierOverlayTypeFilters)

script.on_event(
    defines.events.on_player_created,
    function(event)
        setStartItems(event)
    end
)
script.on_event(
    defines.events.on_cutscene_cancelled,
    function(event)
        setStartItems(event)
    end
)

function setStartItems(event)
    local atStart = {}
    atStart["items"] = {}
    atStart["tech"] = {}
    atStart["equip"] = {}
    local player = game.get_player(event.player_index)
    --Items
    if settings.startup["5d-item-start"].value == "Small amount" then
        atStart["items"] = {
            { "transport-belt",      200 },
            { "inserter",            50 },
            { "splitter",            20 },
            { "underground-belt",    20 },
            { "lab",                 1 },
            { "steam-engine",        20 },
            { "boiler",              10 },
            { "offshore-pump",       1 },
            { "burner-mining-drill", 5 },
            { "stone-furnace",       5 },
            { "coal",                50 }
        }
    elseif settings.startup["5d-item-start"].value == "Medium amount" then
        atStart["items"] = {
            { "transport-belt",        500 },
            { "inserter",              150 },
            { "splitter",              50 },
            { "underground-belt",      50 },
            { "small-electric-pole",   50 },
            { "electric-mining-drill", 20 },
            { "lab",                   1 },
            { "steam-engine",          20 },
            { "boiler",                10 },
            { "offshore-pump",         1 },
            { "stone-furnace",         10 },
            { "coal",                  100 },
            { "copper-plate",          100 },
            { "iron-plate",            100 },
            { "steel-plate",           50 }
        }
    elseif settings.startup["5d-item-start"].value == "Big amount" then
        atStart["items"] = {
            { "transport-belt",        1000 },
            { "inserter",              300 },
            { "splitter",              100 },
            { "underground-belt",      100 },
            { "medium-electric-pole",  100 },
            { "big-electric-pole",     50 },
            { "rail",                  1000 },
            { "locomotive",            5 },
            { "cargo-wagon",           10 },
            { "fluid-wagon",           10 },
            { "electric-mining-drill", 150 },
            { "lab",                   1 },
            { "steam-engine",          40 },
            { "boiler",                20 },
            { "offshore-pump",         2 },
            { "steel-furnace",         100 },
            { "coal",                  100 },
            { "copper-plate",          100 },
            { "iron-plate",            92 },
            { "steel-plate",           100 }
        }
    elseif settings.startup["5d-item-start"].value == "Huge amount" then
        atStart["items"] = {
            { "transport-belt",         600 },
            { "inserter",               300 },
            { "splitter",               100 },
            { "underground-belt",       100 },
            { "medium-electric-pole",   100 },
            { "big-electric-pole",      50 },
            { "rail",                   500 },
            { "locomotive",             5 },
            { "cargo-wagon",            10 },
            { "fluid-wagon",            10 },
            { "electric-mining-drill",  100 },
            { "roboport",               10 },
            { "passive-provider-chest", 50 },
            { "active-provider-chest",  50 },
            { "storage-chest",          50 },
            { "requester-chest",        50 },
            { "buffer-chest",           50 },
            { "construction-robot",     150 },
            { "logistic-robot",         150 },
            { "lab",                    1 },
            { "steam-engine",           40 },
            { "boiler",                 20 },
            { "offshore-pump",          2 },
            { "steel-furnace",          100 },
            { "coal",                   100 },
            { "copper-plate",           100 },
            { "iron-plate",             92 },
            { "steel-plate",            100 }
        }
    end
    for _, item in pairs(atStart["items"]) do
        player.insert({ name = item[1], count = item[2] })
    end

    atStart["items"] = {}
    --Tecnologies
    if settings.startup["5d-train-tech"].value then
        atStart["tech"] = {
            { "automation" },
            { "automation-2" },
            { "logistics" },
            { "logistics-2" },
            { "steel-processing" },
            { "engine" },
            { "railway" },
            { "automated-rail-transportation" },
            { "rail-signals" },
            { "fluid-wagon" }
        }
    end

    if atStart["tech"] ~= nil then
        for _, tech in pairs(atStart["tech"]) do
            if player.force.technologies[tech[1]] then
                player.force.technologies[tech[1]].researched = true
            end
        end
    end

    atStart["tech"] = {}
    if settings.startup["5d-robot-tech"].value then
        atStart["tech"] = {
            { "oil-processing" },
            { "plastics" },
            { "advanced-electronics" },
            { "sulfur-processing" },
            { "battery" },
            { "electronics" },
            { "engine" },
            { "electric-engine" },
            { "robotics" },
            { "logistic-robotics" },
            { "construction-robotics" },
            { "logistic-system" }
        }
    end

    if atStart["tech"] ~= nil then
        for _, tech in pairs(atStart["tech"]) do
            if player.force.technologies[tech[1]] then
                player.force.technologies[tech[1]].researched = true
            end
        end
    end

    --Equipment
    if settings.startup["5d-equip-start"].value == "Modular armor" then
        atStart["equip"] = {
            { "solar-panel-equipment",       15 },
            { "battery-equipment",           1 },
            { "personal-roboport-equipment", 2 }
        }
        atStart["items"] = {
            { "modular-armor",      1 },
            { "construction-robot", 20 },
        }
    elseif settings.startup["5d-equip-start"].value == "Power armor" then
        atStart["equip"] = {
            { "fission-reactor-equipment",    1 },
            { "battery-equipment",           3 },
            { "personal-roboport-equipment", 5 }
        }
        atStart["items"] = {
            { "power-armor",            1 },
            { "construction-robot",     50 },
            { "deconstruction-planner", 1 }
        }
    elseif settings.startup["5d-equip-start"].value == "Power armor MK2" then
        atStart["equip"] = {
            { "fission-reactor-equipment",    2 },
            { "battery-equipment",           4 },
            { "exoskeleton-equipment",       2 },
            { "personal-roboport-equipment", 11 }
        }
        atStart["items"] = {
            { "power-armor-mk2",    1 },
            { "construction-robot", 110 },
        }
    end

    for _, item in pairs(atStart["items"]) do
        player.insert({ name = item[1], count = item[2] })
    end

    for _, equip in pairs(atStart["equip"]) do
        player.insert({ name = equip[1], count = equip[2] })
    end
end
