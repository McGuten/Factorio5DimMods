function dim_laser_turret_extension_mask(inputs)
    return {
        filename = "__base__/graphics/entity/laser-turret/laser-turret-raising-mask.png",
        flags = {"mask"},
        width = 44,
        height = 40,
        frame_count = inputs.frame_count and inputs.frame_count or 15,
        line_length = inputs.line_length and inputs.line_length or 0,
        run_mode = inputs.run_mode and inputs.run_mode or "forward",
        axially_symmetrical = false,
        apply_runtime_tint = false,
        tint = inputs.tint,
        direction_count = 4,
        shift = util.by_pixel(0, -43),
        hr_version = {
            filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-raising-mask.png",
            flags = {"mask"},
            width = 86,
            height = 80,
            frame_count = inputs.frame_count and inputs.frame_count or 15,
            line_length = inputs.line_length and inputs.line_length or 0,
            run_mode = inputs.run_mode and inputs.run_mode or "forward",
            axially_symmetrical = false,
            apply_runtime_tint = false,
            direction_count = 4,
            shift = util.by_pixel(0, -43),
            tint = inputs.tint,
            scale = 0.5
        }
    }
end

function dim_laser_turret_shooting_mask(inputs)
    return {
        filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-mask.png",
        flags = {"mask"},
        line_length = 8,
        width = 46,
        height = 42,
        frame_count = 1,
        apply_runtime_tint = false,
        direction_count = 64,
        shift = util.by_pixel(0, -43),
            tint = inputs.tint,
        hr_version = {
            filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-shooting-mask.png",
            flags = {"mask"},
            line_length = 8,
            width = 92,
            height = 80,
            frame_count = 1,
            apply_runtime_tint = false,
            direction_count = 64,
            shift = util.by_pixel(0, -43.5),
            tint = inputs.tint,
            scale = 0.5
        }
    }
end
