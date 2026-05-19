local function apply_if_present(mod_name, module_path)
    if not mods[mod_name] then
        return
    end

    local menu_simulations = data.raw["utility-constants"]["default"].main_menu_simulations
    require(module_path)(menu_simulations)
end

local function apply(menu_simulations)
    if not menu_simulations then
        return
    end

    apply_if_present("5dim_enemies", "__5dim_enemies__.prototypes.menu-simulations.apply")
    apply_if_present("5dim_resources", "__5dim_resources__.prototypes.menu-simulations.apply")
end

return apply