-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Acid Mine Generation
-- Creates tiered acid mines with acid damage
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Base: 750 acid + 500 explosion = 1250 total (same as land mine)
-- Scale: x10 damage (1250 → 12500 at T10)
-------------------------------------------------------------------------------

local baseDamage = 750                    -- Acid damage
local damageIncrement = 750               -- 750 → 7500 (x10)
local baseExplosionDamage = 500           -- Explosion damage  
local explosionIncrement = 500            -- 500 → 5000 (x10)
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
        prerequisites = { "5d-acid-mine-1" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-acid-mine-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-acid-mine-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 }
        },
        prerequisites = { "5d-acid-mine-4" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-acid-mine-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "5d-acid-mine-6" }
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
        prerequisites = { "5d-acid-mine-7" }
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
        prerequisites = { "5d-acid-mine-8" }
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
        prerequisites = { "5d-acid-mine-9" }
    }
}

-------------------------------------------------------------------------------
-- SUBGROUP (defined in 5dim_core: defense-acid-mine)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier, config in pairs(tierConfig) do
    local tierTech = techConfig[tier]
    local acidDamage = baseDamage + (tier - 1) * damageIncrement
    local explosionDamage = baseExplosionDamage + (tier - 1) * explosionIncrement
    local triggerRadius = baseTriggerRadius + (tier - 1) * triggerRadiusIncrement
    local tierColor = tierColors[tier]
    
    -- Copy land mine as base
    local item = table.deepcopy(data.raw.item["land-mine"])
    local recipe = table.deepcopy(data.raw.recipe["land-mine"])
    local entity = table.deepcopy(data.raw["land-mine"]["land-mine"])
    
    local name = "5d-acid-mine-" .. tier
    
    -- Item
    item.name = name
    item.subgroup = "defense-acid-mine"
    item.order = config.order
    item.place_result = name
    item.icon = nil
    item.icon_size = nil
    item.icons = {
        { icon = "__base__/graphics/icons/land-mine.png", icon_size = 64 },
        { icon = "__base__/graphics/icons/fluid/sulfuric-acid.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
    }
    
    -- Recipe
    recipe.name = name
    recipe.enabled = false
    recipe.category = "crafting-with-fluid"
    recipe.results = { { type = "item", name = name, amount = 1 } }
    if tier == 1 then
        recipe.ingredients = {
            { type = "item", name = "land-mine", amount = 1 },
            { type = "fluid", name = "sulfuric-acid", amount = 50 }
        }
    else
        recipe.ingredients = {
            { type = "item", name = "5d-acid-mine-" .. (tier - 1), amount = 1 },
            { type = "fluid", name = "sulfuric-acid", amount = 50 },
            { type = "item", name = "steel-plate", amount = 1 }
        }
    end
    
    -- Entity
    entity.name = name
    entity.minable.result = name
    entity.trigger_radius = triggerRadius
    
    -- Change damage type to acid
    entity.action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                {
                    type = "create-entity",
                    entity_name = "acid-splash-fire-spitter-big"
                },
                {
                    type = "damage",
                    damage = { amount = acidDamage, type = "acid" }
                },
                {
                    type = "damage",
                    damage = { amount = explosionDamage, type = "explosion" }
                }
            }
        }
    }
    
    data:extend({ entity, recipe, item })
    
    -- Technology
    if tierTech then
        local tech = table.deepcopy(data.raw.technology["land-mine"])
        tech.name = "5d-acid-mine-" .. tier
        tech.icon = nil
        tech.icon_size = nil
        tech.icons = {
            { icon = "__base__/graphics/icons/land-mine.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/fluid/sulfuric-acid.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
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
