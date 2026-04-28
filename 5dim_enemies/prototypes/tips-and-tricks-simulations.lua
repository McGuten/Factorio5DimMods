-- =============================================================================
-- 5dim_enemies - Tips and Tricks Simulations
-- =============================================================================
-- Provides visual demonstrations of enemy types attacking defenses.
-- Uses actual mod entities with proper tier naming: 5d-{type}-{biter/spitter}-t{1-10}
-- =============================================================================

local simulations = {}

-- =============================================================================
-- HELPER FUNCTIONS
-- =============================================================================

-- Standard setup: compact area, 1 gun turret
local function standard_setup()
    return [[
        game.simulation.camera_position = {0, 0}
        game.simulation.camera_zoom = 1.0
        game.surfaces[1].build_checkerboard{{-12, -8}, {12, 8}}
        
        local turret = game.surfaces[1].create_entity{name = "gun-turret", position = {-5, 0}, force = "player"}
        if turret then turret.insert({name = "firearm-magazine", count = 200}) end
    ]]
end

-- Setup with working laser turret (with power poles!)
local function laser_setup()
    return [[
        game.simulation.camera_position = {0, 0}
        game.simulation.camera_zoom = 1.0
        game.surfaces[1].build_checkerboard{{-12, -8}, {12, 8}}
        
        -- Power source
        local power = game.surfaces[1].create_entity{name = "electric-energy-interface", position = {-9, 0}, force = "player"}
        if power then 
            power.power_production = 100000000
            power.electric_buffer_size = 100000000
        end
        
        -- Power poles to connect!
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-7, 0}, force = "player"}
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-4, 0}, force = "player"}
        
        -- Laser turret
        local turret = game.surfaces[1].create_entity{name = "laser-turret", position = {-5, 0}, force = "player"}
    ]]
end

-- =============================================================================
-- INTRO SIMULATION - Overview of enemy diversity
-- =============================================================================
simulations.enemies_intro = {
    init = standard_setup() .. [[
        local function spawn_enemies()
            local enemies = {
                {"5d-normal-biter-t3", {8, -2}},
                {"5d-laser-biter-t3", {9, 0}},
                {"5d-physical-biter-t3", {8, 2}},
            }
            
            for _, data in pairs(enemies) do
                local entity = game.surfaces[1].create_entity{name = data[1], position = data[2], force = "enemy"}
                if entity and entity.commandable then
                    entity.commandable.set_command{
                        type = defines.command.attack_area,
                        destination = {-5, 0},
                        radius = 6
                    }
                end
            end
        end
        
        spawn_enemies()
        
        script.on_nth_tick(300, function()
            for _, e in pairs(game.surfaces[1].find_entities_filtered{force = "enemy"}) do
                if e.valid then e.destroy() end
            end
            spawn_enemies()
        end)
    ]]
}

-- =============================================================================
-- TIER SYSTEM SIMULATION - Show tier progression T1 to T10 + Boss
-- =============================================================================
simulations.tier_system = {
    init = [[
        game.simulation.camera_position = {0, 0}
        game.simulation.camera_zoom = 0.4
        game.surfaces[1].build_checkerboard{{-40, -12}, {40, 12}}
        
        -- Row of biters T1 to T10 showing size progression
        local positions = {
            {-33, 0}, {-27, 0}, {-21, 0}, {-15, 0}, {-9, 0},
            {-3, 0}, {3, 0}, {9, 0}, {15, 0}, {21, 0}
        }
        
        for i, pos in ipairs(positions) do
            local biter = game.surfaces[1].create_entity{
                name = "5d-normal-biter-t" .. i, 
                position = pos, 
                force = "enemy"
            }
            if biter then biter.orientation = 0.75 end
        end
        
        -- Boss at the end (bigger!)
        local boss = game.surfaces[1].create_entity{
            name = "5d-normal-biter-boss", 
            position = {33, 0}, 
            force = "enemy"
        }
        if boss then boss.orientation = 0.75 end
    ]]
}

