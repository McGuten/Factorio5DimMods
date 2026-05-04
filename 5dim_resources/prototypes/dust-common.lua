local DustCommon = {}

DustCommon.overlay_icon = "__5dim_resources__/graphics/icon/resources/dust-overlay.png"

DustCommon.tints = {
    iron = { r = 0.78, g = 0.78, b = 0.80, a = 1 },
    copper = { r = 0.92, g = 0.55, b = 0.33, a = 1 },
    stone = { r = 0.82, g = 0.80, b = 0.74, a = 1 },
    coal = { r = 0.33, g = 0.33, b = 0.36, a = 1 },
    refined_coal = { r = 0.69, g = 0.69, b = 0.73, a = 1 },
    uranium = { r = 0.55, g = 0.85, b = 0.28, a = 1 },
    tungsten = { r = 0.65, g = 0.65, b = 0.68, a = 1 },
    holmium = { r = 0.30, g = 0.74, b = 0.95, a = 1 },
    calcite = { r = 0.96, g = 0.90, b = 0.74, a = 1 }
}

function DustCommon.make_dust_icons(base_icon, tint, options)
    options = options or {}

    return {
        {
            icon = base_icon,
            icon_size = options.base_icon_size or 64
        },
        {
            icon = options.overlay_icon or DustCommon.overlay_icon,
            icon_size = options.overlay_icon_size or 64,
            scale = options.overlay_scale or 0.425,
            shift = options.overlay_shift or { 10, 10 },
            tint = tint or { r = 1, g = 1, b = 1, a = 1 }
        }
    }
end

function DustCommon.make_dust_technology_icons(base_icon, tint, extra_icon, extra_options)
    local icons = DustCommon.make_dust_icons(base_icon, tint)

    if extra_icon ~= nil then
        extra_options = extra_options or {}
        table.insert(icons, {
            icon = extra_icon,
            icon_size = extra_options.icon_size or 64,
            scale = extra_options.scale or 0.35,
            shift = extra_options.shift or { -12, -12 }
        })
    end

    return icons
end

return DustCommon