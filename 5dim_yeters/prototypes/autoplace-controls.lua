local yetersResourceControls = {
    { name = "yeters_stone", order = "f-c" },
    { name = "yeters_coal", order = "f-d" },
    { name = "yeters_crude_oil", order = "f-e" },
    { name = "yeters_uranium_ore", order = "f-f" },
    { name = "yeters_calcite", order = "f-g" },
    { name = "yeters_tungsten_ore", order = "f-h" },
    { name = "yeters_scrap", order = "f-i" },
    { name = "yeters_lithium_brine", order = "f-j" },
    { name = "yeters_fluorine_vent", order = "f-k" },
    { name = "yeters_sulfuric_acid_geyser", order = "f-l" }
}

local controls = {
    {
        type = "autoplace-control",
        name = "yeters_biomes",
        order = "c-z-c",
        category = "terrain",
        can_be_disabled = false
    }
}

for _, control in ipairs(yetersResourceControls) do
    controls[#controls + 1] = {
        type = "autoplace-control",
        name = control.name,
        richness = true,
        order = control.order,
        category = "resource"
    }
end

data:extend(controls)