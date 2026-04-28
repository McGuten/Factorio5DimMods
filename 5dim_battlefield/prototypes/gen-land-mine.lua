-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Land Mine Generation
-- Creates tiered land mines
-- Subgroup defined in 5dim_core: defense-land-mine
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")

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
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 }
        }
    end
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
        
        local name = "5d-land-mine-" .. tier
        
        -- Copy entity and modify damage structure
        local entity = table.deepcopy(data.raw["land-mine"]["land-mine"])
        entity.name = name
        entity.minable.result = name
        entity.trigger_radius = triggerRadius
        
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
        item.icons = {
            { icon = "__base__/graphics/icons/land-mine.png", icon_size = 64 },
            { icon = "__base__/graphics/icons/explosion.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
        }
        
        -- Create recipe
        local recipe = {
            type = "recipe",
            name = name,
            enabled = false,
            energy_required = 5,
            ingredients = tier == 2 and {
                { type = "item", name = "land-mine", amount = 1 },
                { type = "item", name = "steel-plate", amount = 1 },
                { type = "item", name = "explosives", amount = 2 }
            } or {
                { type = "item", name = "5d-land-mine-" .. (tier - 1), amount = 1 },
                { type = "item", name = "steel-plate", amount = 1 },
                { type = "item", name = "explosives", amount = 2 }
            },
            results = { { type = "item", name = name, amount = 1 } }
        }
        
        -- Create technology
        local tech = {
            type = "technology",
            name = "5d-land-mine-" .. tier,
            icons = {
                { icon = "__base__/graphics/icons/land-mine.png", icon_size = 64 },
                { icon = "__base__/graphics/icons/explosion.png", icon_size = 64, scale = 0.3, shift = {-10, -10} }
            },
            effects = {
                { type = "unlock-recipe", recipe = name }
            },
            prerequisites = tier == 2 and { "land-mine" } or { "5d-land-mine-" .. (tier - 1) },
            unit = {
                count = baseTechCount * tier,
                ingredients = getTechPacks(tier),
                time = 30
            }
        }
        
        data:extend({ entity, item, recipe, tech })
    end
end
