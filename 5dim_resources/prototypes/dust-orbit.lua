if not mods["space-age"] then
    return
end

local DustCommon = require("prototypes.dust-common")

local orbitOnly = {
    {
        property = "gravity",
        min = 0,
        max = 0
    }
}

local asteroidTints = {
    metallic = { r = 0.82, g = 0.80, b = 0.83, a = 1 },
    carbonic = { r = 0.34, g = 0.36, b = 0.39, a = 1 },
    oxide = { r = 0.72, g = 0.88, b = 0.97, a = 1 }
}

local function make_orbit_process_icons(baseIcon, tint, machineIcon)
    local icons = DustCommon.make_dust_icons(baseIcon, tint)

    if machineIcon ~= nil then
        table.insert(icons, {
            icon = machineIcon,
            icon_size = 64,
            scale = 0.33,
            shift = { -11, -11 }
        })
    end

    return icons
end

local masherIcon = "__5dim_resources__/graphics/icon/masher/masher-icon-01.png"
local crusherIcon = "__space-age__/graphics/icons/crusher.png"

data:extend({
    {
        type = "item",
        name = "5d-metallic-asteroid-dust",
        icons = DustCommon.make_dust_icons("__space-age__/graphics/icons/metallic-asteroid-chunk.png", asteroidTints.metallic),
        subgroup = "orbit-resources",
        order = "a[metallic-asteroid-dust]",
        stack_size = 200
    },
    {
        type = "item",
        name = "5d-carbonic-asteroid-dust",
        icons = DustCommon.make_dust_icons("__space-age__/graphics/icons/carbonic-asteroid-chunk.png", asteroidTints.carbonic),
        subgroup = "orbit-resources",
        order = "b[carbonic-asteroid-dust]",
        stack_size = 200
    },
    {
        type = "item",
        name = "5d-oxide-asteroid-dust",
        icons = DustCommon.make_dust_icons("__space-age__/graphics/icons/oxide-asteroid-chunk.png", asteroidTints.oxide),
        subgroup = "orbit-resources",
        order = "c[oxide-asteroid-dust]",
        stack_size = 200
    },
    {
        type = "recipe",
        name = "5d-metallic-asteroid-mashing",
        enabled = false,
        category = "mashering",
        subgroup = "orbit-resources",
        order = "a[metallic-asteroid-mashing]",
        energy_required = 3,
        allow_productivity = true,
        surface_conditions = orbitOnly,
        icons = make_orbit_process_icons("__space-age__/graphics/icons/metallic-asteroid-chunk.png", asteroidTints.metallic, masherIcon),
        ingredients = {
            { type = "item", name = "metallic-asteroid-chunk", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-metallic-asteroid-dust", amount = 1 }
        }
    },
    {
        type = "recipe",
        name = "5d-carbonic-asteroid-mashing",
        enabled = false,
        category = "mashering",
        subgroup = "orbit-resources",
        order = "b[carbonic-asteroid-mashing]",
        energy_required = 3,
        allow_productivity = true,
        surface_conditions = orbitOnly,
        icons = make_orbit_process_icons("__space-age__/graphics/icons/carbonic-asteroid-chunk.png", asteroidTints.carbonic, masherIcon),
        ingredients = {
            { type = "item", name = "carbonic-asteroid-chunk", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-carbonic-asteroid-dust", amount = 1 }
        }
    },
    {
        type = "recipe",
        name = "5d-oxide-asteroid-mashing",
        enabled = false,
        category = "mashering",
        subgroup = "orbit-resources",
        order = "c[oxide-asteroid-mashing]",
        energy_required = 3,
        allow_productivity = true,
        surface_conditions = orbitOnly,
        icons = make_orbit_process_icons("__space-age__/graphics/icons/oxide-asteroid-chunk.png", asteroidTints.oxide, masherIcon),
        ingredients = {
            { type = "item", name = "oxide-asteroid-chunk", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-oxide-asteroid-dust", amount = 1 }
        }
    },
    {
        type = "recipe",
        name = "5d-metallic-asteroid-crushing",
        icons = make_orbit_process_icons("__space-age__/graphics/icons/metallic-asteroid-crushing.png", asteroidTints.metallic, crusherIcon),
        category = "crushing",
        subgroup = "orbit-crushing",
        order = "b-a-a[5d]",
        auto_recycle = false,
        enabled = false,
        energy_required = 2,
        allow_productivity = true,
        allow_decomposition = false,
        surface_conditions = orbitOnly,
        ingredients = {
            { type = "item", name = "5d-metallic-asteroid-dust", amount = 1 }
        },
        results = {
            { type = "item", name = "iron-ore", amount = 40 }
        }
    },
    {
        type = "recipe",
        name = "5d-carbonic-asteroid-crushing",
        icons = make_orbit_process_icons("__space-age__/graphics/icons/carbonic-asteroid-crushing.png", asteroidTints.carbonic, crusherIcon),
        category = "crushing",
        subgroup = "orbit-crushing",
        order = "b-a-b[5d]",
        auto_recycle = false,
        enabled = false,
        energy_required = 2,
        allow_productivity = true,
        allow_decomposition = false,
        surface_conditions = orbitOnly,
        ingredients = {
            { type = "item", name = "5d-carbonic-asteroid-dust", amount = 1 }
        },
        results = {
            { type = "item", name = "carbon", amount = 20 }
        }
    },
    {
        type = "recipe",
        name = "5d-oxide-asteroid-crushing",
        icons = make_orbit_process_icons("__space-age__/graphics/icons/oxide-asteroid-crushing.png", asteroidTints.oxide, crusherIcon),
        category = "crushing",
        subgroup = "orbit-crushing",
        order = "b-a-c[5d]",
        auto_recycle = false,
        enabled = false,
        energy_required = 2,
        allow_productivity = true,
        allow_decomposition = false,
        surface_conditions = orbitOnly,
        ingredients = {
            { type = "item", name = "5d-oxide-asteroid-dust", amount = 1 }
        },
        results = {
            { type = "item", name = "ice", amount = 10 }
        }
    },
    {
        type = "recipe",
        name = "5d-advanced-metallic-asteroid-crushing",
        icons = make_orbit_process_icons("__space-age__/graphics/icons/advanced-metallic-asteroid-crushing.png", asteroidTints.metallic, crusherIcon),
        category = "crushing",
        subgroup = "orbit-advanced-crushing",
        order = "c-a-b[5d]",
        auto_recycle = false,
        enabled = false,
        energy_required = 6,
        allow_productivity = true,
        allow_decomposition = false,
        surface_conditions = orbitOnly,
        ingredients = {
            { type = "item", name = "5d-metallic-asteroid-dust", amount = 1 }
        },
        results = {
            { type = "item", name = "iron-ore", amount = 20 },
            { type = "item", name = "copper-ore", amount = 8 }
        }
    },
    {
        type = "recipe",
        name = "5d-advanced-carbonic-asteroid-crushing",
        icons = make_orbit_process_icons("__space-age__/graphics/icons/advanced-carbonic-asteroid-crushing.png", asteroidTints.carbonic, crusherIcon),
        category = "crushing",
        subgroup = "orbit-advanced-crushing",
        order = "e[advanced-carbonic-asteroid-crushing]-b[5d]",
        auto_recycle = false,
        enabled = false,
        energy_required = 6,
        allow_productivity = true,
        allow_decomposition = false,
        surface_conditions = orbitOnly,
        ingredients = {
            { type = "item", name = "5d-carbonic-asteroid-dust", amount = 1 }
        },
        results = {
            { type = "item", name = "carbon", amount = 10 },
            { type = "item", name = "sulfur", amount = 4 }
        }
    },
    {
        type = "recipe",
        name = "5d-advanced-oxide-asteroid-crushing",
        icons = make_orbit_process_icons("__space-age__/graphics/icons/advanced-oxide-asteroid-crushing.png", asteroidTints.oxide, crusherIcon),
        category = "crushing",
        subgroup = "orbit-advanced-crushing",
        order = "f[advanced-oxide-asteroid-crushing]-b[5d]",
        auto_recycle = false,
        enabled = false,
        energy_required = 6,
        allow_productivity = true,
        allow_decomposition = false,
        surface_conditions = orbitOnly,
        ingredients = {
            { type = "item", name = "5d-oxide-asteroid-dust", amount = 1 }
        },
        results = {
            { type = "item", name = "ice", amount = 6 },
            { type = "item", name = "calcite", amount = 4 }
        }
    }
})