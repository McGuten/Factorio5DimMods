-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Rifle Ammo
-- Extends the vanilla bullet line with tungsten and uranium+tungsten magazines.
-------------------------------------------------------------------------------

local CostConfig = require("__5dim_core__.lib.costs.config")

if not CostConfig.shouldUseSpaceAgeMaterials() then
    return
end

local tungstenRifleMagazineIcon = "__5dim_battlefield__/graphics/icon/rifle/tungsten-rifle-magazine.png"
local tungstenRifleMagazineTechIcon = "__5dim_battlefield__/graphics/icon/rifle/tungsten-rifle-magazine-tech.png"
local uraniumTungstenRifleMagazineIcon = "__5dim_battlefield__/graphics/icon/rifle/uranium-tungsten-rifle-magazine.png"
local uraniumTungstenRifleMagazineTechIcon = "__5dim_battlefield__/graphics/icon/rifle/uranium-tungsten-rifle-magazine-tech.png"

local function make_ammo(name, icon, order, damage)
    local ammo = table.deepcopy(data.raw.ammo["piercing-rounds-magazine"])

    ammo.name = name
    ammo.icon = icon
    ammo.icon_size = 64
    ammo.icons = nil
    ammo.pictures = nil
    ammo.subgroup = "equipment-bullet"
    ammo.order = order
    ammo.ammo_type.action.action_delivery.target_effects[2].damage.amount = damage

    return ammo
end

local function make_recipe(name, icon, order, energy_required, ingredients)
    local recipe = table.deepcopy(data.raw.recipe["uranium-rounds-magazine"])

    recipe.name = name
    recipe.enabled = false
    recipe.energy_required = energy_required
    recipe.subgroup = "equipment-bullet"
    recipe.order = order
    recipe.ingredients = ingredients
    recipe.results = {
        { type = "item", name = name, amount = 1 }
    }
    recipe.main_product = name
    recipe.icon = icon
    recipe.icon_size = 64
    recipe.icons = nil

    return recipe
end

local function make_technology(name, icon, recipe_name, prerequisites, unit, order)
    return {
        type = "technology",
        name = name,
        icon = icon,
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = recipe_name
            }
        },
        prerequisites = prerequisites,
        unit = unit,
        order = order
    }
end

data:extend({
    make_ammo("5d-tungsten-rifle-magazine", tungstenRifleMagazineIcon, "f", 16),
    make_recipe(
        "5d-tungsten-rifle-magazine",
        tungstenRifleMagazineIcon,
        "f",
        8,
        {
            { type = "item", name = "piercing-rounds-magazine", amount = 1 },
            { type = "item", name = "tungsten-plate", amount = 1 }
        }
    ),
    make_technology(
        "5d-tungsten-rifle-rounds",
        tungstenRifleMagazineTechIcon,
        "5d-tungsten-rifle-magazine",
        { "military-4", "space-science-pack", "metallurgic-science-pack" },
        {
            count = 600,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 },
                { "metallurgic-science-pack", 1 }
            },
            time = 45
        },
        "e-a-c"
    ),
    make_ammo("5d-uranium-tungsten-rifle-magazine", uraniumTungstenRifleMagazineIcon, "h", 32),
    make_recipe(
        "5d-uranium-tungsten-rifle-magazine",
        uraniumTungstenRifleMagazineIcon,
        "h",
        12,
        {
            { type = "item", name = "uranium-rounds-magazine", amount = 1 },
            { type = "item", name = "tungsten-plate", amount = 1 }
        }
    ),
    make_technology(
        "5d-uranium-tungsten-rifle-rounds",
        uraniumTungstenRifleMagazineTechIcon,
        "5d-uranium-tungsten-rifle-magazine",
        { "5d-tungsten-rifle-rounds", "uranium-ammo" },
        {
            count = 900,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "military-science-pack", 1 },
                { "utility-science-pack", 1 },
                { "space-science-pack", 1 },
                { "metallurgic-science-pack", 1 }
            },
            time = 60
        },
        "e-a-e"
    )
})