function dim_gun_turret_extension_mask(inputs)
    return {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-raising-mask.png",
        flags = {"mask"},
        width = 24,
        height = 32,
        direction_count = 4,
        frame_count = inputs.frame_count or 5,
        line_length = inputs.line_length or 0,
        run_mode = inputs.run_mode or "forward",
        shift = util.by_pixel(0, -28),
        axially_symmetrical = false,
        apply_runtime_tint = false,
        tint = inputs.tint,
        hr_version = {
            filename = "__base__/graphics/entity/gun-turret/hr-gun-turret-raising-mask.png",
            flags = {"mask"},
            width = 48,
            height = 62,
            direction_count = 4,
            frame_count = inputs.frame_count or 5,
            line_length = inputs.line_length or 0,
            run_mode = inputs.run_mode or "forward",
            shift = util.by_pixel(0, -28),
            axially_symmetrical = false,
            apply_runtime_tint = false,
            tint = inputs.tint,
            scale = 0.5
        }
    }
end