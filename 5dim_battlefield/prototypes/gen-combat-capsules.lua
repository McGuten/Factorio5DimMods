-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Combat Capsules Generation
-- Creates tiered combat capsules (Grenade, Cluster Grenade, Poison, Slowdown)
-- Subgroups defined in 5dim_core
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")
local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")

local function setTieredIcons(prototype, baseIcon, tier)
    prototype.icon = nil
    prototype.icon_size = nil
    prototype.icon_mipmaps = nil
    prototype.icons = TierBadgeIcons.buildTieredIcons(baseIcon, tier, 64)
end

setTieredIcons(data.raw.capsule["grenade"], "__base__/graphics/icons/grenade.png", 1)
setTieredIcons(data.raw.recipe["grenade"], "__base__/graphics/icons/grenade.png", 1)
setTieredIcons(data.raw.capsule["cluster-grenade"], "__base__/graphics/icons/cluster-grenade.png", 1)
setTieredIcons(data.raw.recipe["cluster-grenade"], "__base__/graphics/icons/cluster-grenade.png", 1)
setTieredIcons(data.raw.capsule["poison-capsule"], "__base__/graphics/icons/poison-capsule.png", 1)
setTieredIcons(data.raw.recipe["poison-capsule"], "__base__/graphics/icons/poison-capsule.png", 1)
setTieredIcons(data.raw.capsule["slowdown-capsule"], "__base__/graphics/icons/slowdown-capsule.png", 1)
setTieredIcons(data.raw.recipe["slowdown-capsule"], "__base__/graphics/icons/slowdown-capsule.png", 1)

-------------------------------------------------------------------------------
-- TIER DEFINITIONS
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { order = "a", isVanilla = true },
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
-- TECHNOLOGY PACKS BY TIER
-------------------------------------------------------------------------------

local function getTechPacks(tier)
    if tier <= 3 then
        return {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        }
    elseif tier <= 7 then
        return {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        }
    else
        return {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        }
    end
end

local combatSupportMaterials = {
    [2] = { type = "item", name = "flying-robot-frame", amount = 1 },
    [3] = { type = "item", name = "battery", amount = 2 },
    [4] = { type = "item", name = "advanced-circuit", amount = 2 },
    [5] = { type = "item", name = "electric-engine-unit", amount = 1 },
    [6] = { type = "item", name = "processing-unit", amount = 1 },
    [7] = { type = "item", name = "low-density-structure", amount = 1 },
    [8] = { type = "item", name = "speed-module-2", amount = 1 },
    [9] = { type = "item", name = "productivity-module-2", amount = 1 },
    [10] = { type = "item", name = "speed-module-3", amount = 1 }
}

local combatSupportSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 2, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 40, category = "electromagnetics" },
    [9] = { name = "superconductor", amount = 1, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 1, category = "cryogenics" }
}

