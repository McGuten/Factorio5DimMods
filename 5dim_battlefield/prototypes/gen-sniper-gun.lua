-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Sniper Rifle
-------------------------------------------------------------------------------

local rifleItemIcon = "__5dim_battlefield__/graphics/icon/sniper/sniper-rifle.png"
local rifleTechIcon = "__5dim_battlefield__/graphics/icon/sniper/sniper-rifle-tech.png"

local rifle = table.deepcopy(data.raw.gun["submachine-gun"])
local heavyGun = data.raw.gun["tank-machine-gun"]

rifle.name = "5d-sniper-rifle"
rifle.icon = rifleItemIcon
rifle.icon_size = 64
rifle.icon_mipmaps = nil
rifle.icons = nil
rifle.subgroup = "equipment-sniper"
rifle.order = "a"
rifle.stack_size = 1
rifle.attack_parameters.ammo_category = "5d-sniper-rounds"
rifle.attack_parameters.cooldown = 10
rifle.attack_parameters.movement_slow_down_factor = 0.8
rifle.attack_parameters.projectile_creation_distance = 1.25
rifle.attack_parameters.range = 28
if heavyGun and heavyGun.attack_parameters and heavyGun.attack_parameters.sound then
    rifle.attack_parameters.sound = table.deepcopy(heavyGun.attack_parameters.sound)
end

data:extend({
    rifle,
    {
        type = "recipe",
        name = "5d-sniper-rifle",
        enabled = false,
        energy_required = 10,
        subgroup = rifle.subgroup,
        order = rifle.order,
        ingredients = {
            { type = "item", name = "submachine-gun", amount = 1 },
            { type = "item", name = "steel-plate", amount = 10 },
            { type = "item", name = "advanced-circuit", amount = 5 }
        },
        results = { { type = "item", name = "5d-sniper-rifle", amount = 1 } },
        icon = rifleItemIcon,
        icon_size = 64
    },
    {
        type = "technology",
        name = "5d-sniper-rifle",
        icon = rifleTechIcon,
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "5d-sniper-rifle"
            },
            {
                type = "unlock-recipe",
                recipe = "5d-sniper-magazine"
            }
        },
        prerequisites = { "military-2", "steel-processing" },
        unit = {
            count = 80,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 }
            },
            time = 20
        },
        order = "e-a-a"
    }
})