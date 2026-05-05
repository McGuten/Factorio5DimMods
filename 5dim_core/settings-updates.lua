data:extend(
    {
        {
            type = "int-setting",
            name = "5d-change-inventory",
            order = "aa",
            setting_type = "startup",
            default_value = 60,
            minimum_value = 1,
            maximum_value = 1000
        },
        {
            type = "int-setting",
            name = "5d-change-stack",
            order = "ab",
            setting_type = "startup",
            default_value = 1,
            minimum_value = 1,
            maximum_value = 1000
        },
        {
            type = "int-setting",
            name = "5d-long-reach",
            order = "ba",
            setting_type = "startup",
            default_value = 6,
            minimum_value = 1,
            maximum_value = 1000
        },
        {
            type = "int-setting",
            name = "5d-long-mine",
            order = "bb",
            setting_type = "startup",
            default_value = 6,
            minimum_value = 1,
            maximum_value = 1000
        },
        {
            type = "double-setting",
            name = "5d-mining-speed",
            order = "bc",
            setting_type = "startup",
            default_value = 1,
            minimum_value = 0.01,
            maximum_value = 1000
        },
        {
            type = "int-setting",
            name = "5d-light-radius",
            order = "bd",
            setting_type = "startup",
            default_value = 25,
            minimum_value = 1,
            maximum_value = 1000
        },
        {
            type = "bool-setting",
            name = "5d-ores",
            order = "be",
            setting_type = "startup",
            default_value = false,
            per_user = false
        },
        {
            type = "bool-setting",
            name = "5d-yield",
            order = "bf",
            setting_type = "startup",
            default_value = false,
            per_user = false
        },
        {
            type = "bool-setting",
            name = "5d-tree",
            order = "caa",
            setting_type = "startup",
            default_value = false,
            per_user = false
        },
        {
            type = "string-setting",
            name = "5d-item-start",
            order = "cb",
            setting_type = "startup",
            default_value = "Nothing",
            allowed_values = {"Nothing", "Small amount", "Medium amount", "Big amount", "Huge amount"}
        },
        {
            type = "string-setting",
            name = "5d-equip-start",
            order = "cc",
            setting_type = "startup",
            default_value = "Nothing",
            allowed_values = {"Nothing", "Modular armor", "Power armor", "Power armor MK2"}
        },
        {
            type = "bool-setting",
            name = "5d-train-tech",
            order = "cd",
            setting_type = "startup",
            default_value = false,
            per_user = false
        },
        {
            type = "bool-setting",
            name = "5d-robot-tech",
            order = "ce",
            setting_type = "startup",
            default_value = false,
            per_user = false
        },
        {
            type = "int-setting",
            name = "5d-hp",
            order = "da",
            setting_type = "startup",
            default_value = 250,
            minimum_value = 1,
            maximum_value = 100000
        },
        {
            type = "double-setting",
            name = "5d-healing",
            order = "db",
            setting_type = "startup",
            default_value = 0.15,
            minimum_value = 0.1,
            maximum_value = 1000
        },
        {
            type = "bool-setting",
            name = "5d-stack-artillery-bullets",
            order = "cab",
            setting_type = "startup",
            default_value = false,
            per_user = false
        }
    }
)
if not mods["Rampant"] then
    data:extend(
        {
            {
                type = "double-setting",
                name = "5d-bicho-spawner-hp",
                order = "dc",
                setting_type = "startup",
                default_value = 1,
                minimum_value = 0.01,
                maximum_value = 1000
            },
            {
                type = "double-setting",
                name = "5d-bicho-hp",
                order = "dd",
                setting_type = "startup",
                default_value = 1,
                minimum_value = 0.01,
                maximum_value = 1000
            },
            {
                type = "double-setting",
                name = "5d-bicho-healing",
                order = "de",
                setting_type = "startup",
                default_value = 1,
                minimum_value = 0.001,
                maximum_value = 1000
            }
        }
    )
end

if mods["5dim_battlefield"] then
    data:extend(
        {
            {
                type = "bool-setting",
                name = "5d-special-turrets",
                order = "cac",
                setting_type = "startup",
                default_value = false,
                per_user = false
            },
            {
                type = "bool-setting",
                name = "5d-special-mines",
                order = "cad",
                setting_type = "startup",
                default_value = false,
                per_user = false
            }
        }
    )
end

if mods["5dim_infiniteresearch"] then
    --order e for infinite research
    data:extend(
        {
            {
                type = "bool-setting",
                name = "5d-storage",
                order = "ec",
                setting_type = "startup",
                default_value = true,
                per_user = false
            },
            {
                type = "bool-setting",
                name = "5d-stack",
                order = "ed",
                setting_type = "startup",
                default_value = true,
                per_user = false
            },
            {
                type = "bool-setting",
                name = "5d-speed",
                order = "ee",
                setting_type = "startup",
                default_value = true,
                per_user = false
            },
            {
                type = "bool-setting",
                name = "5d-speed-gun-turret",
                order = "ef",
                setting_type = "startup",
                default_value = true,
                per_user = false
            },
            {
                type = "bool-setting",
                name = "5d-braking",
                order = "eg",
                setting_type = "startup",
                default_value = true,
                per_user = false
            }
        }
    )
end

if mods["5dim_transport"] and mods["5dim_equipment"] then
    --order z for misc
    data:extend(
        {
            {
                type = "bool-setting",
                name = "5d-grid",
                order = "za",
                setting_type = "startup",
                default_value = true,
                per_user = false
            },
            {
                type = "bool-setting",
                name = "5d-grid-override",
                order = "zb",
                setting_type = "startup",
                default_value = false,
                per_user = false
            }
        }
    )
end
