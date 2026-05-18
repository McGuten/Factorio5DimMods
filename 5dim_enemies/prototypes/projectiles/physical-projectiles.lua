-- =============================================================================
-- 5dim_enemies - Physical Spitter Projectiles
-- =============================================================================
-- Dedicated projectiles for armored spitters so damage and travel distance stay
-- under mod control instead of inheriting tank-shell behavior.
-- =============================================================================

local debris_tint = {r = 0.72, g = 0.70, b = 0.64, a = 1}

data:extend({
    {
        type = "projectile",
        name = "5d-physical-spitter-projectile",
        flags = {"not-on-map"},
        hidden = true,
        collision_box = {{-0.12, -0.4}, {0.12, 0.4}},
        acceleration = 0,
        direction_only = true,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        damage = {amount = 40, type = "physical"}
                    },
                    {
                        type = "damage",
                        damage = {amount = 8, type = "explosion"}
                    },
                    {
                        type = "create-entity",
                        entity_name = "explosion-hit"
                    }
                }
            }
        },
        final_action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "small-scorchmark-tintable",
                        check_buildability = true
                    }
                }
            }
        },
        animation = {
            filename = "__base__/graphics/entity/bullet/bullet.png",
            width = 3,
            height = 50,
            priority = "high",
            tint = debris_tint
        }
    }
})