-- 5Dim's Development Tools
-- Runtime debugging, commands and GUI
-- Updated for TypeMultipliers system with DYNAMIC configuration loading

-- =============================================================================
-- DYNAMIC CONFIGURATION LOADING
-- =============================================================================
-- This module now loads configuration dynamically from 5dim_enemies via
-- remote interface. This means adding new enemy types only requires updating
-- 5dim_enemies - no changes needed here!
-- =============================================================================

local TierConfig = nil
local TypeDisplay = nil
local TypeOrder = nil
local CategoryDisplay = nil
local configLoaded = false

-- Fallback configuration (used if 5dim_enemies is not loaded)
local FallbackConfig = {
    COUNT = 10,
    base = {
        biter = {
            [1]  = { scale = 0.50, health = 20,    damage = 7,   speed = 0.22, healing = 0.013 },
            [2]  = { scale = 0.60, health = 40,    damage = 11,  speed = 0.21, healing = 0.017 },
            [3]  = { scale = 0.70, health = 80,    damage = 16,  speed = 0.20, healing = 0.027 },
            [4]  = { scale = 0.85, health = 160,   damage = 24,  speed = 0.19, healing = 0.042 },
            [5]  = { scale = 1.00, health = 320,   damage = 36,  speed = 0.18, healing = 0.075 },
            [6]  = { scale = 1.15, health = 640,   damage = 54,  speed = 0.17, healing = 0.128 },
            [7]  = { scale = 1.30, health = 1280,  damage = 81,  speed = 0.16, healing = 0.213 },
            [8]  = { scale = 1.50, health = 2560,  damage = 122, speed = 0.15, healing = 0.388 },
            [9]  = { scale = 1.80, health = 5120,  damage = 182, speed = 0.14, healing = 0.717 },
            [10] = { scale = 2.20, health = 10240, damage = 274, speed = 0.13, healing = 1.422 }
        },
        spitter = {
            [1]  = { scale = 0.50, health = 13,   damage = 10,  range = 13, speed = 0.18, healing = 0.009 },
            [2]  = { scale = 0.60, health = 26,   damage = 15,  range = 14, speed = 0.17, healing = 0.011 },
            [3]  = { scale = 0.70, health = 52,   damage = 22,  range = 15, speed = 0.16, healing = 0.017 },
            [4]  = { scale = 0.85, health = 104,  damage = 34,  range = 16, speed = 0.15, healing = 0.028 },
            [5]  = { scale = 1.00, health = 208,  damage = 50,  range = 17, speed = 0.14, healing = 0.049 },
            [6]  = { scale = 1.15, health = 416,  damage = 76,  range = 18, speed = 0.13, healing = 0.084 },
            [7]  = { scale = 1.30, health = 832,  damage = 114, range = 19, speed = 0.12, healing = 0.139 },
            [8]  = { scale = 1.50, health = 1664, damage = 170, range = 20, speed = 0.11, healing = 0.252 },
            [9]  = { scale = 1.80, health = 3328, damage = 256, range = 22, speed = 0.10, healing = 0.466 },
            [10] = { scale = 2.20, health = 6656, damage = 384, range = 25, speed = 0.09, healing = 0.924 }
        },
        worm = {
            [1]  = { scale = 0.55, health = 200,  damage = 25,  range = 22, speed = 0, healing = 0.044 },
            [2]  = { scale = 0.62, health = 300,  damage = 35,  range = 24, speed = 0, healing = 0.056 },
            [3]  = { scale = 0.70, health = 450,  damage = 49,  range = 26, speed = 0, healing = 0.075 },
            [4]  = { scale = 0.78, health = 675,  damage = 69,  range = 28, speed = 0, healing = 0.102 },
            [5]  = { scale = 0.88, health = 1013, damage = 96,  range = 30, speed = 0, healing = 0.141 },
            [6]  = { scale = 0.98, health = 1519, damage = 135, range = 33, speed = 0, healing = 0.195 },
            [7]  = { scale = 1.10, health = 2278, damage = 189, range = 36, speed = 0, healing = 0.271 },
            [8]  = { scale = 1.25, health = 3418, damage = 264, range = 40, speed = 0, healing = 0.380 },
            [9]  = { scale = 1.45, height = 5127, damage = 370, range = 45, speed = 0, healing = 0.534 },
            [10] = { scale = 1.70, health = 7690, damage = 518, range = 52, speed = 0, healing = 0.754 }
        }
    },
    TypeMultipliers = {
        default = { health = 1.0, healing = 1.0, speed = 1.0, damage = 1.0, evolution_min = 0.0, evolution_max = 1.0 },
        normal = { health = 1.0, healing = 1.0, speed = 1.0, damage = 1.0, evolution_min = 0.0, evolution_max = 0.8 }
    },
    boss = {
        health_multiplier = 3.0,
        damage_multiplier = 3.0,
        scale_multiplier = 2.0,
        speed_multiplier = 0.6,
        healing_time = 125
    },
    typeCategories = {
        normal = {"biter", "spitter", "worm"}
    }
}

