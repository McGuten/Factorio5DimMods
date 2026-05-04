-------------------------------------------------------------------------------
-- 5Dim's Battlefield - Combat Robot Capsules Generation
-- Creates tiered combat robot capsules (Defender, Distractor, Destroyer)
-- Each tier needs: robot entity + projectile + capsule item
-- Subgroups defined in 5dim_core
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")
local sounds = require("__base__.prototypes.entity.sounds")
local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

local function setTieredIcons(prototype, baseIcon, tier)
    prototype.icon = nil
    prototype.icon_size = nil
    prototype.icon_mipmaps = nil
    prototype.icons = TierBadgeIcons.buildTieredIcons(baseIcon, tier, 64)
end

setTieredIcons(data.raw.capsule["defender-capsule"], "__base__/graphics/icons/defender-capsule.png", 1)
setTieredIcons(data.raw.recipe["defender-capsule"], "__base__/graphics/icons/defender-capsule.png", 1)
setTieredIcons(data.raw.technology["defender"], "__base__/graphics/icons/defender.png", 1)

setTieredIcons(data.raw.capsule["distractor-capsule"], "__base__/graphics/icons/distractor-capsule.png", 1)
setTieredIcons(data.raw.recipe["distractor-capsule"], "__base__/graphics/icons/distractor-capsule.png", 1)
setTieredIcons(data.raw.technology["distractor"], "__base__/graphics/icons/distractor.png", 1)

setTieredIcons(data.raw.capsule["destroyer-capsule"], "__base__/graphics/icons/destroyer-capsule.png", 1)
setTieredIcons(data.raw.recipe["destroyer-capsule"], "__base__/graphics/icons/destroyer-capsule.png", 1)
setTieredIcons(data.raw.technology["destroyer"], "__base__/graphics/icons/destroyer.png", 1)

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
-- CAPSULE SMOKE (shared)
-------------------------------------------------------------------------------

local capsule_smoke = {
    {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 0},
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed_deviation = 5
    }
}

-------------------------------------------------------------------------------
-- DEFENDER T2-T10
-- Vanilla: 60 HP, 8 damage (bullet), 15 range, 45s life
-- Scale: x10 damage (8 → 80), x7 HP
-------------------------------------------------------------------------------

local defenderBaseHealth = 60
local defenderHealthIncrement = 40        -- 60 → 420 (x7)
local defenderBaseDamage = 8
local defenderDamageIncrement = 8         -- 8 → 80 (x10)
local defenderBaseRange = 15
local defenderRangeIncrement = 2
local defenderBaseLife = 45 * 60
local defenderLifeIncrement = 15 * 60

