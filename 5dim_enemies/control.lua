-- =============================================================================
-- 5dim_enemies - Control Script (Runtime)
-- =============================================================================
-- This file provides runtime functionality, remote interfaces, and info GUI.
-- Configuration is loaded from shared-config.lua (SINGLE SOURCE OF TRUTH)
-- =============================================================================

-- Load shared configuration (same file used by data stage)
local SharedConfig = require("shared-config")
local Tiers = require("prototypes.config.tiers")

-- Check if 5dim_dev is installed (for dev tools)
local DEV_MODE = script.active_mods["5dim_dev"] ~= nil

-- =============================================================================
-- CONSTANTS
-- =============================================================================
local GUI_NAME = "5dim_enemies_info_gui"
local BUTTON_NAME = "5dim_enemies_toggle_button"
local SPITTER_EVOLUTION_OFFSET = 0.02

-- Category display names
local CategoryDisplay = {
    biter = { name = "Biter", color = "red" },
    spitter = { name = "Spitter", color = "green" },
    worm = { name = "Worm", color = "yellow" }
}

-- =============================================================================
-- REGISTER REMOTE INTERFACE
-- =============================================================================
-- Allows other mods (like 5dim_dev) to access configuration data
-- at runtime without duplicating configuration.
--
-- Usage from other mods:
--   local config = remote.call("5dim_enemies", "get_config")
--   local types = remote.call("5dim_enemies", "get_type_order")
-- =============================================================================

remote.add_interface("5dim_enemies", {
    -- Get full configuration
    get_config = function()
        return SharedConfig.getFullConfig()
    end,
    
    -- Get type multipliers
    get_type_multipliers = function()
        return SharedConfig.TypeMultipliers
    end,
    
    -- Get type display info
    get_type_display = function()
        return SharedConfig.TypeDisplay
    end,
    
    -- Get type order list
    get_type_order = function()
        return SharedConfig.TypeOrder
    end,
    
    -- Get categories per type
    get_type_categories = function()
        return SharedConfig.TypeCategories
    end,
    
    -- Get boss configuration
    get_boss_config = function()
        return SharedConfig.BossConfig
    end,
    
    -- Get base stats
    get_base_stats = function()
        return SharedConfig.BaseStats
    end,
    
    -- Get specific type info
    get_type_info = function(type_name)
        return {
            multipliers = SharedConfig.TypeMultipliers[type_name],
            display = SharedConfig.TypeDisplay[type_name],
            categories = SharedConfig.TypeCategories[type_name]
        }
    end
})

-- =============================================================================
-- SPAWN PROBABILITY CALCULATIONS
-- =============================================================================

local TIER_COUNT = 10

-- Base evolution thresholds for each tier
local BASE_EVOLUTION = {
    [1] = 0.00, [2] = 0.08, [3] = 0.16, [4] = 0.24, [5] = 0.32,
    [6] = 0.40, [7] = 0.48, [8] = 0.56, [9] = 0.64, [10] = 0.72
}

-- Calculate evolution thresholds for a type/category
local function calculateEvolution(typeName, category)
    local TypeMultipliers = SharedConfig.TypeMultipliers or {}
    local mult = TypeMultipliers[typeName] or {evolution_min = 0, evolution_max = 1}
    local evoMin = mult.evolution_min or 0
    local evoMax = mult.evolution_max or 1
    local evoRange = evoMax - evoMin
    
    -- Apply spitter offset
    local offset = (category == "spitter") and SPITTER_EVOLUTION_OFFSET or 0
    
    local evolution = {}
    for tier = 1, TIER_COUNT do
        local baseEvo = BASE_EVOLUTION[tier]
        local scaledEvo = evoMin + (baseEvo * evoRange / 0.72)
        evolution[tier] = math.min(1.0, scaledEvo + offset)
    end
    -- Boss at 80% of type's evolution range
    evolution[11] = math.min(1.0, evoMin + (evoRange * 0.8) + offset)
    
    return evolution
end

-- Generate spawn curve for a tier
local function getSpawnCurve(typeName, tier, category)
    local evolution = calculateEvolution(typeName, category)
    local tierEvo = evolution[tier]
    
    if tier == 11 then
        -- Boss: only at very high evolution
        return {{0.80, 0.0}, {0.85, 0.05}, {1.0, 0.1}}
    end
    
    local curve = {}
    local peakEvo = tierEvo + 0.08
    local endEvo = tierEvo + 0.24
    
    -- T10 stays relevant
    if tier == TIER_COUNT then
        return {{tierEvo, 0.0}, {math.min(0.98, tierEvo + 0.02), 0.3}, {1.0, 0.4}}
    end
    
    -- T9 fades slightly
    if tier == 9 then
        return {{tierEvo, 0.0}, {tierEvo + 0.05, 0.3}, {1.0, 0.2}}
    end
    
    -- T8 fades at max
    if tier == 8 then
        return {{tierEvo, 0.0}, {tierEvo + 0.10, 0.3}, {1.0, 0.1}}
    end
    
    -- Regular tiers fade out
    table.insert(curve, {tierEvo, 0.0})
    table.insert(curve, {math.min(1.0, peakEvo), 0.3})
    table.insert(curve, {math.min(1.0, endEvo), 0.0})
    
    return curve
