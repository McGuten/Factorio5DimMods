-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Land Mine Generation
-- Creates tiered land mines
-- Subgroup defined in 5dim_core: defense-land-mine
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")
local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION (Vanilla: 250 area damage, 1000 direct damage = 1250 total)
-- Scale: x10 damage (1250 → 12500 at T10)
-------------------------------------------------------------------------------

local baseAreaDamage = 250
local areaIncrement = 250                 -- 250 → 2500 (x10)
local baseDirectDamage = 1000
local directIncrement = 1000              -- 1000 → 10000 (x10)
local baseTriggerRadius = 2.5
local triggerRadiusIncrement = 0.25
local baseAreaRadius = 6
local areaRadiusIncrement = 0.5           -- 6 → 10.5 (moderate)
local baseTechCount = 100

local vanillaMineIcons = {
    { icon = "__base__/graphics/icons/land-mine.png", icon_size = 64 },
    { icon = "__base__/graphics/icons/explosion.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
}

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

data.raw.item["land-mine"].icon = nil
data.raw.item["land-mine"].icon_size = nil
data.raw.item["land-mine"].icons = TierBadgeIcons.buildTieredIconsFromIcons(vanillaMineIcons, 1)

data.raw["land-mine"]["land-mine"].is_military_target = false
data.raw["land-mine"]["land-mine"].icon = nil
data.raw["land-mine"]["land-mine"].icon_size = nil
data.raw["land-mine"]["land-mine"].icons = TierBadgeIcons.buildTieredIconsFromIcons(vanillaMineIcons, 1)

data.raw.recipe["land-mine"].icon = nil
data.raw.recipe["land-mine"].icon_size = nil
data.raw.recipe["land-mine"].icons = TierBadgeIcons.buildTieredIconsFromIcons(vanillaMineIcons, 1)

data.raw.technology["land-mine"].icon = nil
data.raw.technology["land-mine"].icon_size = nil
data.raw.technology["land-mine"].icons = TierBadgeIcons.buildTieredIconsFromIcons(vanillaMineIcons, 1)

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-------------------------------------------------------------------------------

local function getTechPacks(tier)
    if tier <= 3 then
        return {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 }
        }
    elseif tier <= 5 then
        return {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 }
        }
    elseif tier <= 7 then
        return {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 }
        }
    elseif tier <= 9 then
        return {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        }
    else
        return {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "military-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 }
        }
    end
end

local landMineMaterials = {
    [2] = { type = "item", name = "steel-plate", amount = 1 },
    [3] = { type = "item", name = "pipe-to-ground", amount = 1 },
    [4] = { type = "item", name = "sulfur", amount = 2 },
    [5] = { type = "item", name = "plastic-bar", amount = 2 },
    [6] = { type = "fluid", name = "sulfuric-acid", amount = 30 },
    [7] = { type = "item", name = "explosives", amount = 3 },
    [8] = { type = "item", name = "battery", amount = 2 },
    [9] = { type = "item", name = "processing-unit", amount = 1 },
    [10] = { type = "item", name = "low-density-structure", amount = 1 }
}

local landMineSpaceAgeMaterials = {
    [6] = { name = "calcite", amount = 6, category = "metallurgy" },
    [7] = { name = "carbon-fiber", amount = 4, category = "organic" },
    [8] = { type = "fluid", name = "holmium-solution", amount = 60, category = "chemistry" },
    [9] = { name = "supercapacitor", amount = 2, category = "electromagnetics" },
    [10] = { type = "fluid", name = "fluoroketone-cold", amount = 60, category = "cryogenics" }
}

