-- =============================================================================
-- 5dim_enemies - Control Script (Runtime)
-- =============================================================================
-- This file provides runtime functionality, remote interfaces, and info GUI.
-- Configuration is loaded from shared-config.lua (SINGLE SOURCE OF TRUTH)
-- =============================================================================

-- Load shared configuration (same file used by data stage)
local SharedConfig = require("shared-config")

-- Check if 5dim_dev is installed (for dev tools)
local DEV_MODE = script.active_mods["5dim_dev"] ~= nil

-- =============================================================================
-- CONSTANTS
-- =============================================================================
local GUI_NAME = "5dim_enemies_info_gui"
local BUTTON_NAME = "5dim_enemies_toggle_button"
local SPITTER_EVOLUTION_OFFSET = 0.05

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
            selected_category = "biter"
        }
    end
    return storage.player_settings[player_index]
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
    
    -- Evolution info frame
    local evo_frame = frame.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
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
    local selector_frame = frame.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
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
    
    info_frame.add{type = "label", caption = string.format("[color=%s][font=default-bold]%s[/font][/color]", typeColor, typeDisplayName)}
    
    local stats_table = info_frame.add{type = "table", column_count = 2}
    stats_table.style.cell_padding = 2
    
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
    local spawn_frame = frame.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
    spawn_frame.style.top_margin = 8
    
    local catDisplayName = CategoryDisplay[selectedCategory] and CategoryDisplay[selectedCategory].name or selectedCategory
    spawn_frame.add{type = "label", caption = "Active Tiers at Current Evolution", style = "heading_2_label"}
    
    -- Calculate all spawn probabilities
    local totalProb = 0
    local tierProbs = {}
    local tierEvos = calculateEvolution(selectedType, selectedCategory)
    
    for tier = 1, 11 do
        local curve = getSpawnCurve(selectedType, tier, selectedCategory)
        local prob = calculateSpawnProbability(evolution, curve)
        tierProbs[tier] = prob
        totalProb = totalProb + prob
    end
    
    -- Spawn table
    local spawn_table = spawn_frame.add{type = "table", column_count = 5}
    spawn_table.style.cell_padding = 2
    
    spawn_table.add{type = "label", caption = "[font=default-bold]Tier[/font]"}
    spawn_table.add{type = "label", caption = "[font=default-bold]Evo[/font]"}
    spawn_table.add{type = "label", caption = "[font=default-bold]Spawn%[/font]"}
    spawn_table.add{type = "label", caption = "[font=default-bold]Distribution[/font]"}
    spawn_table.add{type = "label", caption = ""}
    
    local activeTiers = 0
    for tier = 1, 11 do
        local prob = tierProbs[tier]
        local normalizedProb = totalProb > 0 and (prob / totalProb) or 0
        
        -- Only show tiers with probability
        if prob > 0.001 then
            activeTiers = activeTiers + 1
            local tierLabel = tier == 11 and "[color=purple]BOSS[/color]" or "T" .. tier
            local evoStr = string.format("%.0f%%", tierEvos[tier] * 100)
            local probStr = string.format("%.1f%%", normalizedProb * 100)
            
            spawn_table.add{type = "label", caption = tierLabel}
            spawn_table.add{type = "label", caption = evoStr}
            spawn_table.add{type = "label", caption = probStr}
            
            local bar = spawn_table.add{type = "progressbar", value = normalizedProb}
            bar.style.width = 120
            bar.style.height = 10
            bar.style.bar_width = 10
            if tier == 11 then
                bar.style.color = {r = 0.6, g = 0.1, b = 0.8}
            else
                bar.style.color = {r = 0.9, g = 0.2, b = 0.2}
            end
            
            spawn_table.add{type = "label", caption = ""}
        end
    end
    
    if activeTiers == 0 then
        spawn_frame.add{type = "label", caption = "[color=gray]No tiers active at this evolution[/color]"}
    end
    
    -- ==========================================================================
    -- DEV MODE: Additional controls when 5dim_dev is installed
    -- ==========================================================================
    if DEV_MODE then
        -- Evolution control frame
        local dev_frame = frame.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
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
