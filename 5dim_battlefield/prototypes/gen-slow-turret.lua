-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Slow Turret Generation
-- Electric (laser-style) turret that fires a beam applying a slowdown sticker
-- to enemies instead of dealing damage. Reuses laser-turret graphics from base
-- with a cyan tint to indicate "slow" role. T1-T10 with tier-color base accent.
-------------------------------------------------------------------------------

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local RepairSpeedScaling = require("__5dim_core__.lib.repair-speed-scaling")
local tierColors = require("__5dim_core__.lib.tier-colors")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-- Slow effect scales with tier. Damage is intentionally tiny (1-3) so this
-- turret is a debuff/utility tool, not a damage dealer.
-------------------------------------------------------------------------------

local baseRange         = 22                       -- T1 range in tiles
local rangeIncrement    = 3                        -- +3 per tier (T10 = 49)
local baseHealth        = 1000
local healthIncrement   = 444                      -- 1000 -> 5000 (x5)
local baseTechCount     = 200
local typeColor         = { r = 0.2, g = 0.8, b = 1.0, a = 1 } -- cyan
local slowItemBaseIcon  = "__base__/graphics/icons/laser-turret.png"
local slowTechBaseIcon  = "__base__/graphics/technology/laser-turret.png"
local slowOverlayIcon   = "__base__/graphics/icons/slowdown-capsule.png"

local function makeSlowItemIcons(tier)
    return {
        { icon = slowItemBaseIcon, icon_size = 64, tint = tierColors[tier] },
        { icon = slowOverlayIcon, icon_size = 64, scale = 0.5, shift = { -8, -8 } }
    }
end

local function makeSlowTechIcons()
    return {
        { icon = slowTechBaseIcon, icon_size = 256, tint = typeColor },
        { icon = slowOverlayIcon, icon_size = 64, scale = 1.15, shift = { 72, 72 } }
    }
end

-- Slow effect curve per tier
-- T1: 30% movement speed, 1.5s   ->   T10: 80% reduction, 4s
local function getSlowParams(tier)
    local reduction = 0.30 + (tier - 1) * (0.50 / 9)        -- 0.30 .. 0.80
    local seconds   = 1.5 + (tier - 1) * (2.5 / 9)          -- 1.5 .. 4.0
    return {
        movementModifierFrom = 1.0 - reduction,             -- 0.70 .. 0.20
        durationTicks        = math.floor(seconds * 60)
    }
end

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
        techName = "5d-slow-turret-1",
        countMultiplier = 1,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "laser-turret" }
    },
    [2] = {
        techName = "5d-slow-turret-2",
        countMultiplier = 2,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-slow-turret-1" }
    },
    [3] = {
        techName = "5d-slow-turret-3",
        countMultiplier = 3,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-slow-turret-2" }
    },
    [4] = {
        techName = "5d-slow-turret-4",
        countMultiplier = 4,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 }
        },
        prerequisites = { "5d-slow-turret-3" }
    },
    [5] = {
        techName = "5d-slow-turret-5",
        countMultiplier = 5,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-slow-turret-4", "utility-science-pack" }
    },
    [6] = {
        techName = "5d-slow-turret-6",
        countMultiplier = 6,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-slow-turret-5" }
    },
    [7] = {
        techName = "5d-slow-turret-7",
        countMultiplier = 7,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-slow-turret-6" }
    },
    [8] = {
        techName = "5d-slow-turret-8",
        countMultiplier = 8,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-slow-turret-7" }
    },
    [9] = {
        techName = "5d-slow-turret-9",
        countMultiplier = 9,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-slow-turret-8" }
    },
    [10] = {
        techName = "5d-slow-turret-10",
        countMultiplier = 10,
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "5d-slow-turret-9" }
    }
}

-------------------------------------------------------------------------------
-- RESISTANCES BY TIER (matches laser-turret pattern)
-------------------------------------------------------------------------------