local FallbackTypeDisplay = {
    normal = { name = "Normal", color = "white" }
}

local FallbackTypeOrder = {"normal"}

-- Load configuration from 5dim_enemies remote interface
local function loadConfig()
    if configLoaded then return end
    
    -- Check if 5dim_enemies remote interface is available
    if remote.interfaces["5dim_enemies"] then
        local success, config = pcall(function()
            return remote.call("5dim_enemies", "get_config")
        end)
        
        if success and config then
            -- Build TierConfig from remote data
            TierConfig = {
                COUNT = 10,
                base = config.BaseStats,
                TypeMultipliers = config.TypeMultipliers,
                boss = config.BossConfig,
                typeCategories = config.TypeCategories
            }
            TypeDisplay = config.TypeDisplay
            TypeOrder = config.TypeOrder
            configLoaded = true
            log("[5dim_dev] Configuration loaded dynamically from 5dim_enemies")
            return
        end
    end
    
    -- Fallback to hardcoded config if remote interface not available
    log("[5dim_dev] WARNING: 5dim_enemies remote interface not available, using fallback config")
    TierConfig = FallbackConfig
    TypeDisplay = FallbackTypeDisplay
    TypeOrder = FallbackTypeOrder
    configLoaded = true
end

-- Category display names (static - doesn't change)
CategoryDisplay = {
    biter = { name = "Biter", color = "red" },
    spitter = { name = "Spitter", color = "green", evolution_offset = 0.05 },
    worm = { name = "Worm", color = "yellow" }
}

-- Spitter evolution offset (+5%)
local SPITTER_EVOLUTION_OFFSET = 0.05

-- =============================================================================
-- CALCULATION FUNCTIONS
-- =============================================================================

-- Calculate evolution values for 11 tiers (10 normal + boss)
-- Spitters get +5% evolution offset
local function calculateEvolution(typeName, category)
    local multipliers = TierConfig.TypeMultipliers[typeName] or TierConfig.TypeMultipliers.default
    local evoMin = multipliers.evolution_min
    local evoMax = multipliers.evolution_max
    local range = evoMax - evoMin
    
    -- Spitters spawn at +5% evolution compared to biters
    local offset = (category == "spitter") and SPITTER_EVOLUTION_OFFSET or 0
    
    local evolution = {}
    for tier = 1, 11 do
        -- Calculate base evolution, add offset, cap at 1.0
        evolution[tier] = math.min(1.0, evoMin + (range * (tier - 1) / 10) + offset)
    end
    return evolution
end

-- Generate spawn curve for a specific tier (3 tiers active at once)
-- This matches the logic in tiers.lua Tiers.getSpawnCurve()
local function getSpawnCurve(typeName, tier, category)
    local evolution = calculateEvolution(typeName, category)
    local tierEvo = evolution[tier]
    
    -- Calculate step between tiers
    local multipliers = TierConfig.TypeMultipliers[typeName] or TierConfig.TypeMultipliers.default
    local step = (multipliers.evolution_max - multipliers.evolution_min) / 10
    
    local curve = {}
    
    if tier == 11 then
        -- Boss tier
        local bossEvo = evolution[11]
        table.insert(curve, {bossEvo - step * 0.5, 0.0})
        table.insert(curve, {bossEvo, 0.1})
        table.insert(curve, {1.0, 0.2})
    elseif tier == 1 then
        -- Tier 1: starts at tierEvo (evolution_min), not at 0!
        -- Before tierEvo, normal fillers spawn instead
        table.insert(curve, {tierEvo, 0.3})  -- Starts with full weight at evolution_min
        if evolution[2] then
            table.insert(curve, {evolution[2], 0.3})
        end
        if evolution[3] then
            table.insert(curve, {evolution[3], 0.1})
        end
        if evolution[4] then
            table.insert(curve, {evolution[4], 0.0})
        end
    else
        -- Normal tiers (T2-T10): ramp up, peak, ramp down
        local prevEvo = evolution[tier - 1]
        local nextEvo = tier < 11 and evolution[tier + 1] or tierEvo + step
        local nextNextEvo = tier < 10 and evolution[tier + 2] or nextEvo + step
        local nextNextNextEvo = tier < 9 and evolution[tier + 3] or nextNextEvo + step
        
        -- Start appearing (0% at previous tier's evolution)
        table.insert(curve, {prevEvo, 0.0})
        
        -- Peak (when this is the "middle" active tier)
        table.insert(curve, {tierEvo, 0.3})
        
        -- Decline as next tiers take over
        if tier + 1 <= 11 then
            table.insert(curve, {nextEvo, 0.3})
        end
        if tier + 2 <= 11 then
            table.insert(curve, {nextNextEvo, 0.1})
        end
        if tier + 3 <= 11 then
            table.insert(curve, {nextNextNextEvo, 0.0})
        end
    end
    
    return curve
end

-- Calculate spawn probability at a given evolution
local function calculateSpawnProbability(currentEvolution, curve)
    if #curve < 1 then return 0 end
    
    -- If evolution is before the first point, return 0
    if currentEvolution < curve[1][1] then
        return 0
    end
    
    -- If only one point, return its value if we're at or past it
    if #curve == 1 then
        return curve[1][2]
    end
    
    -- Find the segment we're in and interpolate
    for i = 1, #curve - 1 do
        local p1 = curve[i]
        local p2 = curve[i + 1]
        
        if currentEvolution >= p1[1] and currentEvolution <= p2[1] then
            -- Avoid division by zero
            if p2[1] == p1[1] then
                return p1[2]
            end
            local t = (currentEvolution - p1[1]) / (p2[1] - p1[1])
            return p1[2] + t * (p2[2] - p1[2])
        end
    end
    
    -- If we're past the last point, return the last value
    return curve[#curve][2]
end

-- Get stats for a specific tier with type multipliers
local function getStats(category, typeName, tier)
    local multipliers = TierConfig.TypeMultipliers[typeName] or TierConfig.TypeMultipliers.default
    local baseStats = TierConfig.base[category]
    
    if not baseStats then return nil end
    
    local stats = {}
    local scaleMultiplier = multipliers.scale or 1.0
    
    if tier >= 1 and tier <= 10 then
        local base = baseStats[tier]
        if not base then return nil end
        
        stats.scale = base.scale * scaleMultiplier
        stats.health = math.floor(base.health * multipliers.health)
        stats.damage = math.floor(base.damage * multipliers.damage)
        stats.speed = base.speed * multipliers.speed
        stats.healing = base.healing * multipliers.healing
        if base.range then stats.range = base.range end
        
    elseif tier == 11 then
        local base = baseStats[10]
        stats.scale = base.scale * scaleMultiplier * TierConfig.boss.scale_multiplier
        stats.health = math.floor(base.health * multipliers.health * TierConfig.boss.health_multiplier)
        stats.damage = math.floor(base.damage * multipliers.damage * TierConfig.boss.damage_multiplier)
        stats.speed = base.speed * multipliers.speed * TierConfig.boss.speed_multiplier
        stats.healing = stats.health / (TierConfig.boss.healing_time * 60)
        if base.range then stats.range = base.range * 1.2 end
    end
    
    local evolution = calculateEvolution(typeName, category)
    stats.evolution = evolution[tier]
    
    return stats
end

-- =============================================================================
-- UTILITY FUNCTIONS
-- =============================================================================
local function log_msg(msg)
    game.print("[5dim_dev] " .. msg)
    log("[5dim_dev] " .. msg)
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

-- =============================================================================
-- GUI CREATION
-- =============================================================================
local GUI_NAME = "5dim_dev_gui"
local BUTTON_NAME = "5dim_dev_toggle_button"

local function destroy_gui(player)
    if player.gui.screen[GUI_NAME] then
        player.gui.screen[GUI_NAME].destroy()
    end
end

local function create_gui(player)
    -- Ensure configuration is loaded
    loadConfig()
    
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
        caption = "5Dim Enemy Debug - TypeMultipliers"
    }
    frame.auto_center = true
    
    -- Header with close button
    local header = frame.add{type = "flow", direction = "horizontal"}
    header.drag_target = frame
    header.add{type = "label", caption = "Enemy Stats & Spawn Probabilities", style = "heading_2_label"}
    local spacer = header.add{type = "empty-widget"}
    spacer.style.horizontally_stretchable = true
    header.add{
        type = "sprite-button",
        name = "5dim_dev_close",
        sprite = "utility/close",
        style = "frame_action_button",
        tooltip = "Close"
    }
    
    -- Evolution info frame
    local evo_frame = frame.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
    evo_frame.style.bottom_margin = 8
    
    local evo_flow = evo_frame.add{type = "flow", direction = "horizontal"}
    evo_flow.style.vertical_align = "center"
    
    evo_flow.add{type = "label", caption = "Evolution: ", style = "heading_2_label"}
    
    local evo_bar = evo_frame.add{type = "progressbar", value = evolution}
    evo_bar.style.width = 200
    evo_bar.style.color = {r = 1, g = 0.3, b = 0.3}
    
    evo_flow.add{type = "label", caption = string.format(" %.2f%%", evolution * 100)}
    
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
    for i, typeName in ipairs(TypeOrder) do
        local display = TypeDisplay[typeName]
        table.insert(typeItems, "[color=" .. display.color .. "]" .. display.name .. "[/color]")
        if typeName == selectedType then typeIndex = i end
    end
    
    local type_dropdown = type_flow.add{
        type = "drop-down",
        name = "5dim_dev_type_dropdown",
        items = typeItems,
        selected_index = typeIndex
    }
    type_dropdown.style.width = 150
    
    -- Category dropdown
    type_flow.add{type = "label", caption = "  Category: "}
    
    local categoryItems = {}
    local categoryIndex = 1
    local availableCategories = TierConfig.typeCategories[selectedType] or {"biter", "spitter", "worm"}
    for j, cat in ipairs(availableCategories) do
        local display = CategoryDisplay[cat]
        table.insert(categoryItems, "[color=" .. display.color .. "]" .. display.name .. "[/color]")
        if cat == selectedCategory then categoryIndex = j end
    end
    
    local category_dropdown = type_flow.add{
        type = "drop-down",
        name = "5dim_dev_category_dropdown",
        items = categoryItems,
        selected_index = categoryIndex
    }
    category_dropdown.style.width = 120
    
    -- Type multipliers display
    local mult = TierConfig.TypeMultipliers[selectedType] or TierConfig.TypeMultipliers.default
    local mult_flow = selector_frame.add{type = "flow", direction = "vertical"}
    mult_flow.style.top_margin = 4
    
    -- Calculate actual evolution range with spitter offset if applicable
    local evoOffset = (selectedCategory == "spitter") and SPITTER_EVOLUTION_OFFSET or 0
    local evoMinDisplay = math.min(1.0, mult.evolution_min + evoOffset) * 100
    local evoMaxDisplay = math.min(1.0, mult.evolution_max + evoOffset) * 100
    local offsetText = (selectedCategory == "spitter") and " (+5%)" or ""
    
    -- First row: unit stats multipliers
    local mult_row1 = mult_flow.add{type = "flow", direction = "horizontal"}
    local scaleMultiplier = mult.scale or 1.0
    mult_row1.add{type = "label", caption = string.format(
        "Unit:  HP: %.2fx  Heal: %.2fx  Speed: %.2fx  Dmg: %.2fx  Scale: %.2fx  Evo: %.0f%%-%.0f%%%s",
        mult.health, mult.healing, mult.speed, mult.damage, scaleMultiplier,
        evoMinDisplay, evoMaxDisplay, offsetText
    )}
    
    -- Second row: spawner modifiers (only if type has spawner modifications)
    local spawnerCooldown = mult.spawner_cooldown or 1.0
    local spawnerMaxCount = mult.spawner_max_count or 1.0
    if spawnerCooldown ~= 1.0 or spawnerMaxCount ~= 1.0 then
        local mult_row2 = mult_flow.add{type = "flow", direction = "horizontal"}
        mult_row2.add{type = "label", caption = string.format(
            "Spawner:  Cooldown: %.2fx (%.0f%% speed)  Max Units: %.2fx",
            spawnerCooldown, (1 / spawnerCooldown) * 100, spawnerMaxCount
        )}
    end
    
    -- Stats table frame
    local stats_frame = frame.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
    local typeDisplayName = TypeDisplay[selectedType] and TypeDisplay[selectedType].name or selectedType
    local catDisplayName = CategoryDisplay[selectedCategory] and CategoryDisplay[selectedCategory].name or selectedCategory
    stats_frame.add{type = "label", caption = "Tier Stats for " .. typeDisplayName .. " " .. catDisplayName, style = "heading_2_label"}
    
    -- Toggle show all tiers
    local toggle_flow = stats_frame.add{type = "flow", direction = "horizontal"}
    toggle_flow.add{
        type = "checkbox",
        name = "5dim_dev_show_all_tiers",
        caption = "Show all tiers (not just active)",
        state = settings.show_all_tiers
    }
    
    -- Stats scroll pane
    local scroll = stats_frame.add{type = "scroll-pane", direction = "vertical"}
    scroll.style.maximal_height = 350
    
    -- Stats table header
    local stats_table = scroll.add{type = "table", column_count = 9}
    stats_table.style.cell_padding = 2
    stats_table.add{type = "label", caption = "[font=default-bold]Tier[/font]"}
    stats_table.add{type = "label", caption = "[font=default-bold]Evo[/font]"}
    stats_table.add{type = "label", caption = "[font=default-bold]Health[/font]"}
    stats_table.add{type = "label", caption = "[font=default-bold]Damage[/font]"}
    stats_table.add{type = "label", caption = "[font=default-bold]Speed[/font]"}
    stats_table.add{type = "label", caption = "[font=default-bold]Scale[/font]"}
    stats_table.add{type = "label", caption = "[font=default-bold]Heal/s[/font]"}
    stats_table.add{type = "label", caption = "[font=default-bold]Spawn%[/font]"}
    stats_table.add{type = "label", caption = "[font=default-bold]Distribution[/font]"}
    
    -- Calculate all spawn probabilities for normalization
    local totalProb = 0
    local tierProbs = {}
    for tier = 1, 11 do
        local curve = getSpawnCurve(selectedType, tier, selectedCategory)
        local prob = calculateSpawnProbability(evolution, curve)
        tierProbs[tier] = prob
        totalProb = totalProb + prob
    end
    
    -- Display each tier
    for tier = 1, 11 do
        local stats = getStats(selectedCategory, selectedType, tier)
        local prob = tierProbs[tier]
        local normalizedProb = totalProb > 0 and (prob / totalProb) or 0
        
        -- Only show if has probability or show_all_tiers is enabled
        if prob > 0.001 or settings.show_all_tiers then
            local tierLabel = tier == 11 and "[color=purple]BOSS[/color]" or "T" .. tier
            local evoStr = stats and string.format("%.0f%%", stats.evolution * 100) or "-"
            local healthStr = stats and tostring(stats.health) or "-"
            local damageStr = stats and tostring(stats.damage) or "-"
            local speedStr = stats and string.format("%.2f", stats.speed) or "-"
            local scaleStr = stats and string.format("%.2f", stats.scale) or "-"
            local healStr = stats and string.format("%.3f", stats.healing) or "-"
            local probStr = string.format("%.1f%%", normalizedProb * 100)
            
            stats_table.add{type = "label", caption = tierLabel}
            stats_table.add{type = "label", caption = evoStr}
            stats_table.add{type = "label", caption = healthStr}
            stats_table.add{type = "label", caption = damageStr}
            stats_table.add{type = "label", caption = speedStr}
            stats_table.add{type = "label", caption = scaleStr}
            stats_table.add{type = "label", caption = healStr}
            stats_table.add{type = "label", caption = probStr}
            
            local bar = stats_table.add{type = "progressbar", value = normalizedProb}
            bar.style.width = 100
            if tier == 11 then
                bar.style.color = {r = 0.6, g = 0.1, b = 0.8}
            else
                bar.style.color = {r = 0.8, g = 0.2, b = 0.2}
            end
        end
    end
    
    -- Evolution slider for testing
    local test_frame = frame.add{type = "frame", direction = "vertical", style = "inside_shallow_frame_with_padding"}
    test_frame.style.top_margin = 8
    test_frame.add{type = "label", caption = "Test Evolution", style = "caption_label"}
    
    local slider_flow = test_frame.add{type = "flow", direction = "horizontal"}
    slider_flow.style.vertical_align = "center"
    
    local slider = slider_flow.add{
        type = "slider",
        name = "5dim_dev_evolution_slider",
        minimum_value = 0,
        maximum_value = 100,
        value = evolution * 100
    }
    slider.style.width = 200
    
    local slider_label = slider_flow.add{
        type = "label",
        name = "5dim_dev_evolution_label",
        caption = string.format("%.0f%%", evolution * 100)
    }
    slider_label.style.width = 50
    
    slider_flow.add{
        type = "button",
        name = "5dim_dev_apply_evolution",
        caption = "Apply",
        tooltip = "Set evolution factor to this value"
    }
    
    -- Buttons frame
    local button_frame = frame.add{type = "flow", direction = "horizontal"}
    button_frame.style.top_margin = 8
    
    button_frame.add{
        type = "button",
        name = "5dim_dev_refresh",
        caption = "Refresh",
        tooltip = "Update displayed values"
    }
    
    button_frame.add{
        type = "button",
        name = "5dim_dev_list_spawners_btn",
        caption = "List Spawners",
        tooltip = "List all spawners on current surface"
    }
    
    button_frame.add{
        type = "button",
        name = "5dim_dev_list_units_btn",
        caption = "List Units",
        tooltip = "List all units on current surface"
    }
    
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
        sprite = "5dim-dev-icon",
        tooltip = "5Dim Enemy Debug GUI"
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
-- EVENT HANDLERS
-- =============================================================================
local function on_gui_click(event)
    local element = event.element
    if not element or not element.valid then return end
    
    local player = game.get_player(event.player_index)
    if not player then return end
    
    local name = element.name
    
    if name == BUTTON_NAME then
        toggle_gui(player)
    elseif name == "5dim_dev_close" then
        destroy_gui(player)
    elseif name == "5dim_dev_refresh" then
        create_gui(player)
    elseif name == "5dim_dev_apply_evolution" then
        local gui = player.gui.screen[GUI_NAME]
        if gui then
            local function findSlider(container)
                for _, child in pairs(container.children) do
                    if child.name == "5dim_dev_evolution_slider" then
                        return child
                    elseif child.type == "frame" or child.type == "flow" or child.type == "scroll-pane" then
                        local found = findSlider(child)
                        if found then return found end
                    end
                end
                return nil
            end
            
            local slider = findSlider(gui)
            if slider then
                local value = slider.slider_value / 100
                game.forces["enemy"].set_evolution_factor(value, player.surface)
                log_msg("Evolution set to " .. string.format("%.2f", value))
                create_gui(player)
            end
        end
    elseif name == "5dim_dev_list_spawners_btn" then
        local surface = player.surface
        local spawners = surface.find_entities_filtered{type = "unit-spawner"}
        
        local spawnerCounts = {}
        for _, spawner in pairs(spawners) do
            spawnerCounts[spawner.name] = (spawnerCounts[spawner.name] or 0) + 1
        end
        
        log_msg("=== Spawners on " .. surface.name .. " ===")
        log_msg("Total: " .. #spawners)
        
        for sname, count in pairs(spawnerCounts) do
            log_msg("  " .. sname .. ": " .. count)
        end
    elseif name == "5dim_dev_list_units_btn" then
        local surface = player.surface
        local units = surface.find_entities_filtered{type = "unit"}
        
        local unitCounts = {}
        for _, unit in pairs(units) do
            unitCounts[unit.name] = (unitCounts[unit.name] or 0) + 1
        end
        
        log_msg("=== Units on " .. surface.name .. " ===")
        log_msg("Total: " .. #units)
        
        for uname, count in pairs(unitCounts) do
            log_msg("  " .. uname .. ": " .. count)
        end
    end
end

local function on_gui_selection_state_changed(event)
    local element = event.element
    if not element or not element.valid then return end
    
    local player = game.get_player(event.player_index)
    if not player then return end
    
    local settings = getPlayerSettings(player.index)
    
    if element.name == "5dim_dev_type_dropdown" then
        -- Map index to type name using TypeOrder
        settings.selected_type = TypeOrder[element.selected_index] or "normal"
        
        -- Verify category is valid for this type
        local availableCategories = TierConfig.typeCategories[settings.selected_type] or {"biter", "spitter", "worm"}
        local validCategory = false
        for _, cat in ipairs(availableCategories) do
            if cat == settings.selected_category then
                validCategory = true
                break
            end
        end
        if not validCategory then
            settings.selected_category = availableCategories[1]
        end
        
        create_gui(player)
        
    elseif element.name == "5dim_dev_category_dropdown" then
        local availableCategories = TierConfig.typeCategories[settings.selected_type] or {"biter", "spitter", "worm"}
        settings.selected_category = availableCategories[element.selected_index] or "biter"
        create_gui(player)
    end
end

local function on_gui_checked_state_changed(event)
    local element = event.element
    if not element or not element.valid then return end
    
    local player = game.get_player(event.player_index)
    if not player then return end
    
    if element.name == "5dim_dev_show_all_tiers" then
        local settings = getPlayerSettings(player.index)
        settings.show_all_tiers = element.state
        create_gui(player)
    end
end

local function on_gui_value_changed(event)
    local element = event.element
    if not element or not element.valid then return end
    
    if element.name == "5dim_dev_evolution_slider" then
        local player = game.get_player(event.player_index)
        if not player then return end
        
        local gui = player.gui.screen[GUI_NAME]
        if gui then
            local function find_and_update_label(container)
                for _, child in pairs(container.children) do
                    if child.name == "5dim_dev_evolution_label" then
                        child.caption = string.format("%.0f%%", element.slider_value)
                        return true
                    elseif child.type == "frame" or child.type == "flow" or child.type == "scroll-pane" then
                        if find_and_update_label(child) then return true end
                    end
                end
                return false
            end
            find_and_update_label(gui)
        end
    end
end

local function on_player_created(event)
    local player = game.get_player(event.player_index)
    if player then
        create_toggle_button(player)
    end
end

local function on_init()
    loadConfig()  -- Load configuration from 5dim_enemies
    storage.player_settings = {}
    for _, player in pairs(game.players) do
        create_toggle_button(player)
    end
    game.print("[5dim_dev] Development tools loaded. Type /5d-help for commands or click the debug button.")
end

local function on_configuration_changed()
    configLoaded = false  -- Force reload on configuration change
    loadConfig()  -- Reload configuration from 5dim_enemies
    if not storage.player_settings then
        storage.player_settings = {}
    end
    for _, player in pairs(game.players) do
        create_toggle_button(player)
        destroy_gui(player)
    end
    game.print("[5dim_dev] Development tools updated. Configuration reloaded from 5dim_enemies.")
end

-- =============================================================================
-- CONSOLE COMMANDS
-- =============================================================================

commands.add_command("5d-list-spawners", "List all spawners on the current surface", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    local surface = player.surface
    local spawners = surface.find_entities_filtered{type = "unit-spawner"}
    
    local spawnerCounts = {}
    for _, spawner in pairs(spawners) do
        spawnerCounts[spawner.name] = (spawnerCounts[spawner.name] or 0) + 1
    end
    
    log_msg("=== Spawners on " .. surface.name .. " ===")
    log_msg("Total spawners: " .. #spawners)
    
    local sortedNames = {}
    for spname in pairs(spawnerCounts) do
        table.insert(sortedNames, spname)
    end
    table.sort(sortedNames)
    
    for _, spname in ipairs(sortedNames) do
        log_msg("  " .. spname .. ": " .. spawnerCounts[spname])
    end
end)

commands.add_command("5d-list-units", "List all units on the current surface", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    local surface = player.surface
    local units = surface.find_entities_filtered{type = "unit"}
    
    local unitCounts = {}
    for _, unit in pairs(units) do
        unitCounts[unit.name] = (unitCounts[unit.name] or 0) + 1
    end
    
    log_msg("=== Units on " .. surface.name .. " ===")
    log_msg("Total units: " .. #units)
    
    local sortedNames = {}
    for uname in pairs(unitCounts) do
        table.insert(sortedNames, uname)
    end
    table.sort(sortedNames)
    
    for _, uname in ipairs(sortedNames) do
        log_msg("  " .. uname .. ": " .. unitCounts[uname])
    end
end)

commands.add_command("5d-list-worms", "List all worms on the current surface", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    local surface = player.surface
    local turrets = surface.find_entities_filtered{type = "turret"}
    
    local wormCounts = {}
    for _, turret in pairs(turrets) do
        if string.find(turret.name, "worm") then
            wormCounts[turret.name] = (wormCounts[turret.name] or 0) + 1
        end
    end
    
    log_msg("=== Worms on " .. surface.name .. " ===")
    
    local total = 0
    local sortedNames = {}
    for wname in pairs(wormCounts) do
        table.insert(sortedNames, wname)
        total = total + wormCounts[wname]
    end
    table.sort(sortedNames)
    
    log_msg("Total worms: " .. total)
    for _, wname in ipairs(sortedNames) do
        log_msg("  " .. wname .. ": " .. wormCounts[wname])
    end
end)

commands.add_command("5d-spawn", "Spawn an enemy near you. Usage: /5d-spawn <entity-name> [count]", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    local args = {}
    if cmd.parameter then
        for word in string.gmatch(cmd.parameter, "%S+") do
            table.insert(args, word)
        end
    end
    
    local entityName = args[1]
    local count = tonumber(args[2]) or 1
    
    if not entityName then
        log_msg("Usage: /5d-spawn <entity-name> [count]")
        log_msg("Example: /5d-spawn 5d-fire-spitter-t1 5")
        return
    end
    
    if not prototypes.entity[entityName] then
        log_msg("Entity '" .. entityName .. "' not found!")
        return
    end
    
    local pos = player.position
    local surface = player.surface
    local spawned = 0
    
    for _ = 1, count do
        local spawnPos = surface.find_non_colliding_position(entityName, {pos.x + math.random(-10, 10), pos.y + math.random(-10, 10)}, 20, 1)
        if spawnPos then
            surface.create_entity{name = entityName, position = spawnPos, force = "enemy"}
            spawned = spawned + 1
        end
    end
    
    log_msg("Spawned " .. spawned .. " x " .. entityName)
end)

commands.add_command("5d-spawn-spawner", "Spawn a spawner near you. Usage: /5d-spawn-spawner <spawner-name>", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    local spawnerName = cmd.parameter
    
    if not spawnerName then
        log_msg("Usage: /5d-spawn-spawner <spawner-name>")
        log_msg("Examples:")
        log_msg("  /5d-spawn-spawner 5d-fire-spitter-spawner")
        log_msg("  /5d-spawn-spawner 5d-laser-biter-spawner")
        return
    end
    
    if not prototypes.entity[spawnerName] then
        log_msg("Spawner '" .. spawnerName .. "' not found!")
        return
    end
    
    local pos = player.position
    local surface = player.surface
    local spawnPos = surface.find_non_colliding_position(spawnerName, {pos.x + 15, pos.y}, 30, 1)
    
    if spawnPos then
        surface.create_entity{name = spawnerName, position = spawnPos, force = "enemy"}
        log_msg("Spawned " .. spawnerName .. " at " .. spawnPos.x .. ", " .. spawnPos.y)
    else
        log_msg("Could not find valid position for spawner")
    end
end)

commands.add_command("5d-evolution", "Show current evolution factor", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    local enemy_force = game.forces["enemy"]
    log_msg("=== Evolution Factor ===")
    log_msg("Current: " .. string.format("%.4f", enemy_force.get_evolution_factor(player.surface)))
    log_msg("By time: " .. string.format("%.4f", enemy_force.get_evolution_factor_by_time(player.surface)))
    log_msg("By pollution: " .. string.format("%.4f", enemy_force.get_evolution_factor_by_pollution(player.surface)))
    log_msg("By killing spawners: " .. string.format("%.4f", enemy_force.get_evolution_factor_by_killing_spawners(player.surface)))
end)

commands.add_command("5d-set-evolution", "Set evolution factor. Usage: /5d-set-evolution <0.0-1.0>", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    local value = tonumber(cmd.parameter)
    if not value or value < 0 or value > 1 then
        log_msg("Usage: /5d-set-evolution <0.0-1.0>")
        return
    end
    
    game.forces["enemy"].set_evolution_factor(value, player.surface)
    log_msg("Evolution factor set to " .. value)
end)

commands.add_command("5d-list-prototypes", "List all 5dim enemy prototypes", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    log_msg("=== 5Dim Enemy Prototypes ===")
    
    local spawners = {}
    for pname, _ in pairs(prototypes.entity) do
        if string.find(pname, "^5d%-.*%-spawner$") then
            table.insert(spawners, pname)
        end
    end
    table.sort(spawners)
    
    log_msg("Spawners (" .. #spawners .. "):")
    for _, pname in ipairs(spawners) do
        log_msg("  " .. pname)
    end
    
    local unitTypes = {}
    for pname, _ in pairs(prototypes.entity) do
        if string.find(pname, "^5d%-.*%-t1$") and (string.find(pname, "biter") or string.find(pname, "spitter")) then
            table.insert(unitTypes, pname)
        end
    end
    table.sort(unitTypes)
    
    log_msg("Unit types (tier 1 only, " .. #unitTypes .. "):")
    for _, pname in ipairs(unitTypes) do
        log_msg("  " .. pname)
    end
end)

commands.add_command("5d-type-stats", "Show stats for a specific type. Usage: /5d-type-stats <type> [category]", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    local args = {}
    if cmd.parameter then
        for word in string.gmatch(cmd.parameter, "%S+") do
            table.insert(args, word)
        end
    end
    
    local typeName = args[1] or "normal"
    local category = args[2] or "biter"
    
    local mult = TierConfig.TypeMultipliers[typeName]
    if not mult then
        log_msg("Unknown type: " .. typeName)
        log_msg("Available types: normal, laser, physical, impact, railgun, fire, rocket, suicide, poison, electric, acid")
        return
    end
    
    log_msg("=== " .. typeName .. " " .. category .. " Stats ===")
    log_msg("Multipliers: HP=" .. mult.health .. "x, Heal=" .. mult.healing .. "x, Speed=" .. mult.speed .. "x, Dmg=" .. mult.damage .. "x")
    log_msg("Evolution range: " .. (mult.evolution_min * 100) .. "% - " .. (mult.evolution_max * 100) .. "%")
    log_msg("")
    
    for tier = 1, 11 do
        local stats = getStats(category, typeName, tier)
        if stats then
            local tierLabel = tier == 11 and "BOSS" or "T" .. tier
            log_msg(string.format("%s: HP=%d Dmg=%d Spd=%.2f Heal=%.3f Evo=%.0f%%",
                tierLabel, stats.health, stats.damage, stats.speed, stats.healing, stats.evolution * 100))
        end
    end
end)

commands.add_command("5d-gui", "Toggle the 5Dim debug GUI", function(cmd)
    local player = game.get_player(cmd.player_index)
    if player then
        toggle_gui(player)
    end
end)

commands.add_command("5d-help", "Show all 5dim development commands", function(cmd)
    local player = game.get_player(cmd.player_index)
    if not player then return end
    
    log_msg("=== 5Dim Development Commands ===")
    log_msg("/5d-gui - Toggle debug GUI")
    log_msg("/5d-list-spawners - List all spawners on surface")
    log_msg("/5d-list-units - List all units on surface")
    log_msg("/5d-list-worms - List all worms on surface")
    log_msg("/5d-list-prototypes - List all 5dim enemy prototypes")
    log_msg("/5d-type-stats <type> [category] - Show stats for a type")
    log_msg("/5d-spawn <name> [count] - Spawn enemies")
    log_msg("/5d-spawn-spawner <name> - Spawn a spawner")
    log_msg("/5d-evolution - Show evolution factor")
    log_msg("/5d-set-evolution <value> - Set evolution factor")
end)

-- =============================================================================
-- AUTO-REFRESH (every 60 seconds)
-- =============================================================================
local REFRESH_INTERVAL = 60 * 60  -- 60 seconds in ticks

local function on_tick(event)
    if event.tick % REFRESH_INTERVAL ~= 0 then return end
    
    for _, player in pairs(game.players) do
        if player.gui.screen[GUI_NAME] then
            create_gui(player)
        end
    end
end

-- =============================================================================
-- EVENT REGISTRATION
-- =============================================================================

-- Handler for closing GUI with Escape key
local function on_gui_closed(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    
    -- Check if our GUI was the one being closed
    if event.element and event.element.valid and event.element.name == GUI_NAME then
        destroy_gui(player)
    end
end

script.on_init(on_init)
script.on_load(function()
    loadConfig()  -- Reload configuration when loading a saved game
end)
script.on_configuration_changed(on_configuration_changed)
script.on_event(defines.events.on_player_created, on_player_created)
script.on_event(defines.events.on_gui_click, on_gui_click)
script.on_event(defines.events.on_gui_value_changed, on_gui_value_changed)
script.on_event(defines.events.on_gui_selection_state_changed, on_gui_selection_state_changed)
script.on_event(defines.events.on_gui_checked_state_changed, on_gui_checked_state_changed)
script.on_event(defines.events.on_gui_closed, on_gui_closed)
script.on_event(defines.events.on_tick, on_tick)
