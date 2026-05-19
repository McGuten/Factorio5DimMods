local function build(context)
    local breach = context.perimeter_breach

    local init = [[
    local surface = game.surfaces.nauvis
    local logo = surface.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    if not logo then return end

    logo.destructible = false
    local center = {logo.position.x, logo.position.y + 9.75}
    game.simulation.camera_position = center
    game.simulation.camera_zoom = 1
    game.tick_paused = false
    surface.daytime = 0.95
    surface.peaceful_mode = false
    game.map_settings.steering.moving.force_unit_fuzzy_goto_behavior = true
    game.map_settings.steering.moving.radius = 2
    game.forces.enemy.set_evolution_factor(0.65)
    game.forces.player.research_all_technologies()

    local pick_first = function(candidates)
      return candidates[1]
    end

    local gun_candidates = __PERIMETER_BREACH_GUN_CANDIDATES__
    local laser_candidates = __PERIMETER_BREACH_LASER_CANDIDATES__
    local flame_candidates = __PERIMETER_BREACH_FLAME_CANDIDATES__
    local wall_candidates = __PERIMETER_BREACH_WALL_CANDIDATES__
    local gate_candidates = __PERIMETER_BREACH_GATE_CANDIDATES__
    local available_units = __PERIMETER_BREACH_AVAILABLE_UNITS__

    local clear_existing_enemies = function()
      local entities = surface.find_entities_filtered{position = center, radius = 120, force = "enemy"}
      for _, entity in ipairs(entities) do
        if entity.valid and (entity.type == "unit" or entity.type == "unit-spawner" or entity.type == "turret") then
          entity.destroy()
        end
      end
    end

    clear_existing_enemies()

    local prime_defense = function(entity)
      if not (entity and entity.valid) then
        return
      end

      if entity.energy ~= nil then
        entity.energy = math.max(entity.energy or 0, 1200000)
      end

      if entity.type == "ammo-turret" then
        local inventory = entity.get_inventory(defines.inventory.turret_ammo)
        if inventory then
          inventory.insert{name = "piercing-rounds-magazine", count = 45}
        end
      elseif entity.type == "fluid-turret" and entity.fluidbox then
        entity.fluidbox[1] = {name = "light-oil", amount = 7000, temperature = 25}
      end
    end

    local replace_entities = function(from_name, candidates)
      if #candidates == 0 then
        return
      end

      local entities = surface.find_entities_filtered{name = from_name, force = "player"}
      table.sort(entities, function(a, b)
        if a.position.y == b.position.y then
          return a.position.x < b.position.x
        end
        return a.position.y < b.position.y
      end)

      for index, entity in ipairs(entities) do
        if entity.valid then
          local replacement = candidates[((index - 1) % #candidates) + 1]
          local position = entity.position
          local direction = entity.direction
          entity.destroy()
          local new_entity = surface.create_entity{name = replacement, position = position, direction = direction, force = "player"}
          prime_defense(new_entity)
        end
      end
    end

    replace_entities("gun-turret", gun_candidates)
    replace_entities("laser-turret", laser_candidates)
    replace_entities("flamethrower-turret", flame_candidates)
    replace_entities("stone-wall", wall_candidates)
    replace_entities("gate", gate_candidates)

    local gate_positions = {}
    for _, entity in ipairs(surface.find_entities_filtered{type = "gate", force = "player"}) do
      table.insert(gate_positions, {position = entity.position, direction = entity.direction})
    end

    for _, entity_type in ipairs({"ammo-turret", "electric-turret", "fluid-turret"}) do
      local entities = surface.find_entities_filtered{type = entity_type, force = "player"}
      for _, entity in ipairs(entities) do
        prime_defense(entity)
      end
    end

    local thin_defenses = function(entity_type, keep_pattern)
      local entities = surface.find_entities_filtered{type = entity_type, force = "player"}
      table.sort(entities, function(a, b)
        if a.position.y == b.position.y then
          return a.position.x < b.position.x
        end
        return a.position.y < b.position.y
      end)

      for index, entity in ipairs(entities) do
        if entity.valid and not keep_pattern(index, #entities) then
          entity.destroy()
        end
      end
    end

    thin_defenses("electric-turret", function(index, count)
      return index == math.ceil(count / 2)
    end)

    thin_defenses("ammo-turret", function(index, count)
      return index == math.ceil(count / 2)
    end)

    thin_defenses("fluid-turret", function(index)
      return false
    end)

    thin_defenses("wall", function(index)
      return true
    end)

    for _, entity in ipairs(surface.find_entities_filtered{type = "gate", force = "player"}) do
      if entity.valid then
        entity.destroy()
      end
    end

    local breach_point = {center[1] + 16, center[2]}
    local interior_point = {center[1] + 26, center[2]}
    local exit_point = {center[1] + 36, center[2]}
    local max_active_units = 22
    local spawn_cursor = 1
    local attack_targets = {}

    local is_attack_target = function(entity)
      if not (entity and entity.valid and entity.health and entity.health > 0) then
        return false
      end

      if not (entity.force and entity.force.name == "player") then
        return false
      end

      return entity.type == "wall" or
        entity.type == "gate" or
        entity.type == "ammo-turret" or
        entity.type == "electric-turret" or
        entity.type == "fluid-turret" or
        entity.type == "artillery-turret"
    end

    local select_attack_target = function(unit)
      local closest = nil
      local closest_distance = nil
      for _, entity in ipairs(attack_targets) do
        if is_attack_target(entity) then
          local distance = ((entity.position.x - unit.position.x) ^ 2) + ((entity.position.y - unit.position.y) ^ 2)
          if not closest_distance or distance < closest_distance then
            closest = entity
            closest_distance = distance
          end
        end
      end

      return closest
    end

    local refresh_attack_targets = function()
      attack_targets = {}
      local corridor = surface.find_entities_filtered{area = {{center[1] + 8, center[2] - 9}, {center[1] + 36, center[2] + 9}}, force = "player"}
      for _, entity in ipairs(corridor) do
        if is_attack_target(entity) then
          table.insert(attack_targets, entity)
        end
      end
    end

    refresh_attack_targets()

    local command_attack = function(unit)
      if not (unit and unit.valid and unit.commandable) then
        return
      end

      local commands = {}
      local target = select_attack_target(unit)
      if target then
        table.insert(commands, {type = defines.command.attack, target = target, distraction = defines.distraction.by_enemy})
      end
      table.insert(commands, {type = defines.command.attack_area, destination = breach_point, radius = 7, distraction = defines.distraction.by_enemy})
      table.insert(commands, {type = defines.command.attack_area, destination = interior_point, radius = 10, distraction = defines.distraction.by_enemy})
      table.insert(commands, {type = defines.command.go_to_location, destination = exit_point, radius = 2, distraction = defines.distraction.by_enemy})

      unit.commandable.set_command{
        type = defines.command.compound,
        structure_type = defines.compound_command.return_last,
        commands = commands
      }
    end

    local count_enemy_units = function(radius)
      return #surface.find_entities_filtered{type = "unit", position = center, radius = radius, force = "enemy"}
    end

    local rally_enemy_units = function(radius, limit)
      local units = surface.find_entities_filtered{type = "unit", position = center, radius = radius, force = "enemy"}
      local commanded = 0
      for _, unit in ipairs(units) do
        if limit and commanded >= limit then
          return
        end
        command_attack(unit)
        commanded = commanded + 1
      end
    end

    local spawn_wave = function(count, spread)
      if #available_units == 0 then
        return
      end

      local available_slots = max_active_units - count_enemy_units(110)
      if available_slots <= 0 then
        return
      end

      local spawn_count = math.min(count, available_slots)
      for wave = 1, spawn_count do
        local name = available_units[spawn_cursor]
        spawn_cursor = (spawn_cursor % #available_units) + 1
        local spawn_anchor = {center[1] - 46 + math.random(-8, 4), center[2] + math.random(-(spread or 3), spread or 3)}
        local spawn_position = surface.find_non_colliding_position(name, spawn_anchor, 18, 0.5)
        if spawn_position then
          local unit = surface.create_entity{name = name, position = spawn_position, force = "enemy"}
          if unit and unit.speed then
            unit.speed = 0.22 + (math.random() / 10)
          end
          command_attack(unit)
        end
      end
    end

    spawn_wave(math.min(20, #available_units, max_active_units), 3)
    rally_enemy_units(88, 18)

    script.on_nth_tick(60 * 5, function()
      refresh_attack_targets()
      rally_enemy_units(88, 18)
    end)

    script.on_nth_tick(60 * 8, function()
      spawn_wave(3, 3)
    end)
]]

    init = init
        :gsub("__PERIMETER_BREACH_GUN_CANDIDATES__", context.to_lua_string_array(breach.gun_candidates), 1)
        :gsub("__PERIMETER_BREACH_LASER_CANDIDATES__", context.to_lua_string_array(breach.laser_candidates), 1)
        :gsub("__PERIMETER_BREACH_FLAME_CANDIDATES__", context.to_lua_string_array(breach.flame_candidates), 1)
        :gsub("__PERIMETER_BREACH_WALL_CANDIDATES__", context.to_lua_string_array(breach.wall_candidates), 1)
        :gsub("__PERIMETER_BREACH_GATE_CANDIDATES__", context.to_lua_string_array(breach.gate_candidates), 1)
        :gsub("__PERIMETER_BREACH_AVAILABLE_UNITS__", context.to_lua_string_array(breach.available_units), 1)

    return context.clone_menu_simulation("nauvis_big_defense", {
        length = 60 * 18,
        init = init
    })
end

return build