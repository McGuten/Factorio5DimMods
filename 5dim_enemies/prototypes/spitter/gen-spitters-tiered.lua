-- =============================================================================
-- 5dim_enemies - Tiered Spitter Generator
-- =============================================================================
-- Generates all 10 tiers of spitters for each spitter type defined in spitter-types.lua
-- =============================================================================

local Tiers = require("prototypes.config.tiers")
local SpitterTypes = require("prototypes.config.spitter-types")
local SpawnerConfig = require("prototypes.config.spawner-config")
local TierUtils = require("prototypes.lib.tier-utils")
local SpitterAttack = require("prototypes.lib.spitter-attack")

local enemy_autoplace = require("__base__.prototypes.entity.enemy-autoplace-utils")

-- =============================================================================
-- SINGLE SPITTER GENERATOR
-- =============================================================================

-- Generate a single tiered spitter entity
-- Parameters:
--   typeConfig: The spitter type configuration
--   tier: The tier number (1-10)
-- Returns: The spitter entity definition
local function createTieredSpitter(typeConfig, tier)
    local baseTierData = Tiers.spitter[tier]
    local entityName = TierUtils.getEntityName(typeConfig.name, "spitter", tier)
    
    -- Apply type-specific multipliers
    local tierData = {
        health = math.floor(baseTierData.health * (typeConfig.health_multiplier or 1)),
        damage = math.floor(baseTierData.damage * (typeConfig.damage_multiplier or 1)),
        speed = baseTierData.speed * (typeConfig.speed_multiplier or 1),
        healing = baseTierData.healing * (typeConfig.healing_multiplier or 1),
        scale = baseTierData.scale * (typeConfig.scale_multiplier or 1),
        range = baseTierData.range
    }
    
    -- Copy from appropriate base entity
    local baseSpitter = "small-spitter"
    if tier >= 7 then
        baseSpitter = "behemoth-spitter"
    elseif tier >= 5 then
        baseSpitter = "big-spitter"
    elseif tier >= 3 then
        baseSpitter = "medium-spitter"
    end
    
    local spitter = table.deepcopy(data.raw["unit"][baseSpitter])
    
    -- Basic properties
    spitter.name = entityName
    spitter.order = string.format("b-b-%s-t%02d", typeConfig.order, tier)
    
    -- Stats (now using type-modified tierData)
    spitter.max_health = tierData.health
    spitter.movement_speed = tierData.speed
    spitter.healing_per_tick = tierData.healing
    
    -- Clear alternative attacking frame (can cause issues with custom attacks)
    spitter.alternative_attacking_frame_sequence = nil
    
    -- Resistances
    spitter.resistances = TierUtils.calculateResistances(typeConfig, tier)
    
    -- Attack parameters based on attack type
    local attackData = {
        range = tierData.range,
        damage = tierData.damage,
        scale = tierData.scale,
        tint = typeConfig.colors.primary,
        tint2 = typeConfig.colors.secondary
    }
    spitter.attack_parameters = SpitterAttack.get(typeConfig.attack_type, tier, attackData)
    
    -- Animations (using scaled size)
    spitter.run_animation = spitterrunanimation(tierData.scale, typeConfig.colors.primary, typeConfig.colors.secondary)
    spitter.water_reflection = spitter_water_reflection(tierData.scale)
    
    -- AI behavior (scales with tier)
    spitter.vision_distance = TierUtils.getVisionDistance(tier)
    spitter.min_pursue_time = TierUtils.getMinPursueTime(tier)
    spitter.max_pursue_distance = TierUtils.getMaxPursueDistance(tier)
    spitter.absorptions_to_join_attack = TierUtils.getAbsorptionsToJoinAttack(tier)
    
    -- Selection box - larger than collision for easier clicking
    -- Scale selection box with tier and type scale for better visibility
    local selectionScale = 0.8 + (tier * 0.15) -- 0.95 at T1 to 2.3 at T10
    spitter.selection_box = {{-selectionScale, -selectionScale}, {selectionScale, selectionScale}}
    
    -- Corpse reference
    spitter.corpse = TierUtils.getCorpseName(entityName)
    
    -- =============================================================================
    -- DEATH EFFECTS BY TYPE
    -- =============================================================================
    
    -- Suicide spitters - big explosion on death
    if typeConfig.special_behavior == "suicide" then
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "big-explosion"
            },
            {
                type = "damage",
                damage = { amount = tierData.damage * 2, type = "explosion" }
            },
            {
                type = "create-entity",
                entity_name = "explosion"
            }
        }
    
    -- Fire spitters - leave fire on ground when dying
    elseif typeConfig.name == "fire" then
        local fireRadius = 1 + tier * 0.7
        local fireCount = 2 + tier
        spitter.dying_trigger_effect = {}
        for i = 1, fireCount do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-fire",
                entity_name = "fire-flame",
                initial_ground_flame_count = 3 + tier * 2,
                offset_deviation = {{-fireRadius, -fireRadius}, {fireRadius, fireRadius}}
            })
        end
    
    -- Poison spitters - leave poison cloud when dying
    elseif typeConfig.name == "poison" then
        local poisonCount = math.max(1, math.floor(tier / 3))  -- Reduced count for performance
        local poisonRadius = 0.5 + tier * 0.4
        -- Select cloud size based on tier
        local cloudName = tier <= 3 and "5d-poison-cloud-small" or tier <= 6 and "5d-poison-cloud-medium" or tier <= 9 and "5d-poison-cloud-big" or "5d-poison-cloud-behemoth"
        spitter.dying_trigger_effect = {}
        for i = 1, poisonCount do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = cloudName,
                offset_deviation = {{-poisonRadius, -poisonRadius}, {poisonRadius, poisonRadius}}
            })
        end
    
    -- Electric spitters - electric discharge explosion on death
    elseif typeConfig.name == "electric" then
        local sparkCount = 2 + math.floor(tier / 2)
        local sparkRadius = 0.5 + tier * 0.4
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "explosion",
                offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
            },
            {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-sparkRadius, -sparkRadius}, {sparkRadius, sparkRadius}},
                repeat_count = sparkCount
            },
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
    
    -- Laser spitters - bright light explosion on death
    elseif typeConfig.name == "laser" then
        local lightRadius = 1 + tier * 0.3
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "laser-bubble",
                offset_deviation = {{-0.3, -0.3}, {0.3, 0.3}}
            },
            {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-lightRadius, -lightRadius}, {lightRadius, lightRadius}},
                repeat_count = 3 + tier
            },
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
    
    -- Physical spitters - debris/shrapnel explosion on death
    elseif typeConfig.name == "physical" then
        local debrisCount = 3 + tier
        local debrisRadius = 1 + tier * 0.4
        spitter.dying_trigger_effect = {
            {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 10,
                offset_deviation = {{-debrisRadius, -debrisRadius}, {debrisRadius, debrisRadius}},
                repeat_count = debrisCount
            },
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
    
    -- Rocket spitters - mini explosions on death
    elseif typeConfig.name == "rocket" then
        local explosionCount = 2 + math.floor(tier / 2)
        local explosionRadius = 1 + tier * 0.5
        spitter.dying_trigger_effect = {}
        for i = 1, explosionCount do
            table.insert(spitter.dying_trigger_effect, {
                type = "create-entity",
                entity_name = "explosion",
                offset_deviation = {{-explosionRadius, -explosionRadius}, {explosionRadius, explosionRadius}}
            })
        end
        table.insert(spitter.dying_trigger_effect, {
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
    
    -- Railgun spitters - penetrating line damage on death (Space Age)
    elseif typeConfig.name == "railgun" then
        local lineLength = 3 + tier * 0.5
        spitter.dying_trigger_effect = {
            {
                type = "create-entity",
                entity_name = "explosion",
                offset_deviation = {{-0.3, -0.3}, {0.3, 0.3}}
            },
            {
                type = "create-trivial-smoke",
                smoke_name = "smoke-explosion-particle",
                starting_frame_deviation = 5,
                offset_deviation = {{-lineLength, -0.5}, {lineLength, 0.5}},
                repeat_count = 4 + tier
            },
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
    
    -- Broodmother spitters - spawn 2 offspring of previous tier on death
    elseif typeConfig.name == "broodmother" or typeConfig.special_behavior == "broodmother" then
        -- Only spawn offspring if tier > 1 (T1 has nothing to spawn)
        if tier > 1 then
            local offspringTier = tier - 1
            local offspringName = TierUtils.getEntityName("broodmother", "spitter", offspringTier)
            local spawnRadius = 1 + tier * 0.3  -- Spread increases with tier
            
            spitter.dying_trigger_effect = {
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
            spitter.dying_trigger_effect = {
                {
                    type = "create-entity",
                    entity_name = "blood-explosion-big",
                    offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
                }
            }
        end
    end
    
    return spitter
end

-- =============================================================================
-- CORPSE GENERATOR
-- =============================================================================

-- Generate corpse for a tiered spitter
local function createTieredSpitterCorpse(typeConfig, tier)
    local baseTierData = Tiers.spitter[tier]
    local entityName = TierUtils.getEntityName(typeConfig.name, "spitter", tier)
    
    -- Apply scale multiplier for corpse
    local scale = baseTierData.scale * (typeConfig.scale_multiplier or 1)
    
    local corpse = add_spitter_die_animation(
        scale,
        typeConfig.colors.primary,
        typeConfig.colors.secondary,
        {
            type = "corpse",
            name = TierUtils.getCorpseName(entityName),
            icon = "__base__/graphics/icons/medium-spitter-corpse.png",
            icon_size = 64,
            selectable_in_game = false,
            selection_box = {{-1, -1}, {1, 1}},
            subgroup = "corpses",
            order = string.format("c[corpse]-b[spitter]-%s-t%02d", typeConfig.name, tier),
            flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
        }
    )
    
    return corpse
end

-- =============================================================================
-- SPAWNER GENERATOR
-- =============================================================================

-- Generate spawner for a spitter type
local function createSpitterSpawner(typeConfig)
    local spawnerName = TierUtils.getSpawnerName(typeConfig.name, "spitter")
    
    local spawner = table.deepcopy(data.raw["unit-spawner"]["spitter-spawner"])
    
    -- Basic properties
    spawner.name = spawnerName
    spawner.order = string.format("b-d-b-%s", typeConfig.order)
    
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
    -- Spitters also get +5% evolution offset via SPITTER_EVOLUTION_OFFSET
    spawner.result_units = {}
    
    -- If this type has evolution_min > 0, add normal spitter T1 as filler
    -- This ensures the spawner always has something to spawn from evolution 0
    local fillerCurve = Tiers.getNormalFillerCurve(typeConfig.name, "spitter")
    if fillerCurve and typeConfig.name ~= "normal" then
        local normalT1Name = TierUtils.getEntityName("normal", "spitter", 1)
        table.insert(spawner.result_units, {normalT1Name, fillerCurve})
        log("[5dim_enemies] Added normal filler to " .. spawnerName .. ": " .. normalT1Name .. " curve: 0.0-" .. fillerCurve[2][1])
    end
    
    for tier = 1, Tiers.COUNT do
        local unitName = TierUtils.getEntityName(typeConfig.name, "spitter", tier)
        local curve = Tiers.getSpawnCurve(typeConfig.name, tier, "spitter")
        table.insert(spawner.result_units, {unitName, curve})
    end
    
    -- Add boss if enabled
    if TierUtils.isBossEnabled() then
        local bossName = TierUtils.getBossName(typeConfig.name, "spitter")
        local bossCurve = Tiers.getSpawnCurve(typeConfig.name, 11, "spitter")
        table.insert(spawner.result_units, {bossName, bossCurve})
    end
    
    -- Log total result units for debugging
    log("[5dim_enemies] Spawner " .. spawnerName .. " has " .. #spawner.result_units .. " result_units")
    
    -- Autoplace with intelligent system:
    -- - Uses distance_factor from SharedConfig (stronger types spawn farther)
    -- - Divides probability by number of active types (balances total spawner count)
    local autoplaceExpression = SpawnerConfig.buildAutoplaceExpression(typeConfig.name, "spitter")
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

-- Generate all tiered spitters for a specific type
local function generateSpitterType(typeConfig)
    local entities = {}
    
    -- Generate all 10 tiers
    for tier = 1, Tiers.COUNT do
        local spitter = createTieredSpitter(typeConfig, tier)
        local corpse = createTieredSpitterCorpse(typeConfig, tier)
        table.insert(entities, spitter)
        table.insert(entities, corpse)
    end
    
    -- Generate spawner for this type (only for new types, not vanilla override)
    if not typeConfig.is_vanilla_override then
        local spawner = createSpitterSpawner(typeConfig)
        table.insert(entities, spawner)
    end
    
    return entities
end

-- =============================================================================
-- EXECUTE GENERATION
-- =============================================================================

-- Generate all spitter types
local function generateAllSpitters()
    local allEntities = {}
    
    -- Get all spitter types (excluding vanilla overrides for now)
    local spitterTypes = SpitterTypes.getNew()
    
    -- Debug: Log which types are being generated
    log("[5dim_enemies] Generating " .. #spitterTypes .. " spitter types:")
    for i, typeConfig in ipairs(spitterTypes) do
        log("[5dim_enemies]   " .. i .. ". " .. typeConfig.name .. " (setting: " .. (typeConfig.requires_setting or "none") .. ")")
    end
    
    for _, typeConfig in ipairs(spitterTypes) do
        local entities = generateSpitterType(typeConfig)
        for _, entity in ipairs(entities) do
            table.insert(allEntities, entity)
        end
    end
    
    -- Register all entities
    if #allEntities > 0 then
        data:extend(allEntities)
        log("[5dim_enemies] Registered " .. #allEntities .. " spitter entities (spitters + corpses + spawners)")
    end
end

-- Run generation
generateAllSpitters()
