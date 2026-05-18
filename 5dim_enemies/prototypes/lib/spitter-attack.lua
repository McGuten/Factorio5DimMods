-- =============================================================================
-- 5dim_enemies - Spitter Attack Parameters
-- =============================================================================
-- Defines attack parameters for different spitter attack types.
-- This module is used by gen-spitters-tiered.lua
-- =============================================================================

-- Require base game spitter animations and enemy constants
require("__base__/prototypes/entity/spitter-animations")
require("__base__/prototypes/entity/enemy-constants")
require("__base__/prototypes/entity/enemy-projectiles")

local SpitterAttack = {}

-- =============================================================================
-- ACID ATTACK (Standard spitter attack)
-- =============================================================================

function SpitterAttack.acid(tier, data)
    local acidStreamNames = {
        [1] = "acid-stream-spitter-small",
        [2] = "acid-stream-spitter-small",
        [3] = "acid-stream-spitter-small",
        [4] = "acid-stream-spitter-medium",
        [5] = "acid-stream-spitter-medium",
        [6] = "acid-stream-spitter-big",
        [7] = "acid-stream-spitter-big",
        [8] = "acid-stream-spitter-behemoth",
        [9] = "acid-stream-spitter-behemoth",
        [10] = "acid-stream-spitter-behemoth"
    }
    
    local minAttackDistance = 6 + math.floor(tier / 3)
    local cooldown = math.max(60, 100 - (tier * 4))
    local roarVolume = 0.3 + (tier * 0.07)
    
    -- Use appropriate base function based on tier
    if tier <= 3 then
        return spitter_attack_parameters({
            acid_stream_name = acidStreamNames[tier],
            range = data.range,
            min_attack_distance = minAttackDistance,
            cooldown = cooldown,
            cooldown_deviation = 0.15,
            damage_modifier = data.damage,
            scale = data.scale,
            tint1 = data.tint,
            tint2 = data.tint2,
            roarvolume = roarVolume
        })
    elseif tier <= 5 then
        return spitter_mid_attack_parameters({
            acid_stream_name = acidStreamNames[tier],
            range = data.range,
            min_attack_distance = minAttackDistance,
            cooldown = cooldown,
            cooldown_deviation = 0.15,
            damage_modifier = data.damage,
            scale = data.scale,
            tint1 = data.tint,
            tint2 = data.tint2,
            roarvolume = roarVolume
        })
    elseif tier <= 7 then
        return spitter_big_attack_parameters({
            acid_stream_name = acidStreamNames[tier],
            range = data.range,
            min_attack_distance = minAttackDistance,
            cooldown = cooldown,
            cooldown_deviation = 0.15,
            damage_modifier = data.damage,
            scale = data.scale,
            tint1 = data.tint,
            tint2 = data.tint2,
            roarvolume = roarVolume
        })
    else
        return spitter_behemoth_attack_parameters({
            acid_stream_name = acidStreamNames[tier],
            range = data.range,
            min_attack_distance = minAttackDistance,
            cooldown = cooldown,
            cooldown_deviation = 0.15,
            damage_modifier = data.damage,
            scale = data.scale,
            tint1 = data.tint,
            tint2 = data.tint2,
            roarvolume = roarVolume
        })
    end
end

-- =============================================================================
-- FIRE ATTACK (Flamethrower stream)
-- =============================================================================

function SpitterAttack.fire(tier, data)
    local cooldown = math.max(40, 70 - (tier * 3))
    local minRange = 4 + math.floor(tier / 2)
    
    return {
        type = "stream",
        cooldown = cooldown,
        range = data.range,
        min_range = minRange,
        turn_range = 1.0 / 3.0,
        fire_penalty = 15,
        warmup = 30,
        -- Use the same projectile creation system as vanilla spitters
        projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
        use_shooter_direction = true,
        ammo_category = "flamethrower",
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = "flamethrower-fire-stream"
                }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

-- =============================================================================
-- ROCKET ATTACK (Explosive projectiles)
-- =============================================================================

function SpitterAttack.rocket(tier, data)
    local cooldown = math.max(100, 180 - (tier * 8))
    local projectileType = tier >= 7 and "explosive-rocket" or "rocket"
    local startingSpeed = math.min(0.1 + (tier * 0.015), 0.22)
    local maxRange = data.range + 1
    local damageModifier = data.damage / 32
    
    return {
        type = "projectile",
        ammo_category = "rocket",
        cooldown = cooldown,
        range = data.range,
        projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
        damage_modifier = damageModifier,
        warmup = 30,
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = projectileType,
                    starting_speed = startingSpeed,
                    max_range = maxRange,
                    source_effects = {
                        type = "create-entity",
                        entity_name = "explosion-hit"
                    }
                }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

