-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Acid Mine Generation
-- Creates tiered acid mines with acid damage
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")
local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Base: 750 acid + 500 explosion = 1250 total (same as land mine)
-- Scale: x10 damage (1250 → 12500 at T10)
-------------------------------------------------------------------------------

local baseExplosionAcidDamage = 250        -- Instant acid damage on detonation
local explosionAcidIncrement = 250         -- 250 → 2500 (x10)
local baseAcidDamage = 15                  -- Acid pool damage/tick
local acidDamageIncrement = 15             -- 15 → 150 (x10)
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
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-acid-mine-9" }
    }
}

local acidMineMaterials = {
    [2] = { type = "item", name = "steel-plate", amount = 1 },
    [3] = { type = "item", name = "pipe-to-ground", amount = 1 },
    [4] = { type = "item", name = "sulfur", amount = 2 },
    [5] = { type = "item", name = "plastic-bar", amount = 2 },
    [6] = { type = "fluid", name = "sulfuric-acid", amount = 40 },
    [7] = { type = "item", name = "explosives", amount = 2 },
    [8] = { type = "item", name = "battery", amount = 2 },
    [9] = { type = "item", name = "processing-unit", amount = 1 },
    [10] = { type = "item", name = "low-density-structure", amount = 1 }
}

local acidMineSpaceAgeMaterials = {
    [6] = { name = "calcite", amount = 6, category = "metallurgy" },
    [7] = { name = "carbon-fiber", amount = 4, category = "organic" },
    [8] = { type = "fluid", name = "holmium-solution", amount = 60, category = "chemistry" },
    [9] = { name = "supercapacitor", amount = 2, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 60, category = "cryogenics" }
}

local acidMineSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "agricultural-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local acidMineSpaceAgePrerequisites = {
    [6] = "foundry",
    [7] = "carbon-fiber",
    [8] = "holmium-processing",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local function getAcidMineDeltaMaterial(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and acidMineSpaceAgeMaterials[tier] then
        local override = acidMineSpaceAgeMaterials[tier]
        return {
            type = override.type or "item",
            name = override.name,
            amount = override.amount
        }
    end

    return acidMineMaterials[tier]
end

local function getAcidMineRecipeCategory(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and acidMineSpaceAgeMaterials[tier] then
        return acidMineSpaceAgeMaterials[tier].category
    end

    local material = acidMineMaterials[tier]
    if material and material.type == "fluid" then
        return "crafting-with-fluid"
    end
end

local function getAcidMineIngredients(tier, normalMineName)
    if tier == 1 then
        return {
            { type = "item", name = "land-mine", amount = 1 },
            { type = "fluid", name = "sulfuric-acid", amount = 50 }
        }
    end

    return {
        { type = "item", name = "5d-acid-mine-" .. (tier - 1), amount = 1 },
        { type = "item", name = normalMineName, amount = 1 },
        getAcidMineDeltaMaterial(tier)
    }
end

local function copyPrerequisites(values)
    local result = {}

    for _, value in ipairs(values) do
        table.insert(result, value)
    end

    return result
end

local function getAcidMinePrerequisites(tier, basePrerequisites)
    local prerequisites = copyPrerequisites(basePrerequisites)

    if CostConfig.shouldUseSpaceAgeMaterials() and acidMineSpaceAgePrerequisites[tier] then
        table.insert(prerequisites, acidMineSpaceAgePrerequisites[tier])
    end

    return prerequisites
end

local function getNormalMineName(tier)
    if tier == 1 then
        return "land-mine"
    end

    return "5d-land-mine-" .. tier
end

local function getAcidMineIcons()
    return {
        { icon = "__base__/graphics/icons/land-mine.png", icon_size = 64 },
        { icon = "__base__/graphics/icons/explosion.png", icon_size = 64, scale = 0.28, shift = {-10, -10} },
        { icon = "__base__/graphics/icons/fluid/sulfuric-acid.png", icon_size = 64, scale = 0.28, shift = {10, -10} }
    }
end

local function getAcidMineTieredIcons(tier)
    return TierBadgeIcons.buildTieredIconsFromIcons(getAcidMineIcons(), tier)
end

-------------------------------------------------------------------------------
-- SUBGROUP (defined in 5dim_core: defense-acid-mine)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier, config in pairs(tierConfig) do
    local tierTech = techConfig[tier]
    local normalMineName = getNormalMineName(tier)
    local splashName = "5d-acid-mine-splash-" .. tier
    local explosionAcidDamage = baseExplosionAcidDamage + (tier - 1) * explosionAcidIncrement
    local acidTick = baseAcidDamage + (tier - 1) * acidDamageIncrement
    local triggerRadius = baseTriggerRadius + (tier - 1) * triggerRadiusIncrement
    local tierColor = tierColors[tier]
    local tieredIcons = getAcidMineTieredIcons(tier)
    
    -- Copy the matching normal mine tier as the base so damage stacks logically.
    local item = table.deepcopy(data.raw.item["land-mine"])
    local recipe = table.deepcopy(data.raw.recipe["land-mine"])
    local entity = table.deepcopy(data.raw["land-mine"][normalMineName])
    
    local name = "5d-acid-mine-" .. tier
    
    -- Item
    item.name = name
    item.subgroup = "defense-acid-mine"
    item.order = config.order
    item.place_result = name
    item.icon = nil
    item.icon_size = nil
    item.icon_mipmaps = nil
    item.icons = table.deepcopy(tieredIcons)
    
    -- Recipe
    recipe.name = name
    recipe.enabled = false
    recipe.categories = { "crafting-with-fluid" }
    recipe.icon = nil
    recipe.icon_size = nil
    recipe.icon_mipmaps = nil
    recipe.icons = table.deepcopy(tieredIcons)
    recipe.results = { { type = "item", name = name, amount = 1 } }
    recipe.ingredients = getAcidMineIngredients(tier, normalMineName)
    if getAcidMineRecipeCategory(tier) then recipe.categories = { getAcidMineRecipeCategory(tier) } end
    
    -- Entity
    entity.name = name
    entity.minable.result = name
    entity.trigger_radius = triggerRadius
    entity.is_military_target = false
    entity.icon = nil
    entity.icon_size = nil
    entity.icon_mipmaps = nil
    entity.icons = table.deepcopy(tieredIcons)

    local splash = table.deepcopy(data.raw.fire["acid-splash-fire-spitter-big"])
    splash.name = splashName
    splash.localised_name = nil
    splash.on_damage_tick_effect.action_delivery.target_effects[2].damage.amount = acidTick
    
    -- Keep the normal mine tier damage and add acid burst + scaled acid pool.
    entity.action.action_delivery.target_effects = {
        {
            type = "damage",
            damage = { amount = explosionAcidDamage, type = "acid" }
        },
        {
            type = "create-entity",
            show_in_tooltip = true,
            entity_name = splashName
        }
    }
    
    data:extend({ splash, entity, recipe, item })
    
    -- Technology
    if tierTech then
        local tech = table.deepcopy(data.raw.technology["land-mine"])
        tech.name = "5d-acid-mine-" .. tier
        tech.icon = nil
        tech.icon_size = nil
        tech.icon_mipmaps = nil
        tech.icons = table.deepcopy(tieredIcons)
        tech.unit.count = baseTechCount * tier
        tech.unit.ingredients = CostCalculator.getTechPacks(tierTech.basePacks, tier, {
            spaceAgePackOverrides = acidMineSpaceAgeSciencePacks,
            forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
        })
        tech.prerequisites = getAcidMinePrerequisites(tier, tierTech.prerequisites)
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = name
            }
        }
        data:extend({ tech })
    end
end
