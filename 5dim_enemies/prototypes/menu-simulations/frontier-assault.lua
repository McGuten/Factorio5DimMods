local function build(context)
    local frontier = context.frontier_assault

    local init = [[
    local surface = game.surfaces.nauvis
    local logo = surface.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    if not logo then return end

    logo.destructible = false
    local center = {logo.position.x, logo.position.y + 9.75}
    game.simulation.camera_position = center
    game.simulation.camera_zoom = 1
    game.tick_paused = false
    surface.daytime = 0.08
    surface.peaceful_mode = false
    game.map_settings.steering.moving.force_unit_fuzzy_goto_behavior = true
    game.map_settings.steering.moving.radius = 2
    game.forces.enemy.set_evolution_factor(0.78)
    game.forces.player.research_all_technologies()

    local spider_candidates = __FRONTIER_ASSAULT_SPIDER_CANDIDATES__
    local tesla_effect_candidates = __FRONTIER_ASSAULT_TESLA_EFFECT_CANDIDATES__
    local spawner_candidates = __FRONTIER_ASSAULT_SPAWNER_CANDIDATES__
    local available_units = __FRONTIER_ASSAULT_AVAILABLE_UNITS__

    local pick_first = function(candidates)
      return candidates[1]
    end

    local cleanup_names = {
      ["solar-panel"] = true,
      ["accumulator"] = true,
      ["big-electric-pole"] = true,
      ["medium-electric-pole"] = true,
      ["small-electric-pole"] = true,
      ["substation"] = true,
      ["radar"] = true,
      ["gun-turret"] = true,
      ["laser-turret"] = true,
      ["flamethrower-turret"] = true,
      ["stone-wall"] = true,
      ["gate"] = true,
    }

    local clear_player_infrastructure = function()
      local entities = surface.find_entities_filtered{position = center, radius = 96}
      for _, entity in ipairs(entities) do
        if entity.valid and entity.name ~= "factorio-logo-11tiles" then
          local is_player_entity = entity.force and entity.force.name == "player"
          if cleanup_names[entity.name] or is_player_entity then
            entity.destroy()
          end
        end
      end
    end

    clear_player_infrastructure()

    local replace_enemy_entities = function(entity_type, candidates, radius)
      if #candidates == 0 then
        return
      end

      local entities = surface.find_entities_filtered{type = entity_type, position = center, radius = radius, force = "enemy"}
      table.sort(entities, function(a, b)
        if a.position.x == b.position.x then
          return a.position.y < b.position.y
        end
        return a.position.x < b.position.x
      end)

      for index, entity in ipairs(entities) do
        if entity.valid then
          local replacement = candidates[((index - 1) % #candidates) + 1]
          local position = surface.find_non_colliding_position(replacement, entity.position, 3, 0.25) or entity.position
          local direction = entity.direction
          entity.destroy()
          surface.create_entity{name = replacement, position = position, direction = direction, force = "enemy"}
        end
      end
    end

    replace_enemy_entities("unit-spawner", spawner_candidates, 48)
    replace_enemy_entities("unit", available_units, 40)

    local spider_name = pick_first(spider_candidates)
    if not spider_name then return end

    local spider_position = surface.find_non_colliding_position(spider_name, {center[1] - 28, center[2] + 2}, 8, 0.25) or {center[1] - 28, center[2] + 2}
    local spider = surface.create_entity{name = spider_name, position = spider_position, force = "player"}
    if not spider then return end

    spider.insert{name = "explosive-rocket", count = 700}

    if spider.grid then
      local add_equipment = function(name, count)
        for index = 1, count do
          if not spider.grid.put{name = name} then
            break
          end
        end
      end

      add_equipment("fission-reactor-equipment", 3)
      add_equipment("personal-laser-defense-equipment", 10)
      add_equipment("energy-shield-mk2-equipment", 8)
      add_equipment("battery-mk2-equipment", 6)
      add_equipment("exoskeleton-equipment", 2)

      for _, equipment in pairs(spider.grid.equipment) do
        if equipment.max_shield > 0 then equipment.shield = equipment.max_shield end
        equipment.energy = equipment.max_energy
      end
    end

    local fallback_points =
    {
      {-10, -10},
      {4, -10},
      {18, -4},
      {28, 4},
      {34, 10},
      {22, 12},
    }

    local points = {}

    local rebuild_spider_points = function()
      points = {}

      local spawners = surface.find_entities_filtered{type = "unit-spawner", position = center, radius = 56, force = "enemy"}
      table.sort(spawners, function(a, b)
        if a.position.x == b.position.x then
          return a.position.y < b.position.y
        end
        return a.position.x < b.position.x
      end)

      for _, spawner in ipairs(spawners) do
        if spawner.valid then
          table.insert(points, {spawner.position.x - center[1], spawner.position.y - center[2]})
        end
      end

      if #points == 0 then
        for _, point in ipairs(fallback_points) do
          table.insert(points, point)
        end
      end
    end

    local advance_spider = function()
      if #points == 0 then
        rebuild_spider_points()
      end

      local k, destination = next(points)
      if not k then
        rebuild_spider_points()
        k, destination = next(points)
      end
      if not (k and destination and spider.valid) then return end
      points[k] = nil
      spider.autopilot_destination = {center[1] + destination[1], center[2] + destination[2]}
    end

    advance_spider()

    script.on_event(defines.events.on_spider_command_completed, function()
      if spider.valid then
        advance_spider()
      end
    end)

    local command_attack = function(unit)
      if not (unit and unit.valid and unit.commandable) then
        return
      end
      local commands = {}
      if spider.valid then
        table.insert(commands, {type = defines.command.attack, target = spider})
      end
      table.insert(commands, {type = defines.command.attack_area, destination = {center[1] + 14, center[2]}, radius = 9})
      table.insert(commands, {type = defines.command.go_to_location, destination = {center[1] + 32, center[2]}})

      unit.commandable.set_command{
        type = defines.command.compound,
        structure_type = defines.compound_command.return_last,
        commands = commands
      }
    end

    local cast_tesla = function()
      if not (spider.valid and #tesla_effect_candidates > 0) then
        return
      end

      local enemies = surface.find_enemy_units(spider.position, 18)
      local target = surface.get_closest(spider.position, enemies)
      if not (target and target.valid) then
        return
      end

      local effect_name = tesla_effect_candidates[((game.tick / 30) % #tesla_effect_candidates) + 1]
      surface.create_entity{name = effect_name, position = spider.position, target = target}
    end

    local rally_enemy_units = function(radius)
      local units = surface.find_entities_filtered{type = "unit", position = center, radius = radius, force = "enemy"}
      for _, unit in ipairs(units) do
        command_attack(unit)
      end
    end

    local spawn_wave = function(count, spread)
      if #available_units == 0 then
        return
      end

      for wave = 1, count do
        local name = available_units[((wave - 1) % #available_units) + 1]
        local spawn_anchor = {center[1] + 20 + math.random(0, 18), center[2] + math.random(-(spread or 12), spread or 12)}
        local spawn_position = surface.find_non_colliding_position(name, spawn_anchor, 16, 0.5)
        if spawn_position then
          local unit = surface.create_entity{name = name, position = spawn_position, force = "enemy"}
          if unit and unit.speed then
            unit.speed = unit.speed * (0.92 + (math.random() * 0.16))
          end
          command_attack(unit)
        end
      end
    end

    rally_enemy_units(52)
    spawn_wave(#available_units, 10)

    script.on_nth_tick(60 * 2, function()
      if spider.valid then
        rally_enemy_units(52)
        if not spider.autopilot_destination then
          advance_spider()
        end
      end
    end)

    script.on_nth_tick(30, function()
      cast_tesla()
    end)

    script.on_nth_tick(60 * 4, function()
      if spider.valid then
        spawn_wave(3, 8)
      end
    end)
]]

    init = init
        :gsub("__FRONTIER_ASSAULT_SPIDER_CANDIDATES__", context.to_lua_string_array(frontier.spider_candidates), 1)
        :gsub("__FRONTIER_ASSAULT_TESLA_EFFECT_CANDIDATES__", context.to_lua_string_array(frontier.tesla_effect_candidates), 1)
        :gsub("__FRONTIER_ASSAULT_SPAWNER_CANDIDATES__", context.to_lua_string_array(frontier.spawner_candidates), 1)
        :gsub("__FRONTIER_ASSAULT_AVAILABLE_UNITS__", context.to_lua_string_array(frontier.available_units), 1)

    return context.clone_menu_simulation("nauvis_biter_base_laser_defense", {
        length = 60 * 14,
        init = init
    })
end

return build