-- =============================================================================
-- EXPLOSIVE/SUICIDE ATTACK (Self-destruct)
-- =============================================================================

function SpitterAttack.explosive(tier, data)
    return {
        type = "projectile",
        ammo_category = "rocket",
        cooldown = 60,
        range = 1,  -- Must get very close
        projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
        damage_modifier = data.damage / 5,
        warmup = 30,
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = "explosive-rocket",
                    starting_speed = 0.1,
                    source_effects = {
                        type = "create-entity",
                        entity_name = "explosion-hit"
                    }
                }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

-- =============================================================================
-- LASER ATTACK (Laser projectile bursts - discontinuous shots)
-- =============================================================================

function SpitterAttack.laser(tier, data)
    local cooldown = math.max(20, 40 - (tier * 2))
    
    return {
        type = "projectile",
        ammo_category = "biological",
        cooldown = cooldown,
        range = data.range,
        projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
        damage_modifier = data.damage / 12,
        warmup = 8,
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    source_effects = {
                        {
                            type = "create-explosion",
                            entity_name = "laser-bubble"
                        }
                    },
                    target_effects = {
                        {
                            type = "create-entity",
                            entity_name = "laser-bubble"
                        },
                        {
                            type = "damage",
                            damage = { amount = 8 + (tier * 2), type = "laser" }
                        }
                    }
                }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

-- =============================================================================
-- ELECTRIC ATTACK (Electric beam)
-- =============================================================================

function SpitterAttack.electric(tier, data)
    local cooldown = math.max(30, 60 - (tier * 3))
    local beamDuration = 12 + (tier * 2)
    
    return {
        type = "beam",
        ammo_category = "biological",
        cooldown = cooldown,
        range = data.range,
        damage_modifier = data.damage / 10,  -- Beam does base damage
        warmup = 8,
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "beam",
                    beam = "electric-beam",
                    max_length = data.range,
                    duration = beamDuration,
                    source_offset = {0, -0.5}
                }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

-- =============================================================================
-- POISON ATTACK (Uses poison stream, creates poison cloud on impact)
-- =============================================================================

