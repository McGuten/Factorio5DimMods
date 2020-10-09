-- Flamer
data:extend(
    {
        {
            type = "flame-thrower-explosion",
            name = "flame-thrower-bicho",
            flags = {"not-on-map"},
            animation_speed = 1,
            animations = {
                {
                    filename = "__5dim_enemies__/graphics/entities/flame-thrower-bicho.png",
                    priority = "extra-high",
                    width = 64,
                    height = 64,
                    frame_count = 64,
                    line_length = 8
                }
            },
            light = {intensity = 0.2, size = 20},
            slow_down_factor = 1,
            smoke = "smoke-fast",
            smoke_count = 1,
            smoke_slow_down_factor = 0.95,
            damage = {amount = 0.3, type = "acid"}
        }
    }
)

-- Spitter
function selectAttackParams(size, type, data)
    if type == "spitter" then
        if size == "small" then
            return spitter_attack_parameters(
                {
                    acid_stream_name = "acid-stream-spitter-small",
                    range = data.range,
                    min_attack_distance = 8,
                    cooldown = 100,
                    cooldown_deviation = 0.15,
                    damage_modifier = data.damage,
                    scale = data.scale,
                    tint1 = data.tint,
                    tint2 = data.tint2,
                    roarvolume = 0.4,
                    animation = spitterattackanimation(data.scale, data.tint, data.tint2)
                }
            )
        elseif size == "medium" then
            return spitter_mid_attack_parameters(
                {
                    acid_stream_name = "acid-stream-spitter-medium",
                    range = data.range,
                    min_attack_distance = 10,
                    cooldown = 100,
                    cooldown_deviation = 0.15,
                    damage_modifier = data.damage,
                    scale = data.scale,
                    tint1 = data.tint,
                    tint2 = data.tint2,
                    roarvolume = 0.5,
                    animation = spitterattackanimation(data.scale, data.tint, data.tint2)
                }
            )
        elseif size == "big" then
            return spitter_big_attack_parameters(
                {
                    acid_stream_name = "acid-stream-spitter-big",
                    range = data.range,
                    min_attack_distance = 10,
                    cooldown = 100,
                    cooldown_deviation = 0.15,
                    damage_modifier = data.damage,
                    scale = data.scale,
                    tint1 = data.tint,
                    tint2 = data.tint2,
                    roarvolume = 0.6,
                    animation = spitterattackanimation(data.scale, data.tint, data.tint2)
                }
            )
        elseif size == "behemoth" then
            return spitter_behemoth_attack_parameters(
                {
                    acid_stream_name = "acid-stream-spitter-behemoth",
                    range = data.range,
                    min_attack_distance = 10,
                    cooldown = 100,
                    cooldown_deviation = 0.15,
                    damage_modifier = data.damage,
                    scale = data.scale,
                    tint1 = data.tint,
                    tint2 = data.tint2,
                    roarvolume = 0.8,
                    animation = spitterattackanimation(data.scale, data.tint, data.tint2)
                }
            )
        end
    elseif type == "fire" then
        if size == "small" then
            return {
                type = "projectile",
                ammo_category = "flame-thrower-ammo",
                cooldown = 1,
                range = data.range,
                projectile_creation_distance = 1.5,
                damage_modifier = data.damage_modifier,
                warmup = 1,
                ammo_type = {
                    category = "biological",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "flame-thrower",
                            explosion = "flame-thrower-bicho",
                            direction_deviation = 0.07,
                            speed_deviation = 0.1,
                            starting_frame_deviation = 0.07,
                            projectile_starting_speed = 0.2,
                            starting_distance = 0.6
                        }
                    }
                },
                animation = spitterattackanimation(data.scale, data.tint, data.tint2)
            }
        elseif size == "medium" then
            return {
                type = "projectile",
                ammo_category = "flame-thrower-ammo",
                cooldown = 1,
                range = data.range,
                projectile_creation_distance = 1.5,
                damage_modifier = data.damage_modifier,
                warmup = 1,
                ammo_type = {
                    category = "biological",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "flame-thrower",
                            explosion = "flame-thrower-bicho",
                            direction_deviation = 0.07,
                            speed_deviation = 0.1,
                            starting_frame_deviation = 0.07,
                            projectile_starting_speed = 0.2,
                            starting_distance = 1
                        }
                    }
                },
                animation = spitterattackanimation(data.scale, data.tint, data.tint2)
            }
        elseif size == "big" then
            return {
                type = "projectile",
                ammo_category = "flame-thrower-ammo",
                cooldown = 1,
                range = data.range,
                projectile_creation_distance = 1.5,
                damage_modifier = data.damage_modifier,
                warmup = 1,
                ammo_type = {
                    category = "biological",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "flame-thrower",
                            explosion = "flame-thrower-bicho",
                            direction_deviation = 0.07,
                            speed_deviation = 0.1,
                            starting_frame_deviation = 0.07,
                            projectile_starting_speed = 0.2,
                            starting_distance = 2
                        }
                    }
                },
                --sound = make_spitter_roars(data.roarvolume),
                animation = spitterattackanimation(data.scale, data.tint, data.tint2)
            }
        elseif size == "behemoth" then
            return {
                type = "projectile",
                ammo_category = "flame-thrower-ammo",
                cooldown = 1,
                range = data.range,
                projectile_creation_distance = 1.5,
                damage_modifier = data.damage_modifier,
                warmup = 1,
                ammo_type = {
                    category = "biological",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "flame-thrower",
                            explosion = "flame-thrower-bicho",
                            direction_deviation = 0.07,
                            speed_deviation = 0.1,
                            starting_frame_deviation = 0.07,
                            projectile_starting_speed = 0.2,
                            starting_distance = 3
                        }
                    }
                },
                --sound = make_spitter_roars(data.roarvolume),
                animation = spitterattackanimation(data.scale, data.tint, data.tint2)
            }
        end
    elseif type == "suicide" then
        if size == "small" then
            return {
                type = "projectile",
                ammo_category = "explosive-rocket",
                cooldown = 120,
                range = 1,
                projectile_creation_distance = 0.5,
                damage_modifier = data.damage_modifier,
                warmup = 5,
                ammo_type = {
                    category = "biological",
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
        elseif size == "medium" then
            return {
                type = "projectile",
                ammo_category = "explosive-rocket",
                cooldown = 120,
                range = 1,
                projectile_creation_distance = 0.5,
                damage_modifier = data.damage_modifier,
                warmup = 5,
                ammo_type = {
                    category = "biological",
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
        elseif size == "big" then
            return {
                type = "projectile",
                ammo_category = "explosive-rocket",
                cooldown = 120,
                range = 1,
                projectile_creation_distance = 0.5,
                damage_modifier = data.damage_modifier,
                warmup = 5,
                ammo_type = {
                    category = "biological",
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
        elseif size == "behemoth" then
            return {
                type = "projectile",
                ammo_category = "explosive-rocket",
                cooldown = 120,
                range = 1,
                projectile_creation_distance = 0.5,
                damage_modifier = data.damage_modifier,
                warmup = 5,
                ammo_type = {
                    category = "biological",
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
    elseif type == "rocket" then
        if size == "small" then
            return {
                type = "projectile",
                ammo_category = "explosive-rocket",
                cooldown = 120,
                range = data.range,
                projectile_creation_distance = 0.5,
                damage_modifier = data.damage_modifier,
                warmup = 5,
                ammo_type = {
                    category = "biological",
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
        elseif size == "medium" then
            return {
                type = "projectile",
                ammo_category = "explosive-rocket",
                cooldown = 120,
                range = data.range,
                projectile_creation_distance = 0.5,
                damage_modifier = data.damage_modifier,
                warmup = 5,
                ammo_type = {
                    category = "biological",
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
        elseif size == "big" then
            return {
                type = "projectile",
                ammo_category = "explosive-rocket",
                cooldown = 120,
                range = data.range,
                projectile_creation_distance = 0.5,
                damage_modifier = data.damage_modifier,
                warmup = 5,
                ammo_type = {
                    category = "biological",
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
        elseif size == "behemoth" then
            return {
                type = "projectile",
                ammo_category = "explosive-rocket",
                cooldown = 120,
                range = data.range,
                projectile_creation_distance = 0.5,
                damage_modifier = data.damage_modifier,
                warmup = 5,
                ammo_type = {
                    category = "biological",
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
    else
        if size == "small" then
            return spitter_attack_parameters(
                {
                    acid_stream_name = "acid-stream-spitter-small",
                    range = data.range,
                    min_attack_distance = 8,
                    cooldown = 100,
                    cooldown_deviation = 0.15,
                    damage_modifier = data.damage,
                    scale = data.scale,
                    tint1 = data.tint,
                    tint2 = data.tint2,
                    roarvolume = 0.4,
                    animation = spitterattackanimation(data.scale, data.tint, data.tint2)
                }
            )
        elseif size == "medium" then
            return spitter_mid_attack_parameters(
                {
                    acid_stream_name = "acid-stream-spitter-medium",
                    range = data.range,
                    min_attack_distance = 10,
                    cooldown = 100,
                    cooldown_deviation = 0.15,
                    damage_modifier = data.damage,
                    scale = data.scale,
                    tint1 = data.tint,
                    tint2 = data.tint2,
                    roarvolume = 0.5,
                    animation = spitterattackanimation(data.scale, data.tint, data.tint2)
                }
            )
        elseif size == "big" then
            return spitter_big_attack_parameters(
                {
                    acid_stream_name = "acid-stream-spitter-big",
                    range = data.range,
                    min_attack_distance = 10,
                    cooldown = 100,
                    cooldown_deviation = 0.15,
                    damage_modifier = data.damage,
                    scale = data.scale,
                    tint1 = data.tint,
                    tint2 = data.tint2,
                    roarvolume = 0.6,
                    animation = spitterattackanimation(data.scale, data.tint, data.tint2)
                }
            )
        elseif size == "behemoth" then
            return spitter_behemoth_attack_parameters(
                {
                    acid_stream_name = "acid-stream-spitter-behemoth",
                    range = data.range,
                    min_attack_distance = 10,
                    cooldown = 100,
                    cooldown_deviation = 0.15,
                    damage_modifier = data.damage,
                    scale = data.scale,
                    tint1 = data.tint,
                    tint2 = data.tint2,
                    roarvolume = 0.8,
                    animation = spitterattackanimation(data.scale, data.tint, data.tint2)
                }
            )
        end
    end
end
