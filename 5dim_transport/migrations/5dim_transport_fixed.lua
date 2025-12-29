-- migrations/5dim_transport_fix_tech.lua
if script.active_mods["space-age"] then
    if game then
        for _, force in pairs(game.forces) do
            -- Si la tecnología de 5Dim nivel 4 estaba investigada
            if force.technologies["5d-transport-belt-04"] and force.technologies["5d-transport-belt-04"].researched then
                -- Desbloqueamos la tecnología Turbo de Space Age
                if force.technologies["turbo-transport-belt"] then
                    force.technologies["turbo-transport-belt"].researched = true
                end
            end
        end
    end
end