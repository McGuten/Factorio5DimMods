-- 5Dim's Infinite Research - Space Age science pack integration
-- When Space Age is active, infinite techs added by this mod also require
-- the metallurgic science pack (matching vanilla SA progression for late-game
-- infinite techs, which already require this pack from level 1).

if not mods["space-age"] then return end

-- All technology names this mod creates that contain space-science-pack and
-- should also require metallurgic-science-pack under Space Age.
local techNames = {
    "weapon-shooting-speed-7",
    "laser-shooting-speed-8",
    "research-speed-7",
    "research-productivity",
    "braking-force-8",
    "inserter-capacity-bonus-8",
    "worker-robots-storage-4",
    "worker-robots-battery-1",
    "worker-robots-battery-2",
    "worker-robots-battery-3",
    "worker-robots-battery-4",
    "worker-robots-battery-5",
    "worker-robots-battery-6",
    "crafting-speed-1",
    "crafting-speed-6",
    "crafting-speed-11",
    "crafting-speed-16",
    "crafting-speed-21",
    "crafting-speed-26",
    "mining-speed-1",
    "mining-speed-6",
    "mining-speed-11",
    "mining-speed-16",
    "mining-speed-21",
    "mining-speed-26"
}

local function hasIngredient(ingredients, name)
    for _, pack in ipairs(ingredients) do
        if pack[1] == name or pack.name == name then
            return true
        end
    end
    return false
end

for _, techName in ipairs(techNames) do
    local tech = data.raw.technology[techName]
    if tech and tech.unit and tech.unit.ingredients then
        if hasIngredient(tech.unit.ingredients, "space-science-pack")
            and not hasIngredient(tech.unit.ingredients, "metallurgic-science-pack") then
            table.insert(tech.unit.ingredients, { "metallurgic-science-pack", 1 })
        end
    end
end