end

-- Calculate spawn probability at current evolution
local function calculateSpawnProbability(currentEvolution, curve)
    if #curve < 1 then return 0 end
    if currentEvolution < curve[1][1] then return 0 end
    if #curve == 1 then return curve[1][2] end
    
    for i = 1, #curve - 1 do
        local p1, p2 = curve[i], curve[i + 1]
        if currentEvolution >= p1[1] and currentEvolution <= p2[1] then
            if p2[1] == p1[1] then return p1[2] end
            local t = (currentEvolution - p1[1]) / (p2[1] - p1[1])
            return p1[2] + t * (p2[2] - p1[2])
        end
    end
    
    return curve[#curve][2]
end

-- =============================================================================
-- PLAYER SETTINGS STORAGE
-- =============================================================================
local function getPlayerSettings(player_index)
    if not storage.player_settings then
        storage.player_settings = {}
    end
    if not storage.player_settings[player_index] then
        storage.player_settings[player_index] = {
            selected_type = "normal",
            selected_category = "biter",
            show_all_tiers = false
        }
    end
    return storage.player_settings[player_index]
end

local function safe_read(getter)
    local ok, value = pcall(getter)
    if ok then
        return value
    end
    return nil
end

local function get_enemy_prototype_name(typeName, category, tier)
    if category == "worm" then
        if tier == 11 then
            return string.format("5d-%s-worm-boss", typeName)
        end
        return string.format("5d-%s-worm-t%d", typeName, tier)
    end

    if tier == 11 then
        return string.format("5d-%s-%s-boss", typeName, category)
    end

    return string.format("5d-%s-%s-t%d", typeName, category, tier)
end

local function is_boss_enabled()
    local setting = settings.startup["5d-boss"]
    return setting == nil or setting.value ~= false
end

local function to_array(value)
    if type(value) ~= "table" then
        return {}
    end

    if value[1] ~= nil then
        return value
    end

    return {value}
end

local sum_trigger_item_damage
local sum_delivery_damage
local get_referenced_prototype_damage

local function sum_trigger_effect_damage(effectItems)
    local total = 0
    local found = false

    for _, effect in pairs(to_array(effectItems)) do
        local effectType = safe_read(function() return effect.type end)
        if effectType == "damage" then
            local damage = safe_read(function() return effect.damage end)
            local amount = damage and safe_read(function() return damage.amount end)
            if type(amount) == "number" then
                total = total + amount
                found = true
            end
        end
    end

    if found then
        return total
    end

    return nil
end

get_referenced_prototype_damage = function(prototypeName)
    local prototype = safe_read(function() return prototypes.entity[prototypeName] end)
    if not prototype then
        return nil
    end

    local total = 0
    local found = false

    for _, resultName in ipairs({"attack_result", "final_attack_result"}) do
        local result = safe_read(function() return prototype[resultName] end)
        local damage = sum_trigger_item_damage(result, nil)
        if type(damage) == "number" then
            total = total + damage
            found = true
        end
    end

    if found then
        return total
    end

    return nil
end

sum_delivery_damage = function(deliveries, attackParameters)
    local total = 0
    local found = false

    for _, delivery in pairs(to_array(deliveries)) do
        local damage = sum_trigger_effect_damage(safe_read(function() return delivery.target_effects end))
        if type(damage) == "number" then
            total = total + damage
            found = true
        end

        local deliveryType = safe_read(function() return delivery.type end)
        local referencedName
        if deliveryType == "projectile" then
            referencedName = safe_read(function() return delivery.projectile end)
        elseif deliveryType == "stream" then
            referencedName = safe_read(function() return delivery.stream end)
        elseif deliveryType == "beam" then
            referencedName = safe_read(function() return delivery.beam end)
        end

        if referencedName then
            local referencedDamage = get_referenced_prototype_damage(referencedName)
            if type(referencedDamage) == "number" then
                local modifier = attackParameters and safe_read(function() return attackParameters.damage_modifier end) or 1
                if type(modifier) ~= "number" or modifier <= 0 then
                    modifier = 1
                end
                total = total + (referencedDamage * modifier)
                found = true
            end
        end
    end

    if found then
        return total
    end

    return nil
end

sum_trigger_item_damage = function(triggerItems, attackParameters)
    local total = 0
    local found = false

    for _, triggerItem in pairs(to_array(triggerItems)) do
        local damage = sum_delivery_damage(safe_read(function() return triggerItem.action_delivery end), attackParameters)
        if type(damage) == "number" then
            total = total + damage
            found = true
        end
    end

    if found then
        return total
    end

    return nil
end

local function get_runtime_tier_stats(typeName, category, tier)
    local prototypeName = get_enemy_prototype_name(typeName, category, tier)
    local prototype = safe_read(function() return prototypes.entity[prototypeName] end)
    local fallbackStats

    if prototype or not (tier == 11 and not is_boss_enabled()) then
        fallbackStats = safe_read(function() return Tiers.getStats(category, typeName, tier) end)
    end

    if not prototype and not fallbackStats then
        return {
            prototype_name = prototypeName,
            prototype_loaded = false,
            health = nil,
            damage = nil,
            speed = nil,
            healing = nil,
            range = nil
        }
    end

    local attackParameters = prototype and safe_read(function() return prototype.attack_parameters end) or nil
    local ammoType = attackParameters and safe_read(function() return attackParameters.ammo_type end) or nil
    local ammoActions = ammoType and safe_read(function() return ammoType.action end) or nil

    local health = prototype and safe_read(function() return prototype.get_max_health() end) or nil
    if type(health) ~= "number" then
        health = prototype and safe_read(function() return prototype.max_health end) or nil
    end
    if type(health) ~= "number" and fallbackStats then
        health = fallbackStats.health
    end

    local damage = attackParameters and sum_trigger_item_damage(ammoActions, attackParameters) or nil
    if type(damage) ~= "number" and attackParameters then
        local damageModifier = safe_read(function() return attackParameters.damage_modifier end)
        if type(damageModifier) == "number" and damageModifier > 0 then
            damage = damageModifier
        end
    end
    if type(damage) ~= "number" and fallbackStats then
        damage = fallbackStats.damage
    end

    local speed
    if prototype then
        for _, getter in ipairs({
            function() return prototype.movement_speed end,
            function() return prototype.speed end,
            function() return prototype.max_speed end
        }) do
            local value = safe_read(getter)
            if type(value) == "number" then
                speed = value
                break
            end
        end
    end
    if type(speed) ~= "number" and fallbackStats then
        speed = fallbackStats.speed
    end

    local healing = prototype and safe_read(function() return prototype.healing_per_tick end) or nil
    if type(healing) ~= "number" and fallbackStats then
        healing = fallbackStats.healing
    end

    local range
    if category == "worm" and prototype then
        range = safe_read(function() return prototype.turret_range end)
    end
    if category ~= "biter" and type(range) ~= "number" and attackParameters then
        range = safe_read(function() return attackParameters.range end)
    end
    if category ~= "biter" and type(range) ~= "number" and fallbackStats then
        range = fallbackStats.range
    end

    return {
        prototype_name = prototypeName,
        prototype_loaded = prototype ~= nil,
        health = health,
        damage = damage,
        speed = speed,
        healing = healing,
        range = range
    }
end

local function format_tier_stat(value, decimals, color)
    if type(value) ~= "number" then
        return "[color=gray]-[/color]"
    end

    return string.format("[color=%s]%." .. tostring(decimals or 0) .. "f[/color]", color or "white", value)
end

-- =============================================================================
-- GUI CREATION
-- =============================================================================

local function destroy_gui(player)
    if player.gui.screen[GUI_NAME] then
        player.gui.screen[GUI_NAME].destroy()
    end
end

local function create_gui(player)
    destroy_gui(player)
    
    local settings = getPlayerSettings(player.index)
    local selectedType = settings.selected_type
    local selectedCategory = settings.selected_category
    local showAllTiers = settings.show_all_tiers == true
    
    local surface = player.surface
    local evolution = game.forces["enemy"].get_evolution_factor(surface)
    
    -- Main frame
    local frame = player.gui.screen.add{
        type = "frame",
        name = GUI_NAME,
        direction = "vertical",
        caption = "5Dim Enemies Info"
    }
    frame.auto_center = true
    frame.style.minimal_width = 980
    frame.style.maximal_width = 1180
    
    -- Header with close button
    local header = frame.add{type = "flow", direction = "horizontal"}
    header.drag_target = frame
    header.add{type = "label", caption = "Enemy Types & Stats", style = "heading_2_label"}
    local spacer = header.add{type = "empty-widget"}
    spacer.style.horizontally_stretchable = true
    header.add{
        type = "sprite-button",
        name = "5dim_enemies_close",
        sprite = "utility/close",
        style = "frame_action_button",
        tooltip = "Close"
    }

    local content = frame.add{
        type = "scroll-pane",
        direction = "vertical",
        vertical_scroll_policy = "auto",
        horizontal_scroll_policy = "auto"
    }
    content.style.minimal_width = 940
    content.style.maximal_height = 720
    
    -- Evolution info frame
    local evo_frame = content.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
    evo_frame.style.bottom_margin = 8
    
    -- Get evolution factors
    local enemy_force = game.forces["enemy"]
    local evo_time = enemy_force.get_evolution_factor_by_time(surface)
    local evo_pollution = enemy_force.get_evolution_factor_by_pollution(surface)
    local evo_kills = enemy_force.get_evolution_factor_by_killing_spawners(surface)
    
    -- Main evolution display
    local evo_header = evo_frame.add{type = "flow", direction = "horizontal"}
    evo_header.style.vertical_align = "center"
    evo_header.add{type = "label", caption = "Total Evolution: ", style = "heading_2_label"}
    evo_header.add{type = "label", caption = string.format("[color=red]%.2f%%[/color]", evolution * 100)}
    
    local evo_bar = evo_frame.add{type = "progressbar", value = evolution}
    evo_bar.style.horizontally_stretchable = true
    evo_bar.style.height = 12
    evo_bar.style.color = {r = 1, g = 0.3, b = 0.3}
    
    -- Evolution breakdown table
    local evo_table = evo_frame.add{type = "table", column_count = 3}
    evo_table.style.top_margin = 6
    evo_table.style.cell_padding = 2
    
    -- Time evolution
    evo_table.add{type = "label", caption = "[color=cyan]Time:[/color]"}
    evo_table.add{type = "label", caption = string.format("%.2f%%", evo_time * 100)}
    local bar_time = evo_table.add{type = "progressbar", value = evo_time}
    bar_time.style.width = 120
    bar_time.style.height = 8
    bar_time.style.color = {r = 0.3, g = 0.8, b = 1}
    
    -- Pollution evolution
    evo_table.add{type = "label", caption = "[color=green]Pollution:[/color]"}
    evo_table.add{type = "label", caption = string.format("%.2f%%", evo_pollution * 100)}
    local bar_poll = evo_table.add{type = "progressbar", value = evo_pollution}
    bar_poll.style.width = 120
    bar_poll.style.height = 8
    bar_poll.style.color = {r = 0.3, g = 1, b = 0.3}
    
    -- Spawner kills evolution
    evo_table.add{type = "label", caption = "[color=orange]Spawner Kills:[/color]"}
    evo_table.add{type = "label", caption = string.format("%.2f%%", evo_kills * 100)}
    local bar_kills = evo_table.add{type = "progressbar", value = evo_kills}
    bar_kills.style.width = 120
    bar_kills.style.height = 8
    bar_kills.style.color = {r = 1, g = 0.6, b = 0.2}
    
    -- Type selector frame
    local selector_frame = content.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
    selector_frame.style.bottom_margin = 8
    selector_frame.add{type = "label", caption = "Enemy Type Selection", style = "heading_2_label"}
    
    -- Type dropdown
    local type_flow = selector_frame.add{type = "flow", direction = "horizontal"}
    type_flow.style.vertical_align = "center"
    type_flow.add{type = "label", caption = "Type: "}
    
    local typeItems = {}
    local typeIndex = 1
    local TypeOrder = SharedConfig.TypeOrder or {"normal"}
    local TypeDisplay = SharedConfig.TypeDisplay or {normal = {name = "Normal", color = "white"}}
    
    for i, typeName in ipairs(TypeOrder) do
        local display = TypeDisplay[typeName]
        if display then
                table.insert(typeItems, display.name or typeName)
            if typeName == selectedType then typeIndex = i end
        end
    end
    
    local type_dropdown = type_flow.add{
        type = "drop-down",
        name = "5dim_enemies_type_dropdown",
        items = typeItems,
        selected_index = typeIndex
    }
    type_dropdown.style.width = 150
    
    -- Category dropdown
    type_flow.add{type = "label", caption = "  Category: "}
    
    local categoryItems = {}
    local categoryIndex = 1
    local TypeCategories = SharedConfig.TypeCategories or {}
    local availableCategories = TypeCategories[selectedType] or {"biter", "spitter", "worm"}
    
    for j, cat in ipairs(availableCategories) do
        local display = CategoryDisplay[cat]
        if display then
                table.insert(categoryItems, display.name)
            if cat == selectedCategory then categoryIndex = j end
        end
    end
    
    local category_dropdown = type_flow.add{
        type = "drop-down",
        name = "5dim_enemies_category_dropdown",
        items = categoryItems,
        selected_index = categoryIndex
    }
    category_dropdown.style.width = 120
    
    -- Type info display
    local TypeMultipliers = SharedConfig.TypeMultipliers or {}
    local mult = TypeMultipliers[selectedType] or {health = 1, healing = 1, speed = 1, damage = 1, evolution_min = 0, evolution_max = 1}
    local info_frame = selector_frame.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
    info_frame.style.top_margin = 8
    
    -- Calculate actual evolution range with spitter offset if applicable
    local evoOffset = (selectedCategory == "spitter") and SPITTER_EVOLUTION_OFFSET or 0
    local evoMinDisplay = math.min(1.0, (mult.evolution_min or 0) + evoOffset) * 100
    local evoMaxDisplay = math.min(1.0, (mult.evolution_max or 1) + evoOffset) * 100
    
    -- Type stats
    local typeDisplayName = TypeDisplay[selectedType] and TypeDisplay[selectedType].name or selectedType
    local typeColor = TypeDisplay[selectedType] and TypeDisplay[selectedType].color or "white"
    local catDisplayName = CategoryDisplay[selectedCategory] and CategoryDisplay[selectedCategory].name or selectedCategory
    
    info_frame.add{type = "label", caption = string.format("[color=%s][font=default-bold]%s[/font][/color]", typeColor, typeDisplayName)}
    local description_label = info_frame.add{type = "label", caption = {"enemy-info-description." .. selectedType}}
    description_label.style.maximal_width = 860
    description_label.style.top_margin = 4
    description_label.style.bottom_margin = 6

    local overview_table = info_frame.add{type = "table", column_count = 2}
    overview_table.style.cell_padding = 2
    overview_table.add{type = "label", caption = {"enemy-info-ui.category"}}
    overview_table.add{type = "label", caption = string.format("[color=%s]%s[/color]", CategoryDisplay[selectedCategory] and CategoryDisplay[selectedCategory].color or "white", catDisplayName)}
    overview_table.add{type = "label", caption = {"enemy-info-ui.data-source"}}
    overview_table.add{type = "label", caption = {"enemy-info-ui.data-source-runtime"}}
    
    local stats_table = info_frame.add{type = "table", column_count = 2}
    stats_table.style.cell_padding = 2
    stats_table.style.top_margin = 6
    
    stats_table.add{type = "label", caption = "Health Multiplier:"}
    stats_table.add{type = "label", caption = string.format("[color=green]%.2fx[/color]", mult.health or 1)}
    
    stats_table.add{type = "label", caption = "Damage Multiplier:"}
    stats_table.add{type = "label", caption = string.format("[color=red]%.2fx[/color]", mult.damage or 1)}
    
    stats_table.add{type = "label", caption = "Speed Multiplier:"}
    stats_table.add{type = "label", caption = string.format("[color=yellow]%.2fx[/color]", mult.speed or 1)}
    
    stats_table.add{type = "label", caption = "Healing Multiplier:"}
    stats_table.add{type = "label", caption = string.format("[color=cyan]%.2fx[/color]", mult.healing or 1)}
    
    stats_table.add{type = "label", caption = "Evolution Range:"}
    stats_table.add{type = "label", caption = string.format("[color=orange]%.0f%% - %.0f%%[/color]", evoMinDisplay, evoMaxDisplay)}
    
    -- Spawner modifiers (only if type has spawner modifications)
    local spawnerCooldown = mult.spawner_cooldown or 1.0
    local spawnerMaxCount = mult.spawner_max_count or 1.0
    if spawnerCooldown ~= 1.0 or spawnerMaxCount ~= 1.0 then
        stats_table.add{type = "label", caption = "Spawner Cooldown:"}
        stats_table.add{type = "label", caption = string.format("[color=purple]%.2fx (%.0f%% speed)[/color]", spawnerCooldown, (1 / spawnerCooldown) * 100)}
        
        stats_table.add{type = "label", caption = "Spawner Max Units:"}
        stats_table.add{type = "label", caption = string.format("[color=purple]%.2fx[/color]", spawnerMaxCount)}
    end
    
    -- Distance factor info
    local TypeDefinitions = SharedConfig.TypeDefinitions or {}
    local typeDef = TypeDefinitions[selectedType]
    if typeDef and typeDef.distance_factor then
        stats_table.add{type = "label", caption = "Distance Factor:"}
        local distDesc = typeDef.distance_factor == 0 and "Near spawn" or 
                         typeDef.distance_factor == 1 and "Moderate" or "Far from spawn"
        stats_table.add{type = "label", caption = string.format("[color=white]%d (%s)[/color]", typeDef.distance_factor, distDesc)}
    end
    
    -- ==========================================================================
    -- SPAWN DISTRIBUTION TABLE (Main feature!)
    -- ==========================================================================
    local spawn_frame = content.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
    spawn_frame.style.top_margin = 8

    spawn_frame.add{type = "label", caption = {"enemy-info-ui.tier-breakdown", typeDisplayName, catDisplayName}, style = "heading_2_label"}
    local visibility_flow = spawn_frame.add{type = "flow", direction = "horizontal"}
    visibility_flow.style.top_margin = 4
    visibility_flow.add{
        type = "checkbox",
        name = "5dim_enemies_show_all_tiers",
        state = showAllTiers,
        caption = {"enemy-info-ui.show-all-tiers"}
    }
    local spawn_help = spawn_frame.add{type = "label", caption = {"enemy-info-ui.tier-help"}}
    spawn_help.style.maximal_width = 860
    spawn_help.style.bottom_margin = 6

    -- Calculate all spawn probabilities and read current prototype stats
    local totalProb = 0
    local tierRows = {}
    local tierEvos = calculateEvolution(selectedType, selectedCategory)
    local showRangeColumn = false
    
    for tier = 1, 11 do
        local tierStats = get_runtime_tier_stats(selectedType, selectedCategory, tier)
        local curve = getSpawnCurve(selectedType, tier, selectedCategory)
        local prob = tierStats.prototype_loaded and calculateSpawnProbability(evolution, curve) or 0
        tierRows[tier] = {
            stats = tierStats,
            probability = prob,
            evolution = tierEvos[tier]
        }
        if type(tierStats.range) == "number" then
            showRangeColumn = true
        end
        totalProb = totalProb + prob
    end
    
    -- Spawn table
    local spawn_table = spawn_frame.add{type = "table", column_count = showRangeColumn and 8 or 7}
    spawn_table.style.cell_padding = 2
    
    spawn_table.add{type = "label", caption = "[font=default-bold]Tier[/font]"}
    spawn_table.add{type = "label", caption = "[font=default-bold]Evo[/font]"}
    spawn_table.add{type = "label", caption = "[font=default-bold]Health[/font]"}
    spawn_table.add{type = "label", caption = "[font=default-bold]Damage[/font]"}
    if showRangeColumn then
        spawn_table.add{type = "label", caption = {"", "[font=default-bold]", {"enemy-info-ui.range"}, "[/font]"}}
    end
    spawn_table.add{type = "label", caption = "[font=default-bold]Speed[/font]"}
    spawn_table.add{type = "label", caption = "[font=default-bold]Healing[/font]"}
    spawn_table.add{type = "label", caption = "[font=default-bold]Spawn%[/font]"}
    
    local activeTiers = 0
    local visibleTiers = 0
    for tier = 1, 11 do
        local row = tierRows[tier]
        local stats = row.stats
        local prob = row.probability
        local normalizedProb = totalProb > 0 and (prob / totalProb) or 0

        if prob > 0.001 then
            activeTiers = activeTiers + 1
        end

        if showAllTiers or prob > 0.001 then
            visibleTiers = visibleTiers + 1

            local tierColor = stats.prototype_loaded and (prob > 0.001 and (tier == 11 and "purple" or "white") or "gray") or "gray"
            local tierText = tier == 11 and "BOSS" or ("T" .. tier)
            if prob > 0.001 then
                tierText = "[font=default-bold]" .. tierText .. "[/font]"
            end
            local tierLabel = spawn_table.add{
                type = "label",
                caption = string.format("[color=%s]%s[/color]", tierColor, tierText),
                tooltip = stats.prototype_name
            }

            if not stats.prototype_loaded then
                tierLabel.tooltip = stats.prototype_name .. " (prototype not loaded)"
            end

            local evoColor = prob > 0.001 and "orange" or "gray"
            local spawnColor = prob > 0.001 and (tier == 11 and "purple" or "red") or "gray"
            local spawnBarColor = prob > 0.001 and (tier == 11 and {r = 0.7, g = 0.35, b = 1} or {r = 1, g = 0.25, b = 0.25}) or {r = 0.4, g = 0.4, b = 0.4}
            local evoStr = string.format("[color=%s]%.0f%%[/color]", evoColor, row.evolution * 100)
            local probStr = string.format("[color=%s]%.1f%%[/color]", spawnColor, normalizedProb * 100)

            spawn_table.add{type = "label", caption = evoStr}
            spawn_table.add{type = "label", caption = format_tier_stat(stats.health, 0, "green")}
            spawn_table.add{type = "label", caption = format_tier_stat(stats.damage, 1, "red")}
            if showRangeColumn then
                spawn_table.add{type = "label", caption = format_tier_stat(stats.range, 1, "white")}
            end
            spawn_table.add{type = "label", caption = format_tier_stat(stats.speed, 3, "yellow")}
            spawn_table.add{type = "label", caption = format_tier_stat(stats.healing, 3, "cyan")}

            local spawn_flow = spawn_table.add{type = "flow", direction = "horizontal"}
            spawn_flow.style.vertical_align = "center"
            local spawn_label = spawn_flow.add{type = "label", caption = probStr}
            spawn_label.style.width = 52
            local spawn_bar = spawn_flow.add{type = "progressbar", value = normalizedProb}
            spawn_bar.style.width = 80
            spawn_bar.style.height = 8
            spawn_bar.style.color = spawnBarColor
        end
    end
    
    if visibleTiers == 0 or activeTiers == 0 then
        spawn_frame.add{type = "label", caption = "[color=gray]No tiers active at this evolution[/color]"}
    end
    
    -- ==========================================================================
    -- DEV MODE: Additional controls when 5dim_dev is installed
    -- ==========================================================================
    if DEV_MODE then
        -- Evolution control frame
        local dev_frame = content.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
        dev_frame.style.top_margin = 8
        dev_frame.add{type = "label", caption = "[color=yellow]Developer Tools[/color]", style = "heading_2_label"}
        
        -- Evolution slider
        local evo_control = dev_frame.add{type = "flow", direction = "horizontal"}
        evo_control.style.vertical_align = "center"
        evo_control.add{type = "label", caption = "Set Evolution: "}
        
        local slider = evo_control.add{
            type = "slider",
            name = "5dim_enemies_evolution_slider",
            minimum_value = 0,
            maximum_value = 100,
            value = evolution * 100
        }
        slider.style.width = 150
        
        local slider_label = evo_control.add{
            type = "label",
            name = "5dim_enemies_evolution_label",
            caption = string.format("%.0f%%", evolution * 100)
        }
        slider_label.style.width = 50
        
        evo_control.add{
            type = "button",
            name = "5dim_enemies_apply_evolution",
            caption = "Apply",
            tooltip = "Set evolution factor to this value"
        }
        
        -- List buttons
        local list_flow = dev_frame.add{type = "flow", direction = "horizontal"}
        list_flow.style.top_margin = 8
        
        list_flow.add{
            type = "button",
            name = "5dim_enemies_list_spawners",
            caption = "List Spawners",
            tooltip = "List all spawners on current surface"
        }
        
        list_flow.add{
            type = "button",
            name = "5dim_enemies_list_units",
            caption = "List Units",
            tooltip = "List all units on current surface"
        }
        
        list_flow.add{
            type = "button",
            name = "5dim_enemies_refresh",
            caption = "Refresh",
            tooltip = "Refresh GUI"
        }
    end
    
    -- Set as player's opened GUI to enable closing with Escape
    player.opened = frame
end

local function create_toggle_button(player)
    if player.gui.top[BUTTON_NAME] then
        return
    end
    
    player.gui.top.add{
        type = "sprite-button",
        name = BUTTON_NAME,
        sprite = "utility/enemy_force_icon",
        tooltip = "5Dim Enemies Info"
    }
end

local function toggle_gui(player)
    if player.gui.screen[GUI_NAME] then
        destroy_gui(player)
    else
        create_gui(player)
    end
end

-- =============================================================================
-- DEV MODE HELPER FUNCTIONS
-- =============================================================================

local function log_msg(player, msg)
    player.print("[5dim_dev] " .. msg)
end

local function list_spawners(player)
    local surface = player.surface
    local spawners = surface.find_entities_filtered{type = "unit-spawner"}
    
    local counts = {}
    for _, spawner in pairs(spawners) do
        local name = spawner.name
        counts[name] = (counts[name] or 0) + 1
    end
    
    log_msg(player, "=== Spawners on " .. surface.name .. " ===")
    log_msg(player, "Total: " .. #spawners)
    
    -- Sort by count
    local sorted = {}
    for name, count in pairs(counts) do
        table.insert(sorted, {name = name, count = count})
    end
    table.sort(sorted, function(a, b) return a.count > b.count end)
    
    for _, entry in ipairs(sorted) do
        log_msg(player, "  " .. entry.name .. ": " .. entry.count)
    end
end

local function list_units(player)
    local surface = player.surface
    local units = surface.find_entities_filtered{type = "unit"}
    
    local counts = {}
    for _, unit in pairs(units) do
        local name = unit.name
        counts[name] = (counts[name] or 0) + 1
    end
    
    log_msg(player, "=== Units on " .. surface.name .. " ===")
    log_msg(player, "Total: " .. #units)
    
    -- Sort by count
    local sorted = {}
    for name, count in pairs(counts) do
        table.insert(sorted, {name = name, count = count})
    end
    table.sort(sorted, function(a, b) return a.count > b.count end)
    
    for _, entry in ipairs(sorted) do
        log_msg(player, "  " .. entry.name .. ": " .. entry.count)
    end
end

-- =============================================================================
-- EVENT HANDLERS
-- =============================================================================

script.on_event(defines.events.on_gui_click, function(event)
    local element = event.element
    if not element or not element.valid then return end
    
    local player = game.get_player(event.player_index)
    if not player then return end
    
    if element.name == BUTTON_NAME then
        toggle_gui(player)
    elseif element.name == "5dim_enemies_close" then
        destroy_gui(player)
    elseif element.name == "5dim_enemies_apply_evolution" and DEV_MODE then
        local frame = player.gui.screen[GUI_NAME]
        if frame then
            local slider = frame.tags and frame.tags.evolution_value
            -- Find slider value
            local function find_slider(elem)
                if elem.name == "5dim_enemies_evolution_slider" then
                    return elem.slider_value
                end
                for _, child in pairs(elem.children or {}) do
                    local result = find_slider(child)
                    if result then return result end
                end
                return nil
            end
            local value = find_slider(frame)
            if value then
                local surface = player.surface
                game.forces["enemy"].set_evolution_factor(value / 100, surface)
                log_msg(player, "Evolution set to " .. string.format("%.1f%%", value))
                create_gui(player)
            end
        end
    elseif element.name == "5dim_enemies_list_spawners" and DEV_MODE then
        list_spawners(player)
    elseif element.name == "5dim_enemies_list_units" and DEV_MODE then
        list_units(player)
    elseif element.name == "5dim_enemies_refresh" then
        create_gui(player)
    end
end)

script.on_event(defines.events.on_gui_value_changed, function(event)
    local element = event.element
    if not element or not element.valid then return end
    
    if element.name == "5dim_enemies_evolution_slider" and DEV_MODE then
        -- Update label
        local parent = element.parent
        if parent then
            local label = parent["5dim_enemies_evolution_label"]
            if label then
                label.caption = string.format("%.0f%%", element.slider_value)
            end
        end
    end
end)

script.on_event(defines.events.on_gui_selection_state_changed, function(event)
    local element = event.element
    if not element or not element.valid then return end
    
    local player = game.get_player(event.player_index)
    if not player then return end
    local settings = getPlayerSettings(player.index)
    
    local TypeOrder = SharedConfig.TypeOrder or {"normal"}
    local TypeCategories = SharedConfig.TypeCategories or {}
    
    if element.name == "5dim_enemies_type_dropdown" then
        local selectedIndex = element.selected_index
        if TypeOrder[selectedIndex] then
            settings.selected_type = TypeOrder[selectedIndex]
            -- Reset category to first available for new type
            local availableCats = TypeCategories[settings.selected_type] or {"biter", "spitter", "worm"}
            settings.selected_category = availableCats[1] or "biter"
        end
        create_gui(player)
    elseif element.name == "5dim_enemies_category_dropdown" then
        local availableCats = TypeCategories[settings.selected_type] or {"biter", "spitter", "worm"}
        if availableCats[element.selected_index] then
            settings.selected_category = availableCats[element.selected_index]
        end
        create_gui(player)
    end
end)

script.on_event(defines.events.on_gui_checked_state_changed, function(event)
    local element = event.element
    if not element or not element.valid then return end

    local player = game.get_player(event.player_index)
    if not player then return end

    if element.name == "5dim_enemies_show_all_tiers" then
        local settings = getPlayerSettings(player.index)
        settings.show_all_tiers = element.state == true
        create_gui(player)
    end
end)

script.on_event(defines.events.on_gui_closed, function(event)
    if event.gui_type == defines.gui_type.custom then
        local player = game.get_player(event.player_index)
        if player and player.gui.screen[GUI_NAME] then
            destroy_gui(player)
        end
    end
end)

script.on_event(defines.events.on_player_created, function(event)
    local player = game.get_player(event.player_index)
    if player then
        create_toggle_button(player)
    end
end)

script.on_init(function()
    for _, player in pairs(game.players) do
        create_toggle_button(player)
    end
end)

script.on_configuration_changed(function()
    for _, player in pairs(game.players) do
        create_toggle_button(player)
        -- Refresh GUI if open
        if player.gui.screen[GUI_NAME] then
            create_gui(player)
        end
    end
end)
