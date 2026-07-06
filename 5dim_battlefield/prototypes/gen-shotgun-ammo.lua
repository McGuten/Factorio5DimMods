-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Shotgun Ammo
-- Extends the vanilla shotgun shell line with tungsten and uranium variants.
-------------------------------------------------------------------------------

local CostConfig = require("__5dim_core__.lib.costs.config")

local tungstenShotgunShellIcon = "__5dim_battlefield__/graphics/icon/shotgun/tungsten-shotgun-shell.png"
local uraniumShotgunShellIcon = "__5dim_battlefield__/graphics/icon/shotgun/uranium-shotgun-shell.png"
local uraniumTungstenShotgunShellIcon = "__5dim_battlefield__/graphics/icon/shotgun/uranium-tungsten-shotgun-shell.png"

local function get_piercing_shotgun_pellet_damage()
    local pellet = data.raw.projectile["piercing-shotgun-pellet"]
    if not pellet or not pellet.action or not pellet.action.action_delivery then
        return 0
    end

    local target_effects = pellet.action.action_delivery.target_effects
    if type(target_effects) ~= "table" then
        return 0
    end

    for _, effect in pairs(target_effects) do
        if type(effect) == "table" and effect.type == "damage" and effect.damage and effect.damage.amount then
            return effect.damage.amount
        end
    end

    return 0
end

local function get_piercing_shotgun_pellet_count()
    local ammo = data.raw.ammo["piercing-shotgun-shell"]
    if not ammo or not ammo.ammo_type or not ammo.ammo_type.action then
        return 0
    end

    local action = ammo.ammo_type.action[1]
    if not action or not action.action_delivery or not action.action_delivery.target_effects then
        return 0
    end

    local target_effects = action.action_delivery.target_effects
    if type(target_effects) ~= "table" then
        return 0
    end

    if target_effects.action and target_effects.action.repeat_count then
        return target_effects.action.repeat_count
    end

    for _, effect in pairs(target_effects) do
        if type(effect) == "table" and effect.action and effect.action.repeat_count then
            return effect.action.repeat_count
        end
    end

    return 0
end

local piercingShotgunPelletDamage = get_piercing_shotgun_pellet_damage()
local piercingShotgunPelletCount = get_piercing_shotgun_pellet_count()

-- Damage for the tiered shell variants, scaled from the base piercing pellet
-- so they stay ordered (tungsten < uranium < uranium-tungsten) if the base changes.
local tungstenShotgunPelletDamage = piercingShotgunPelletDamage * 1.5
local uraniumShotgunPelletDamage = piercingShotgunPelletDamage * 2
local uraniumTungstenShotgunPelletDamage = piercingShotgunPelletDamage * 2.5

local function set_pellet_damage(pellet, damage)
    local target_effects = pellet and pellet.action and pellet.action.action_delivery and pellet.action.action_delivery.target_effects
    if type(target_effects) ~= "table" then
        return
    end

    for _, effect in pairs(target_effects) do
        if type(effect) == "table" and effect.type == "damage" and effect.damage then
            effect.damage.amount = damage
            return
        end
    end
end

local function make_pellet(name, damage)
    local pellet = table.deepcopy(data.raw.projectile["piercing-shotgun-pellet"])

    pellet.name = name
    set_pellet_damage(pellet, damage)

    return pellet
end

local function set_ammo_projectile(ammo, projectile_name, pellet_count)
    local action = ammo and ammo.ammo_type and ammo.ammo_type.action and ammo.ammo_type.action[1]
    if not action or not action.action_delivery or not action.action_delivery.target_effects then
        return
    end

    local target_effects = action.action_delivery.target_effects
    local nested_action = target_effects.action

    if not nested_action then
        for _, effect in pairs(target_effects) do
            if type(effect) == "table" and effect.action then
                nested_action = effect.action
                break
            end
        end
    end

    if nested_action then
        nested_action.repeat_count = pellet_count
        if nested_action.action_delivery then
            nested_action.action_delivery.projectile = projectile_name
        end
    end
end

local function make_ammo(name, icon, order, projectile_name, pellet_count)
    local ammo = table.deepcopy(data.raw.ammo["piercing-shotgun-shell"])

    ammo.name = name
    ammo.icon = icon
    ammo.icon_size = nil
    ammo.icons = nil
    ammo.subgroup = "equipment-shotgun"
    ammo.order = order
    set_ammo_projectile(ammo, projectile_name, pellet_count)

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