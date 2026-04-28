-- =============================================================================
-- 5dim_enemies - Vanilla Spawner Modifier
-- =============================================================================
-- Modifies vanilla biter-spawner and spitter-spawner to use the tier system.
-- Creates T1-T10 normal biters/spitters and updates vanilla spawners.
-- =============================================================================

local Tiers = require("prototypes.config.tiers")
local BiterTypes = require("prototypes.config.biter-types")
local SpitterTypes = require("prototypes.config.spitter-types")
local SpawnerConfig = require("prototypes.config.spawner-config")
local TierUtils = require("prototypes.lib.tier-utils")
local SpitterAttack = require("prototypes.lib.spitter-attack")

-- =============================================================================
-- GENERATE NORMAL TIERED BITERS (T1-T10)
-- =============================================================================

local function createNormalTieredBiter(tier)
    local tierData = Tiers.biter[tier]
    local typeConfig = BiterTypes.get("normal")
    local entityName = TierUtils.getEntityName("normal", "biter", tier)
    
    -- Copy from appropriate base entity
    local baseBiter = "small-biter"
    if tier >= 7 then
        baseBiter = "behemoth-biter"
    elseif tier >= 5 then
        baseBiter = "big-biter"
    elseif tier >= 3 then
        baseBiter = "medium-biter"
    end
    
    local biter = table.deepcopy(data.raw["unit"][baseBiter])
    
    -- Basic properties
    biter.name = entityName
    biter.order = string.format("b-a-a-t%02d", tier)
    
    -- Stats
    biter.max_health = tierData.health
    biter.movement_speed = tierData.speed
    biter.healing_per_tick = tierData.healing
    
    -- Resistances
    biter.resistances = TierUtils.calculateResistances(typeConfig, tier)
    
    -- Attack parameters
    biter.attack_parameters = {
        type = "projectile",
        range = TierUtils.getMeleeRangeBonus(tier),
        cooldown = TierUtils.getAttackCooldown(tier),
        cooldown_deviation = 0.15,
        ammo_category = "melee",
        ammo_type = TierUtils.makeMeleeAmmoType(tierData.damage),
        animation = biterattackanimation(tierData.scale, typeConfig.colors.primary, typeConfig.colors.secondary),
        range_mode = "bounding-box-to-bounding-box"
    }
    
    -- Animations
    biter.run_animation = biterrunanimation(tierData.scale, typeConfig.colors.primary, typeConfig.colors.secondary)
    biter.water_reflection = biter_water_reflection(tierData.scale)
    
    -- AI behavior
    biter.vision_distance = TierUtils.getVisionDistance(tier)
    biter.min_pursue_time = TierUtils.getMinPursueTime(tier)
    biter.max_pursue_distance = TierUtils.getMaxPursueDistance(tier)
    biter.absorptions_to_join_attack = TierUtils.getAbsorptionsToJoinAttack(tier)
    
    -- Selection box - larger than collision for easier clicking
    local selectionScale = 0.8 + (tier * 0.15) -- 0.95 at T1 to 2.3 at T10
    biter.selection_box = {{-selectionScale, -selectionScale}, {selectionScale, selectionScale}}
    
    -- Corpse reference
    biter.corpse = TierUtils.getCorpseName(entityName)
    
    return biter
end

local function createNormalBiterCorpse(tier)
    local tierData = Tiers.biter[tier]
    local typeConfig = BiterTypes.get("normal")
    local entityName = TierUtils.getEntityName("normal", "biter", tier)
    
    local corpse = add_biter_die_animation(
        tierData.scale,
        typeConfig.colors.primary,
        typeConfig.colors.secondary,
        {
            type = "corpse",
            name = TierUtils.getCorpseName(entityName),
            icon = "__base__/graphics/icons/medium-biter-corpse.png",
            icon_size = 64,
            selectable_in_game = false,
            selection_box = {{-1, -1}, {1, 1}},
            subgroup = "corpses",
            order = string.format("c[corpse]-a[biter]-normal-t%02d", tier),
            flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
        }
    )
    
    return corpse
end

-- =============================================================================
-- GENERATE NORMAL TIERED SPITTERS (T1-T10)
-- =============================================================================

