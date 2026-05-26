-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Shotgun Ammo
-- Extends the vanilla shotgun shell line with tungsten and uranium variants.
-------------------------------------------------------------------------------

local CostConfig = require("__5dim_core__.lib.costs.config")

local tungstenShotgunShellIcon = "__5dim_battlefield__/graphics/icon/shotgun/tungsten-shotgun-shell.png"
local uraniumShotgunShellIcon = "__5dim_battlefield__/graphics/icon/shotgun/uranium-shotgun-shell.png"
local uraniumTungstenShotgunShellIcon = "__5dim_battlefield__/graphics/icon/shotgun/uranium-tungsten-shotgun-shell.png"

local piercingShotgunPelletDamage = data.raw.projectile["piercing-shotgun-pellet"].action.action_delivery.target_effects.damage.amount
local piercingShotgunPelletCount = data.raw.ammo["piercing-shotgun-shell"].ammo_type.action[2].repeat_count

local function scale_pellet_damage(numerator, denominator)
    return math.floor((piercingShotgunPelletDamage * numerator / denominator) + 0.5)
end

local tungstenShotgunPelletDamage = scale_pellet_damage(20, 16)
local uraniumShotgunPelletDamage = scale_pellet_damage(24, 16)
local uraniumTungstenShotgunPelletDamage = scale_pellet_damage(32, 16)

local function make_pellet(name, damage)
    local pellet = table.deepcopy(data.raw.projectile["piercing-shotgun-pellet"])

    pellet.name = name
    pellet.action.action_delivery.target_effects.damage.amount = damage

    return pellet
end

local function make_ammo(name, icon, order, projectile_name, pellet_count)
    local ammo = table.deepcopy(data.raw.ammo["piercing-shotgun-shell"])

    ammo.name = name
    ammo.icon = icon
    ammo.icon_size = nil
    ammo.icons = nil
    ammo.subgroup = "equipment-shotgun"
    ammo.order = order
    ammo.ammo_type.action[2].repeat_count = pellet_count
    ammo.ammo_type.action[2].action_delivery.projectile = projectile_name

    return ammo
end

local function make_recipe(name, icon, order, energy_required, ingredients)
    local recipe = table.deepcopy(data.raw.recipe["piercing-shotgun-shell"])

    recipe.name = name
    recipe.enabled = false
    recipe.energy_required = energy_required
    recipe.subgroup = "equipment-shotgun"
    recipe.order = order
    recipe.ingredients = ingredients
    recipe.results = {
        { type = "item", name = name, amount = 1 }
    }
    recipe.main_product = name
    recipe.icon = icon
    recipe.icon_size = nil
    recipe.icons = nil

    return recipe
end

local function make_technology(name, icon, recipe_name, prerequisites, unit, order)
    return {
        type = "technology",
        name = name,
        icon = icon,
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

local prototypes = {
    make_pellet("5d-uranium-shotgun-pellet", uraniumShotgunPelletDamage),
    make_ammo("5d-uranium-shotgun-shell", uraniumShotgunShellIcon, "f", "5d-uranium-shotgun-pellet", piercingShotgunPelletCount),
    make_recipe(
        "5d-uranium-shotgun-shell",
        uraniumShotgunShellIcon,
        "f",
        10,
        {
            { type = "item", name = "piercing-shotgun-shell", amount = 1 },
            { type = "item", name = "uranium-238", amount = 1 }
        }
    ),
    make_technology(
        "5d-uranium-shotgun-shells",
        uraniumShotgunShellIcon,
        "5d-uranium-shotgun-shell",
        { "uranium-ammo" },
        {
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
        "e-a-d"
    )
}

if CostConfig.shouldUseSpaceAgeMaterials() then
    table.insert(prototypes, make_pellet("5d-tungsten-shotgun-pellet", tungstenShotgunPelletDamage))
    table.insert(prototypes, make_ammo("5d-tungsten-shotgun-shell", tungstenShotgunShellIcon, "e", "5d-tungsten-shotgun-pellet", piercingShotgunPelletCount))
    table.insert(
        prototypes,
        make_recipe(
            "5d-tungsten-shotgun-shell",
            tungstenShotgunShellIcon,
            "e",
            8,
            {
                { type = "item", name = "piercing-shotgun-shell", amount = 1 },
                { type = "item", name = "tungsten-plate", amount = 1 }
            }
        )
    )
    table.insert(
        prototypes,
        make_technology(
            "5d-tungsten-shotgun-shells",
            tungstenShotgunShellIcon,
            "5d-tungsten-shotgun-shell",
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
        )
    )

    table.insert(prototypes, make_pellet("5d-uranium-tungsten-shotgun-pellet", uraniumTungstenShotgunPelletDamage))
    table.insert(
        prototypes,
        make_ammo(
            "5d-uranium-tungsten-shotgun-shell",
            uraniumTungstenShotgunShellIcon,
            "g",
            "5d-uranium-tungsten-shotgun-pellet",
            piercingShotgunPelletCount
        )
    )
    table.insert(
        prototypes,
        make_recipe(
            "5d-uranium-tungsten-shotgun-shell",
            uraniumTungstenShotgunShellIcon,
            "g",
            12,
            {
                { type = "item", name = "5d-uranium-shotgun-shell", amount = 1 },
                { type = "item", name = "tungsten-plate", amount = 1 }
            }
        )
    )
    table.insert(
        prototypes,
        make_technology(
            "5d-uranium-tungsten-shotgun-shells",
            uraniumTungstenShotgunShellIcon,
            "5d-uranium-tungsten-shotgun-shell",
            { "5d-tungsten-shotgun-shells", "5d-uranium-shotgun-shells" },
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
    )
end

data:extend(prototypes)