-- =============================================================================
-- NORMAL BITER SIMULATION
-- =============================================================================
simulations.normal_biter = {
    init = standard_setup() .. [[
        local function spawn_wave()
            for i = 1, 3 do
                local biter = game.surfaces[1].create_entity{
                    name = "5d-normal-biter-t3", 
                    position = {8 + math.random()*2, -2 + math.random()*4}, 
                    force = "enemy"
                }
                if biter and biter.commandable then
                    biter.commandable.set_command{
                        type = defines.command.attack_area,
                        destination = {-5, 0},
                        radius = 6
                    }
                end
            end
        end
        
        spawn_wave()
        
        script.on_nth_tick(240, function()
            spawn_wave()
        end)
    ]]
}

-- =============================================================================
-- SWARM BITER SIMULATION - Many small fast enemies
-- =============================================================================
simulations.swarm_biter = {
    init = standard_setup() .. [[
        local function spawn_swarm()
            for i = 1, 6 do
                local biter = game.surfaces[1].create_entity{
                    name = "5d-swarm-biter-t2", 
                    position = {7 + math.random()*3, -3 + math.random()*6}, 
                    force = "enemy"
                }
                if biter and biter.commandable then
                    biter.commandable.set_command{
                        type = defines.command.attack_area,
                        destination = {-5, 0},
                        radius = 6
                    }
                end
            end
        end
        
        spawn_swarm()
        
        script.on_nth_tick(180, function()
            spawn_swarm()
        end)
    ]]
}

-- =============================================================================
-- BROODMOTHER SIMULATION - Spawns children on death
-- =============================================================================
simulations.broodmother_biter = {
    init = [[
        game.simulation.camera_position = {0, 0}
        game.simulation.camera_zoom = 1.0
        game.surfaces[1].build_checkerboard{{-12, -8}, {12, 8}}
        
        -- Power source for laser
        local power = game.surfaces[1].create_entity{name = "electric-energy-interface", position = {-9, 0}, force = "player"}
        if power then 
            power.power_production = 100000000
            power.electric_buffer_size = 100000000
        end
        
        -- Power poles to connect!
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-7, 0}, force = "player"}
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-4, 0}, force = "player"}
        
        -- Multiple turrets: 2 gun + 1 laser to kill broodmother
        local turret1 = game.surfaces[1].create_entity{name = "gun-turret", position = {-5, -2}, force = "player"}
        local turret2 = game.surfaces[1].create_entity{name = "gun-turret", position = {-5, 2}, force = "player"}
        local laser = game.surfaces[1].create_entity{name = "laser-turret", position = {-5, 0}, force = "player"}
        if turret1 then turret1.insert({name = "firearm-magazine", count = 200}) end
        if turret2 then turret2.insert({name = "firearm-magazine", count = 200}) end
        
        local broodmother_name = "5d-broodmother-biter-t2"
        local child_name = "5d-swarm-biter-t1"
        
        local function spawn_broodmother()
            local broodmother = game.surfaces[1].create_entity{
                name = broodmother_name, 
                position = {8, 0}, 
                force = "enemy"
            }
            if broodmother and broodmother.commandable then
                broodmother.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-5, 0},
                    radius = 6
                }
            end
        end
        
        spawn_broodmother()
        
        -- Key mechanic: spawn children when broodmother dies
        script.on_event(defines.events.on_entity_died, function(event)
            if event.entity.name == broodmother_name then
                local pos = event.entity.position
                for i = 1, 4 do
                    local child = game.surfaces[1].create_entity{
                        name = child_name,
                        position = {pos.x + math.random()*2 - 1, pos.y + math.random()*2 - 1},
                        force = "enemy"
                    }
                    if child and child.commandable then
                        child.commandable.set_command{
                            type = defines.command.attack_area,
                            destination = {-5, 0},
                            radius = 6
                        }
                    end
                end
            end
        end)
        
        -- Respawn cycle
        script.on_nth_tick(300, function()
            local enemies = game.surfaces[1].find_entities_filtered{force = "enemy", type = "unit"}
            if #enemies == 0 then
                spawn_broodmother()
            end
        end)
    ]]
}

