local Common = require("__5dim_enemies__.prototypes.menu-simulations.common")
local build_frontier_assault = require("__5dim_enemies__.prototypes.menu-simulations.frontier-assault")
local build_defense_line = require("__5dim_enemies__.prototypes.menu-simulations.defense-line")
local build_power_grid = require("__5dim_enemies__.prototypes.menu-simulations.power-grid")
local build_perimeter_breach = require("__5dim_enemies__.prototypes.menu-simulations.perimeter-breach")

local function apply(menu_simulations)
    if not menu_simulations then
        return
    end

    Common.apply_base_laser_fix(menu_simulations)

    local context = Common.create_context(menu_simulations)

    local frontier_assault = build_frontier_assault(context)
    if frontier_assault then
        menu_simulations["5dim_enemies_frontier_assault"] = frontier_assault
    end

    local defense_line = build_defense_line(context)
    if defense_line then
        menu_simulations["5dim_enemies_defense_line"] = defense_line
    end

    local power_grid = build_power_grid(context)
    if power_grid then
        menu_simulations["5dim_enemies_power_grid"] = power_grid
    end

    local perimeter_breach = build_perimeter_breach(context)
    if perimeter_breach then
        menu_simulations["5dim_enemies_perimeter_breach"] = perimeter_breach
    end
end

return apply