local build_dust_progress = require("__5dim_resources__.prototypes.menu-simulations.dust-progress")

local function apply(menu_simulations)
    if not menu_simulations then
        return
    end

    local dust_progress = build_dust_progress(menu_simulations)
    if dust_progress then
        menu_simulations["5dim_resources_dust_progress"] = dust_progress
    end
end

return apply