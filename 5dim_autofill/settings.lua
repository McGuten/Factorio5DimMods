_G.data:extend(
    {
        {
            type = "int-setting",
            name = "folk-fill-ammo-stack-size",
            setting_type = "runtime-per-user",
            default_value = 100,
            maximum_value = 100,
            minimum_value = 5
        },
        {
            type = "int-setting",
            name = "folk-fill-fuel-stack-size",
            setting_type = "runtime-per-user",
            default_value = 100,
            maximum_value = 100,
            minimum_value = 5
        },
        {
            -- When enabled, turrets/vehicles placed by construction robots are
            -- also auto-filled, sourcing ammo and fuel from the robot's logistic
            -- network. Off by default because network-sourced refills are
            -- stronger than the manual, player-inventory behavior.
            type = "bool-setting",
            name = "5d-autofill-robots",
            setting_type = "startup",
            default_value = false
        }
    }
)
