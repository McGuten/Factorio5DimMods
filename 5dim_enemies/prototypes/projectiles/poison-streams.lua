-- =============================================================================
-- 5dim_enemies - Poison Stream Projectiles
-- =============================================================================
-- Custom acid streams that create poison clouds on impact
-- Uses optimized 5d-poison-cloud variants instead of vanilla for better performance
-- =============================================================================

require("__base__/prototypes/entity/spitter-animations")
require("__base__/prototypes/entity/enemy-constants")

-- Poison tint (toxic green)
local poison_tint = {r = 0.3, g = 0.9, b = 0.2, a = 0.8}
local poison_tint_secondary = {r = 0.2, g = 0.7, b = 0.15, a = 0.6}

-- =============================================================================
-- POISON SPLASH FIRE (lingering poison puddle)
-- =============================================================================

local function create_poison_splash_fire(data)
    return {
        type = "fire",
        name = data.name,
        localised_name = {"entity-name.poison-splash"},
        flags = {"placeable-off-grid", "not-on-map"},
        hidden = true,
        damage_per_tick = {amount = data.damage_per_tick or (0.5 / 60), type = "poison"},
        maximum_damage_multiplier = 3,
        damage_multiplier_increase_per_added_fuel = 1,
        damage_multiplier_decrease_per_tick = 0.005,
        
        uses_alternative_behavior = true,
        limit_overlapping_particles = true,
        initial_render_layer = "object",
        render_layer = "lower-object-above-shadow",
        secondary_render_layer = "higher-object-above",
        secondary_picture_fade_out_start = 30,
        secondary_picture_fade_out_duration = 60,
        
        spread_delay = 300,
        spread_delay_deviation = 180,
        maximum_spread_count = 100,
        
        particle_alpha = 0.6,
        particle_alpha_blend_duration = 60 * 5,

        add_fuel_cooldown = 10,
        fade_in_duration = 1,
        fade_out_duration = 60 * 2,
        initial_lifetime = 60 * 8,
        lifetime_increase_by = 0,
        lifetime_increase_cooldown = 4,
        maximum_lifetime = 60 * 8,
        delay_between_initial_flames = 10,
        initial_flame_count = 1,
        burnt_patch_lifetime = 0,
        
        pictures = {
            {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                width = 246,
                height = 176,
                shift = util.by_pixel(12, -10),
                tint = poison_tint,
                scale = data.scale or 0.5
            },
            {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
                width = 224,
                height = 172,
                shift = util.by_pixel(6, -6),
                tint = poison_tint,
                scale = data.scale or 0.5
            },
            {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
                width = 236,
                height = 156,
                shift = util.by_pixel(-6, 8),
                tint = poison_tint,
                scale = data.scale or 0.5
            },
            {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
                width = 252,
                height = 154,
                shift = util.by_pixel(0, 6),
                tint = poison_tint,
                scale = data.scale or 0.5
            }
        },
        
        secondary_pictures = {
            {
                filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                width = 246,
                height = 176,
                shift = util.by_pixel(12, -10),
                tint = poison_tint_secondary,
                scale = (data.scale or 0.5) * 0.7
            }
        },
        
        working_sound = {
            sound = {
                category = "enemy",
                filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg",
                volume = 0.3
            },
            max_sounds_per_prototype = 2
        }
    }
end

-- =============================================================================
-- POISON STICKER (slow effect on hit)
-- =============================================================================

local function create_poison_sticker(data)
    return {
        type = "sticker",
        name = data.name,
        flags = {"not-on-map"},
        hidden = true,
        
        duration_in_ticks = 60 * 5,  -- 5 second slow
        target_movement_modifier_from = 0.7,  -- 30% slow
        target_movement_modifier_to = 1,
        damage_per_tick = {amount = data.damage_per_tick or 0.5, type = "poison"},
        
        animation = {
            filename = "__base__/graphics/entity/acid-sticker/acid-sticker.png",
            draw_as_glow = true,
            line_length = 5,
            width = 30,
            height = 34,
            frame_count = 50,
            animation_speed = 0.5,
            shift = util.by_pixel(1.5, 0),
            tint = poison_tint,
            scale = 0.5
        }
    }
end

-- =============================================================================
-- POISON STREAM (the actual projectile)
-- =============================================================================

