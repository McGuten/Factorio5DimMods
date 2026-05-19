local function build(context)
    local defense = context.defense_line

    local init = [[
    local surface = game.surfaces.nauvis
    local logo = surface.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    if not logo then return end

    logo.destructible = false
    local center = {logo.position.x, logo.position.y + 9.75}
    game.simulation.camera_position = center
    game.simulation.camera_zoom = 1
    game.tick_paused = false
    surface.daytime = 0.9
    surface.peaceful_mode = false
    game.map_settings.steering.moving.force_unit_fuzzy_goto_behavior = true
    game.map_settings.steering.moving.radius = 2
    game.forces.enemy.set_evolution_factor(0.88)
    game.forces.player.research_all_technologies()

    local pick_first = function(candidates)
      return candidates[1]
    end

    local gun_candidates = __DEFENSE_LINE_GUN_CANDIDATES__
    local laser_candidates = __DEFENSE_LINE_LASER_CANDIDATES__
    local flame_candidates = __DEFENSE_LINE_FLAME_CANDIDATES__
    local wall_candidates = __DEFENSE_LINE_WALL_CANDIDATES__
    local gate_candidates = __DEFENSE_LINE_GATE_CANDIDATES__
    local available_units = __DEFENSE_LINE_AVAILABLE_UNITS__

    local clear_existing_enemies = function()
      local entities = surface.find_entities_filtered{position = center, radius = 120, force = "enemy"}
      for _, entity in ipairs(entities) do
        if entity.valid and (entity.type == "unit" or entity.type == "unit-spawner" or entity.type == "turret") then
          entity.destroy()
        end
      end
    end

    clear_existing_enemies()

    local max_active_units = 18
    local spawn_cursor = 1
    local attack_targets = {}

    local fortify = function(entity)
      if not (entity and entity.valid) then
        return
      end

      entity.destructible = false

      if entity.energy ~= nil then
        entity.energy = 100000000
      end
    end

    local prime_defense = function(entity)
      if not (entity and entity.valid) then
        return
      end

      fortify(entity)

      if entity.type == "ammo-turret" then
        local inventory = entity.get_inventory(defines.inventory.turret_ammo)
        if inventory then
          inventory.insert{name = "piercing-rounds-magazine", count = 120}
        end
      elseif entity.type == "fluid-turret" and entity.fluidbox then
        entity.fluidbox[1] = {name = "light-oil", amount = 18000, temperature = 25}
      elseif entity.type == "artillery-turret" then
        local inventory = entity.get_inventory(defines.inventory.artillery_turret_ammo)
        if inventory then
          inventory.insert{name = "artillery-shell", count = 20}
        end
      end
    end

    local place_entity = function(candidates, position, direction)
      local name = pick_first(candidates)
      if not name then
        return nil
      end

      local place_position = surface.find_non_colliding_position(name, position, 8, 0.25)
      if not place_position then
        return nil
      end

      local entity = surface.create_entity{name = name, position = place_position, direction = direction, force = "player"}
      prime_defense(entity)
      return entity
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
          prime_defense(surface.create_entity{name = replacement, position = position, direction = direction, force = "player"})
        end
      end
    end

    replace_entities("gun-turret", gun_candidates)
    replace_entities("laser-turret", laser_candidates)
    replace_entities("flamethrower-turret", flame_candidates)
    replace_entities("stone-wall", wall_candidates)
    replace_entities("gate", gate_candidates)

    for _, entity_name in ipairs({"ammo-turret", "electric-turret", "fluid-turret", "wall", "gate"}) do
      local entities = surface.find_entities_filtered{type = entity_name, force = "player"}
      for _, entity in ipairs(entities) do
        if entity_name == "wall" or entity_name == "gate" then
          fortify(entity)
        else
          prime_defense(entity)
        end
      end
    end

    local is_attack_target = function(entity)
      if not (entity and entity.valid and entity.health and entity.health > 0) then
        return false
      end

      local entity_type = entity.type
      return entity.force and entity.force.name == "player" and (
        entity_type == "ammo-turret" or
        entity_type == "electric-turret" or
        entity_type == "fluid-turret" or
        entity_type == "artillery-turret" or
        entity_type == "wall" or
        entity_type == "gate"
      )
    end

    local refresh_attack_targets = function()
      attack_targets = {}
      local candidates = surface.find_entities_filtered{position = {center[1] + 12, center[2]}, radius = 8, force = "player"}
      for _, entity in ipairs(candidates) do
        if is_attack_target(entity) then
          table.insert(attack_targets, entity)
        end
      end
    end

    local select_target = function()
      if #attack_targets == 0 then
        return nil
      end

      return attack_targets[math.random(#attack_targets)]
    end

    refresh_attack_targets()

    local command_attack = function(unit)
      if not (unit and unit.valid and unit.commandable) then
        return
      end

      local commands = {}
      local target = select_target()
      if target then
        table.insert(commands, {type = defines.command.attack, target = target, distraction = defines.distraction.by_enemy})
      end
      table.insert(commands, {type = defines.command.attack_area, destination = {center[1] + 12, center[2]}, radius = 6, distraction = defines.distraction.by_enemy})
      table.insert(commands, {type = defines.command.go_to_location, destination = {center[1] + 42, center[2]}, distraction = defines.distraction.by_enemy})

      unit.commandable.set_command{
        type = defines.command.compound,
        structure_type = defines.compound_command.return_last,
        commands = commands
      }
    end

    local count_enemy_units = function(radius)
      return #surface.find_entities_filtered{type = "unit", position = center, radius = radius, force = "enemy"}
    end

    local spawn_wave = function(count)
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
        local spawn_anchor = {center[1] - 52 + math.random(-8, 4), center[2] + math.random(-5, 5)}
        local spawn_position = surface.find_non_colliding_position(name, spawn_anchor, 18, 0.5)
        if spawn_position then
          local unit = surface.create_entity{name = name, position = spawn_position, force = "enemy"}
          if unit and unit.speed then
            unit.speed = 0.19 + (math.random() / 18)
          end
          command_attack(unit)
        end
      end
    end

    local rally_enemy_units = function(radius)
      local units = surface.find_entities_filtered{type = "unit", position = center, radius = radius, force = "enemy"}
      for _, unit in ipairs(units) do
        command_attack(unit)
      end
    end

    spawn_wave(math.min(16, #available_units, max_active_units))
    rally_enemy_units(96)

    script.on_nth_tick(60 * 5, function()
      refresh_attack_targets()
      rally_enemy_units(96)
    end)

    script.on_nth_tick(60 * 8, function()
      spawn_wave(3)
    end)
]]

    init = init
        :gsub("__DEFENSE_LINE_GUN_CANDIDATES__", context.to_lua_string_array(defense.gun_candidates), 1)
        :gsub("__DEFENSE_LINE_LASER_CANDIDATES__", context.to_lua_string_array(defense.laser_candidates), 1)
        :gsub("__DEFENSE_LINE_FLAME_CANDIDATES__", context.to_lua_string_array(defense.flame_candidates), 1)
        :gsub("__DEFENSE_LINE_WALL_CANDIDATES__", context.to_lua_string_array(defense.wall_candidates), 1)
        :gsub("__DEFENSE_LINE_GATE_CANDIDATES__", context.to_lua_string_array(defense.gate_candidates), 1)
        :gsub("__DEFENSE_LINE_AVAILABLE_UNITS__", context.to_lua_string_array(defense.available_units), 1)

    return context.clone_menu_simulation("nauvis_big_defense", {
        length = 60 * 18,
        init = init
    })
end

return build