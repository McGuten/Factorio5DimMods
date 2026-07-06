-------------------------------------------------------------------------------
-- 5Dim's Space Age - Rocket Silo Generation (10 tiers)
-- Uses the centralized cost system from 5dim_core.
--
-- Runs at the data-updates stage (required from data-updates.lua) so that the
-- base "space-age" mod has already turned the vanilla silo into its Space Age
-- form. Base stats are read live from the silo prototype, so the family adapts
-- automatically to whatever Space Age sets (rocket_parts_required = 50, etc.).
--
-- Hybrid progression: every tier improves a bit of everything (speed, modules,
-- launch cost, launch sequence, energy-per-launch and orbital lift weight),
-- with MK10 as a capstone.
-------------------------------------------------------------------------------

require("__5dim_core__.lib.space-age.generation-rocket-silo")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

-------------------------------------------------------------------------------
-- READ LIVE BASE STATS FROM THE (SPACE AGE) SILO
-------------------------------------------------------------------------------

local silo = data.raw["rocket-silo"]["rocket-silo"]

local function parseEnergyKw(value)
    local num = tonumber(string.match(value, "[%d%.]+")) or 0
    local unit = string.upper(string.match(value, "%a+$") or "W")
    if unit == "W" then return num / 1000 end
    if unit == "KW" then return num end
    if unit == "MW" then return num * 1000 end
    if unit == "GW" then return num * 1000000 end
    if unit == "TW" then return num * 1000000000 end
    return num
end

local baseCraftingSpeed = silo.crafting_speed or 1
local baseModuleSlots   = silo.module_slots or 4
local baseEnergyKw      = parseEnergyKw(silo.energy_usage or "250kW")
local baseRocketParts   = silo.rocket_parts_required or 50
local baseLiftWeight    = silo.lift_weight or 1000000
local baseDoorSpeed     = silo.door_opening_speed or (1 / (4.25 * 60))
local baseRisingDelay   = silo.rocket_rising_delay or 30
local baseLaunchWait    = silo.launch_wait_time or 120
local baseTrash         = silo.logistic_trash_inventory_size or 20

-- Phase 2: base values of the rocket entity itself (cloned per tier)
local rocketProto = data.raw["rocket-silo-rocket"]["rocket-silo-rocket"]
local baseRisingSpeed          = rocketProto.rising_speed or (1 / (7 * 60))
local baseEngineStartingSpeed  = rocketProto.engine_starting_speed or (1 / (5.5 * 60))
local baseRocketInventory      = math.max(rocketProto.inventory_size or 20, 20)

local targetRocketPartsT10 = 30
local targetRocketInventoryT10 = 50
local baseTechCount = RecipeTemplates.baseTechCounts.rocketSilo or 1000

-------------------------------------------------------------------------------
-- TIER DEFINITIONS (MK1 = vanilla Space Age silo, MK2..MK10 generated)
-- moduleSlots: 4 -> 10  | sequence: 1.00 -> 0.60  | lift: x1.0 -> x3.2 (capstone)
-------------------------------------------------------------------------------

local tierConfig = {
    [1]  = { moduleSlots = baseModuleSlots, sequence = 1.00, lift = 1.00, order = "a", isVanilla = true },
    [2]  = { moduleSlots = 4,  sequence = 0.96, lift = 1.15, order = "b" },
    [3]  = { moduleSlots = 5,  sequence = 0.92, lift = 1.30, order = "c" },
    [4]  = { moduleSlots = 5,  sequence = 0.88, lift = 1.48, order = "d" },
    [5]  = { moduleSlots = 6,  sequence = 0.84, lift = 1.68, order = "e" },
    [6]  = { moduleSlots = 6,  sequence = 0.80, lift = 1.90, order = "f" },
    [7]  = { moduleSlots = 7,  sequence = 0.76, lift = 2.15, order = "g" },
    [8]  = { moduleSlots = 7,  sequence = 0.72, lift = 2.42, order = "h" },
    [9]  = { moduleSlots = 8,  sequence = 0.68, lift = 2.70, order = "i" },
    [10] = { moduleSlots = 10, sequence = 0.60, lift = 3.20, order = "j" }
}

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION BY TIER
-- Endgame building: rich base packs + Space Age packs forced on every tier.
-------------------------------------------------------------------------------

local baseSciencePacks = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "production-science-pack", 1 },
    { "utility-science-pack", 1 }
}

