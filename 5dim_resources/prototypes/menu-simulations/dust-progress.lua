local function prototype_exists(name, prototype_types)
    for _, prototype_type in ipairs(prototype_types) do
        local prototypes = data.raw[prototype_type]
        if prototypes and prototypes[name] then
            return true
        end
    end

    return false
end

local function filter_candidates(candidates, prototype_types)
    local result = {}

    for _, name in ipairs(candidates) do
        if prototype_exists(name, prototype_types) then
            table.insert(result, name)
        end
    end

    return result
end

local function to_lua_string_array(values)
    local quoted_values = {}

    for _, value in ipairs(values) do
        table.insert(quoted_values, string.format("%q", value))
    end

    return "{" .. table.concat(quoted_values, ", ") .. "}"
end

local function build(_menu_simulations)

    local masher_candidates = filter_candidates({
        "5d-masher-03",
        "5d-masher-04",
        "5d-masher-02",
        "5d-masher-01"
    }, { "furnace" })
    local industrial_furnace_candidates = filter_candidates({
        "5d-industrial-furnace"
    }, { "furnace" })
    local belt_candidates = filter_candidates({
        "express-transport-belt",
      "fast-transport-belt",
        "transport-belt"
    }, { "transport-belt" })
    local splitter_candidates = filter_candidates({
      "express-splitter",
      "fast-splitter",
      "splitter"
    }, { "splitter" })
    local inserter_candidates = filter_candidates({
      "5d-inserter-03",
      "fast-inserter",
      "inserter"
    }, { "inserter" })
    local bulk_inserter_candidates = filter_candidates({
      "5d-bulk-inserter-03",
      "bulk-inserter",
      "stack-inserter",
      "fast-inserter",
      "inserter"
    }, { "inserter" })
    local chest_candidates = filter_candidates({
        "steel-chest",
        "iron-chest",
        "wooden-chest"
    }, { "container" })
    local pole_candidates = filter_candidates({
        "substation",
        "big-electric-pole",
        "medium-electric-pole"
    }, { "electric-pole" })
    local solar_candidates = filter_candidates({
      "solar-panel"
    }, { "solar-panel" })
    local accumulator_candidates = filter_candidates({
      "accumulator"
    }, { "accumulator" })
    local power_interface_candidates = filter_candidates({
        "hidden-electric-energy-interface",
        "electric-energy-interface"
    }, { "electric-energy-interface" })
    local iron_ore_candidates = filter_candidates({
        "iron-ore"
    }, { "item" })
    local iron_dust_candidates = filter_candidates({
        "5d-iron-dust"
    }, { "item" })
    local iron_plate_candidates = filter_candidates({
        "iron-plate"
    }, { "item" })
    local copper_ore_candidates = filter_candidates({
      "copper-ore"
    }, { "item" })
    local copper_dust_candidates = filter_candidates({
      "5d-copper-dust"
    }, { "item" })
    local copper_plate_candidates = filter_candidates({
      "copper-plate"
    }, { "item" })

    if #masher_candidates == 0 or #industrial_furnace_candidates == 0 or #belt_candidates == 0 or #inserter_candidates == 0 or #bulk_inserter_candidates == 0 or #chest_candidates == 0 then
        return nil
    end

    if #iron_ore_candidates == 0 or #iron_dust_candidates == 0 or #iron_plate_candidates == 0 then
        return nil
    end

    if #copper_ore_candidates == 0 or #copper_dust_candidates == 0 or #copper_plate_candidates == 0 then
      return nil
    end

    local init = [[
    local surface = game.surfaces.nauvis
    local logo = surface.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    if not logo then return end

    logo.destructible = false
    local center = {logo.position.x, logo.position.y + 9.75}
    game.simulation.camera_position = center
    game.simulation.camera_zoom = 0.78
    game.tick_paused = false
    surface.daytime = 0.72
    surface.peaceful_mode = true
    game.forces.player.research_all_technologies()

    local masher_candidates = __DUST_PROGRESS_MASHER_CANDIDATES__
    local industrial_furnace_candidates = __DUST_PROGRESS_INDUSTRIAL_FURNACE_CANDIDATES__
    local belt_candidates = __DUST_PROGRESS_BELT_CANDIDATES__
    local splitter_candidates = __DUST_PROGRESS_SPLITTER_CANDIDATES__
    local inserter_candidates = __DUST_PROGRESS_INSERTER_CANDIDATES__
    local bulk_inserter_candidates = __DUST_PROGRESS_BULK_INSERTER_CANDIDATES__
    local chest_candidates = __DUST_PROGRESS_CHEST_CANDIDATES__
    local pole_candidates = __DUST_PROGRESS_POLE_CANDIDATES__
    local solar_candidates = __DUST_PROGRESS_SOLAR_CANDIDATES__
    local accumulator_candidates = __DUST_PROGRESS_ACCUMULATOR_CANDIDATES__
    local power_interface_candidates = __DUST_PROGRESS_POWER_INTERFACE_CANDIDATES__
    local iron_ore_candidates = __DUST_PROGRESS_IRON_ORE_CANDIDATES__
    local iron_dust_candidates = __DUST_PROGRESS_IRON_DUST_CANDIDATES__
    local iron_plate_candidates = __DUST_PROGRESS_IRON_PLATE_CANDIDATES__
    local copper_ore_candidates = __DUST_PROGRESS_COPPER_ORE_CANDIDATES__
    local copper_dust_candidates = __DUST_PROGRESS_COPPER_DUST_CANDIDATES__
    local copper_plate_candidates = __DUST_PROGRESS_COPPER_PLATE_CANDIDATES__

    local pick_first = function(candidates)
      return candidates[1]
    end

    local pick_from = function(candidates, index)
      return candidates[math.min(index, #candidates)]
    end

    local clear_scene_area = function()
      local entities = surface.find_entities_filtered{position = center, radius = 84}
      for _, entity in ipairs(entities) do
        if entity.valid and entity.name ~= "factorio-logo-11tiles" then
          if entity.force and (entity.force.name == "player" or entity.force.name == "enemy") then
            entity.destroy()
          end
        end
      end
    end

    clear_scene_area()

    local belt_name = pick_first(belt_candidates)
    local splitter_name = pick_first(splitter_candidates)
    local inserter_name = pick_first(inserter_candidates)
    local bulk_inserter_name = pick_first(bulk_inserter_candidates)
    local chest_name = pick_first(chest_candidates)
    local pole_name = pick_first(pole_candidates)
    local solar_name = pick_first(solar_candidates)
    local accumulator_name = pick_first(accumulator_candidates)
    local power_interface_name = pick_first(power_interface_candidates)
    local masher_name = pick_first(masher_candidates)
    local industrial_furnace_name = pick_first(industrial_furnace_candidates)
    local iron_ore_name = pick_first(iron_ore_candidates)
    local iron_dust_name = pick_first(iron_dust_candidates)
    local iron_plate_name = pick_first(iron_plate_candidates)
    local copper_ore_name = pick_first(copper_ore_candidates)
    local copper_dust_name = pick_first(copper_dust_candidates)
    local copper_plate_name = pick_first(copper_plate_candidates)

    if not (belt_name and inserter_name and bulk_inserter_name and chest_name and masher_name and industrial_furnace_name and copper_ore_name and copper_dust_name and copper_plate_name) then
      return
    end

    local powered_entities = {}

    local create_entity = function(name, position, direction)
      local entity = surface.create_entity{name = name, position = position, direction = direction, force = "player"}
      if entity and entity.energy ~= nil then
        entity.energy = 100000000
        table.insert(powered_entities, entity)
      end
      return entity
    end

    local create_belt_row = function(start_x, finish_x, y)
      local belts = {}
      for x = start_x, finish_x do
        table.insert(belts, create_entity(belt_name, {center[1] + x, y}, defines.direction.east))
      end
      return belts
    end

    local create_belt = function(x, y, direction)
      return create_entity(belt_name, {center[1] + x, y}, direction or defines.direction.east)
    end

    local create_splitter = function(x, y, direction)
      if not splitter_name then
        return nil
      end

      return create_entity(splitter_name, {center[1] + x, y}, direction or defines.direction.east)
    end

    local build_power_strip = function(y)
      local pole_offsets = {-10, 5, 18, 30}

      if pole_name then
        for _, x in ipairs(pole_offsets) do
          create_entity(pole_name, {center[1] + x, y})
        end
      end

      if power_interface_name then
        create_entity(power_interface_name, {center[1] + 5, y})
        create_entity(power_interface_name, {center[1] + 18, y})
      end
    end

    local build_line = function(y_offset, masher_name, ore_name, dust_name, plate_name)
      local y = center[2] + y_offset
      local transfer_direction = defines.direction.west
      local source_chest = create_entity(chest_name, {center[1] - 13.5, y})
      local source_inserter = create_entity(inserter_name, {center[1] - 12.5, y}, transfer_direction)
      local input_belts = create_belt_row(-11.5, 2.5, y)
      local input_inserter = create_entity(inserter_name, {center[1] + 3.5, y}, transfer_direction)
      local masher = create_entity(masher_name, {center[1] + 5.5, y})
      local output_inserter = create_entity(bulk_inserter_name, {center[1] + 7.5, y}, transfer_direction)
      local dust_belts = {create_belt(8.5, y)}
      create_splitter(9.5, y - 0.5, defines.direction.east)
      create_belt(10.5, y - 1, defines.direction.south)
      for x = 10.5, 13.5 do
        table.insert(dust_belts, create_belt(x, y))
      end
      local furnace_input_inserter = create_entity(bulk_inserter_name, {center[1] + 14.5, y}, transfer_direction)
      local industrial_furnace = create_entity(industrial_furnace_name, {center[1] + 17.5, y})
      local furnace_output_inserter = create_entity(bulk_inserter_name, {center[1] + 20.5, y}, transfer_direction)
      local output_belts = {create_belt(21.5, y)}
      create_splitter(22.5, y - 0.5, defines.direction.east)
      create_belt(23.5, y - 1, defines.direction.south)
      for x = 23.5, 30.5 do
        table.insert(output_belts, create_belt(x, y))
      end
      local sink_inserter = create_entity(inserter_name, {center[1] + 31.5, y}, transfer_direction)
      local output_chest = create_entity(chest_name, {center[1] + 32.5, y})

      return {
        ore = ore_name,
        dust = dust_name,
        plate = plate_name,
        source_chest = source_chest,
        source_inserter = source_inserter,
        input_belts = input_belts,
        input_inserter = input_inserter,
        masher = masher,
        output_inserter = output_inserter,
        dust_belts = dust_belts,
        dust_tail_belt = dust_belts[#dust_belts],
        furnace_input_inserter = furnace_input_inserter,
        industrial_furnace = industrial_furnace,
        furnace_output_inserter = furnace_output_inserter,
        output_belts = output_belts,
        output_tail_belt = output_belts[#output_belts],
        sink_inserter = sink_inserter,
        output_chest = output_chest,
        input_tail_belt = input_belts[#input_belts],
        input_head_belt = input_belts[1],
        dust_head_belt = dust_belts[1],
        output_head_belt = output_belts[1]
      }
    end

    build_power_strip(center[2] + 0.5)

    local copper_line = build_line(-5, masher_name, copper_ore_name, copper_dust_name, copper_plate_name)
    local iron_line = build_line(6, masher_name, iron_ore_name, iron_dust_name, iron_plate_name)
    local lines = {copper_line, iron_line}

    local prime_line = function(line)
      if line.source_chest and line.source_chest.valid then
        local inventory = line.source_chest.get_inventory(defines.inventory.chest)
        if inventory then
          inventory.insert{name = line.ore, count = 1000}
        end
      end

      if line.masher and line.masher.valid then
        local source_inventory = line.masher.get_inventory(defines.inventory.furnace_source)
        if source_inventory then
          source_inventory.insert{name = line.ore, count = 50}
        end

        local result_inventory = line.masher.get_inventory(defines.inventory.furnace_result)
        if result_inventory then
          result_inventory.clear()
        end
      end

      if line.industrial_furnace and line.industrial_furnace.valid then
        local source_inventory = line.industrial_furnace.get_inventory(defines.inventory.furnace_source)
        if source_inventory then
          source_inventory.insert{name = line.dust, count = 170}
        end

        local result_inventory = line.industrial_furnace.get_inventory(defines.inventory.furnace_result)
        if result_inventory then
          result_inventory.clear()
        end
      end
    end

    local prime_scene = function()
      for _, line in ipairs(lines) do
        prime_line(line)
      end
    end

    prime_scene()
]]

    init = init
        :gsub("__DUST_PROGRESS_MASHER_CANDIDATES__", to_lua_string_array(masher_candidates), 1)
        :gsub("__DUST_PROGRESS_INDUSTRIAL_FURNACE_CANDIDATES__", to_lua_string_array(industrial_furnace_candidates), 1)
        :gsub("__DUST_PROGRESS_BELT_CANDIDATES__", to_lua_string_array(belt_candidates), 1)
        :gsub("__DUST_PROGRESS_SPLITTER_CANDIDATES__", to_lua_string_array(splitter_candidates), 1)
        :gsub("__DUST_PROGRESS_INSERTER_CANDIDATES__", to_lua_string_array(inserter_candidates), 1)
        :gsub("__DUST_PROGRESS_BULK_INSERTER_CANDIDATES__", to_lua_string_array(bulk_inserter_candidates), 1)
        :gsub("__DUST_PROGRESS_CHEST_CANDIDATES__", to_lua_string_array(chest_candidates), 1)
        :gsub("__DUST_PROGRESS_POLE_CANDIDATES__", to_lua_string_array(pole_candidates), 1)
        :gsub("__DUST_PROGRESS_SOLAR_CANDIDATES__", to_lua_string_array(solar_candidates), 1)
        :gsub("__DUST_PROGRESS_ACCUMULATOR_CANDIDATES__", to_lua_string_array(accumulator_candidates), 1)
        :gsub("__DUST_PROGRESS_POWER_INTERFACE_CANDIDATES__", to_lua_string_array(power_interface_candidates), 1)
        :gsub("__DUST_PROGRESS_IRON_ORE_CANDIDATES__", to_lua_string_array(iron_ore_candidates), 1)
        :gsub("__DUST_PROGRESS_IRON_DUST_CANDIDATES__", to_lua_string_array(iron_dust_candidates), 1)
        :gsub("__DUST_PROGRESS_IRON_PLATE_CANDIDATES__", to_lua_string_array(iron_plate_candidates), 1)
        :gsub("__DUST_PROGRESS_COPPER_ORE_CANDIDATES__", to_lua_string_array(copper_ore_candidates), 1)
        :gsub("__DUST_PROGRESS_COPPER_DUST_CANDIDATES__", to_lua_string_array(copper_dust_candidates), 1)
        :gsub("__DUST_PROGRESS_COPPER_PLATE_CANDIDATES__", to_lua_string_array(copper_plate_candidates), 1)

    return {
      checkboard = false,
      save = "__base__/menu-simulations/menu-simulation-early-smelting.zip",
      length = 60 * 18,
      init = init,
      update = [[
    ]]
    }
end

return build