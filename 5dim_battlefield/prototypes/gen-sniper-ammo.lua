-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Sniper Ammo
-- Shared sniper ammunition for the manual rifle and sniper gun turrets
-------------------------------------------------------------------------------

local sniperRoundsCategoryIcon = "__5dim_battlefield__/graphics/icon/sniper/sniper-magazine.png"
local sniperMagazineItemIcon = "__5dim_battlefield__/graphics/icon/sniper/sniper-magazine.png"
local sniperMagazineTechIcon = "__5dim_battlefield__/graphics/icon/sniper/sniper-magazine-tech.png"
local piercingSniperMagazineItemIcon = "__5dim_battlefield__/graphics/icon/sniper/piercing-sniper-magazine.png"
local piercingSniperMagazineTechIcon = "__5dim_battlefield__/graphics/icon/sniper/piercing-sniper-magazine-tech.png"
local uraniumSniperMagazineItemIcon = "__5dim_battlefield__/graphics/icon/sniper/uranium-sniper-magazine.png"
local uraniumSniperMagazineTechIcon = "__5dim_battlefield__/graphics/icon/sniper/uranium-sniper-magazine-tech.png"

local function ammo_effects(damage)
    return {
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                source_effects = {
                    {
                        type = "create-explosion",
                        entity_name = "explosion-gunshot",
                        only_when_visible = true
                    }
                },
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "explosion-hit",
                        offsets = { { 0, 1 } },
                        offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
                        only_when_visible = true
                    },
                    {
                        type = "damage",
                        damage = { amount = damage, type = "physical" }
                    },
                    {
                        type = "activate-impact",
                        deliver_category = "bullet"
                    }
                }
            }
        }
    }
end

data:extend({
    {
        type = "ammo-category",
        name = "5d-sniper-rounds",
        icon = sniperRoundsCategoryIcon,
        icon_size = 64,
        subgroup = "ammo-category"
    },
    {
        type = "ammo",
        name = "5d-sniper-magazine",
        icon = sniperMagazineItemIcon,
        icon_size = 64,
        ammo_category = "5d-sniper-rounds",
        ammo_type = ammo_effects(10),
        magazine_size = 5,
        subgroup = "equipment-sniper",
        order = "b",
        stack_size = 100
    },
    {
        type = "ammo",
        name = "5d-piercing-sniper-magazine",
        icon = piercingSniperMagazineItemIcon,
        icon_size = 64,
        ammo_category = "5d-sniper-rounds",
        ammo_type = ammo_effects(16),
        magazine_size = 5,
        subgroup = "equipment-sniper",
        order = "c",
        stack_size = 100
    },
    {
        type = "ammo",
        name = "5d-uranium-sniper-magazine",
        icon = uraniumSniperMagazineItemIcon,
        icon_size = 64,
        ammo_category = "5d-sniper-rounds",
        ammo_type = ammo_effects(24),
        magazine_size = 5,
        subgroup = "equipment-sniper",
        order = "d",
        stack_size = 100
    },
    {
        type = "recipe",
        name = "5d-sniper-magazine",
        enabled = false,
        energy_required = 2,
        subgroup = "equipment-sniper",
        order = "b",
        ingredients = {
            { type = "item", name = "firearm-magazine", amount = 1 },
            { type = "item", name = "steel-plate", amount = 1 },
            { type = "item", name = "copper-plate", amount = 2 }
        },
        results = { { type = "item", name = "5d-sniper-magazine", amount = 1 } },
        icon = sniperMagazineItemIcon,
        icon_size = 64
    },
    {
        type = "recipe",
        name = "5d-piercing-sniper-magazine",
        enabled = false,
        energy_required = 3,
        subgroup = "equipment-sniper",
        order = "c",
        ingredients = {
            { type = "item", name = "5d-sniper-magazine", amount = 1 },
            { type = "item", name = "steel-plate", amount = 2 },
            { type = "item", name = "copper-plate", amount = 2 }
        },
        results = { { type = "item", name = "5d-piercing-sniper-magazine", amount = 1 } },
        icon = piercingSniperMagazineItemIcon,
        icon_size = 64
    },
    {
        type = "recipe",
        name = "5d-uranium-sniper-magazine",
        enabled = false,
        energy_required = 10,
        subgroup = "equipment-sniper",
        order = "d",
        ingredients = {
            { type = "item", name = "5d-piercing-sniper-magazine", amount = 1 },
            { type = "item", name = "uranium-238", amount = 1 }
        },
        results = { { type = "item", name = "5d-uranium-sniper-magazine", amount = 1 } },
        icon = uraniumSniperMagazineItemIcon,
        icon_size = 64
    },
    {
        type = "technology",
        name = "5d-piercing-sniper-rounds",
        icon = piercingSniperMagazineTechIcon,
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "5d-piercing-sniper-magazine"
            }
        },
        prerequisites = { "5d-gun-turret-sniper-1", "physical-projectile-damage-3" },
        unit = {
            count = 150,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "military-science-pack", 1 }
            },
            time = 30
        },
        order = "e-a-b"
    },
    {
        type = "technology",
        name = "5d-uranium-sniper-rounds",
        icon = uraniumSniperMagazineTechIcon,
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "5d-uranium-sniper-magazine"
            }
        },
        prerequisites = { "5d-piercing-sniper-rounds", "uranium-ammo" },
        unit = {
            count = 400,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            time = 45
        },
        order = "e-a-c"
    }
})