local function createNormalTieredSpitter(tier)
    local tierData = Tiers.spitter[tier]
    local typeConfig = SpitterTypes.get("normal")
    local entityName = TierUtils.getEntityName("normal", "spitter", tier)
    
    -- Copy from appropriate base entity
    local baseSpitter = "small-spitter"
    if tier >= 7 then
        baseSpitter = "behemoth-spitter"
    elseif tier >= 5 then
        baseSpitter = "big-spitter"
    elseif tier >= 3 then
        baseSpitter = "medium-spitter"
    end
    
    local spitter = table.deepcopy(data.raw["unit"][baseSpitter])
    
    -- Basic properties
    spitter.name = entityName
    spitter.order = string.format("b-b-a-t%02d", tier)
    
    -- Clear alternative attacking frame
    spitter.alternative_attacking_frame_sequence = nil
    
    -- Stats
    spitter.max_health = tierData.health
    spitter.movement_speed = tierData.speed
    spitter.healing_per_tick = tierData.healing
    
    -- Resistances
    spitter.resistances = TierUtils.calculateResistances(typeConfig, tier)
    
    -- Attack parameters
    local attackData = {
        range = tierData.range,
        damage = tierData.damage,
        scale = tierData.scale,
        tint = typeConfig.colors.primary,
        tint2 = typeConfig.colors.secondary
    }
    spitter.attack_parameters = SpitterAttack.get(typeConfig.attack_type, tier, attackData)
    
    -- Animations
    spitter.run_animation = spitterrunanimation(tierData.scale, typeConfig.colors.primary, typeConfig.colors.secondary)
    spitter.water_reflection = spitter_water_reflection(tierData.scale)
    
    -- AI behavior
    spitter.vision_distance = TierUtils.getVisionDistance(tier)
    spitter.min_pursue_time = TierUtils.getMinPursueTime(tier)
    spitter.max_pursue_distance = TierUtils.getMaxPursueDistance(tier)
    spitter.absorptions_to_join_attack = TierUtils.getAbsorptionsToJoinAttack(tier)
    
    -- Selection box - larger than collision for easier clicking
    local selectionScale = 0.8 + (tier * 0.15) -- 0.95 at T1 to 2.3 at T10
    spitter.selection_box = {{-selectionScale, -selectionScale}, {selectionScale, selectionScale}}
    
    -- Corpse reference
    spitter.corpse = TierUtils.getCorpseName(entityName)
    
    return spitter
end

local function createNormalSpitterCorpse(tier)
    local tierData = Tiers.spitter[tier]
    local typeConfig = SpitterTypes.get("normal")
    local entityName = TierUtils.getEntityName("normal", "spitter", tier)
    
    local corpse = add_spitter_die_animation(
        tierData.scale,
        typeConfig.colors.primary,
        typeConfig.colors.secondary,
        {
            type = "corpse",
            name = TierUtils.getCorpseName(entityName),
            icon = "__base__/graphics/icons/medium-spitter-corpse.png",
            icon_size = 64,
            selectable_in_game = false,
            selection_box = {{-1, -1}, {1, 1}},
            subgroup = "corpses",
            order = string.format("c[corpse]-b[spitter]-normal-t%02d", tier),
            flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
        }
    )
    
    return corpse
end

-- =============================================================================
-- GENERATE VANILLA SPAWNER RESULT UNITS
-- =============================================================================

local function generateVanillaBiterSpawnerUnits()
    local result = {}
    
    for tier = 1, Tiers.COUNT do
        local unitName = TierUtils.getEntityName("normal", "biter", tier)
        local curve = Tiers.getSpawnCurve("normal", tier, "biter")
        table.insert(result, {unitName, curve})
    end
    
    -- Add boss if enabled
    if TierUtils.isBossEnabled() then
        local bossName = TierUtils.getBossName("normal", "biter")
        local bossCurve = Tiers.getSpawnCurve("normal", 11, "biter")
        table.insert(result, {bossName, bossCurve})
    end
    
    return result
end

local function generateVanillaSpitterSpawnerUnits()
    local result = {}
    
    for tier = 1, Tiers.COUNT do
        local unitName = TierUtils.getEntityName("normal", "spitter", tier)
        local curve = Tiers.getSpawnCurve("normal", tier, "spitter")
        table.insert(result, {unitName, curve})
    end
    
    -- Add boss if enabled
    if TierUtils.isBossEnabled() then
        local bossName = TierUtils.getBossName("normal", "spitter")
        local bossCurve = Tiers.getSpawnCurve("normal", 11, "spitter")
        table.insert(result, {bossName, bossCurve})
    end
    
    return result
end

-- =============================================================================
-- EXECUTE
-- =============================================================================

local function generateAllNormalTiered()
    local allEntities = {}
    
    -- Generate normal biters T1-T10
    for tier = 1, Tiers.COUNT do
        local biter = createNormalTieredBiter(tier)
        local corpse = createNormalBiterCorpse(tier)
        table.insert(allEntities, biter)
        table.insert(allEntities, corpse)
    end
    
    -- Generate normal spitters T1-T10
    for tier = 1, Tiers.COUNT do
        local spitter = createNormalTieredSpitter(tier)
        local corpse = createNormalSpitterCorpse(tier)
        table.insert(allEntities, spitter)
        table.insert(allEntities, corpse)
    end
    
    -- Register entities
    if #allEntities > 0 then
        data:extend(allEntities)
    end
    
    -- Modify vanilla biter-spawner (only result_units, keep original autoplace)
    local biterSpawner = data.raw["unit-spawner"]["biter-spawner"]
    if biterSpawner then
        biterSpawner.result_units = generateVanillaBiterSpawnerUnits()
    end
    
    -- Modify vanilla spitter-spawner (only result_units, keep original autoplace)
    local spitterSpawner = data.raw["unit-spawner"]["spitter-spawner"]
    if spitterSpawner then
        spitterSpawner.result_units = generateVanillaSpitterSpawnerUnits()
    end
end

-- Run
generateAllNormalTiered()
