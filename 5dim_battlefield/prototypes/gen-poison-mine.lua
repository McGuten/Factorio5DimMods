-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Poison Mine Generation
-- Creates tiered poison mines that leave a cloud of poison gas
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Base: 500 impact + poison cloud (~750 DoT) = ~1250 total (same as land mine)
-- Scale: x10 damage (1250 → 12500 at T10)
-------------------------------------------------------------------------------

local baseDamage = 500                    -- Impact damage
local damageIncrement = 500               -- 500 → 5000 (x10)
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

-------------------------------------------------------------------------------
-- SUBGROUP (defined in 5dim_core: defense-poison-mine)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier, config in pairs(tierConfig) do
    local tierTech = techConfig[tier]
    local impactDamage = baseDamage + (tier - 1) * damageIncrement
    local poisonTick = basePoisonDamage + (tier - 1) * poisonDamageIncrement
    local triggerRadius = baseTriggerRadius + (tier - 1) * triggerRadiusIncrement
    local tierColor = tierColors[tier]
    
    -- Copy land mine as base
    local item = table.deepcopy(data.raw.item["land-mine"])
    local recipe = table.deepcopy(data.raw.recipe["land-mine"])
    local entity = table.deepcopy(data.raw["land-mine"]["land-mine"])
    
    local name = "5d-poison-mine-" .. tier
    
    -- Item
    item.name = name
    item.subgroup = "defense-poison-mine"
    item.order = config.order
    item.place_result = name
    item.icon = nil
    item.icon_size = nil
    item.icons = {
        { icon = "__base__/graphics/icons/land-mine.png", icon_size = 64 },
        { icon = "__base__/graphics/icons/poison-capsule.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
    }
    
    -- Recipe
    recipe.name = name
    recipe.enabled = false
    recipe.results = { { type = "item", name = name, amount = 1 } }
    if tier == 1 then
        recipe.ingredients = {
            { type = "item", name = "land-mine", amount = 1 },
            { type = "item", name = "poison-capsule", amount = 2 }
        }
    else
        recipe.ingredients = {
            { type = "item", name = "5d-poison-mine-" .. (tier - 1), amount = 1 },
            { type = "item", name = "poison-capsule", amount = 1 },
            { type = "item", name = "steel-plate", amount = 1 }
        }
    end
    
    -- Entity
    entity.name = name
    entity.minable.result = name
    entity.trigger_radius = triggerRadius
    
    -- Change damage type to poison
    entity.action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                {
                    type = "create-entity",
                    entity_name = "poison-cloud"
                },
                {
                    type = "damage",
                    damage = { amount = impactDamage, type = "explosion" }
                },
                {
                    type = "damage",
                    damage = { amount = impactDamage, type = "poison" }
                }
            }
        }
    }
    
    data:extend({ entity, recipe, item })
    
    -- Technology
    if tierTech then
        local tech = table.deepcopy(data.raw.technology["land-mine"])
        tech.name = "5d-poison-mine-" .. tier
        tech.icon = nil
        tech.icon_size = nil
        tech.icons = {
            { icon = "__base__/graphics/icons/land-mine.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/poison-capsule.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        }
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