local function getResistances(tier)
    return {
        { type = "fire",      percent = 5  + (tier - 1) * 5 },
        { type = "explosion", percent = 2.5 + (tier - 1) * 2.5 }
    }
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config  = tierConfig[tier]
    local tierNum = string.format("%02d", tier)
    local entityName = "5d-slow-turret-" .. tierNum
    local stickerName = "5d-slow-sticker-" .. tierNum
    local beamName    = "5d-slow-beam-"    .. tierNum
    local slow = getSlowParams(tier)

    ---------------------------------------------------------------------------
    -- Sticker: applies movement slowdown to target unit
    ---------------------------------------------------------------------------
    local sticker = {
        type  = "sticker",
        name  = stickerName,
        flags = { "not-on-map" },
        hidden = true,
        animation = {
            filename     = "__base__/graphics/entity/acid-sticker/acid-sticker.png",
            draw_as_glow = true,
            line_length  = 5,
            width        = 30,
            height       = 34,
            frame_count  = 50,
            animation_speed = 0.5,
            tint         = typeColor,
            shift        = { 0, 0 },
            scale        = 0.5
        },
        duration_in_ticks              = slow.durationTicks,
        target_movement_modifier_from  = slow.movementModifierFrom,
        target_movement_modifier_to    = 1,
        vehicle_speed_modifier_from    = slow.movementModifierFrom,
        vehicle_speed_modifier_to      = 1,
        vehicle_friction_modifier_from = slow.movementModifierFrom,
        vehicle_friction_modifier_to   = 1
    }

    ---------------------------------------------------------------------------
    -- Beam: cyan-tinted laser beam that creates the sticker on hit
    -- (deepcopy of vanilla laser-beam, retint, replace damage with sticker)
    ---------------------------------------------------------------------------
    local beam = table.deepcopy(data.raw["beam"]["laser-beam"])
    beam.name = beamName
    beam.action = {
        type = "direct",
        action_delivery = {
            type = "instant",
            target_effects = {
                { type = "create-sticker", sticker = stickerName },
                -- Tiny chip damage so the turret can still finish off weakened biters
                { type = "damage",         damage  = { amount = 1 + tier, type = "laser" } }
            }
        }
    }
    -- Recolor beam graphics with type tint
    if beam.graphics_set and beam.graphics_set.beam then
        local function tintLayers(part)
            if part and part.layers then
                for _, layer in ipairs(part.layers) do
                    layer.tint = typeColor
                end
            end
        end
        tintLayers(beam.graphics_set.beam.head)
        tintLayers(beam.graphics_set.beam.tail)
        if beam.graphics_set.beam.body then
            for _, body in ipairs(beam.graphics_set.beam.body) do
                tintLayers(body)
            end
        end
    end

    ---------------------------------------------------------------------------
    -- Item / Recipe / Entity: deepcopy of base laser-turret + retint + rewire
    ---------------------------------------------------------------------------
    local item   = table.deepcopy(data.raw.item["laser-turret"])
    local recipe = table.deepcopy(data.raw.recipe["laser-turret"])
    local entity = table.deepcopy(data.raw["electric-turret"]["laser-turret"])

    item.name        = entityName
    item.subgroup    = "defense-slow-turret"
    item.order       = config.order
    item.place_result = entityName
    item.icon        = nil
    item.icon_size   = nil
    item.icons       = makeSlowItemIcons(tier)

    recipe.name        = entityName
    recipe.enabled     = false
    recipe.results     = { { type = "item", name = entityName, amount = 1 } }
    recipe.ingredients = RecipeTemplates.slowTurret[tier]
    recipe.icon        = nil
    recipe.icon_size   = nil
    recipe.icons       = makeSlowItemIcons(tier)

    entity.name         = entityName
    entity.next_upgrade = (tier < 10) and ("5d-slow-turret-" .. string.format("%02d", tier + 1)) or nil
    entity.minable.result = entityName
    entity.max_health   = baseHealth + (tier - 1) * healthIncrement
    entity.repair_speed_modifier = RepairSpeedScaling.linear(baseHealth, entity.max_health)
    entity.fast_replaceable_group = "5d-slow-turret"
    entity.resistances  = getResistances(tier)

    -- Wire range, beam reference, energy
    if entity.attack_parameters then
        entity.attack_parameters.range = baseRange + (tier - 1) * rangeIncrement
        entity.attack_parameters.damage_modifier = nil  -- damage handled by beam target_effects
        if entity.attack_parameters.ammo_type then
            entity.attack_parameters.ammo_type.energy_consumption = "400kJ"
            local delivery = entity.attack_parameters.ammo_type.action
                             and entity.attack_parameters.ammo_type.action.action_delivery
            if delivery then
                delivery.beam       = beamName
                delivery.max_length = (baseRange + (tier - 1) * rangeIncrement) + 1
            end
        end
    end

    -- Cyan tint for turret head, tier color for base ring
    if entity.folded_animation and entity.folded_animation.layers and entity.folded_animation.layers[2] then
        entity.folded_animation.layers[2].tint = typeColor
    end
    if entity.preparing_animation and entity.preparing_animation.layers and entity.preparing_animation.layers[2] then
        entity.preparing_animation.layers[2].tint = typeColor
    end
    if entity.prepared_animation and entity.prepared_animation.layers and entity.prepared_animation.layers[2] then
        entity.prepared_animation.layers[2].tint = typeColor
    end
    if entity.folding_animation and entity.folding_animation.layers and entity.folding_animation.layers[2] then
        entity.folding_animation.layers[2].tint = typeColor
    end
    if entity.graphics_set and entity.graphics_set.base_visualisation
       and entity.graphics_set.base_visualisation.animation
       and entity.graphics_set.base_visualisation.animation.layers
       and entity.graphics_set.base_visualisation.animation.layers[1] then
        entity.graphics_set.base_visualisation.animation.layers[1].tint = tierColors[tier]
    end

    data:extend({ sticker, beam, entity, recipe, item })

    ---------------------------------------------------------------------------
    -- Technology
    ---------------------------------------------------------------------------
    local tc = techConfig[tier]
    if tc then
        local tech = table.deepcopy(data.raw.technology["laser-turret"])
        tech.name          = tc.techName
        tech.unit.count    = baseTechCount * tc.countMultiplier
        tech.unit.ingredients = CostCalculator.getTechPacks(tc.basePacks, tier)
        tech.prerequisites = tc.prerequisites
        tech.icon = nil
        tech.icon_size = nil
        tech.icons = makeSlowTechIcons()
        tech.effects = {
            { type = "unlock-recipe", recipe = entityName }
        }
        data:extend({ tech })
    end
end
