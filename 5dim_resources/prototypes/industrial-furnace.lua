data:extend(
    {
        -- Item
        {
            type = "item",
            name = "5d-industrial-furnace",
            icon = "__5dim_resources__/graphics/icon/industrial-furnace/industrial-furnace-icon.png",
            icon_size = 32,
            subgroup = "furnace-industrial",
            order = "a",
            place_result = "5d-industrial-furnace",
            stack_size = 50
        },
        --Recipe
        {
            type = "recipe",
            name = "5d-industrial-furnace",
            enabled = "false",
            ingredients = {
                {"electric-furnace", 2},
                {"steel-plate", 10},
                {"advanced-circuit", 10}
            },
            result = "5d-industrial-furnace",
            energy_required = 5
        },
        --Entity
        {
            type = "furnace",
            name = "5d-industrial-furnace",
            icon = "__5dim_resources__/graphics/icon/industrial-furnace/industrial-furnace-icon.png",
            flags = {"placeable-neutral", "placeable-player", "player-creation"},
            minable = {mining_time = 1, result = "5d-industrial-furnace"},
            icon_size = 32,
            max_health = 150,
            corpse = "big-remnants",
            dying_explosion = "medium-explosion",
            light = {intensity = 1, size = 10},
            resistances = {
                {
                    type = "fire",
                    percent = 80
                }
            },
            collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
            selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
            module_specification = {
                module_slots = 4,
                module_info_icon_shift = {0, 0.8}
            },
            allowed_effects = {"consumption", "speed", "productivity", "pollution"},
            crafting_categories = {"industrial-furnace"},
            crafting_speed = 1,
            energy_usage = "3000kW",
            source_inventory_size = 1,
            result_inventory_size = 1,
            energy_source = {
                type = "electric",
                usage_priority = "secondary-input",
                emissions = 0.005
            },
            working_sound = {
                sound = {
                    filename = "__base__/sound/electric-furnace.ogg",
                    volume = 0.7
                },
                apparent_volume = 1.5
            },
            animation = {
                filename = "__5dim_resources__/graphics/entities/industrial-furnace/industrial-furnace.png",
                priority = "high",
                width = 224,
                height = 224,
                frame_count = 1,
                shift = {0, 0}
            },
            working_visualisations = {
                util.empty_sprite()
            },
            fast_replaceable_group = "electric-furnace"
        }
    }
)
