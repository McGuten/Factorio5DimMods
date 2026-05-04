local function add_tech_effect(techName, effect)
    local technology = data.raw.technology[techName]
    if technology and technology.effects then
        table.insert(technology.effects, effect)
    end
end

for _, dataEntry in ipairs({
    { name = "physical-projectile-damage-1", modifier = 0.1 },
    { name = "physical-projectile-damage-2", modifier = 0.1 },
    { name = "physical-projectile-damage-3", modifier = 0.2 },
    { name = "physical-projectile-damage-4", modifier = 0.2 },
    { name = "physical-projectile-damage-5", modifier = 0.2 },
    { name = "physical-projectile-damage-6", modifier = 0.4 },
    { name = "physical-projectile-damage-7", modifier = 0.4 }
}) do
    add_tech_effect(dataEntry.name, {
        type = "ammo-damage",
        ammo_category = "5d-sniper-rounds",
        modifier = dataEntry.modifier
    })
end

for _, dataEntry in ipairs({
    { name = "weapon-shooting-speed-1", modifier = 0.1 },
    { name = "weapon-shooting-speed-2", modifier = 0.2 },
    { name = "weapon-shooting-speed-3", modifier = 0.2 },
    { name = "weapon-shooting-speed-4", modifier = 0.3 },
    { name = "weapon-shooting-speed-5", modifier = 0.3 },
    { name = "weapon-shooting-speed-6", modifier = 0.4 },
    { name = "weapon-shooting-speed-7", modifier = 0.4 }
}) do
    add_tech_effect(dataEntry.name, {
        type = "gun-speed",
        ammo_category = "5d-sniper-rounds",
        modifier = dataEntry.modifier
    })
end