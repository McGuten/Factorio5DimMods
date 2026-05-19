local function build(context)
    local power_grid = context.power_grid

    local init = [[
    local surface = game.surfaces.nauvis
    local logo = surface.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    if not logo then return end

    logo.destructible = false
    local center = {logo.position.x, logo.position.y + 9.75}
    game.simulation.camera_position = center
    game.simulation.camera_zoom = 1
    game.tick_paused = false
    game.map_settings.steering.moving.force_unit_fuzzy_goto_behavior = true
    game.map_settings.steering.moving.radius = 2
  game.forces.enemy.set_evolution_factor(0.88)
  surface.daytime = 0.62
    surface.peaceful_mode = false

    local available_units = __POWER_GRID_AVAILABLE_UNITS__

    local clear_scene_area = function()
      local entities = surface.find_entities_filtered{position = center, radius = 96}
      for _, entity in ipairs(entities) do
        if entity.valid and entity.name ~= "factorio-logo-11tiles" then
          if entity.force and (entity.force.name == "player" or entity.force.name == "enemy") then
            entity.destroy()
          end
        end
      end
    end

    clear_scene_area()

    local command_move = function(unit)
      if not (unit and unit.valid and unit.commandable) then
        return
      end

      unit.commandable.set_command{
        type = defines.command.go_to_location,
        destination = {center[1] + 40, center[2] + math.random(-6, 6)},
        radius = 2
      }
    end

    local spawn_wave = function(count, spread)
      if #available_units == 0 then
        return
      end

      for wave = 1, count do
        local name = available_units[((wave - 1) % #available_units) + 1]
        local spawn_anchor = {center[1] - 44 + math.random(-10, 6), center[2] + math.random(-(spread or 8), spread or 8)}
        local spawn_position = surface.find_non_colliding_position(name, spawn_anchor, 16, 0.5)
        if spawn_position then
          local unit = surface.create_entity{name = name, position = spawn_position, force = "enemy"}
          if unit and unit.speed then
            unit.speed = 0.17 + (math.random() / 24)
          end
          command_move(unit)
        end
      end
    end

    local rally_enemy_units = function(radius)
      local units = surface.find_entities_filtered{type = "unit", position = center, radius = radius, force = "enemy"}
      for _, unit in ipairs(units) do
        command_move(unit)
      end
    end

    spawn_wave(24, 8)
    rally_enemy_units(96)

    script.on_nth_tick(60 * 2, function()
      rally_enemy_units(96)
    end)

    script.on_nth_tick(60 * 5, function()
      spawn_wave(6, 6)
    end)
]]

    init = init
        :gsub("__POWER_GRID_AVAILABLE_UNITS__", context.to_lua_string_array(power_grid.available_units), 1)

    return context.clone_menu_simulation("nauvis_big_defense", {
        length = 60 * 16,
        init = init
    })
end

return build
