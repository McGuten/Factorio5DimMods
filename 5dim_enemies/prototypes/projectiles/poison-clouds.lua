-- =============================================================================
-- 5dim_enemies - Optimized Poison Clouds
-- =============================================================================
-- Performance-optimized poison clouds that reduce entity count and particles
-- compared to vanilla poison-cloud while maintaining visual appeal
-- =============================================================================

local poison_tint = {r = 0.3, g = 0.9, b = 0.2, a = 0.8}

-- =============================================================================
-- HELPER: Create optimized poison cloud
-- =============================================================================
-- Performance optimizations:
-- 1. Reduced particle_count (8 vs 16-24 vanilla)
-- 2. No cluster-spawned visual dummies (saves 21 entities per cloud!)
-- 3. Shorter duration (10s vs 20s vanilla)
-- 4. Longer action_cooldown (45 vs 30 vanilla) - less CPU per tick
-- 5. Smaller area radius (8 vs 11 vanilla)
-- =============================================================================

local function create_optimized_poison_cloud(data)
    return {
        type = "smoke-with-trigger",
        name = data.name,
        flags = {"not-on-map"},
        hidden = true,
        show_when_smoke_off = true,
        
        -- PERFORMANCE: Reduced particles (8 vs 16 vanilla)
        particle_count = data.particle_count or 8,
        particle_spread = { 3.0 * (data.scale or 1), 2.0 * (data.scale or 1) },
        particle_distance_scale_factor = 0.5,
        particle_scale_factor = { 1, 0.707 },
        wave_speed = { 1/80, 1/60 },
        wave_distance = { 0.3, 0.2 },
        spread_duration_variation = 20,
        particle_duration_variation = 60 * 2,
        render_layer = "object",
        
        affected_by_wind = false,
        cyclic = true,
        
        -- PERFORMANCE: Shorter duration (10s vs 20s vanilla)
        duration = 60 * (data.duration_seconds or 10),
        fade_away_duration = 60,
        spread_duration = 20,
        
        -- Poison green color
        color = poison_tint,
        
        animation = {
            width = 152,
            height = 120,
            line_length = 5,
            frame_count = 60,
            shift = {-0.53125, -0.4375},
            priority = "high",
            animation_speed = 0.25,
            filename = "__base__/graphics/entity/smoke/smoke.png",
            flags = { "smoke" },
            tint = poison_tint,
            scale = data.scale or 1
        },
        
        -- PERFORMANCE: NO created_effect = no spawning 21 visual dummies!
        -- The main cloud animation is sufficient for visual feedback
        
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "nested-result",
                    action = {
                        type = "area",
                        -- PERFORMANCE: Smaller radius (scaled, base 6 vs 11 vanilla)
                        radius = data.radius or 6,
                        entity_flags = {"breaths-air"},
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                type = "damage",
                                damage = { amount = data.damage or 5, type = "poison" }
                            }
                        }
                    }
                }
            }
        },
        
        -- PERFORMANCE: Longer cooldown (45 vs 30 vanilla) = fewer calculations
        action_cooldown = data.action_cooldown or 45,
        
        working_sound = {
            sound = {filename = "__base__/sound/fight/poison-cloud.ogg", volume = 0.3, audible_distance_modifier = 0.6},
            max_sounds_per_prototype = 2
        }
    }
end

-- =============================================================================
-- CREATE TIERED POISON CLOUDS
-- =============================================================================
-- Scaled versions for different tier spitters/worms

data:extend({
    -- Small (T1-T3) - minimal impact
    create_optimized_poison_cloud({
        name = "5d-poison-cloud-small",
        scale = 0.6,
        particle_count = 6,
        duration_seconds = 6,
        radius = 4,
        damage = 3,
        action_cooldown = 50
    }),
    
    -- Medium (T4-T6)
    create_optimized_poison_cloud({
        name = "5d-poison-cloud-medium",
        scale = 0.8,
        particle_count = 8,
        duration_seconds = 8,
        radius = 5,
        damage = 5,
        action_cooldown = 45
    }),
    
    -- Big (T7-T9)
    create_optimized_poison_cloud({
        name = "5d-poison-cloud-big",
        scale = 1.0,
        particle_count = 10,
        duration_seconds = 10,
        radius = 6,
        damage = 7,
        action_cooldown = 40
    }),
    
    -- Behemoth (T10+Boss)
    create_optimized_poison_cloud({
        name = "5d-poison-cloud-behemoth",
        scale = 1.2,
        particle_count = 12,
        duration_seconds = 12,
        radius = 8,
        damage = 10,
        action_cooldown = 35
    })
})

-- =============================================================================
-- CLOUD SIZE LOOKUP FOR OTHER MODULES
-- =============================================================================

_G.PoisonCloudNames = {
    small = "5d-poison-cloud-small",
    medium = "5d-poison-cloud-medium",
    big = "5d-poison-cloud-big",
    behemoth = "5d-poison-cloud-behemoth"
}

-- Helper to get cloud name by tier
function _G.getPoisonCloudForTier(tier)
    if tier <= 3 then
        return "5d-poison-cloud-small"
    elseif tier <= 6 then
        return "5d-poison-cloud-medium"
    elseif tier <= 9 then
        return "5d-poison-cloud-big"
    else
        return "5d-poison-cloud-behemoth"
    end
end
