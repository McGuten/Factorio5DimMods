-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Poison Mine Generation
-- Creates tiered poison mines that leave a cloud of poison gas
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Base: 500 impact + poison cloud (~750 DoT) = ~1250 total (same as land mine)
-- Scale: x10 damage (1250 → 12500 at T10)
-------------------------------------------------------------------------------

local baseExplosionPoisonDamage = 250      -- Instant poison damage on detonation
local explosionPoisonIncrement = 250       -- 250 → 2500 (x10)
local basePoisonDamage = 15               -- Poison cloud damage/tick
local poisonDamageIncrement = 15          -- 15 → 150 (x10)
local baseTriggerRadius = 2.5
local triggerRadiusIncrement = 0.25
local baseTechCount = 150

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a" },
    [2]  = { order = "b" },
    [3]  = { order = "c" },
    [4]  = { order = "d" },
    [5]  = { order = "e" },
    [6]  = { order = "f" },
    [7]  = { order = "g" },
    [8]  = { order = "h" },
    [9]  = { order = "i" },
    [10] = { order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local techConfig = {
    [1] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "land-mine", "military-3" }
    },
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-poison-mine-1" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-poison-mine-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-poison-mine-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-poison-mine-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-poison-mine-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-poison-mine-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-poison-mine-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-poison-mine-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        },
        prerequisites = { "5d-poison-mine-9" }
    }
}

local function getNormalMineName(tier)
    if tier == 1 then
        return "land-mine"
    end

    return "5d-land-mine-" .. tier
end

local function getPoisonMineIcons()
    return {
        { icon = "__base__/graphics/icons/land-mine.png", icon_size = 64 },
        { icon = "__base__/graphics/icons/explosion.png", icon_size = 64, scale = 0.28, shift = {-10, -10} },
        { icon = "__base__/graphics/icons/poison-capsule.png", icon_size = 64, scale = 0.28, shift = {10, -10} }
    }
end

local function getPoisonMineTieredIcons(tier)
    return TierBadgeIcons.buildTieredIconsFromIcons(getPoisonMineIcons(), tier)
end

-------------------------------------------------------------------------------
-- SUBGROUP (defined in 5dim_core: defense-poison-mine)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier, config in pairs(tierConfig) do
    local tierTech = techConfig[tier]
    local normalMineName = getNormalMineName(tier)
    local cloudName = "5d-poison-mine-cloud-" .. tier
    local explosionPoisonDamage = baseExplosionPoisonDamage + (tier - 1) * explosionPoisonIncrement
    local poisonTick = basePoisonDamage + (tier - 1) * poisonDamageIncrement
    local triggerRadius = baseTriggerRadius + (tier - 1) * triggerRadiusIncrement
    local tierColor = tierColors[tier]
    local tieredIcons = getPoisonMineTieredIcons(tier)
    
    -- Copy the matching normal mine tier as the base so damage stacks logically.
    local item = table.deepcopy(data.raw.item["land-mine"])
    local recipe = table.deepcopy(data.raw.recipe["land-mine"])
    local entity = table.deepcopy(data.raw["land-mine"][normalMineName])
    
    local name = "5d-poison-mine-" .. tier
    
    -- Item
    item.name = name
    item.subgroup = "defense-poison-mine"
    item.order = config.order
    item.place_result = name
    item.icon = nil
    item.icon_size = nil
    item.icon_mipmaps = nil
    item.icons = table.deepcopy(tieredIcons)
    
    -- Recipe
    recipe.name = name
    recipe.enabled = false
    recipe.icon = nil
    recipe.icon_size = nil
    recipe.icon_mipmaps = nil
    recipe.icons = table.deepcopy(tieredIcons)
    recipe.results = { { type = "item", name = name, amount = 1 } }
    if tier == 1 then
        recipe.ingredients = {
            { type = "item", name = "land-mine", amount = 1 },
            { type = "item", name = "poison-capsule", amount = 2 }
        }
    else
        recipe.ingredients = {
            { type = "item", name = "5d-poison-mine-" .. (tier - 1), amount = 1 },
            { type = "item", name = normalMineName, amount = 1 },
            { type = "item", name = "poison-capsule", amount = 1 },
            { type = "item", name = "steel-plate", amount = 1 }
        }
    end
    
    -- Entity
    entity.name = name
    entity.minable.result = name
    entity.trigger_radius = triggerRadius
    entity.is_military_target = false
    entity.icon = nil
    entity.icon_size = nil
    entity.icon_mipmaps = nil
    entity.icons = table.deepcopy(tieredIcons)

    local cloud = table.deepcopy(data.raw["smoke-with-trigger"]["poison-cloud"])
    cloud.name = cloudName
    cloud.localised_name = nil
    cloud.action.action_delivery.target_effects.action.action_delivery.target_effects.damage.amount = poisonTick
    
    -- Keep the normal mine tier damage and add poison burst + scaled poison cloud.
    entity.action.action_delivery.target_effects = {
        {
            type = "damage",
            damage = { amount = explosionPoisonDamage, type = "poison" }
        },
        {
            type = "create-smoke",
            show_in_tooltip = true,
            entity_name = cloudName,
            initial_height = 0
        }
    }
    
    data:extend({ cloud, entity, recipe, item })
    
    -- Technology
    if tierTech then
        local tech = table.deepcopy(data.raw.technology["land-mine"])
        tech.name = "5d-poison-mine-" .. tier
        tech.icon = nil
        tech.icon_size = nil
        tech.icon_mipmaps = nil
        tech.icons = table.deepcopy(tieredIcons)
        tech.unit.count = baseTechCount * tier
        tech.unit.ingredients = tierTech.basePacks
        tech.prerequisites = tierTech.prerequisites
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = name
            }
        }
        data:extend({ tech })
    end
end
