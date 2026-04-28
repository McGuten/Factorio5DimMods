-- =============================================================================
-- 5dim_enemies - Tiered Biter Generator
-- =============================================================================
-- Generates all 10 tiers of biters for each biter type defined in biter-types.lua
-- =============================================================================

local Tiers = require("prototypes.config.tiers")
local BiterTypes = require("prototypes.config.biter-types")
local SpawnerConfig = require("prototypes.config.spawner-config")
local TierUtils = require("prototypes.lib.tier-utils")

local enemy_autoplace = require("__base__.prototypes.entity.enemy-autoplace-utils")

-- =============================================================================
-- SINGLE BITER GENERATOR
-- =============================================================================

-- Generate a single tiered biter entity
-- Parameters:
--   typeConfig: The biter type configuration
--   tier: The tier number (1-10)
-- Returns: The biter entity definition
local function createTieredBiter(typeConfig, tier)
    local baseTierData = Tiers.biter[tier]
    local entityName = TierUtils.getEntityName(typeConfig.name, "biter", tier)
    
    -- Apply type-specific multipliers
    local tierData = {
        health = math.floor(baseTierData.health * (typeConfig.health_multiplier or 1)),
        damage = math.floor(baseTierData.damage * (typeConfig.damage_multiplier or 1)),
        speed = baseTierData.speed * (typeConfig.speed_multiplier or 1),
        healing = baseTierData.healing * (typeConfig.healing_multiplier or 1),
        scale = baseTierData.scale * (typeConfig.scale_multiplier or 1)
    }
    
    -- Copy from appropriate base entity
    local baseBiter = "small-biter"
    if tier >= 7 then
        baseBiter = "behemoth-biter"
    elseif tier >= 5 then
        baseBiter = "big-biter"
    elseif tier >= 3 then
        baseBiter = "medium-biter"
    end
    
    local biter = table.deepcopy(data.raw["unit"][baseBiter])
    
    -- Basic properties
    biter.name = entityName
    biter.order = string.format("b-a-%s-t%02d", typeConfig.order, tier)
    
    -- Stats (now using type-modified tierData)
    biter.max_health = tierData.health
    biter.movement_speed = tierData.speed
    biter.healing_per_tick = tierData.healing
    
    -- Resistances
    biter.resistances = TierUtils.calculateResistances(typeConfig, tier)
    
    -- Attack parameters with typed damage
    biter.attack_parameters = {
        type = "projectile",
        range = TierUtils.getMeleeRangeBonus(tier),
        cooldown = TierUtils.getAttackCooldown(tier),
        cooldown_deviation = 0.15,
        ammo_category = "melee",
        ammo_type = TierUtils.makeMeleeAmmoType(tierData.damage, typeConfig.name, tier),
        animation = biterattackanimation(tierData.scale, typeConfig.colors.primary, typeConfig.colors.secondary),
        range_mode = "bounding-box-to-bounding-box"
    }
    
    -- Animations (using scaled size)
    biter.run_animation = biterrunanimation(tierData.scale, typeConfig.colors.primary, typeConfig.colors.secondary)
    biter.water_reflection = biter_water_reflection(tierData.scale)
    
    -- AI behavior (scales with tier)
    biter.vision_distance = TierUtils.getVisionDistance(tier)
    biter.min_pursue_time = TierUtils.getMinPursueTime(tier)
    biter.max_pursue_distance = TierUtils.getMaxPursueDistance(tier)
    biter.absorptions_to_join_attack = TierUtils.getAbsorptionsToJoinAttack(tier)
    
    -- Selection box - larger than collision for easier clicking
    -- Scale selection box with tier and type scale for better visibility
    local selectionScale = (0.8 + (tier * 0.15)) * (typeConfig.scale_multiplier or 1)
    biter.selection_box = {{-selectionScale, -selectionScale}, {selectionScale, selectionScale}}
    
    -- Corpse reference
    biter.corpse = TierUtils.getCorpseName(entityName)
    
    -- =============================================================================
    -- DEATH EFFECTS BY TYPE
    -- =============================================================================
    
    -- Fire biters - leave fire on ground when dying
    if typeConfig.name == "fire" then
        local fireRadius = 1 + tier * 0.7  -- T1: ~2 tiles, T10: ~8 tiles
        local fireCount = 2 + tier
        biter.dying_trigger_effect = {}
        for i = 1, fireCount do
            table.insert(biter.dying_trigger_effect, {
                type = "create-fire",
                entity_name = "fire-flame",
                initial_ground_flame_count = 3 + tier * 2,
                offset_deviation = {{-fireRadius, -fireRadius}, {fireRadius, fireRadius}}
            })
        end
    
    -- Poison biters - leave poison cloud when dying
    elseif typeConfig.name == "poison" then
        local poisonCount = math.max(1, math.floor(tier / 3))  -- 1 at T1-T2, 2 at T3-T5, 3 at T6-T8, 4 at T9-T10 (reduced for performance)
        local poisonRadius = 0.5 + tier * 0.4
        -- Select cloud size based on tier
        local cloudName = tier <= 3 and "5d-poison-cloud-small" or tier <= 6 and "5d-poison-cloud-medium" or tier <= 9 and "5d-poison-cloud-big" or "5d-poison-cloud-behemoth"
        biter.dying_trigger_effect = {}
        for i = 1, poisonCount do
            table.insert(biter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = cloudName,
                offset_deviation = {{-poisonRadius, -poisonRadius}, {poisonRadius, poisonRadius}}
            })
        end
    
    -- Electric biters - electric discharge explosion on death
    elseif typeConfig.name == "electric" then
        local sparkCount = 2 + math.floor(tier / 2)  -- 2 at T1, 7 at T10
        local sparkRadius = 0.5 + tier * 0.4  -- Spreads with tier
        biter.dying_trigger_effect = {
            -- Main electric explosion
            {
                type = "create-entity",
                entity_name = "explosion",
                offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
            },
            -- Visual spark effect
            {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-sparkRadius, -sparkRadius}, {sparkRadius, sparkRadius}},
                repeat_count = sparkCount
            },
            -- Electric stun area damage
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 2 + tier * 0.5,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = {amount = 5 + tier * 3, type = "electric"}
                            },
                            {
                                type = "create-sticker",
                                sticker = "slowdown-sticker"
                            }
                        }
                    }
                }
            }
        }
    
    -- Laser biters - bright light explosion on death
    elseif typeConfig.name == "laser" then
        local lightRadius = 1 + tier * 0.3
        biter.dying_trigger_effect = {
            -- Bright flash
            {
                type = "create-entity",
                entity_name = "laser-bubble",
                offset_deviation = {{-0.3, -0.3}, {0.3, 0.3}}
            },
            -- Laser explosion visual
            {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-lightRadius, -lightRadius}, {lightRadius, lightRadius}},
                repeat_count = 3 + tier
            },
            -- Small laser damage in area
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 1.5 + tier * 0.3,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = {amount = 3 + tier * 2, type = "laser"}
                            }
                        }
                    }
                }
            }
        }
    
    -- Physical biters - debris/shrapnel explosion on death
    elseif typeConfig.name == "physical" then
        local debrisCount = 3 + tier  -- More debris at higher tiers
        local debrisRadius = 1 + tier * 0.4
        biter.dying_trigger_effect = {
            -- Debris/rock particles
            {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 10,
                offset_deviation = {{-debrisRadius, -debrisRadius}, {debrisRadius, debrisRadius}},
                repeat_count = debrisCount
            },
            -- Physical shrapnel damage
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 1.5 + tier * 0.3,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = {amount = 5 + tier * 2, type = "physical"}
                            }
                        }
                    }
                }
            }
        }
    
    -- Impact biters - shockwave explosion on death
    elseif typeConfig.name == "impact" then
        local shockwaveRadius = 2 + tier * 0.5  -- Large impact area
        biter.dying_trigger_effect = {
            -- Ground shake visual
            {
                type = "create-entity",
                entity_name = "big-explosion",
                offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
            },
            -- Smoke cloud from impact
            {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-shockwaveRadius, -shockwaveRadius}, {shockwaveRadius, shockwaveRadius}},
                repeat_count = 5 + tier
            },
            -- Shockwave pushback and damage
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = shockwaveRadius,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = {amount = 10 + tier * 4, type = "impact"}
                            },
                            {
                                type = "push-back",
                                distance = 0.5 + tier * 0.1
                            }
                        }
                    }
                }
            }
        }
    
    -- Rocket biters - mini explosions on death
    elseif typeConfig.name == "rocket" then
        local explosionCount = 2 + math.floor(tier / 2)
        local explosionRadius = 1 + tier * 0.5
        biter.dying_trigger_effect = {}
        -- Multiple small explosions
        for i = 1, explosionCount do
            table.insert(biter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = "explosion",
                offset_deviation = {{-explosionRadius, -explosionRadius}, {explosionRadius, explosionRadius}}
            })
        end
        -- Explosion damage
        table.insert(biter.dying_trigger_effect, {
            type = "nested-result",
            action = {
                type = "area",
                radius = 2 + tier * 0.4,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = 8 + tier * 3, type = "explosion"}
                        }
                    }
                }
            }
        })
    
    -- Railgun biters - penetrating line damage on death (Space Age)
    elseif typeConfig.name == "railgun" then
        local lineLength = 3 + tier * 0.5
        biter.dying_trigger_effect = {
            -- Energy discharge visual
            {
                type = "create-entity",
                entity_name = "explosion",
                offset_deviation = {{-0.3, -0.3}, {0.3, 0.3}}
            },
            -- Smoke trail
            {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-lineLength, -0.5}, {lineLength, 0.5}},
                repeat_count = 4 + tier
            },
            -- Armor-piercing damage in line
            {
                type = "nested-result",
                action = {
                    type = "area",
                    radius = 2 + tier * 0.3,
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = {amount = 15 + tier * 5, type = "physical"}
                            }
                        }
                    }
                }
            }
        }
    
    -- Broodmother biters - spawn 2 offspring of previous tier on death
    elseif typeConfig.name == "broodmother" or typeConfig.special_behavior == "broodmother" then
        -- Only spawn offspring if tier > 1 (T1 has nothing to spawn)
        if tier > 1 then
            local offspringTier = tier - 1
            local offspringName = TierUtils.getEntityName("broodmother", "biter", offspringTier)
            local spawnRadius = 1 + tier * 0.3  -- Spread increases with tier
            
            biter.dying_trigger_effect = {
                -- Death explosion
                {
                    type = "create-entity",
                    entity_name = "blood-explosion-big",
                    offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
                },
                -- Spawn first offspring (50% chance)
                {
                    type = "create-entity",
                    entity_name = offspringName,
                    offset_deviation = {{-spawnRadius, -spawnRadius}, {spawnRadius, spawnRadius}},
                    trigger_created_entity = true,
                    probability = 0.5
                },
                -- Spawn second offspring (50% chance)
                {
                    type = "create-entity",
                    entity_name = offspringName,
                    offset_deviation = {{-spawnRadius, -spawnRadius}, {spawnRadius, spawnRadius}},
                    trigger_created_entity = true,
                    probability = 0.5
                }
            }
        else
            -- T1 broodmother just has a blood explosion
            biter.dying_trigger_effect = {
                {
                    type = "create-entity",
                    entity_name = "blood-explosion-big",
                    offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
                }
            }
        end
    end
    
    return biter