-- =============================================================================
-- REGENERATOR SIMULATION - Biter that heals rapidly
-- =============================================================================
simulations.regenerator_biter = {
    init = standard_setup() .. [[
        local regen_biter = nil
        local regen_name = "5d-regenerator-biter-t3"
        local regen_max_health = 1000
        
        local function spawn_regenerator()
            regen_biter = game.surfaces[1].create_entity{
                name = regen_name, 
                position = {8, 0}, 
                force = "enemy"
            }
            if regen_biter then
                regen_max_health = regen_biter.max_health
                if regen_biter.commandable then
                    regen_biter.commandable.set_command{
                        type = defines.command.attack_area,
                        destination = {-5, 0},
                        radius = 6
                    }
                end
            end
        end
        
        spawn_regenerator()
        
        -- Visible regeneration effect
        script.on_nth_tick(20, function()
            if regen_biter and regen_biter.valid then
                local current = regen_biter.health
                if current < regen_max_health then
                    regen_biter.health = math.min(regen_max_health, current + regen_max_health * 0.08)
                end
            else
                spawn_regenerator()
            end
        end)
    ]]
}

-- =============================================================================
-- BERSERKER SIMULATION - Fast aggressive biter
-- =============================================================================
simulations.berserker_biter = {
    init = standard_setup() .. [[
        local function spawn_berserker()
            local biter = game.surfaces[1].create_entity{
                name = "5d-berserker-biter-t3", 
                position = {9 + math.random()*2, -1 + math.random()*2}, 
                force = "enemy"
            }
            if biter and biter.commandable then
                biter.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-5, 0},
                    radius = 6
                }
            end
        end
        
        spawn_berserker()
        spawn_berserker()
        
        script.on_nth_tick(150, function()
            spawn_berserker()
        end)
    ]]
}

-- =============================================================================
-- FIRE SPITTER SIMULATION
-- =============================================================================
simulations.fire_spitter = {
    init = standard_setup() .. [[
        local function spawn_spitters()
            for i = 1, 2 do
                local spitter = game.surfaces[1].create_entity{
                    name = "5d-fire-spitter-t3", 
                    position = {8 + math.random()*2, -1 + math.random()*2}, 
                    force = "enemy"
                }
                if spitter and spitter.commandable then
                    spitter.commandable.set_command{
                        type = defines.command.attack_area,
                        destination = {-5, 0},
                        radius = 8
                    }
                end
            end
        end
        
        spawn_spitters()
        
        script.on_nth_tick(240, function()
            spawn_spitters()
        end)
    ]]
}

-- =============================================================================
-- ROCKET/EXPLOSIVE SPITTER SIMULATION  
-- =============================================================================
simulations.rocket_spitter = {
    init = standard_setup() .. [[
        -- Walls to show splash damage
        for y = -2, 2 do
            game.surfaces[1].create_entity{name = "stone-wall", position = {-3, y}, force = "player"}
        end
        
        local function spawn_spitters()
            local spitter = game.surfaces[1].create_entity{
                name = "5d-rocket-spitter-t3", 
                position = {9, math.random()*2 - 1}, 
                force = "enemy"
            }
            if spitter and spitter.commandable then
                spitter.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-5, 0},
                    radius = 8
                }
            end
        end
        
        spawn_spitters()
        
        script.on_nth_tick(240, function()
            spawn_spitters()
        end)
    ]]
}

-- =============================================================================
-- SUICIDE SPITTER SIMULATION - Explodes on death
-- =============================================================================
simulations.suicide_spitter = {
    init = [[
        game.simulation.camera_position = {0, 0}
        game.simulation.camera_zoom = 1.0
        game.surfaces[1].build_checkerboard{{-12, -8}, {12, 8}}
        
        -- Two turrets to kill them
        local turret1 = game.surfaces[1].create_entity{name = "gun-turret", position = {-5, -1}, force = "player"}
        local turret2 = game.surfaces[1].create_entity{name = "gun-turret", position = {-5, 1}, force = "player"}
        if turret1 then turret1.insert({name = "firearm-magazine", count = 200}) end
        if turret2 then turret2.insert({name = "firearm-magazine", count = 200}) end
        
        -- Walls to show explosion damage
        for y = -2, 2 do
            game.surfaces[1].create_entity{name = "stone-wall", position = {-2, y}, force = "player"}
        end
        
        local suicide_name = "5d-suicide-spitter-t2"
        
        local function spawn_suicide()
            local spitter = game.surfaces[1].create_entity{
                name = suicide_name, 
                position = {9, math.random()*2 - 1}, 
                force = "enemy"
            }
            if spitter and spitter.commandable then
                spitter.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-5, 0},
                    radius = 5
                }
            end
        end
        
        -- Explosion on death
        script.on_event(defines.events.on_entity_died, function(event)
            if event.entity.name == suicide_name then
                game.surfaces[1].create_entity{
                    name = "big-explosion",
                    position = event.entity.position
                }
            end
        end)
        
        spawn_suicide()
        spawn_suicide()
        
        script.on_nth_tick(180, function()
            spawn_suicide()
        end)
    ]]
}

