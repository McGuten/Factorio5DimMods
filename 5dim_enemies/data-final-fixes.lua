-- Fix for menu simulation crash when character dies
-- The base game simulation doesn't check if character is valid before accessing it

local menu_simulations = data.raw["utility-constants"]["default"].main_menu_simulations

if menu_simulations and menu_simulations.nauvis_biter_base_laser_defense then
    menu_simulations.nauvis_biter_base_laser_defense.init = [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    logo.destructible = false
    game.simulation.camera_position = {logo.position.x, logo.position.y+9.75}
    center = {logo.position.x, logo.position.y+9.75}
    game.simulation.camera_zoom = 1
    game.tick_paused = false
    game.forces.enemy.set_evolution_factor(0.7)
    game.surfaces[1].peaceful_mode = true
    game.forces.player.research_all_technologies()
    game.surfaces.nauvis.daytime = 0

    local character = game.surfaces[1].create_entity{name = "character", position = {center[1] - 40, center[2] + 20}, force = "player"}
    character.insert{name = "power-armor-mk2"}
    local grid = character.get_inventory(defines.inventory.character_armor)[1].grid
    grid.put{name = "exoskeleton-equipment"}
    grid.put{name = "exoskeleton-equipment"}
    for k = 1, 10 do
      grid.put{name = "personal-laser-defense-equipment"}
      grid.put{name = "energy-shield-mk2-equipment"}
      grid.put{name = "battery-mk2-equipment"}
      grid.put{name = "battery-mk2-equipment"}
    end

    for k, equipment in pairs(grid.equipment) do
      if equipment.max_shield > 0 then equipment.shield = equipment.max_shield end
      equipment.energy = equipment.max_energy
    end

    character.insert{name = "submachine-gun"}
    character.insert{name = "uranium-rounds-magazine", count = 50}

    points =
    {
      {-16, -8},
      {0, -12},
      {16, -8},
      {16, 0},
      {8, 8},
      {60, 8},
    }

    local distance = function(p_1, p_2)
      local dx = (p_1[1] or p_1.x) - (p_2[1] or p_2.x)
      local dy = (p_1[2] or p_1.y) - (p_2[2] or p_2.y)
      return ((dx * dx) + (dy * dy)) ^ 0.5
    end

    local direction = function(p_1, p_2)

      local d_x = (p_2[1] or p_2.x) - (p_1[1] or p_1.x)
      local d_y = (p_2[2] or p_2.y) - (p_1[2] or p_1.y)
      local angle = math.atan2(d_y, d_x)

      local orientation =  (angle / (2 * math.pi)) - 0.25
      if orientation < 0 then orientation = orientation + 1 end

      local direction = math.floor((orientation * 16) + 0.5)
      if direction == 16 then direction = defines.direction.north end
      return direction
    end

    local get_shoot_target = function(entity)
      if not entity.valid then return nil end
      local enemies = entity.surface.find_enemy_units(entity.position, 10)
      local closest = entity.surface.get_closest(entity.position, enemies)
      return closest
    end

    script.on_event(defines.events.on_tick, function()
      if not character.valid then return end
      local k, destination = next(points)
      if not k then return end
      local target = {center[1] + destination[1], center[2] + destination[2]}
      if distance(character.position, target) < 1 then
        points[k] = nil
        return
      end

      if game.tick % 17 == 0 then
        local walking_direction = direction(target, character.position)
        character.walking_state = {walking = true, direction = walking_direction}
      end

      if not (shoot_target and shoot_target.valid) then
        shoot_target = get_shoot_target(character)
      end

      if shoot_target then
        character.shooting_state = {state = defines.shooting.shooting_enemies, position = shoot_target.position}
      else
        character.shooting_state = {state = defines.shooting.not_shooting}
      end

    end)

  ]]
end