end

-- =============================================================================
-- CORPSE GENERATOR
-- =============================================================================

-- Generate corpse for a tiered biter
local function createTieredBiterCorpse(typeConfig, tier)
    local baseTierData = Tiers.biter[tier]
    local entityName = TierUtils.getEntityName(typeConfig.name, "biter", tier)
    
    -- Apply scale multiplier for corpse
    local scale = baseTierData.scale * (typeConfig.scale_multiplier or 1)
    
    local corpse = add_biter_die_animation(
        scale,
        typeConfig.colors.primary,
        typeConfig.colors.secondary,
        {
            type = "corpse",
            name = TierUtils.getCorpseName(entityName),
            icon = "__base__/graphics/icons/medium-biter-corpse.png",
            icon_size = 64,
            selectable_in_game = false,
            selection_box = {{-1, -1}, {1, 1}},
            subgroup = "corpses",
            order = string.format("c[corpse]-a[biter]-%s-t%02d", typeConfig.name, tier),
            flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
        }
    )
    
    return corpse
end

-- =============================================================================
-- SPAWNER GENERATOR
-- =============================================================================

-- Generate spawner for a biter type
local function createBiterSpawner(typeConfig)
    local spawnerName = TierUtils.getSpawnerName(typeConfig.name, "biter")
    
    local spawner = table.deepcopy(data.raw["unit-spawner"]["biter-spawner"])
    
    -- Basic properties
    spawner.name = spawnerName
    spawner.order = string.format("b-d-a-%s", typeConfig.order)
    
    -- Apply spawner multipliers if defined
    local cooldownMultiplier = typeConfig.spawner_cooldown_multiplier or 1.0
    local maxCountMultiplier = typeConfig.spawner_max_count_multiplier or 1.0
    
    -- Spawning cooldown: {max_ticks, min_ticks} - lower = faster
    if spawner.spawning_cooldown then
        spawner.spawning_cooldown = {
            math.floor(spawner.spawning_cooldown[1] * cooldownMultiplier),
            math.floor(spawner.spawning_cooldown[2] * cooldownMultiplier)
        }
    end
    
    -- Max owned units - multiplied and rounded
    if spawner.max_count_of_owned_units then
        spawner.max_count_of_owned_units = math.floor(spawner.max_count_of_owned_units * maxCountMultiplier)
    end
    
    -- Use specific spawner tint if defined, otherwise use a tinted version of primary color
    local spawnerTint = typeConfig.spawner_tint or {
        typeConfig.colors.primary.r or typeConfig.colors.primary[1],
        typeConfig.colors.primary.g or typeConfig.colors.primary[2],
        typeConfig.colors.primary.b or typeConfig.colors.primary[3],
        0.5  -- Reduce alpha for better blending
    }
    
    -- Visuals with type color
    spawner.graphics_set = {
        animations = {
            spawner_idle_animation(0, spawnerTint),
            spawner_idle_animation(1, spawnerTint),
            spawner_idle_animation(2, spawnerTint),
            spawner_idle_animation(3, spawnerTint)
        }
    }
    
    -- Resistances (spawner-specific)
    spawner.resistances = {
        { type = "physical", decrease = 2, percent = 15 },
        { type = "explosion", decrease = 5, percent = 15 },
        { type = "fire", decrease = 3, percent = 60 }
    }
    
    -- If this is a specialized type, add its primary resistance at tier 3 values
    -- Tier 3 = base + (3-1) * per_tier = base + 2 * per_tier
    if not typeConfig.is_vanilla_override and typeConfig.resistances.base then
        for _, res in pairs(typeConfig.resistances.base) do
            -- Find matching per_tier increment
            local decreaseIncrement = 0
            local percentIncrement = 0
            if typeConfig.resistances.per_tier then
                for _, perTierRes in pairs(typeConfig.resistances.per_tier) do
                    if perTierRes.type == res.type then
                        decreaseIncrement = perTierRes.decrease_increment or 0
                        percentIncrement = perTierRes.percent_increment or 0
                        break
                    end
                end
            end
            
            -- Calculate tier 3 values
            local tier3Decrease = (res.decrease or 0) + 2 * decreaseIncrement
            local tier3Percent = (res.percent or 0) + 2 * percentIncrement
            
            -- Apply caps if defined
            if typeConfig.resistances.max_decrease then
                tier3Decrease = math.min(tier3Decrease, typeConfig.resistances.max_decrease)
            end
            if typeConfig.resistances.max_percent then
                tier3Percent = math.min(tier3Percent, typeConfig.resistances.max_percent)
            end
            
            table.insert(spawner.resistances, {
                type = res.type,
                decrease = tier3Decrease,
                percent = tier3Percent
            })
        end
    end
    
    -- Generate result units (all 10 tiers + boss if enabled)
    -- Uses Tiers.getSpawnCurve which respects TypeMultipliers.evolution_min/max
    spawner.result_units = {}
    
    -- If this type has evolution_min > 0, add normal biter T1 as filler
    -- This ensures the spawner always has something to spawn from evolution 0
    local fillerCurve = Tiers.getNormalFillerCurve(typeConfig.name, "biter")
    if fillerCurve and typeConfig.name ~= "normal" then
        local normalT1Name = TierUtils.getEntityName("normal", "biter", 1)
        table.insert(spawner.result_units, {normalT1Name, fillerCurve})
        log("[5dim_enemies] Added normal filler to " .. spawnerName .. ": " .. normalT1Name .. " curve: 0.0-" .. fillerCurve[2][1])
    end
    
    for tier = 1, Tiers.COUNT do
        local unitName = TierUtils.getEntityName(typeConfig.name, "biter", tier)
        local curve = Tiers.getSpawnCurve(typeConfig.name, tier, "biter")
        table.insert(spawner.result_units, {unitName, curve})
    end
    
    -- Add boss if enabled
    if TierUtils.isBossEnabled() then
        local bossName = TierUtils.getBossName(typeConfig.name, "biter")
        local bossCurve = Tiers.getSpawnCurve(typeConfig.name, 11, "biter")
        table.insert(spawner.result_units, {bossName, bossCurve})
    end
    
    -- Log total result units for debugging
    log("[5dim_enemies] Spawner " .. spawnerName .. " has " .. #spawner.result_units .. " result_units")
    
    -- Autoplace with intelligent system:
    -- - Uses distance_factor from SharedConfig (stronger types spawn farther)
    -- - Divides probability by number of active types (balances total spawner count)
    local autoplaceExpression = SpawnerConfig.buildAutoplaceExpression(typeConfig.name, "biter")
    spawner.autoplace = enemy_autoplace.enemy_spawner_autoplace(autoplaceExpression)
    
    -- Log spawner stats including multipliers
    local cooldownStr = spawner.spawning_cooldown and string.format("{%d, %d}", spawner.spawning_cooldown[1], spawner.spawning_cooldown[2]) or "default"
    local distanceFactor = SpawnerConfig.getDistanceFactor(typeConfig.name)
    log("[5dim_enemies] Created spawner: " .. spawner.name .. " | max_count=" .. (spawner.max_count_of_owned_units or 7) .. " | cooldown=" .. cooldownStr .. " | distance_factor=" .. distanceFactor)
    
    return spawner
end

-- =============================================================================
-- MAIN GENERATION FUNCTION
-- =============================================================================

-- Generate all tiered biters for a specific type
local function generateBiterType(typeConfig)
    local entities = {}
    
    -- Generate all 10 tiers
    for tier = 1, Tiers.COUNT do
        local biter = createTieredBiter(typeConfig, tier)
        local corpse = createTieredBiterCorpse(typeConfig, tier)
        table.insert(entities, biter)
        table.insert(entities, corpse)
    end
    
    -- Generate spawner for this type (only for new types, not vanilla override)
    if not typeConfig.is_vanilla_override then
        local spawner = createBiterSpawner(typeConfig)
        table.insert(entities, spawner)
    end
    
    return entities
end

-- =============================================================================
-- EXECUTE GENERATION
-- =============================================================================

-- Generate all biter types
local function generateAllBiters()
    local allEntities = {}
    
    -- Get all biter types (excluding vanilla overrides for now)
    local biterTypes = BiterTypes.getNew()
    
    -- Debug: Log which types are being generated
    log("[5dim_enemies] Generating " .. #biterTypes .. " biter types:")
    for i, typeConfig in ipairs(biterTypes) do
        log("[5dim_enemies]   " .. i .. ". " .. typeConfig.name .. " (setting: " .. (typeConfig.requires_setting or "none") .. ")")
    end
    
    for _, typeConfig in ipairs(biterTypes) do
        local entities = generateBiterType(typeConfig)
        for _, entity in ipairs(entities) do
            table.insert(allEntities, entity)
        end
    end
    
    -- Register all entities
    if #allEntities > 0 then
        data:extend(allEntities)
        log("[5dim_enemies] Registered " .. #allEntities .. " biter entities (biters + corpses + spawners)")
    end
end

-- Run generation
generateAllBiters()