function SpitterAttack.poison(tier, data)
    local cooldown = math.max(80, 140 - (tier * 6))
    local minAttackDistance = 6 + math.floor(tier / 3)
    local roarVolume = 0.3 + (tier * 0.07)
    
    -- Select poison stream based on tier (creates poison cloud on impact)
    local streamNames = {
        [1] = "5d-poison-stream-spitter-small",
        [2] = "5d-poison-stream-spitter-small",
        [3] = "5d-poison-stream-spitter-small",
        [4] = "5d-poison-stream-spitter-medium",
        [5] = "5d-poison-stream-spitter-medium",
        [6] = "5d-poison-stream-spitter-big",
        [7] = "5d-poison-stream-spitter-big",
        [8] = "5d-poison-stream-spitter-behemoth",
        [9] = "5d-poison-stream-spitter-behemoth",
        [10] = "5d-poison-stream-spitter-behemoth"
    }
    
    -- Use the standard spitter attack with poison stream
    return {
        type = "stream",
        ammo_category = "biological",
        cooldown = cooldown,
        cooldown_deviation = 0.15,
        range = data.range,
        min_attack_distance = minAttackDistance,
        damage_modifier = data.damage / 20,  -- Base damage is low, poison cloud does the work
        warmup = 30,
        projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
        use_shooter_direction = true,
        lead_target_for_projectile_speed = 0.2 * 0.75 * 1.5 * 1.5,
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = streamNames[tier] or "5d-poison-stream-spitter-medium"
                }
            }
        },
        cyclic_sound = {
            begin_sound = {
                category = "enemy",
                variations = sound_variations("__base__/sound/creatures/spitter-spit-start", 4, 0.27 * roarVolume),
                aggregation = { max_count = 1, remove = true, count_already_playing = true }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

-- =============================================================================
-- PHYSICAL ATTACK (Cannon projectile - throws rocks)
-- =============================================================================

function SpitterAttack.physical(tier, data)
    local cooldown = math.max(60, 100 - (tier * 4))
    local startingSpeed = math.min(0.12 + (tier * 0.008), 0.2)
    local maxRange = data.range + 1
    
    return {
        type = "projectile",
        ammo_category = "biological",
        cooldown = cooldown,
        range = data.range,
        projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
        damage_modifier = data.damage / 8,  -- Cannon has base damage
        warmup = 15,
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = "5d-physical-spitter-projectile",
                    starting_speed = startingSpeed,
                    max_range = maxRange,
                    source_effects = {
                        type = "create-entity",
                        entity_name = "explosion-hit"
                    }
                }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

-- =============================================================================
-- RAILGUN ATTACK (Space Age - High-velocity armor-piercing line attack)
-- Uses the same beam visual as the railgun turret
-- =============================================================================

function SpitterAttack.railgun(tier, data)
    local cooldown = math.max(120, 180 - (tier * 6))  -- Slow but powerful
    local attackRange = data.range + 2
    local baseDamage = math.floor(data.damage * 2.5)
    
    return {
        type = "beam",
        ammo_category = "biological",
        cooldown = cooldown,
        range = attackRange,
        warmup = 30,  -- Longer charge-up like railgun turret
        ammo_type = {
            action = {
                type = "line",
                range = attackRange,
                width = 0.5,
                range_effects = {
                    type = "create-explosion",
                    entity_name = "railgun-beam"
                },
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "damage",
                            damage = {amount = baseDamage, type = "physical"}
                        },
                        {
                            type = "create-entity",
                            entity_name = "explosion-hit"
                        }
                    }
                }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

-- =============================================================================
-- BOSS ACID ATTACK (For boss spitters, tier 11)
-- =============================================================================

function SpitterAttack.boss_acid(data)
    return spitter_behemoth_attack_parameters({
        acid_stream_name = "acid-stream-spitter-behemoth",
        range = data.range,
        min_attack_distance = 12,
        cooldown = 50,
        cooldown_deviation = 0.1,
        damage_modifier = data.damage,
        scale = data.scale,
        tint1 = data.tint,
        tint2 = data.tint2,
        roarvolume = 1.0
    })
end

function SpitterAttack.boss_fire(data)
    return {
        type = "stream",
        cooldown = 40,
        range = data.range,
        min_range = 8,
        turn_range = 1.0 / 3.0,
        fire_penalty = 15,
        warmup = 30,
        projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
        use_shooter_direction = true,
        ammo_category = "flamethrower",
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = "flamethrower-fire-stream"
                }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

function SpitterAttack.boss_rocket(data)
    local maxRange = data.range + 1
    local damageModifier = data.damage / 64

    return {
        type = "projectile",
        ammo_category = "rocket",
        cooldown = 80,
        range = data.range,
        projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
        damage_modifier = damageModifier,
        warmup = 30,
        ammo_type = {
            action = {
                type = "direct",
                action_delivery = {
                    type = "projectile",
                    projectile = "explosive-rocket",
                    starting_speed = 0.22,
                    max_range = maxRange,
                    source_effects = {
                        type = "create-entity",
                        entity_name = "big-explosion"
                    }
                }
            }
        },
        animation = spitterattackanimation(data.scale, data.tint, data.tint2)
    }
end

-- =============================================================================
-- ATTACK TYPE SELECTOR
-- =============================================================================

-- Get attack parameters based on attack type
-- Parameters:
--   attackType: "acid", "fire", "rocket", "explosive", "laser", "electric", "poison", "physical", "railgun"
--   tier: 1-10 for normal, 11 for boss
--   data: { range, damage, scale, tint, tint2 }
function SpitterAttack.get(attackType, tier, data)
    if tier == 11 or tier == nil then
        -- Boss attack (tier 11)
        if attackType == "fire" then
            return SpitterAttack.boss_fire(data)
        elseif attackType == "rocket" then
            return SpitterAttack.boss_rocket(data)
        elseif attackType == "acid" or attackType == nil then
            return SpitterAttack.boss_acid(data)
        else
            -- Boss stats already come scaled from Tiers.getStats(..., 11), so
            -- unsupported boss-specific variants should reuse their normal
            -- attack family instead of silently becoming acid attacks.
            return SpitterAttack.get(attackType, 10, data)
        end
    end
    
    -- Normal tiered attack
    if attackType == "fire" then
        return SpitterAttack.fire(tier, data)
    elseif attackType == "rocket" then
        return SpitterAttack.rocket(tier, data)
    elseif attackType == "explosive" then
        return SpitterAttack.explosive(tier, data)
    elseif attackType == "laser" then
        return SpitterAttack.laser(tier, data)
    elseif attackType == "electric" then
        return SpitterAttack.electric(tier, data)
    elseif attackType == "poison" then
        return SpitterAttack.poison(tier, data)
    elseif attackType == "physical" then
        return SpitterAttack.physical(tier, data)
    elseif attackType == "railgun" then
        return SpitterAttack.railgun(tier, data)
    else
        -- Default to acid
        return SpitterAttack.acid(tier, data)
    end
end

return SpitterAttack