-- =============================================================================
-- BOSS SIMULATION - Giant powerful enemy
-- =============================================================================
simulations.boss_enemy = {
    init = [[
        game.simulation.camera_position = {0, 0}
        game.simulation.camera_zoom = 0.6
        game.surfaces[1].build_checkerboard{{-20, -12}, {20, 12}}
        
        -- Power for laser
        local power = game.surfaces[1].create_entity{name = "electric-energy-interface", position = {-14, 0}, force = "player"}
        if power then 
            power.power_production = 100000000
            power.electric_buffer_size = 100000000
        end
        
        -- Power poles to connect!
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-12, 0}, force = "player"}
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-9, 0}, force = "player"}
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-6, 0}, force = "player"}
        
        -- Multiple turrets for the boss
        local t1 = game.surfaces[1].create_entity{name = "gun-turret", position = {-8, -3}, force = "player"}
        local t2 = game.surfaces[1].create_entity{name = "gun-turret", position = {-8, 3}, force = "player"}
        local laser = game.surfaces[1].create_entity{name = "laser-turret", position = {-8, 0}, force = "player"}
        if t1 then t1.insert({name = "piercing-rounds-magazine", count = 200}) end
        if t2 then t2.insert({name = "piercing-rounds-magazine", count = 200}) end
        
        local function spawn_boss()
            local boss = game.surfaces[1].create_entity{
                name = "5d-normal-biter-boss", 
                position = {14, 0}, 
                force = "enemy"
            }
            if boss and boss.commandable then
                boss.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-8, 0},
                    radius = 10
                }
            end
        end
        
        spawn_boss()
        
        script.on_nth_tick(500, function()
            local enemies = game.surfaces[1].find_entities_filtered{force = "enemy", type = "unit"}
            if #enemies == 0 then
                spawn_boss()
            end
        end)
    ]]
}

-- =============================================================================
-- LASER RESISTANT SIMULATION
-- =============================================================================
simulations.laser_biter = {
    init = laser_setup() .. [[
        local function spawn_biters()
            for i = 1, 2 do
                local biter = game.surfaces[1].create_entity{
                    name = "5d-laser-biter-t3", 
                    position = {8 + math.random()*2, -2 + math.random()*4}, 
                    force = "enemy"
                }
                if biter and biter.commandable then
                    biter.commandable.set_command{
                        type = defines.command.attack_area,
                        destination = {-5, 0},
                        radius = 6
                    }
                end
            end
        end
        
        spawn_biters()
        
        script.on_nth_tick(240, function()
            spawn_biters()
        end)
    ]]
}

-- =============================================================================
-- PHYSICAL/ARMORED SIMULATION
-- =============================================================================
simulations.physical_biter = {
    init = standard_setup() .. [[
        local function spawn_biters()
            for i = 1, 2 do
                local biter = game.surfaces[1].create_entity{
                    name = "5d-physical-biter-t3", 
                    position = {8 + math.random()*2, -1 + math.random()*2}, 
                    force = "enemy"
                }
                if biter and biter.commandable then
                    biter.commandable.set_command{
                        type = defines.command.attack_area,
                        destination = {-5, 0},
                        radius = 6
                    }
                end
            end
        end
        
        spawn_biters()
        
        script.on_nth_tick(300, function()
            spawn_biters()
        end)
    ]]
}