local landMineSpaceAgeSciencePacks = {
    [6] = { "space-science-pack", "metallurgic-science-pack" },
    [7] = { "space-science-pack", "agricultural-science-pack" },
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local landMineSpaceAgePrerequisites = {
    [6] = "foundry",
    [7] = "carbon-fiber",
    [8] = "holmium-processing",
    [9] = "electromagnetic-plant",
    [10] = "fusion-reactor"
}

local function getLandMineDeltaMaterial(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and landMineSpaceAgeMaterials[tier] then
        local override = landMineSpaceAgeMaterials[tier]
        return {
            type = override.type or "item",
            name = override.name,
            amount = override.amount
        }
    end

    return landMineMaterials[tier]
end

local function getLandMineRecipeCategory(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and landMineSpaceAgeMaterials[tier] then
        return landMineSpaceAgeMaterials[tier].category
    end

    local material = landMineMaterials[tier]
    if material and material.type == "fluid" then
        return "crafting-with-fluid"
    end
end

local function getLandMineIngredients(tier)
    return {
        { type = "item", name = tier == 2 and "land-mine" or ("5d-land-mine-" .. (tier - 1)), amount = 1 },
        getLandMineDeltaMaterial(tier)
    }
end

local function copyPrerequisites(values)
    local result = {}

    for _, value in ipairs(values) do
        table.insert(result, value)
    end

    return result
end

local function getLandMinePrerequisites(tier, basePrerequisites)
    local prerequisites = copyPrerequisites(basePrerequisites)

    if CostConfig.shouldUseSpaceAgeMaterials() and landMineSpaceAgePrerequisites[tier] then
        table.insert(prerequisites, landMineSpaceAgePrerequisites[tier])
    end

    return prerequisites
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier, config in pairs(tierConfig) do
    if not config.isVanilla then
        local areaDamage = baseAreaDamage + (tier - 1) * areaIncrement
        local directDamage = baseDirectDamage + (tier - 1) * directIncrement
        local triggerRadius = baseTriggerRadius + (tier - 1) * triggerRadiusIncrement
        local areaRadius = baseAreaRadius + (tier - 1) * areaRadiusIncrement
        local tieredIcons = TierBadgeIcons.buildTieredIconsFromIcons(vanillaMineIcons, tier)
        
        local name = "5d-land-mine-" .. tier
        
        -- Copy entity and modify damage structure
        local entity = table.deepcopy(data.raw["land-mine"]["land-mine"])
        entity.name = name
        entity.minable.result = name
        entity.trigger_radius = triggerRadius
        entity.is_military_target = false
        entity.icon = nil
        entity.icon_size = nil
        entity.icons = table.deepcopy(tieredIcons)
        
        -- Update damage values in the complex action structure
        -- Structure: action.action_delivery.source_effects
        -- [1] = nested-result with area damage
        -- [3] = direct damage
        if entity.action and entity.action.action_delivery and entity.action.action_delivery.source_effects then
            for i, effect in ipairs(entity.action.action_delivery.source_effects) do
                if effect.type == "nested-result" and effect.action and effect.action.type == "area" then
                    -- Update area radius
                    effect.action.radius = areaRadius
                    -- Update area damage
                    if effect.action.action_delivery and effect.action.action_delivery.target_effects then
                        for _, targetEffect in pairs(effect.action.action_delivery.target_effects) do
                            if targetEffect.type == "damage" then
                                targetEffect.damage.amount = areaDamage
                            end
                        end
                    end
                elseif effect.type == "damage" then
                    -- Update direct damage
                    effect.damage.amount = directDamage
                end
            end
        end
        
        -- Create item
        local item = table.deepcopy(data.raw.item["land-mine"])
        item.name = name
        item.subgroup = "defense-land-mine"
        item.order = config.order
        item.place_result = name
        item.icon = nil
        item.icon_size = nil
        item.icons = table.deepcopy(tieredIcons)
        
        -- Create recipe
        local recipe = {
            type = "recipe",
            name = name,
            enabled = false,
            energy_required = 5,
            ingredients = getLandMineIngredients(tier),
            results = { { type = "item", name = name, amount = 1 } }
        }
        recipe.category = getLandMineRecipeCategory(tier)
        recipe.icon = nil
        recipe.icon_size = nil
        recipe.icons = table.deepcopy(tieredIcons)
        
        -- Create technology
        local tech = {
            type = "technology",
            name = "5d-land-mine-" .. tier,
            icons = table.deepcopy(tieredIcons),
            effects = {
                { type = "unlock-recipe", recipe = name }
            },
            unit = {
                count = baseTechCount * tier,
                ingredients = CostCalculator.getTechPacks(getTechPacks(tier), tier, {
                    spaceAgePackOverrides = landMineSpaceAgeSciencePacks,
                    forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
                }),
                time = 30
            },
            prerequisites = getLandMinePrerequisites(tier, tier == 2 and { "land-mine" } or { "5d-land-mine-" .. (tier - 1) })
        }
        
        data:extend({ entity, item, recipe, tech })
    end
end
