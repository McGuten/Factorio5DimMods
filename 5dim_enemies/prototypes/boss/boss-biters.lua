-- =============================================================================
-- 5dim_enemies - Boss Biter Generator
-- =============================================================================
-- Generates boss biters (tier 11) for each biter type.
-- These are massive, powerful enemies that spawn at very high evolution.
-- Boss = x3 health and damage from base T10 stats with type multipliers.
-- =============================================================================

local Tiers = require("prototypes.config.tiers")
local BiterTypes = require("prototypes.config.biter-types")
local TierUtils = require("prototypes.lib.tier-utils")

-- Only generate if boss enemies are enabled
if not TierUtils.isBossEnabled() then
    return
end

-- =============================================================================
-- BOSS BITER GENERATOR
-- =============================================================================

-- Generate a boss biter
-- Parameters:
--   typeConfig: The biter type configuration
-- Returns: The boss biter entity definition
local function createBossBiter(typeConfig)
    -- Get stats using the new system (tier 11 = boss)
    local stats = Tiers.getStats("biter", typeConfig.name, 11)
    local entityName = TierUtils.getBossName(typeConfig.name, "biter")
    
    -- Copy from behemoth as base
    local biter = table.deepcopy(data.raw["unit"]["behemoth-biter"])
    
    -- Basic properties
    biter.name = entityName
    biter.order = string.format("b-a-%s-z-boss", typeConfig.order)
    
    -- Boss stats (from new Tiers system)
    biter.max_health = stats.health
    biter.movement_speed = stats.speed
    biter.healing_per_tick = stats.healing
    
    -- Calculate resistances for boss (tier 11 equivalent)
    local resistances = TierUtils.calculateResistances(typeConfig, 11)
    -- Add extra base resistances for boss
    table.insert(resistances, { type = "physical", decrease = 20, percent = 50 })
    table.insert(resistances, { type = "explosion", decrease = 20, percent = 50 })
    table.insert(resistances, { type = "fire", decrease = 10, percent = 40 })
    biter.resistances = resistances
    
    -- Powerful attack with typed damage
    biter.attack_parameters = {
        type = "projectile",
        range = 1.5,
        cooldown = 15,  -- Very fast attacks
        cooldown_deviation = 0.1,
        ammo_category = "melee",
        ammo_type = TierUtils.makeMeleeAmmoType(stats.damage, typeConfig.name, 11),
        animation = biterattackanimation(stats.scale, typeConfig.colors.primary, typeConfig.colors.secondary),
        range_mode = "bounding-box-to-bounding-box"
    }
    
    -- Massive animations
    biter.run_animation = biterrunanimation(stats.scale, typeConfig.colors.primary, typeConfig.colors.secondary)
    biter.water_reflection = biter_water_reflection(stats.scale)
    
    -- Enhanced AI behavior
    biter.vision_distance = 60
    biter.min_pursue_time = 30 * 60  -- 30 seconds
    biter.max_pursue_distance = 100
    biter.absorptions_to_join_attack = { pollution = 1 }  -- Very aggressive
    
    -- Selection box - very large for boss (easy to click)
    biter.selection_box = {{-3, -3}, {3, 3}}
    
    -- Corpse reference
    biter.corpse = TierUtils.getCorpseName(entityName)
    
    -- ==========================================================================
    -- BOSS DYING EFFECTS - Type-specific MASSIVE effects
    -- ==========================================================================
    
    if typeConfig.name == "fire" then
        -- Fire boss creates MASSIVE fire area (15-20 tiles radius)
        biter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "create-entity",
                entity_name = "medium-explosion"
            }
        }
        -- Create a massive fire field - 20 patches spread over 15 tile radius
        for i = 1, 20 do
            table.insert(biter.dying_trigger_effect, {
                type = "create-fire",
                entity_name = "fire-flame",
                initial_ground_flame_count = 25,
                offset_deviation = {{-15, -15}, {15, 15}}
            })
        end
        
    elseif typeConfig.name == "poison" then
        -- Poison boss creates massive poison cloud area (optimized - 4 big clouds instead of 8 vanilla)
        biter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "create-entity",
                entity_name = "medium-explosion"
            }
        }
        -- Create fewer but bigger optimized poison clouds
        for i = 1, 4 do
            table.insert(biter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = "5d-poison-cloud-behemoth",
                offset_deviation = {{-10, -10}, {10, 10}}
            })
        end
        
    elseif typeConfig.name == "electric" then
        -- Electric boss - massive EMP-like discharge
        biter.dying_trigger_effect = {
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
        -- Multiple spark effects
        for i = 1, 15 do
            table.insert(biter.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 10,
                offset_deviation = {{-12, -12}, {12, 12}}
            })
        end
        -- Massive electric damage area
        table.insert(biter.dying_trigger_effect, {
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
        
    elseif typeConfig.name == "laser" then
        -- Laser boss - massive light explosion
        biter.dying_trigger_effect = {
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
        -- Light particles
        for i = 1, 20 do
            table.insert(biter.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-10, -10}, {10, 10}}
            })
        end
        -- Laser damage area
        table.insert(biter.dying_trigger_effect, {
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
        
    elseif typeConfig.name == "physical" then
        -- Physical boss - massive shrapnel explosion
        biter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            }
        }
        -- Debris everywhere
        for i = 1, 25 do
            table.insert(biter.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 15,
                offset_deviation = {{-12, -12}, {12, 12}}
            })
        end
        -- Physical shrapnel damage
        table.insert(biter.dying_trigger_effect, {
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
        
    elseif typeConfig.name == "impact" then
        -- Impact boss - massive shockwave
        biter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "create-entity",
                entity_name = "big-explosion"
            }
        }
        -- Ground shake effect (smoke)
        for i = 1, 30 do
            table.insert(biter.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 8,
                offset_deviation = {{-15, -15}, {15, 15}}
            })
        end
        -- Massive shockwave with pushback
        table.insert(biter.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = 18,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 150, type = "impact"}
                        },
                        {
                            type = "push-back",
                            distance = 3
                        }
                    }
                }
            }
        })
        
    elseif typeConfig.name == "rocket" then
        -- Rocket boss - chain explosions
        biter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            }
        }
        -- Multiple explosions in area
        for i = 1, 12 do
            table.insert(biter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = "explosion",
                offset_deviation = {{-10, -10}, {10, 10}}
            })
        end
        for i = 1, 6 do
            table.insert(biter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = "big-explosion",
                offset_deviation = {{-8, -8}, {8, 8}}
            })
        end
        -- Explosion damage
        table.insert(biter.dying_trigger_effect, {
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
        
    elseif typeConfig.name == "railgun" then
        -- Railgun boss - energy discharge in lines
        biter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-artillery-explosion"
            },
            {
                type = "create-entity",
                entity_name = "explosion"
            }
        }
        -- Linear smoke trails in multiple directions
        for i = 1, 20 do
            table.insert(biter.dying_trigger_effect, {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-15, -2}, {15, 2}}
            })
        end
        -- High armor-piercing damage
        table.insert(biter.dying_trigger_effect, {
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
    
    -- Broodmother boss - spawns 2x T10 broodmother biters on death (50% each)
    elseif typeConfig.name == "broodmother" or typeConfig.special_behavior == "broodmother" then
        local offspringName = TierUtils.getEntityName("broodmother", "biter", 10)
        biter.dying_trigger_effect = {
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
        biter.dying_trigger_effect = {
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
    
    return biter
end

-- =============================================================================
-- BOSS CORPSE GENERATOR
-- =============================================================================

local function createBossBiterCorpse(typeConfig)
    local stats = Tiers.getStats("biter", typeConfig.name, 11)
    local entityName = TierUtils.getBossName(typeConfig.name, "biter")
    
    local corpse = add_biter_die_animation(
        stats.scale,
        typeConfig.colors.primary,
        typeConfig.colors.secondary,
        {
            type = "corpse",
            name = TierUtils.getCorpseName(entityName),
            icon = "__base__/graphics/icons/medium-biter-corpse.png",
            icon_size = 64,
            selectable_in_game = false,
            selection_box = {{-2, -2}, {2, 2}},
            subgroup = "corpses",
            order = string.format("c[corpse]-a[biter]-%s-boss", typeConfig.name),
            flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
        }
    )
    
    return corpse
end

-- =============================================================================
-- EXECUTE GENERATION
-- =============================================================================

local function generateBossBiters()
    local allEntities = {}
    
    -- Generate boss for all biter types (including vanilla overrides for boss variants)
    local biterTypes = BiterTypes.getAll()
    
    for _, typeConfig in ipairs(biterTypes) do
        local biter = createBossBiter(typeConfig)
        local corpse = createBossBiterCorpse(typeConfig)
        table.insert(allEntities, biter)
        table.insert(allEntities, corpse)
    end
    
    -- Register all entities
    if #allEntities > 0 then
        data:extend(allEntities)
    end
end

-- Run generation
generateBossBiters()
