-- =============================================================================
-- 5dim_enemies - Boss Spitter Generator
-- =============================================================================
-- Generates boss spitters (tier 11) for each spitter type.
-- These are massive, powerful enemies that spawn at very high evolution.
-- Boss = x3 health and damage from base T10 stats with type multipliers.
-- =============================================================================

local Tiers = require("prototypes.config.tiers")
local SpitterTypes = require("prototypes.config.spitter-types")
local TierUtils = require("prototypes.lib.tier-utils")
local SpitterAttack = require("prototypes.lib.spitter-attack")

-- Only generate if boss enemies are enabled
if not TierUtils.isBossEnabled() then
    return
end

-- =============================================================================
-- BOSS SPITTER GENERATOR
-- =============================================================================

-- Generate a boss spitter
-- Parameters:
--   typeConfig: The spitter type configuration
-- Returns: The boss spitter entity definition
local function createBossSpitter(typeConfig)
    -- Get stats using the new system (tier 11 = boss)
    local stats = Tiers.getStats("spitter", typeConfig.name, 11)
    local entityName = TierUtils.getBossName(typeConfig.name, "spitter")
    
    -- Copy from behemoth as base
    local spitter = table.deepcopy(data.raw["unit"]["behemoth-spitter"])
    
    -- Basic properties
    spitter.name = entityName
    spitter.order = string.format("b-b-%s-z-boss", typeConfig.order)
    
    -- Clear alternative attacking frame
    spitter.alternative_attacking_frame_sequence = nil
    
    -- Boss stats (from new Tiers system)
    spitter.max_health = stats.health
    spitter.movement_speed = stats.speed
    spitter.healing_per_tick = stats.healing
    
    -- Calculate resistances for boss (tier 11 equivalent)
    local resistances = TierUtils.calculateResistances(typeConfig, 11)
    -- Add extra base resistances for boss
    table.insert(resistances, { type = "physical", decrease = 15, percent = 40 })
    table.insert(resistances, { type = "explosion", decrease = 15, percent = 40 })
    table.insert(resistances, { type = "fire", decrease = 8, percent = 30 })
    spitter.resistances = resistances
    
    -- Powerful attack based on type
    local attackData = {
        range = stats.range,
        damage = stats.damage,
        scale = stats.scale,
        tint = typeConfig.colors.primary,
        tint2 = typeConfig.colors.secondary
    }
    spitter.attack_parameters = SpitterAttack.get(typeConfig.attack_type, 11, attackData)  -- tier 11 = boss
    
    -- Massive animations
    spitter.run_animation = spitterrunanimation(stats.scale, typeConfig.colors.primary, typeConfig.colors.secondary)
    spitter.water_reflection = spitter_water_reflection(stats.scale)
    
    -- Enhanced AI behavior
    spitter.vision_distance = 50
    spitter.min_pursue_time = 25 * 60  -- 25 seconds
    spitter.max_pursue_distance = 80
    spitter.absorptions_to_join_attack = { pollution = 1 }  -- Very aggressive
    
    -- Selection box - very large for boss (easy to click)
    spitter.selection_box = {{-3, -3}, {3, 3}}
    
    -- Corpse reference
    spitter.corpse = TierUtils.getCorpseName(entityName)
    
    -- ==========================================================================
    -- BOSS DYING EFFECTS - Type-specific MASSIVE effects
    -- ==========================================================================
    
    -- Special behavior for suicide type
    if typeConfig.special_behavior == "suicide" then
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "damage",
                damage = { amount = stats.damage * 3, type = "explosion" }
            },
            {
                type = "create-entity",
                entity_name = "big-explosion"
            },
            {
                type = "create-entity",
                entity_name = "medium-explosion"
            }
        }
        
    -- Fire boss - MASSIVE fire on death (15-20 tiles)
    elseif typeConfig.name == "fire" then
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            }
        }
        -- Create a massive fire field - 20 patches spread over 15 tile radius
        for i = 1, 20 do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-fire",
                entity_name = "fire-flame",
                initial_ground_flame_count = 25,
                offset_deviation = {{-15, -15}, {15, 15}}
            })
        end
        
    -- Poison boss - massive poison cloud area (optimized)
    elseif typeConfig.name == "poison" then
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            }
        }
        -- Create fewer but bigger optimized poison clouds (4 instead of 8)
        for i = 1, 4 do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = "5d-poison-cloud-behemoth",
                offset_deviation = {{-10, -10}, {10, 10}}
            })
        end
        
    -- Electric boss - massive EMP discharge
    elseif typeConfig.name == "electric" then
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "create-entity",
                entity_name = "big-explosion",
                offset_deviation = {{-2, -2}, {2, 2}}
            }
        }
        for i = 1, 15 do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 10,
                offset_deviation = {{-12, -12}, {12, 12}}
            })
        end
        table.insert(spitter.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = 15,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 100, type = "electric"}
                        },
                        {
                            type = "create-sticker",
                            sticker = "slowdown-sticker"
                        }
                    }
                }
            }
        })
        
    -- Laser boss - massive light explosion
    elseif typeConfig.name == "laser" then
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "create-entity",
                entity_name = "laser-bubble",
                offset_deviation = {{-1, -1}, {1, 1}}
            }
        }
        for i = 1, 20 do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-10, -10}, {10, 10}}
            })
        end
        table.insert(spitter.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = 12,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 80, type = "laser"}
                        }
                    }
                }
            }
        })
        
    -- Physical boss - massive shrapnel explosion
    elseif typeConfig.name == "physical" then
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            }
        }
        for i = 1, 25 do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 15,
                offset_deviation = {{-12, -12}, {12, 12}}
            })
        end
        table.insert(spitter.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = 10,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 120, type = "physical"}
                        }
                    }
                }
            }
        })
        
    -- Rocket boss - chain explosions
    elseif typeConfig.name == "rocket" then
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            }
        }
        for i = 1, 12 do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = "explosion",
                offset_deviation = {{-10, -10}, {10, 10}}
            })
        end
        for i = 1, 6 do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = "big-explosion",
                offset_deviation = {{-8, -8}, {8, 8}}
            })
        end
        table.insert(spitter.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = 14,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 100, type = "explosion"}
                        }
                    }
                }
            }
        })
        
    -- Railgun boss - energy discharge in lines
    elseif typeConfig.name == "railgun" then
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "create-entity",
                entity_name = "explosion"
            }
        }
        for i = 1, 20 do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-15, -2}, {15, 2}}
            })
        end
        table.insert(spitter.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = 12,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 200, type = "physical"}
                        }
                    }
                }
            }
        })
    
    -- Broodmother boss - spawns 2x T10 broodmother spitters on death (50% each)
    elseif typeConfig.name == "broodmother" or typeConfig.special_behavior == "broodmother" then
        local offspringName = TierUtils.getEntityName("broodmother", "spitter", 10)
        spitter.dying_trigger_effect = {
            -- Massive blood explosion
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "create-entity",
                entity_name = "blood-explosion-huge",
                offset_deviation = {{-1, -1}, {1, 1}}
            },
            -- Spawn first T10 offspring (50% chance)
            {
                type = "create-entity",
                entity_name = offspringName,
                offset_deviation = {{-3, -3}, {3, 3}},
                trigger_created_entity = true,
                probability = 0.5
            },
            -- Spawn second T10 offspring (50% chance)
            {
                type = "create-entity",
                entity_name = offspringName,
                offset_deviation = {{-3, -3}, {3, 3}},
                trigger_created_entity = true,
                probability = 0.5
            }
        }
        
    else
        -- Default boss death effect
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "create-entity",
                entity_name = "medium-explosion"
            }
        }
    end
    
    return spitter