-- =============================================================================
-- IMPACT BITER SIMULATION - Slow but devastating
-- =============================================================================
simulations.impact_biter = {
    init = standard_setup() .. [[
        local function spawn_impact()
            local biter = game.surfaces[1].create_entity{
                name = "5d-impact-biter-t3", 
                position = {9, math.random()*2 - 1}, 
                force = "enemy"
            }
            if biter and biter.commandable then
                biter.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-5, 0},
                    radius = 6
                }
            end
        end
        
        spawn_impact()
        
        script.on_nth_tick(300, function()
            spawn_impact()
        end)
    ]]
}

-- =============================================================================
-- POISON SPITTER SIMULATION
-- =============================================================================
simulations.poison_spitter = {
    init = standard_setup() .. [[
        local function spawn_spitters()
            for i = 1, 2 do
                local spitter = game.surfaces[1].create_entity{
                    name = "5d-poison-spitter-t3", 
                    position = {8 + math.random()*2, -1 + math.random()*2}, 
                    force = "enemy"
                }
                if spitter and spitter.commandable then
                    spitter.commandable.set_command{
                        type = defines.command.attack_area,
                        destination = {-5, 0},
                        radius = 8
                    }
                end
            end
        end
        
        spawn_spitters()
        
        script.on_nth_tick(240, function()
            spawn_spitters()
        end)
    ]]
}

-- =============================================================================
-- ELECTRIC SPITTER SIMULATION
-- =============================================================================
simulations.electric_spitter = {
    init = [[
        game.simulation.camera_position = {0, 0}
        game.simulation.camera_zoom = 1.0
        game.surfaces[1].build_checkerboard{{-12, -8}, {12, 8}}
        
        -- Clustered turrets to show chain damage
        game.surfaces[1].create_entity{name = "gun-turret", position = {-5, -1}, force = "player"}.insert({name = "firearm-magazine", count = 200})
        game.surfaces[1].create_entity{name = "gun-turret", position = {-5, 1}, force = "player"}.insert({name = "firearm-magazine", count = 200})
        
        local function spawn_spitters()
            local spitter = game.surfaces[1].create_entity{
                name = "5d-electric-spitter-t3", 
                position = {8 + math.random()*2, math.random()*2 - 1}, 
                force = "enemy"
            }
            if spitter and spitter.commandable then
                spitter.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-5, 0},
                    radius = 8
                }
            end
        end
        
        spawn_spitters()
        
        script.on_nth_tick(200, function()
            spawn_spitters()
        end)
    ]]
}

-- =============================================================================
-- RAILGUN ENEMIES SIMULATION (Space Age)
-- =============================================================================
simulations.railgun_enemies = {
    init = standard_setup() .. [[
        local function spawn_enemies()
            local biter = game.surfaces[1].create_entity{
                name = "5d-railgun-biter-t3", 
                position = {8, -1}, 
                force = "enemy"
            }
            local spitter = game.surfaces[1].create_entity{
                name = "5d-railgun-spitter-t3", 
                position = {9, 1}, 
                force = "enemy"
            }
            
            for _, unit in pairs({biter, spitter}) do
                if unit and unit.commandable then
                    unit.commandable.set_command{
                        type = defines.command.attack_area,
                        destination = {-5, 0},
                        radius = 8
                    }
                end
            end
        end
        
        spawn_enemies()
        
        script.on_nth_tick(300, function()
            spawn_enemies()
        end)
    ]]
}