local function create_poison_stream(data)
    local scale = data.scale or 1
    
    return {
        type = "stream",
        name = data.name,
        flags = {"not-on-map"},
        hidden = true,
        
        stream_light = {intensity = 1, size = 4, color = poison_tint},
        ground_light = {intensity = 0.8, size = 4, color = poison_tint},
        
        particle_buffer_size = 90,
        particle_spawn_interval = data.particle_spawn_interval or 1,
        particle_spawn_timeout = data.particle_spawn_timeout or 6,
        particle_vertical_acceleration = 0.005 * 0.6,
        particle_horizontal_speed = 0.2 * 0.75 * 1.5,
        particle_horizontal_speed_deviation = 0.005 * 0.7,
        particle_start_alpha = 0.5,
        particle_end_alpha = 1,
        particle_alpha_per_part = 0.8,
        particle_scale_per_part = 0.8,
        particle_loop_frame_count = 15,
        particle_fade_out_duration = 2,
        particle_loop_exit_threshold = 0.25,
        target_initial_position_only = true,
        
        special_neutral_target_damage = {amount = 1, type = "poison"},
        
        working_sound = {
            sound = {
                category = "enemy",
                filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg",
                volume = 0.4
            },
            max_sounds_per_prototype = 3
        },
        
        initial_action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "play-sound",
                            sound = {
                                category = "enemy",
                                variations = {
                                    {filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg", volume = 0.5},
                                    {filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg", volume = 0.5}
                                },
                                aggregation = {max_count = 3, remove = true, count_already_playing = true}
                            }
                        },
                        {
                            type = "create-fire",
                            entity_name = data.splash_fire_name,
                            tile_collision_mask = {layers = {water_tile = true}},
                            show_in_tooltip = true
                        },
                        -- Create optimized poison cloud on impact (5d- variants are much lighter)
                        {
                            type = "create-entity",
                            entity_name = data.poison_cloud_name or "5d-poison-cloud-medium",
                            show_in_tooltip = true
                        },
                        {
                            type = "create-entity",
                            entity_name = "water-splash",
                            tile_collision_mask = {layers = {ground_tile = true}}
                        }
                    }
                }
            },
            {
                type = "area",
                radius = data.spit_radius or 1.5,
                force = "enemy",
                ignore_collision_condition = true,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-sticker",
                            sticker = data.sticker_name
                        },
                        {
                            type = "damage",
                            damage = {amount = 2, type = "poison"}
                        }
                    }
                }
            }
        },
        
        particle = {
            filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
            draw_as_glow = true,
            line_length = 5,
            width = 42,
            height = 164,
            frame_count = 15,
            shift = util.mul_shift(util.by_pixel(-2, 31), scale),
            tint = poison_tint,
            priority = "high",
            scale = 0.5 * scale,
            animation_speed = 1
        },
        
        spine_animation = {
            filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
            draw_as_glow = true,
            line_length = 5,
            width = 132,
            height = 20,
            frame_count = 15,
            shift = util.mul_shift(util.by_pixel(0, -1), scale),
            tint = poison_tint,
            priority = "high",
            scale = 0.5 * scale,
            animation_speed = 1
        },
        
        shadow = {
            filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
            line_length = 15,
            width = 42,
            height = 164,
            frame_count = 15,
            shift = util.mul_shift(util.by_pixel(-2, 31), scale),
            draw_as_shadow = true,
            priority = "high",
            scale = 0.5 * scale,
            animation_speed = 1
        },
        
        oriented_particle = true,
        shadow_scale_enabled = true
    }
end

-- =============================================================================
-- CREATE ALL POISON PROJECTILES
-- =============================================================================

-- Splash fires (lingering poison puddles)
data:extend({
    create_poison_splash_fire({
        name = "5d-poison-splash-fire-small",
        scale = 0.4,
        damage_per_tick = 0.3 / 60
    }),
    create_poison_splash_fire({
        name = "5d-poison-splash-fire-medium",
        scale = 0.6,
        damage_per_tick = 0.5 / 60
    }),
    create_poison_splash_fire({
        name = "5d-poison-splash-fire-big",
        scale = 0.8,
        damage_per_tick = 0.8 / 60
    }),
    create_poison_splash_fire({
        name = "5d-poison-splash-fire-behemoth",
        scale = 1.0,
        damage_per_tick = 1.0 / 60
    })
})

-- Stickers (slow effect)
data:extend({
    create_poison_sticker({
        name = "5d-poison-sticker-small",
        damage_per_tick = 0.3
    }),
    create_poison_sticker({
        name = "5d-poison-sticker-medium",
        damage_per_tick = 0.5
    }),
    create_poison_sticker({
        name = "5d-poison-sticker-big",
        damage_per_tick = 0.8
    }),
    create_poison_sticker({
        name = "5d-poison-sticker-behemoth",
        damage_per_tick = 1.2
    })
})

-- Streams (the projectile that creates poison on impact)
data:extend({
    create_poison_stream({
        name = "5d-poison-stream-spitter-small",
        scale = scale_spitter_small * 1.1,
        spit_radius = stream_radius_spitter_small,
        particle_spawn_interval = 1,
        particle_spawn_timeout = 6,
        splash_fire_name = "5d-poison-splash-fire-small",
        sticker_name = "5d-poison-sticker-small",
        poison_cloud_name = "5d-poison-cloud-small"
    }),
    create_poison_stream({
        name = "5d-poison-stream-spitter-medium",
        scale = scale_spitter_medium,
        spit_radius = stream_radius_spitter_medium,
        particle_spawn_interval = 1,
        particle_spawn_timeout = 6,
        splash_fire_name = "5d-poison-splash-fire-medium",
        sticker_name = "5d-poison-sticker-medium",
        poison_cloud_name = "5d-poison-cloud-medium"
    }),
    create_poison_stream({
        name = "5d-poison-stream-spitter-big",
        scale = scale_spitter_big,
        spit_radius = stream_radius_spitter_big,
        particle_spawn_interval = 1,
        particle_spawn_timeout = 6,
        splash_fire_name = "5d-poison-splash-fire-big",
        sticker_name = "5d-poison-sticker-big",
        poison_cloud_name = "5d-poison-cloud-big"
    }),
    create_poison_stream({
        name = "5d-poison-stream-spitter-behemoth",
        scale = scale_spitter_behemoth,
        spit_radius = stream_radius_spitter_behemoth,
        particle_spawn_interval = 1,
        particle_spawn_timeout = 6,
        splash_fire_name = "5d-poison-splash-fire-behemoth",
        sticker_name = "5d-poison-sticker-behemoth",
        poison_cloud_name = "5d-poison-cloud-behemoth"
    })
})
