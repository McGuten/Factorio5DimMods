local Common = {}

function Common.apply_base_laser_fix(menu_simulations)
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
end

local function prototype_exists(name, prototype_types)
    for _, prototype_type in ipairs(prototype_types) do
        local prototypes = data.raw[prototype_type]
        if prototypes and prototypes[name] then
            return true
        end
    end

    return false
end

local function filter_simulation_candidates(candidates, prototype_types)
    local result = {}

    for _, name in ipairs(candidates) do
        if prototype_exists(name, prototype_types) then
            table.insert(result, name)
        end
    end

    return result
end

function Common.to_lua_string_array(values)
    local quoted_values = {}

    for _, value in ipairs(values) do
        table.insert(quoted_values, string.format("%q", value))
    end

    return "{" .. table.concat(quoted_values, ", ") .. "}"
end

function Common.create_context(menu_simulations)
    local context = {}

    context.clone_menu_simulation = function(base_name, overrides)
        if not menu_simulations or not menu_simulations[base_name] then
            return nil
        end

        local simulation = table.deepcopy(menu_simulations[base_name])

        for key, value in pairs(overrides) do
            simulation[key] = value
        end

        return simulation
    end

    context.to_lua_string_array = Common.to_lua_string_array

    local all_enemy_spawner_candidates = filter_simulation_candidates({
        "5d-laser-biter-spawner",
        "5d-physical-biter-spawner",
        "5d-impact-biter-spawner",
        "5d-railgun-biter-spawner",
        "5d-fire-spitter-spawner",
        "5d-rocket-spitter-spawner",
        "5d-suicide-spitter-spawner",
        "5d-laser-spitter-spawner",
        "5d-physical-spitter-spawner",
        "5d-poison-spitter-spawner",
        "5d-electric-spitter-spawner",
        "5d-railgun-spitter-spawner",
        "5d-broodmother-biter-spawner",
        "5d-broodmother-spitter-spawner",
        "5d-swarm-biter-spawner",
        "5d-regenerator-biter-spawner",
        "5d-regenerator-spitter-spawner",
        "5d-berserker-biter-spawner",
        "5d-tank-biter-spawner",
        "5d-tank-spitter-spawner",
        "biter-spawner",
        "spitter-spawner"
    }, { "unit-spawner" })

    local all_enemy_unit_candidates = filter_simulation_candidates({
        "5d-normal-biter-t7",
        "5d-laser-biter-t7",
        "5d-physical-biter-t7",
        "5d-impact-biter-t7",
        "5d-broodmother-biter-t7",
        "5d-swarm-biter-t7",
        "5d-regenerator-biter-t7",
        "5d-berserker-biter-t7",
        "5d-tank-biter-t7",
        "5d-railgun-biter-t7",
        "5d-normal-spitter-t7",
        "5d-fire-spitter-t7",
        "5d-rocket-spitter-t7",
        "5d-suicide-spitter-t7",
        "5d-laser-spitter-t7",
        "5d-physical-spitter-t7",
        "5d-poison-spitter-t7",
        "5d-electric-spitter-t7",
        "5d-railgun-spitter-t7",
        "5d-broodmother-spitter-t7",
        "5d-regenerator-spitter-t7",
        "5d-tank-spitter-t7"
    }, { "unit" })

    local breach_enemy_unit_candidates = filter_simulation_candidates({
        "5d-rocket-spitter-t5",
        "5d-suicide-spitter-t5",
        "5d-impact-biter-t5",
        "5d-normal-biter-t5",
        "5d-laser-biter-t5",
        "5d-physical-biter-t5",
        "5d-broodmother-biter-t5",
        "5d-swarm-biter-t5",
        "5d-regenerator-biter-t5",
        "5d-berserker-biter-t5",
        "5d-tank-biter-t5",
        "5d-railgun-biter-t5",
        "5d-normal-spitter-t5",
        "5d-fire-spitter-t5",
        "5d-laser-spitter-t5",
        "5d-physical-spitter-t5",
        "5d-poison-spitter-t5",
        "5d-electric-spitter-t5",
        "5d-railgun-spitter-t5",
        "5d-broodmother-spitter-t5",
        "5d-regenerator-spitter-t5",
        "5d-tank-spitter-t5"
    }, { "unit" })

    context.frontier_assault = {
        spider_candidates = filter_simulation_candidates({
            "5d-spidertron-10",
            "5d-spidertron-9",
            "5d-spidertron-7",
            "spidertron"
        }, { "spider-vehicle" }),
        tesla_effect_candidates = filter_simulation_candidates({
            "tesla-turret-stun",
            "tesla-turret-slow"
        }, { "sticker" }),
        wall_candidates = filter_simulation_candidates({
            "5d-stone-wall-10",
            "5d-stone-wall-08",
            "5d-stone-wall-06",
            "stone-wall"
        }, { "wall" }),
        gate_candidates = filter_simulation_candidates({
            "5d-gate-10",
            "5d-gate-08",
            "5d-gate-06",
            "gate"
        }, { "gate" }),
        gun_candidates = filter_simulation_candidates({
            "5d-gun-turret-09",
            "5d-gun-turret-07",
            "gun-turret"
        }, { "ammo-turret" }),
        laser_candidates = filter_simulation_candidates({
            "5d-laser-turret-10",
            "5d-laser-turret-08",
            "laser-turret"
        }, { "electric-turret" }),
        flame_candidates = filter_simulation_candidates({
            "5d-flamethrower-turret-08",
            "5d-flamethrower-turret-06",
            "flamethrower-turret"
        }, { "fluid-turret" }),
        spawner_candidates = all_enemy_spawner_candidates,
        available_units = all_enemy_unit_candidates
    }

    context.defense_line = {
        gun_candidates = filter_simulation_candidates({
            "5d-gun-turret-05",
            "5d-gun-turret-04",
            "5d-gun-turret-03",
            "gun-turret"
        }, { "ammo-turret" }),
        laser_candidates = filter_simulation_candidates({
            "5d-laser-turret-05",
            "5d-laser-turret-04",
            "5d-laser-turret-03",
            "laser-turret"
        }, { "electric-turret" }),
        flame_candidates = filter_simulation_candidates({
            "5d-flamethrower-turret-05",
            "5d-flamethrower-turret-04",
            "5d-flamethrower-turret-03",
            "flamethrower-turret"
        }, { "fluid-turret" }),
        wall_candidates = filter_simulation_candidates({
            "5d-stone-wall-08",
            "5d-stone-wall-08",
            "5d-stone-wall-06",
            "stone-wall"
        }, { "wall" }),
        gate_candidates = filter_simulation_candidates({
            "5d-gate-08",
            "5d-gate-08",
            "5d-gate-06",
            "gate"
        }, { "gate" }),
        artillery_candidates = filter_simulation_candidates({
            "5d-artillery-turret-06",
            "5d-artillery-turret-04",
            "artillery-turret"
        }, { "artillery-turret" }),
        spawner_candidates = filter_simulation_candidates({
            "5d-tank-biter-spawner",
            "5d-laser-biter-spawner",
            "5d-regenerator-biter-spawner",
            "5d-berserker-biter-spawner",
            "5d-poison-spitter-spawner",
            "5d-electric-spitter-spawner",
            "5d-fire-spitter-spawner",
            "5d-rocket-spitter-spawner",
            "biter-spawner",
            "spitter-spawner"
        }, { "unit-spawner" }),
        available_units = #breach_enemy_unit_candidates > 0 and breach_enemy_unit_candidates or all_enemy_unit_candidates
    }

    context.power_grid = {
        wall_candidates = filter_simulation_candidates({
            "5d-stone-wall-08",
            "5d-stone-wall-06",
            "stone-wall"
        }, { "wall" }),
        gate_candidates = filter_simulation_candidates({
            "5d-gate-08",
            "5d-gate-06",
            "gate"
        }, { "gate" }),
        gun_candidates = filter_simulation_candidates({
            "5d-gun-turret-04",
            "5d-gun-turret-03",
            "gun-turret"
        }, { "ammo-turret" }),
        laser_candidates = filter_simulation_candidates({
            "5d-laser-turret-05",
            "5d-laser-turret-04",
            "5d-laser-turret-03",
            "laser-turret"
        }, { "electric-turret" }),
        flame_candidates = filter_simulation_candidates({
            "5d-flamethrower-turret-04",
            "5d-flamethrower-turret-03",
            "flamethrower-turret"
        }, { "fluid-turret" }),
        artillery_candidates = filter_simulation_candidates({
            "5d-artillery-turret-04",
            "5d-artillery-turret-03",
            "artillery-turret"
        }, { "artillery-turret" }),
        spawner_candidates = context.frontier_assault.spawner_candidates,
        available_units = all_enemy_unit_candidates
    }

    context.perimeter_breach = {
        gun_candidates = filter_simulation_candidates({
            "gun-turret"
        }, { "ammo-turret" }),
        laser_candidates = filter_simulation_candidates({
            "laser-turret"
        }, { "electric-turret" }),
        flame_candidates = filter_simulation_candidates({
            "flamethrower-turret"
        }, { "fluid-turret" }),
        wall_candidates = filter_simulation_candidates({
            "stone-wall"
        }, { "wall" }),
        gate_candidates = filter_simulation_candidates({
            "gate"
        }, { "gate" }),
        available_units = #breach_enemy_unit_candidates > 0 and breach_enemy_unit_candidates or all_enemy_unit_candidates
    }

    return context
end

return Common