-- =============================================================================
-- FULL BATTLE SIMULATION - All enemy types vs fortified defense
-- =============================================================================
simulations.full_battle = {
    init = [[
        game.simulation.camera_position = {0, 0}
        game.simulation.camera_zoom = 0.5
        game.surfaces[1].build_checkerboard{{-30, -18}, {30, 18}}
        
        -- =====================================================================
        -- POWER INFRASTRUCTURE (minimal poles)
        -- =====================================================================
        local power = game.surfaces[1].create_entity{name = "electric-energy-interface", position = {-22, 0}, force = "player"}
        if power then 
            power.power_production = 500000000
            power.electric_buffer_size = 500000000
        end
        
        -- Just 2 substations to cover everything
        game.surfaces[1].create_entity{name = "substation", position = {-18, -5}, force = "player"}
        game.surfaces[1].create_entity{name = "substation", position = {-18, 5}, force = "player"}
        
        -- =====================================================================
        -- ROBOPORTS WITH REPAIR BOTS
        -- =====================================================================
        local robo1 = game.surfaces[1].create_entity{name = "roboport", position = {-16, -8}, force = "player"}
        local robo2 = game.surfaces[1].create_entity{name = "roboport", position = {-16, 8}, force = "player"}
        if robo1 then 
            robo1.insert({name = "construction-robot", count = 30})
        end
        if robo2 then 
            robo2.insert({name = "construction-robot", count = 30})
        end
        
        -- =====================================================================
        -- LOGISTICS CHESTS WITH SUPPLIES FOR ROBOTS
        -- =====================================================================
        -- Chest with repair packs
        local chest1 = game.surfaces[1].create_entity{name = "passive-provider-chest", position = {-14, -6}, force = "player"}
        if chest1 then
            chest1.insert({name = "repair-pack", count = 100})
        end
        
        -- Chest with walls
        local chest2 = game.surfaces[1].create_entity{name = "passive-provider-chest", position = {-14, 0}, force = "player"}
        if chest2 then
            chest2.insert({name = "stone-wall", count = 100})
        end
        
        -- Chest with turrets and ammo
        local chest3 = game.surfaces[1].create_entity{name = "passive-provider-chest", position = {-14, 6}, force = "player"}
        if chest3 then
            chest3.insert({name = "gun-turret", count = 10})
            chest3.insert({name = "laser-turret", count = 5})
            chest3.insert({name = "piercing-rounds-magazine", count = 200})
        end
        
        -- =====================================================================
        -- WALLS - Defensive perimeter
        -- =====================================================================
        for y = -12, 12 do
            game.surfaces[1].create_entity{name = "stone-wall", position = {-6, y}, force = "player"}
        end
        for x = -8, -6 do
            game.surfaces[1].create_entity{name = "stone-wall", position = {x, -12}, force = "player"}
            game.surfaces[1].create_entity{name = "stone-wall", position = {x, 12}, force = "player"}
        end
        
        -- =====================================================================
        -- TURRETS - Mixed defense
        -- =====================================================================
        -- Gun turrets (front)
        local gun_positions = {{-9, -10}, {-9, -5}, {-9, 0}, {-9, 5}, {-9, 10}}
        for _, pos in pairs(gun_positions) do
            local t = game.surfaces[1].create_entity{name = "gun-turret", position = pos, force = "player"}
            if t then t.insert({name = "piercing-rounds-magazine", count = 200}) end
        end
        
        -- Laser turrets (back)
        local laser_positions = {{-12, -8}, {-12, -3}, {-12, 3}, {-12, 8}}
        for _, pos in pairs(laser_positions) do
            game.surfaces[1].create_entity{name = "laser-turret", position = pos, force = "player"}
        end
        
        -- Flamethrower in center
        local flame = game.surfaces[1].create_entity{name = "flamethrower-turret", position = {-8, 0}, force = "player"}
        if flame then flame.insert({name = "light-oil-barrel", count = 20}) end
        
        -- =====================================================================
        -- MASSIVE ENEMY WAVE - All types T3-T4!
        -- =====================================================================
        local biters = {
            -- Normal types
            "5d-normal-biter-t3", "5d-normal-biter-t4",
            -- Resistance types
            "5d-laser-biter-t3", "5d-laser-biter-t4",
            "5d-physical-biter-t3", "5d-physical-biter-t4",
            -- Special types
            "5d-impact-biter-t3",
            "5d-broodmother-biter-t3", "5d-broodmother-biter-t3",
            "5d-regenerator-biter-t3",
            "5d-berserker-biter-t3", "5d-berserker-biter-t4",
            -- Swarm (many!)
            "5d-swarm-biter-t3", "5d-swarm-biter-t3", "5d-swarm-biter-t3",
            "5d-swarm-biter-t4", "5d-swarm-biter-t4", "5d-swarm-biter-t4",
        }
        
        local spitters = {
            "5d-fire-spitter-t3", "5d-fire-spitter-t4",
            "5d-rocket-spitter-t3", "5d-rocket-spitter-t4",
            "5d-poison-spitter-t3",
            "5d-electric-spitter-t3",
            "5d-suicide-spitter-t3", "5d-suicide-spitter-t3",
        }
        
        -- Spawn biters spread across the right side
        for i, name in pairs(biters) do
            local row = math.floor((i - 1) / 6)
            local col = (i - 1) % 6
            local entity = game.surfaces[1].create_entity{
                name = name,
                position = {18 + col * 2, -10 + row * 7},
                force = "enemy"
            }
            if entity and entity.commandable then
                entity.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-9, 0},
                    radius = 15
                }
            end
        end
        
        -- Spawn spitters behind
        for i, name in pairs(spitters) do
            local entity = game.surfaces[1].create_entity{
                name = name,
                position = {24 + (i % 3) * 2, -8 + i * 2},
                force = "enemy"
            }
            if entity and entity.commandable then
                entity.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-9, 0},
                    radius = 18
                }
            end
        end
        
        -- Broodmother children spawn on death
        script.on_event(defines.events.on_entity_died, function(event)
            if string.find(event.entity.name, "broodmother") then
                local pos = event.entity.position
                for i = 1, 4 do
                    local child = game.surfaces[1].create_entity{
                        name = "5d-swarm-biter-t1",
                        position = {pos.x + math.random()*2 - 1, pos.y + math.random()*2 - 1},
                        force = "enemy"
                    }
                    if child and child.commandable then
                        child.commandable.set_command{
                            type = defines.command.attack_area,
                            destination = {-9, 0},
                            radius = 15
                        }
                    end
                end
            end
            -- Suicide explosion
            if string.find(event.entity.name, "suicide") then
                game.surfaces[1].create_entity{
                    name = "big-explosion",
                    position = event.entity.position
                }
            end
        end)
    ]]
}