local combatSupportSpaceAgeSciencePacks = {
    [7] = { "space-science-pack", "electromagnetic-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local combatSupportSpaceAgePrerequisites = {
    [7] = "electromagnetic-plant",
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local grenadeRecipeOverrides = {
    materials = {
        [2] = { type = "item", name = "sulfur", amount = 2 },
        [3] = { type = "item", name = "explosives", amount = 2 },
        [4] = { type = "item", name = "plastic-bar", amount = 2 }
    },
    vanillaPrerequisites = {
        [2] = "sulfur-processing",
        [3] = "explosives",
        [4] = "plastics"
    },
    spaceAgeMaterials = {
        [5] = { name = "calcite", amount = 2 },
        [6] = { name = "tungsten-plate", amount = 2 },
        [7] = { name = "holmium-plate", amount = 2 },
        [8] = { type = "fluid", name = "electrolyte", amount = 40 },
        [9] = { name = "carbon-fiber", amount = 2 },
        [10] = { type = "fluid", name = "fluorine", amount = 40 }
    },
    spaceAgePrerequisites = {
        [5] = "foundry",
        [6] = "tungsten-steel",
        [7] = "electromagnetic-plant",
        [8] = "electromagnetic-plant",
        [9] = "carbon-fiber",
        [10] = "cryogenic-plant"
    }
}

local function getCombatSupportDeltaMaterial(tier, overrides)
    local materials = overrides and overrides.materials
    local spaceAgeMaterials = overrides and overrides.spaceAgeMaterials or combatSupportSpaceAgeMaterials

    if CostConfig.shouldUseSpaceAgeMaterials() and spaceAgeMaterials[tier] then
        local override = spaceAgeMaterials[tier]
        return {
            type = override.type or "item",
            name = override.name,
            amount = override.amount
        }
    end

    return (materials and materials[tier]) or combatSupportMaterials[tier]
end

local function getCombatSupportRecipeCategory(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and combatSupportSpaceAgeMaterials[tier] then
        return combatSupportSpaceAgeMaterials[tier].category
    end
end

local function getCombatSupportIngredients(tier, baseName, previousPrefix, overrides)
    return {
        { type = "item", name = tier == 2 and baseName or (previousPrefix .. (tier - 1)), amount = 1 },
        getCombatSupportDeltaMaterial(tier, overrides)
    }
end

local function copyPrerequisites(values)
    local result = {}

    for _, value in ipairs(values) do
        table.insert(result, value)
    end

    return result
end

local function getCombatSupportPrerequisites(tier, basePrerequisites, overrides)
    local prerequisites = copyPrerequisites(basePrerequisites)
    local vanillaPrerequisites = overrides and overrides.vanillaPrerequisites
    local spaceAgePrerequisites = overrides and overrides.spaceAgePrerequisites or combatSupportSpaceAgePrerequisites
    local deltaPrerequisite

    if CostConfig.shouldUseSpaceAgeMaterials() and spaceAgePrerequisites[tier] then
        deltaPrerequisite = spaceAgePrerequisites[tier]
    elseif vanillaPrerequisites and vanillaPrerequisites[tier] then
        deltaPrerequisite = vanillaPrerequisites[tier]
    end

    if deltaPrerequisite then
        table.insert(prerequisites, deltaPrerequisite)
    end

    return prerequisites
end

-------------------------------------------------------------------------------
-- GRENADES T2-T10
-- Vanilla grenade: 35 damage, radius 6.5
-------------------------------------------------------------------------------

local grenadeBaseDamage = 35
local grenadeDamageIncrement = 35
local grenadeBaseRadius = 6.5
local grenadeRadiusIncrement = 0.5

for tier, config in pairs(tierConfig) do
    if not config.isVanilla then
        local name = "5d-grenade-" .. tier
        local projectileName = "5d-grenade-projectile-" .. tier
        local damage = grenadeBaseDamage + (tier - 1) * grenadeDamageIncrement
        local radius = grenadeBaseRadius + (tier - 1) * grenadeRadiusIncrement
        
        -- Create custom projectile with scaled damage
        local projectile = table.deepcopy(data.raw.projectile["grenade"])
        projectile.name = projectileName
        -- Update damage in projectile action
        for _, action in pairs(projectile.action) do
            if action.type == "area" then
                action.radius = radius
                if action.action_delivery and action.action_delivery.target_effects then
                    for _, effect in pairs(action.action_delivery.target_effects) do
                        if effect.type == "damage" then
                            effect.damage.amount = damage
                        end
                    end
                end
            end
        end
        
        -- Create capsule item
        local item = table.deepcopy(data.raw.capsule["grenade"])
        item.name = name
        item.subgroup = "equipment-grenade"
        item.order = config.order
        setTieredIcons(item, "__base__/graphics/icons/grenade.png", tier)
        -- Update to use custom projectile
        item.capsule_action.attack_parameters.ammo_type.action[1].action_delivery.projectile = projectileName
        
        -- Create recipe
        local recipe = {
            type = "recipe",
            name = name,
            enabled = false,
            energy_required = 8,
            ingredients = getCombatSupportIngredients(tier, "grenade", "5d-grenade-", grenadeRecipeOverrides),
            results = { { type = "item", name = name, amount = 1 } }
        }
        if getCombatSupportRecipeCategory(tier) then recipe.categories = { getCombatSupportRecipeCategory(tier) } end
        setTieredIcons(recipe, "__base__/graphics/icons/grenade.png", tier)
        
        -- Create technology
        local tech = {
            type = "technology",
            name = "5d-grenade-" .. tier,
            effects = {
                { type = "unlock-recipe", recipe = name }
            },
            prerequisites = getCombatSupportPrerequisites(tier, tier == 2 and { "military-2" } or { "5d-grenade-" .. (tier - 1) }, grenadeRecipeOverrides),
            unit = {
                count = 100 * tier,
                ingredients = CostCalculator.getTechPacks(getTechPacks(tier), tier, {
                    spaceAgePackOverrides = combatSupportSpaceAgeSciencePacks,
                    forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
                }),
                time = 30
            }
        }
        setTieredIcons(tech, "__base__/graphics/icons/grenade.png", tier)
        
        data:extend({ projectile, item, recipe, tech })
    end
end

-------------------------------------------------------------------------------
-- CLUSTER GRENADES T2-T10
-- Vanilla cluster grenade: Uses 7 sub-grenades, each does 35 damage = 245 total
-- Scale: x10 total damage via more grenades + stronger sub-grenades
-- T10: 25 grenades = ~875 base, but each grenade also scales with grenade tier
-------------------------------------------------------------------------------

local clusterSubGrenadeCount = 7
local clusterSubGrenadeIncrement = 4      -- 7 → 43 sub-grenades at T10

for tier, config in pairs(tierConfig) do
    if not config.isVanilla then
        local name = "5d-cluster-grenade-" .. tier
        local projectileName = "5d-cluster-grenade-projectile-" .. tier
        local subGrenades = clusterSubGrenadeCount + (tier - 1) * clusterSubGrenadeIncrement
        
        -- Create custom cluster projectile
        local projectile = table.deepcopy(data.raw.projectile["cluster-grenade"])
        projectile.name = projectileName
        -- Update number of sub-grenades
        for _, action in pairs(projectile.action) do
            if action.type == "cluster" then
                action.cluster_count = subGrenades
            end
        end
        
        -- Create capsule item
        local item = table.deepcopy(data.raw.capsule["cluster-grenade"])
        item.name = name
        item.subgroup = "equipment-cluster-grenade"
        item.order = config.order
        setTieredIcons(item, "__base__/graphics/icons/cluster-grenade.png", tier)
        -- Update to use custom projectile
        item.capsule_action.attack_parameters.ammo_type.action[1].action_delivery.projectile = projectileName
        
        -- Create recipe
        local recipe = {
            type = "recipe",
            name = name,
            enabled = false,
            energy_required = 8,
            ingredients = getCombatSupportIngredients(tier, "cluster-grenade", "5d-cluster-grenade-"),
            results = { { type = "item", name = name, amount = 1 } }
        }
        if getCombatSupportRecipeCategory(tier) then recipe.categories = { getCombatSupportRecipeCategory(tier) } end
        setTieredIcons(recipe, "__base__/graphics/icons/cluster-grenade.png", tier)
        
        -- Create technology
        local tech = {
            type = "technology",
            name = "5d-cluster-grenade-" .. tier,
            effects = {
                { type = "unlock-recipe", recipe = name }
            },
            prerequisites = getCombatSupportPrerequisites(tier, tier == 2 and { "military-3" } or { "5d-cluster-grenade-" .. (tier - 1) }),
            unit = {
                count = 150 * tier,
                ingredients = CostCalculator.getTechPacks(getTechPacks(tier), tier, {
                    spaceAgePackOverrides = combatSupportSpaceAgeSciencePacks,
                    forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
                }),
                time = 30
            }
        }
        setTieredIcons(tech, "__base__/graphics/icons/cluster-grenade.png", tier)
        
        data:extend({ projectile, item, recipe, tech })
    end
end

-------------------------------------------------------------------------------
-- POISON CAPSULES T2-T10
-- Vanilla: 8 damage/tick, 11 radius, 20s duration
-- Scale: x10 damage (8 → 80), moderate radius/duration increase
-------------------------------------------------------------------------------

local poisonBaseDamage = 8
local poisonDamageIncrement = 8          -- x10: 8 + 9*8 = 80
local poisonBaseRadius = 11
local poisonRadiusIncrement = 1          -- 11 → 20
local poisonBaseDuration = 20 * 60       -- in ticks
local poisonDurationIncrement = 5 * 60   -- 20s → 65s
local poisonBaseRange = 15
local poisonRangeIncrement = 2           -- 15 → 33

local sounds = require("__base__.prototypes.entity.sounds")

for tier, config in pairs(tierConfig) do
    if not config.isVanilla then
        local capsuleName = "5d-poison-capsule-" .. tier
        local projectileName = "5d-poison-capsule-projectile-" .. tier
        local cloudName = "5d-poison-cloud-" .. tier
        
        local damage = poisonBaseDamage + (tier - 1) * poisonDamageIncrement
        local radius = poisonBaseRadius + (tier - 1) * poisonRadiusIncrement
        local duration = poisonBaseDuration + (tier - 1) * poisonDurationIncrement
        local range = poisonBaseRange + (tier - 1) * poisonRangeIncrement
        
        -- 1. Create custom poison cloud with scaled stats
        local cloud = table.deepcopy(data.raw["smoke-with-trigger"]["poison-cloud"])
        cloud.name = cloudName
        cloud.duration = duration
        cloud.action.action_delivery.target_effects.action.radius = radius
        cloud.action.action_delivery.target_effects.action.action_delivery.target_effects.damage.amount = damage
        
        -- 2. Create custom projectile that spawns our cloud
        local projectile = table.deepcopy(data.raw.projectile["poison-capsule"])
        projectile.name = projectileName
        projectile.action[1].action_delivery.target_effects[1].entity_name = cloudName
        
        -- 3. Create capsule item
        local item = table.deepcopy(data.raw.capsule["poison-capsule"])
        item.name = capsuleName
        item.subgroup = "equipment-poison-capsule"
        item.order = config.order
        setTieredIcons(item, "__base__/graphics/icons/poison-capsule.png", tier)
        item.capsule_action.attack_parameters.range = range
        item.capsule_action.attack_parameters.ammo_type.action[1].action_delivery.projectile = projectileName
        
        -- Create recipe
        local recipe = {
            type = "recipe",
            name = capsuleName,
            enabled = false,
            energy_required = 8,
            ingredients = getCombatSupportIngredients(tier, "poison-capsule", "5d-poison-capsule-"),
            results = { { type = "item", name = capsuleName, amount = 1 } }
        }
        if getCombatSupportRecipeCategory(tier) then recipe.categories = { getCombatSupportRecipeCategory(tier) } end
        setTieredIcons(recipe, "__base__/graphics/icons/poison-capsule.png", tier)
        
        -- Create technology
        local tech = {
            type = "technology",
            name = "5d-poison-capsule-" .. tier,
            effects = {
                { type = "unlock-recipe", recipe = capsuleName }
            },
            prerequisites = getCombatSupportPrerequisites(tier, tier == 2 and { "military-3" } or { "5d-poison-capsule-" .. (tier - 1) }),
            unit = {
                count = 100 * tier,
                ingredients = CostCalculator.getTechPacks(getTechPacks(tier), tier, {
                    spaceAgePackOverrides = combatSupportSpaceAgeSciencePacks,
                    forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
                }),
                time = 30
            }
        }
        setTieredIcons(tech, "__base__/graphics/icons/poison-capsule.png", tier)
        
        data:extend({ cloud, projectile, item, recipe, tech })
    end
end

-------------------------------------------------------------------------------
-- SLOWDOWN CAPSULES T2-T10
-- Vanilla: radius 9, sticker lasts 30s, movement reduced to 25%
-- Scale: 50%→25% speed, larger radius and duration
-------------------------------------------------------------------------------

local slowdownBaseRadius = 9
local slowdownRadiusIncrement = 2        -- 9 → 27 (x3 radius)
local slowdownBaseDuration = 30 * 60     -- in ticks
local slowdownDurationIncrement = 10 * 60 -- 30s → 120s (x4 duration)
local slowdownBaseModifier = 0.50        -- 50% of normal speed (T1)
local slowdownModifierDecrement = 0.028  -- 50% → 25% at T10
local slowdownBaseRange = 15
local slowdownRangeIncrement = 3         -- 15 → 42

for tier, config in pairs(tierConfig) do
    if not config.isVanilla then
        local capsuleName = "5d-slowdown-capsule-" .. tier
        local projectileName = "5d-slowdown-capsule-projectile-" .. tier
        local stickerName = "5d-slowdown-sticker-" .. tier
        
        local radius = slowdownBaseRadius + (tier - 1) * slowdownRadiusIncrement
        local duration = slowdownBaseDuration + (tier - 1) * slowdownDurationIncrement
        local modifier = math.max(0.05, slowdownBaseModifier - (tier - 1) * slowdownModifierDecrement)
        local range = slowdownBaseRange + (tier - 1) * slowdownRangeIncrement
        
        -- 1. Create custom sticker with scaled duration and modifier
        local sticker = table.deepcopy(data.raw.sticker["slowdown-sticker"])
        sticker.name = stickerName
        sticker.duration_in_ticks = duration
        sticker.target_movement_modifier = modifier
        
        -- 2. Create custom projectile with scaled radius
        local projectile = table.deepcopy(data.raw.projectile["slowdown-capsule"])
        projectile.name = projectileName
        projectile.action[2].radius = radius
        projectile.action[2].action_delivery.target_effects[1].sticker = stickerName
        
        -- 3. Create capsule item
        local item = table.deepcopy(data.raw.capsule["slowdown-capsule"])
        item.name = capsuleName
        item.subgroup = "equipment-slowdown-capsule"
        item.order = config.order
        setTieredIcons(item, "__base__/graphics/icons/slowdown-capsule.png", tier)
        item.capsule_action.attack_parameters.range = range
        item.capsule_action.attack_parameters.ammo_type.action[1].action_delivery.projectile = projectileName
        
        -- Create recipe
        local recipe = {
            type = "recipe",
            name = capsuleName,
            enabled = false,
            energy_required = 8,
            ingredients = getCombatSupportIngredients(tier, "slowdown-capsule", "5d-slowdown-capsule-"),
            results = { { type = "item", name = capsuleName, amount = 1 } }
        }
        if getCombatSupportRecipeCategory(tier) then recipe.categories = { getCombatSupportRecipeCategory(tier) } end
        setTieredIcons(recipe, "__base__/graphics/icons/slowdown-capsule.png", tier)
        
        -- Create technology
        local tech = {
            type = "technology",
            name = "5d-slowdown-capsule-" .. tier,
            effects = {
                { type = "unlock-recipe", recipe = capsuleName }
            },
            prerequisites = getCombatSupportPrerequisites(tier, tier == 2 and { "military-3" } or { "5d-slowdown-capsule-" .. (tier - 1) }),
            unit = {
                count = 100 * tier,
                ingredients = CostCalculator.getTechPacks(getTechPacks(tier), tier, {
                    spaceAgePackOverrides = combatSupportSpaceAgeSciencePacks,
                    forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
                }),
                time = 30
            }
        }
        setTieredIcons(tech, "__base__/graphics/icons/slowdown-capsule.png", tier)
        
        data:extend({ sticker, projectile, item, recipe, tech })
    end
end