end

-- =============================================================================
-- BOSS CORPSE GENERATOR
-- =============================================================================

local function createBossSpitterCorpse(typeConfig)
    local stats = Tiers.getStats("spitter", typeConfig.name, 11)
    local entityName = TierUtils.getBossName(typeConfig.name, "spitter")
    
    local corpse = add_spitter_die_animation(
        stats.scale,
        typeConfig.colors.primary,
        typeConfig.colors.secondary,
        {
            type = "corpse",
            name = TierUtils.getCorpseName(entityName),
            icon = "__base__/graphics/icons/medium-spitter-corpse.png",
            icon_size = 64,
            selectable_in_game = false,
            selection_box = {{-2, -2}, {2, 2}},
            subgroup = "corpses",
            order = string.format("c[corpse]-b[spitter]-%s-boss", typeConfig.name),
            flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
        }
    )
    
    return corpse
end

-- =============================================================================
-- EXECUTE GENERATION
-- =============================================================================

local function generateBossSpitters()
    local allEntities = {}
    
    -- Generate boss for all spitter types (including vanilla overrides for boss variants)
    local spitterTypes = SpitterTypes.getAll()
    
    for _, typeConfig in ipairs(spitterTypes) do
        local spitter = createBossSpitter(typeConfig)
        local corpse = createBossSpitterCorpse(typeConfig)
        table.insert(allEntities, spitter)
        table.insert(allEntities, corpse)
    end
    
    -- Register all entities
    if #allEntities > 0 then
        data:extend(allEntities)
    end
end

-- Run generation
generateBossSpitters()
