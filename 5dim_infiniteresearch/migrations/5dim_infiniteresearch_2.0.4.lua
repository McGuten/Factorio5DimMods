if script.active_mods["space-age"] then return end

if not game then return end

for _, force in pairs(game.forces) do
    local oldTech = force.technologies["research-productivity"]
    local newTech = force.technologies["5d-research-productivity"]

    if oldTech and newTech then
        if force.current_research and force.current_research.name == "research-productivity" then
            local progress = force.research_progress
            force.current_research = newTech
            force.research_progress = progress
        end

        if oldTech.researched and not newTech.researched then
            newTech.researched = true
        end

        if oldTech.level > newTech.level then
            newTech.level = oldTech.level
        end

        if oldTech.saved_progress > 0 then
            newTech.saved_progress = oldTech.saved_progress
        end
    end
end