-- =============================================================================
-- TANK SIMULATION - 50% resistance to ALL damage types
-- =============================================================================
simulations.tank_enemy = {
    init = [[
        game.simulation.camera_position = {0, 0}
        game.simulation.camera_zoom = 0.8
        game.surfaces[1].build_checkerboard{{-16, -10}, {16, 10}}
        
        -- Power for laser
        local power = game.surfaces[1].create_entity{name = "electric-energy-interface", position = {-12, 0}, force = "player"}
        if power then 
            power.power_production = 100000000
            power.electric_buffer_size = 100000000
        end
        
        -- Power poles
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-10, -3}, force = "player"}
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-10, 3}, force = "player"}
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-7, -3}, force = "player"}
        game.surfaces[1].create_entity{name = "medium-electric-pole", position = {-7, 3}, force = "player"}
        
        -- Multiple turret types to show tank resists ALL damage
        -- Gun turrets (physical)
        local gun1 = game.surfaces[1].create_entity{name = "gun-turret", position = {-8, -3}, force = "player"}
        local gun2 = game.surfaces[1].create_entity{name = "gun-turret", position = {-8, 3}, force = "player"}
        if gun1 then gun1.insert({name = "piercing-rounds-magazine", count = 200}) end
        if gun2 then gun2.insert({name = "piercing-rounds-magazine", count = 200}) end
        
        -- Laser turret (laser damage)
        local laser = game.surfaces[1].create_entity{name = "laser-turret", position = {-8, 0}, force = "player"}
        
        local function spawn_tank()
            -- Tank biter - very tanky, resists everything
            local tank = game.surfaces[1].create_entity{
                name = "5d-tank-biter-t1", 
                position = {12, 0}, 
                force = "enemy"
            }
            if tank and tank.commandable then
                tank.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-8, 0},
                    radius = 10
                }
            end
        end
        
        local function spawn_normal()
            -- Normal biter for comparison - dies much faster
            local normal = game.surfaces[1].create_entity{
                name = "5d-normal-biter-t1", 
                position = {12, -5}, 
                force = "enemy"
            }
            if normal and normal.commandable then
                normal.commandable.set_command{
                    type = defines.command.attack_area,
                    destination = {-8, -3},
                    radius = 6
                }
            end
        end
        
        spawn_tank()
        spawn_normal()
        
        script.on_nth_tick(360, function()
            local enemies = game.surfaces[1].find_entities_filtered{force = "enemy", type = "unit"}
            if #enemies == 0 then
                spawn_tank()
                spawn_normal()
            end
        end)
    ]]
}

return simulations