for tier, config in pairs(tierConfig) do
    if not config.isVanilla then
        local capsuleName = "5d-defender-capsule-" .. tier
        local robotName = "5d-defender-" .. tier
        local projectileName = "5d-defender-capsule-projectile-" .. tier
        
        local health = defenderBaseHealth + (tier - 1) * defenderHealthIncrement
        local damage = defenderBaseDamage + (tier - 1) * defenderDamageIncrement
        local range = defenderBaseRange + (tier - 1) * defenderRangeIncrement
        local lifeTime = defenderBaseLife + (tier - 1) * defenderLifeIncrement
        
        local robot = table.deepcopy(data.raw["combat-robot"]["defender"])
        robot.name = robotName
        robot.max_health = health
        robot.time_to_live = lifeTime
        robot.attack_parameters.range = range
        robot.attack_parameters.ammo_type = {
            type = "projectile",
            category = "bullet",
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    source_effects = {
                        type = "create-explosion",
                        entity_name = "explosion-gunshot-small"
                    },
                    target_effects = {
                        {
                            type = "create-entity",
                            entity_name = "explosion-hit"
                        },
                        {
                            type = "damage",
                            damage = { amount = damage, type = "physical" }
                        }
                    }
                }
            }
        }
        
        local projectile = {
            type = "projectile",
            name = projectileName,
            flags = { "not-on-map" },
            hidden = true,
            acceleration = 0.005,
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = robotName
                    }
                }
            },
            enable_drawing_with_mask = true,
            animation = {
                layers = {
                    {
                        filename = "__base__/graphics/entity/combat-robot-capsule/defender-capsule.png",
                        flags = { "no-crop" },
                        width = 28,
                        height = 20,
                        priority = "high"
                    },
                    {
                        filename = "__base__/graphics/entity/combat-robot-capsule/defender-capsule-mask.png",
                        flags = { "no-crop" },
                        width = 28,
                        height = 20,
                        priority = "high",
                        apply_runtime_tint = true
                    }
                }
            },
            shadow = {
                filename = "__base__/graphics/entity/combat-robot-capsule/defender-capsule-shadow.png",
                flags = { "no-crop" },
                width = 26,
                height = 20,
                priority = "high"
            },
            smoke = capsule_smoke
        }
        
        local capsule = {
            type = "capsule",
            name = capsuleName,
            icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/defender-capsule.png", tier, 64),
            subgroup = "equipment-defender",
            order = config.order .. "[" .. capsuleName .. "]",
            capsule_action = {
                type = "throw",
                attack_parameters = {
                    type = "projectile",
                    activation_type = "throw",
                    ammo_category = "capsule",
                    cooldown = 30,
                    projectile_creation_distance = 0.6,
                    range = 25,
                    ammo_type = {
                        target_type = "position",
                        action = {
                            {
                                type = "direct",
                                action_delivery = {
                                    type = "projectile",
                                    projectile = projectileName,
                                    starting_speed = 0.3
                                }
                            },
                            {
                                type = "direct",
                                action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                        {
                                            type = "play-sound",
                                            sound = sounds.throw_projectile
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            },
            pick_sound = { filename = "__base__/sound/item/robotic-inventory-pickup.ogg", volume = 0.6 },
            drop_sound = { filename = "__base__/sound/item/robotic-inventory-move.ogg", volume = 0.6 },
            stack_size = 100
        }
        
        local recipe = {
            type = "recipe",
            name = capsuleName,
            enabled = false,
            energy_required = 8,
            ingredients = tier == 2 and {
                { type = "item", name = "defender-capsule", amount = 2 },
                { type = "item", name = "electronic-circuit", amount = 5 }
            } or {
                { type = "item", name = "5d-defender-capsule-" .. (tier - 1), amount = 1 },
                { type = "item", name = "electronic-circuit", amount = 5 },
                { type = "item", name = "iron-plate", amount = 5 }
            },
            results = { { type = "item", name = capsuleName, amount = 1 } },
            icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/defender-capsule.png", tier, 64)
        }
        
        local tech = {
            type = "technology",
            name = "5d-defender-" .. tier,
            icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/defender.png", tier, 64),
            effects = {
                { type = "unlock-recipe", recipe = capsuleName }
            },
            prerequisites = tier == 2 and { "defender" } or { "5d-defender-" .. (tier - 1) },
            unit = {
                count = 100 * tier,
                ingredients = getTechPacks(tier),
                time = 30
            }
        }
        
        data:extend({ robot, projectile, capsule, recipe, tech })
    end
end

-------------------------------------------------------------------------------
-- DISTRACTOR T2-T10
-- Vanilla: 90 HP, 12 damage (electric), 3 robots per capsule, 25s life
-- Scale: x10 damage (12 → 120), x6 HP
-------------------------------------------------------------------------------

local distractorBaseHealth = 90
local distractorHealthIncrement = 50      -- 90 → 540 (x6)
local distractorBaseDamage = 12
local distractorDamageIncrement = 12      -- 12 → 120 (x10)
local distractorBaseRange = 12
local distractorRangeIncrement = 2
local distractorBaseLife = 25 * 60
local distractorLifeIncrement = 10 * 60

for tier, config in pairs(tierConfig) do
    if not config.isVanilla then
        local capsuleName = "5d-distractor-capsule-" .. tier
        local robotName = "5d-distractor-" .. tier
        local projectileName = "5d-distractor-capsule-projectile-" .. tier
        
        local health = distractorBaseHealth + (tier - 1) * distractorHealthIncrement
        local damage = distractorBaseDamage + (tier - 1) * distractorDamageIncrement
        local range = distractorBaseRange + (tier - 1) * distractorRangeIncrement
        local lifeTime = distractorBaseLife + (tier - 1) * distractorLifeIncrement
        
        local robot = table.deepcopy(data.raw["combat-robot"]["distractor"])
        robot.name = robotName
        robot.max_health = health
        robot.time_to_live = lifeTime
        robot.attack_parameters.range = range
        robot.attack_parameters.ammo_type = {
            type = "beam",
            category = "electric",
            action = {
                type = "direct",
                action_delivery = {
                    type = "beam",
                    beam = "electric-beam",
                    max_length = range,
                    duration = 20,
                    source_offset = { 0.15, -0.5 }
                }
            }
        }
        robot.speed = 0.01 + (tier - 1) * 0.002
        
        local projectile = {
            type = "projectile",
            name = projectileName,
            flags = { "not-on-map" },
            hidden = true,
            acceleration = 0.005,
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = robotName,
                        offsets = { { -0.5, -0.5 }, { -0.5, 0.5 }, { 0.5, 0 } }
                    }
                }
            },
            enable_drawing_with_mask = true,
            animation = {
                layers = {
                    {
                        filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule.png",
                        flags = { "no-crop" },
                        width = 36,
                        height = 30,
                        priority = "high"
                    },
                    {
                        filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule-mask.png",
                        flags = { "no-crop" },
                        width = 36,
                        height = 30,
                        priority = "high",
                        apply_runtime_tint = true
                    }
                }
            },
            shadow = {
                filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule-shadow.png",
                flags = { "no-crop" },
                width = 40,
                height = 26,
                priority = "high"
            },
            smoke = capsule_smoke
        }
        
        local capsule = {
            type = "capsule",
            name = capsuleName,
            icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/distractor-capsule.png", tier, 64),
            subgroup = "equipment-distractor",
            order = config.order .. "[" .. capsuleName .. "]",
            capsule_action = {
                type = "throw",
                attack_parameters = {
                    type = "projectile",
                    activation_type = "throw",
                    ammo_category = "capsule",
                    cooldown = 30,
                    projectile_creation_distance = 0.6,
                    range = 25,
                    ammo_type = {
                        target_type = "position",
                        action = {
                            {
                                type = "direct",
                                action_delivery = {
                                    type = "projectile",
                                    projectile = projectileName,
                                    starting_speed = 0.3
                                }
                            },
                            {
                                type = "direct",
                                action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                        {
                                            type = "play-sound",
                                            sound = sounds.throw_projectile
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            },
            pick_sound = { filename = "__base__/sound/item/robotic-inventory-pickup.ogg", volume = 0.6 },
            drop_sound = { filename = "__base__/sound/item/robotic-inventory-move.ogg", volume = 0.6 },
            stack_size = 100
        }
        
        local recipe = {
            type = "recipe",
            name = capsuleName,
            enabled = false,
            energy_required = 15,
            ingredients = tier == 2 and {
                { type = "item", name = "distractor-capsule", amount = 2 },
                { type = "item", name = "advanced-circuit", amount = 3 }
            } or {
                { type = "item", name = "5d-distractor-capsule-" .. (tier - 1), amount = 1 },
                { type = "item", name = "advanced-circuit", amount = 3 },
                { type = "item", name = "steel-plate", amount = 5 }
            },
            results = { { type = "item", name = capsuleName, amount = 1 } },
            icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/distractor-capsule.png", tier, 64)
        }
        
        local tech = {
            type = "technology",
            name = "5d-distractor-" .. tier,
            icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/distractor.png", tier, 64),
            effects = {
                { type = "unlock-recipe", recipe = capsuleName }
            },
            prerequisites = tier == 2 and { "distractor" } or { "5d-distractor-" .. (tier - 1) },
            unit = {
                count = 150 * tier,
                ingredients = getTechPacks(tier),
                time = 30
            }
        }
        
        data:extend({ robot, projectile, capsule, recipe, tech })
    end
end

-------------------------------------------------------------------------------
-- DESTROYER T2-T10  
-- Vanilla: 60 HP, 20+32=52 electric damage, 20 range, 120s life, 5 robots
-- Scale: x10 damage (52 → 520), x7 HP
-------------------------------------------------------------------------------

local destroyerBaseHealth = 60
local destroyerHealthIncrement = 40       -- 60 → 420 (x7)
local destroyerBaseDamage = 20
local destroyerBonusDamage = 32
local destroyerDamageIncrement = 5.2      -- Total: 52 → 520 (x10)
local destroyerBaseRange = 20
local destroyerRangeIncrement = 2
local destroyerBaseLife = 120 * 60
local destroyerLifeIncrement = 30 * 60

for tier, config in pairs(tierConfig) do
    if not config.isVanilla then
        local capsuleName = "5d-destroyer-capsule-" .. tier
        local robotName = "5d-destroyer-" .. tier
        local projectileName = "5d-destroyer-capsule-projectile-" .. tier
        
        local health = destroyerBaseHealth + (tier - 1) * destroyerHealthIncrement
        local baseDmg = destroyerBaseDamage + (tier - 1) * destroyerDamageIncrement
        local bonusDmg = destroyerBonusDamage + (tier - 1) * destroyerDamageIncrement
        local range = destroyerBaseRange + (tier - 1) * destroyerRangeIncrement
        local lifeTime = destroyerBaseLife + (tier - 1) * destroyerLifeIncrement
        local speed = 0.01 + (tier - 1) * 0.002
        
        local robot = table.deepcopy(data.raw["combat-robot"]["destroyer"])
        robot.name = robotName
        robot.max_health = health
        robot.time_to_live = lifeTime
        robot.attack_parameters.range = range
        robot.speed = speed
        robot.attack_parameters.ammo_type = {
            type = "projectile",
            category = "laser",
            energy_consumption = "200kJ",
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    source_effects = {
                        type = "create-entity",
                        entity_name = "laser-bubble"
                    },
                    target_effects = {
                        {
                            type = "create-entity",
                            entity_name = "laser-bubble"
                        },
                        {
                            type = "damage",
                            damage = { amount = baseDmg, type = "physical" }
                        },
                        {
                            type = "damage",
                            damage = { amount = bonusDmg, type = "electric" }
                        }
                    }
                }
            }
        }
        
        local projectile = {
            type = "projectile",
            name = projectileName,
            flags = { "not-on-map" },
            hidden = true,
            acceleration = 0.005,
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = robotName,
                        offsets = { { -0.7, -0.7 }, { -0.7, 0.7 }, { 0.7, -0.7 }, { 0.7, 0.7 }, { 0, 0 } }
                    }
                }
            },
            enable_drawing_with_mask = true,
            animation = {
                layers = {
                    {
                        filename = "__base__/graphics/entity/combat-robot-capsule/destroyer-capsule.png",
                        flags = { "no-crop" },
                        width = 42,
                        height = 34,
                        priority = "high"
                    },
                    {
                        filename = "__base__/graphics/entity/combat-robot-capsule/destroyer-capsule-mask.png",
                        flags = { "no-crop" },
                        width = 42,
                        height = 34,
                        priority = "high",
                        apply_runtime_tint = true
                    }
                }
            },
            shadow = {
                filename = "__base__/graphics/entity/combat-robot-capsule/destroyer-capsule-shadow.png",
                flags = { "no-crop" },
                width = 48,
                height = 32,
                priority = "high"
            },
            smoke = capsule_smoke
        }
        
        local capsule = {
            type = "capsule",
            name = capsuleName,
            icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/destroyer-capsule.png", tier, 64),
            subgroup = "equipment-destroyer",
            order = config.order .. "[" .. capsuleName .. "]",
            capsule_action = {
                type = "throw",
                attack_parameters = {
                    type = "projectile",
                    activation_type = "throw",
                    ammo_category = "capsule",
                    cooldown = 30,
                    projectile_creation_distance = 0.6,
                    range = 25,
                    ammo_type = {
                        target_type = "position",
                        action = {
                            {
                                type = "direct",
                                action_delivery = {
                                    type = "projectile",
                                    projectile = projectileName,
                                    starting_speed = 0.3
                                }
                            },
                            {
                                type = "direct",
                                action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                        {
                                            type = "play-sound",
                                            sound = sounds.throw_projectile
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            },
            pick_sound = { filename = "__base__/sound/item/robotic-inventory-pickup.ogg", volume = 0.6 },
            drop_sound = { filename = "__base__/sound/item/robotic-inventory-move.ogg", volume = 0.6 },
            stack_size = 100
        }
        
        local recipe = {
            type = "recipe",
            name = capsuleName,
            enabled = false,
            energy_required = 15,
            ingredients = tier == 2 and {
                { type = "item", name = "destroyer-capsule", amount = 2 },
                { type = "item", name = "processing-unit", amount = 2 }
            } or {
                { type = "item", name = "5d-destroyer-capsule-" .. (tier - 1), amount = 1 },
                { type = "item", name = "processing-unit", amount = 2 },
                { type = "item", name = "low-density-structure", amount = 2 }
            },
            results = { { type = "item", name = capsuleName, amount = 1 } },
            icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/destroyer-capsule.png", tier, 64)
        }
        
        local tech = {
            type = "technology",
            name = "5d-destroyer-" .. tier,
            icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/destroyer.png", tier, 64),
            effects = {
                { type = "unlock-recipe", recipe = capsuleName }
            },
            prerequisites = tier == 2 and { "destroyer" } or { "5d-destroyer-" .. (tier - 1) },
            unit = {
                count = 200 * tier,
                ingredients = getTechPacks(tier),
                time = 30
            }
        }
        
        data:extend({ robot, projectile, capsule, recipe, tech })
    end
end
