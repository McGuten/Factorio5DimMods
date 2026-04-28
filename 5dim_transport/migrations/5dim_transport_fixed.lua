-- migrations/5dim_transport_fix_tech.lua
-- When Space Age is active, logistics-4 doesn't exist (tier 4 uses turbo-transport-belt)
-- This migration ensures turbo-transport-belt is researched if user had 5dim tier 4
if script.active_mods["space-age"] then
    if game then
        for _, force in pairs(game.forces) do
            -- If logistics-5 was researched (our first custom tech with Space Age)
            -- then turbo-transport-belt should also be researched
            if force.technologies["logistics-5"] and force.technologies["logistics-5"].researched then
                if force.technologies["turbo-transport-belt"] then
                    force.technologies["turbo-transport-belt"].researched = true
                end
            end
        end
    end
end