-- Planetary route, coherent with the recipe ingredient of each tier:
--   MK2 orbit/space | MK3-4 Vulcanus | MK5-6 Fulgora | MK7 Gleba | MK8-10 Aquilo
local rocketSiloSpaceAgeSciencePacks = {
    [2]  = { "space-science-pack" },
    [3]  = { "space-science-pack", "metallurgic-science-pack" },
    [4]  = { "space-science-pack", "metallurgic-science-pack" },
    [5]  = { "space-science-pack", "electromagnetic-science-pack" },
    [6]  = { "space-science-pack", "electromagnetic-science-pack" },
    [7]  = { "space-science-pack", "agricultural-science-pack" },
    [8]  = { "space-science-pack", "cryogenic-science-pack" },
    [9]  = { "space-science-pack", "cryogenic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

-- Extra prerequisite: the science-pack technology, added the tier it first appears.
local rocketSiloDeltaPrerequisites = {
    [2]  = "space-science-pack",
    [3]  = "metallurgic-science-pack",
    [5]  = "electromagnetic-science-pack",
    [7]  = "agricultural-science-pack",
    [8]  = "cryogenic-science-pack"
}

local function addPrerequisiteIfMissing(prerequisites, prerequisite)
    if not prerequisite then
        return
    end
    for _, current in ipairs(prerequisites) do
        if current == prerequisite then
            return
        end
    end
    table.insert(prerequisites, prerequisite)
end

-------------------------------------------------------------------------------
-- VANILLA SILO (MK1): wire fast replace + upgrade chain towards MK2
-------------------------------------------------------------------------------

silo.fast_replaceable_group = "rocket-silo"
silo.next_upgrade = "5d-rocket-silo-02"

-------------------------------------------------------------------------------
-- GENERATION LOOP (MK2..MK10)
-------------------------------------------------------------------------------

for tier = 2, 10 do
    local config = tierConfig[tier]
    local tierNum = string.format("%02d", tier)

    local craftingSpeed = CostCalculator.calculateMachineWorkValue(baseCraftingSpeed, tier, 10, 2)

    local moduleSlots = CostCalculator.applyT10CapstoneModuleBonus(
        config.moduleSlots, tier, 10, tierConfig[tier - 1].moduleSlots)

    local energy = CostCalculator.scaleMachineEnergy(baseEnergyKw, tier)

    -- Launch cost: smooth 50 -> 30
    local rocketParts = math.floor(
        baseRocketParts - (baseRocketParts - targetRocketPartsT10) * (tier - 1) / 9 + 0.5)

    -- Launch sequence: shorter total time
    local doorSpeed = baseDoorSpeed / config.sequence
    local risingDelay = math.max(1, math.ceil(baseRisingDelay * config.sequence))
    local launchWait = math.max(1, math.ceil(baseLaunchWait * config.sequence))

    -- Orbital payload (Space Age): higher per-silo lift weight
    local liftWeight = math.floor(baseLiftWeight * config.lift + 0.5)

    local logisticTrash = baseTrash + (tier - 1)

    -- Phase 2: cloned rocket entity (faster ascent, more cargo slots)
    local rocketInventory = math.floor(
        baseRocketInventory + (targetRocketInventoryT10 - baseRocketInventory) * (tier - 1) / 9 + 0.5)
    local rocketConfig = {
        risingSpeed = baseRisingSpeed / config.sequence,
        engineStartingSpeed = baseEngineStartingSpeed / config.sequence,
        inventorySize = rocketInventory
    }

    -- Recipe ingredients from the shared template
    local ingredients = CostCalculator.processIngredients(RecipeTemplates.rocketSilo[tier], tier, {
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        skipSpaceAgeMaterials = true
    })

    -- Next upgrade (nil for MK10)
    local nextUpgrade = nil
    if tier < 10 then
        nextUpgrade = "5d-rocket-silo-" .. string.format("%02d", tier + 1)
    end

    -- Technology
    local prerequisites
    if tier == 2 then
        prerequisites = { "rocket-silo" }
    else
        prerequisites = { "5d-rocket-silo-" .. (tier - 1) }
    end
    addPrerequisiteIfMissing(prerequisites, rocketSiloDeltaPrerequisites[tier])

    local tech = {
        number = tier,
        count = CostCalculator.calculateMachineTechCount(baseTechCount, tier),
        packs = CostCalculator.getTechPacks(baseSciencePacks, tier, {
            spaceAgePackOverrides = rocketSiloSpaceAgeSciencePacks,
            forceSpaceAgePackOverrides = true
        }),
        prerequisites = prerequisites
    }

    genRocketSilo {
        number = tierNum,
        subgroup = "orbit-silo",
        order = config.order,
        new = true,
        craftingSpeed = craftingSpeed,
        moduleSlots = moduleSlots,
        energyUsage = energy,
        rocketPartsRequired = rocketParts,
        doorOpeningSpeed = doorSpeed,
        rocketRisingDelay = risingDelay,
        launchWaitTime = launchWait,
        liftWeight = liftWeight,
        logisticTrashInventory = logisticTrash,
        rocket = rocketConfig,
        canLaunchWithoutLandingPads = (tier == 10),
        ingredients = ingredients,
        nextUpdate = nextUpgrade,
        tech = tech
    }
end
