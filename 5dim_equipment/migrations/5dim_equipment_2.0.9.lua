-- Migration for 5dim_equipment 2.0.9
-- Converts 5d-battery-equipment-03 to battery-mk3-equipment when Space Age is active
-- This handles the case where tier 3 battery is now the vanilla Space Age item

-- Only run if Space Age is active
if script.active_mods["space-age"] then
    -- Map old item names to new item names
    local item_migrations = {
        ["5d-battery-equipment-03"] = "battery-mk3-equipment"
    }
    
    -- Map old technology names to new technology names
    local technology_migrations = {
        ["5d-battery-equipment-1"] = "battery-mk3-equipment"
    }
    
    -- Migrate items in player inventories, equipment grids, etc.
    for old_name, new_name in pairs(item_migrations) do
        -- Check if the new item exists and old item doesn't (migration needed)
        if prototypes.item[new_name] and not prototypes.item[old_name] then
            -- The old item no longer exists, so we can't migrate it
            -- Items with invalid names are automatically removed by the game
            -- We just need to ensure recipes are unlocked
            
            -- Nothing to do here - game handles invalid items automatically
        elseif prototypes.item[new_name] and prototypes.item[old_name] then
            -- Both items exist - do the migration
            for _, surface in pairs(game.surfaces) do
                for _, entity in pairs(surface.find_entities_filtered{}) do
                    for inv_type = 1, 20 do
                        local inventory = entity.get_inventory(inv_type)
                        if inventory then
                            local count = inventory.get_item_count(old_name)
                            if count > 0 then
                                inventory.remove({name = old_name, count = count})
                                inventory.insert({name = new_name, count = count})
                            end
                        end
                    end
                    
                    if entity.grid then
                        local grid = entity.grid
                        local equipment_to_replace = {}
                        for _, equipment in pairs(grid.equipment) do
                            if equipment.name == old_name then
                                table.insert(equipment_to_replace, {
                                    position = equipment.position,
                                    energy = equipment.energy
                                })
                            end
                        end
                        for _, eq_data in pairs(equipment_to_replace) do
                            grid.take{position = eq_data.position}
                            local new_eq = grid.put{name = new_name, position = eq_data.position}
                            if new_eq then
                                new_eq.energy = eq_data.energy
                            end
                        end
                    end
                end
            end
            
            for _, player in pairs(game.players) do
                local inventory = player.get_main_inventory()
                if inventory then
                    local count = inventory.get_item_count(old_name)
                    if count > 0 then
                        inventory.remove({name = old_name, count = count})
                        inventory.insert({name = new_name, count = count})
                    end
                end
                
                local armor_inventory = player.get_inventory(defines.inventory.character_armor)
                if armor_inventory and not armor_inventory.is_empty() then
                    local armor = armor_inventory[1]
                    if armor and armor.valid_for_read and armor.grid then
                        local grid = armor.grid
                        local equipment_to_replace = {}
                        for _, equipment in pairs(grid.equipment) do
                            if equipment.name == old_name then
                                table.insert(equipment_to_replace, {
                                    position = equipment.position,
                                    energy = equipment.energy
                                })
                            end
                        end
                        for _, eq_data in pairs(equipment_to_replace) do
                            grid.take{position = eq_data.position}
                            local new_eq = grid.put{name = new_name, position = eq_data.position}
                            if new_eq then
                                new_eq.energy = eq_data.energy
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- Migrate technologies - reset research if old tech was researched
    for _, force in pairs(game.forces) do
        for old_name, new_name in pairs(technology_migrations) do
            local old_tech = force.technologies[old_name]
            local new_tech = force.technologies[new_name]
            if old_tech and old_tech.researched and new_tech and not new_tech.researched then
                new_tech.researched = true
            end
        end
    end
end
