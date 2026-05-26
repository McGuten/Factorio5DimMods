-------------------------------------------------------------------------------
-- 5Dim's Logistic - Specialized Roboport Generation
-- Charging, logistic, construction and compact variants unlocked with roboport tech
-------------------------------------------------------------------------------

require("__5dim_core__.lib.logistic.generation-roboport")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")

local baseChargingEnergy = 1000
local baseBufferCapacity = 100
local baseEnergy = 50
local baseInputFlowLimit = 100
local baseLogistic = 25
local baseConstruction = 55
local baseBotSlot = 7
local baseRecharge = 40
local baseSlots = 4
local baseMaterialSlots = 7

local roboportSpaceAgeMaterials = {
    [7] = { name = "holmium-plate", amount = 10, category = "electromagnetics" },
    [8] = { type = "fluid", name = "electrolyte", amount = 120, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 6, category = "electromagnetics" },
    [10] = { name = "fusion-power-cell", amount = 4, category = "cryogenics" }
}

local tierOrders = {
    [1] = "a",
    [2] = "b",
    [3] = "c",
    [4] = "d",
    [5] = "e",
    [6] = "f",
    [7] = "g",
    [8] = "h",
    [9] = "i",
    [10] = "j"
}

local twoTileCollisionBox = { { -0.9, -0.9 }, { 0.9, 0.9 } }
local twoTileSelectionBox = { { -1, -1 }, { 1, 1 } }
local twoTileChargingOffsets = {
    { -0.85, -0.6 },
    { 0.85, -0.6 },
    { 0.85, 0.6 },
    { -0.85, 0.6 }
}
local chargingBaseShift = { -0.063, -1.184 }
local logisticBaseShift = { 0.5, -1.5 }
local constructionBaseShift = { -0.063, -1.697 }
local compactBaseShift = { -0.063, -0.25 }

local function rounded(value)
    return math.max(1, math.floor(value + 0.5))
end

local function getBaseStats(tier)
    return {
        chargingEnergy = CostCalculator.calculateMachineWorkValue(baseChargingEnergy, tier, 10, 0),
        bufferCapacity = CostCalculator.calculateMachineWorkValue(baseBufferCapacity, tier, 10, 0),
        energyUsage = CostCalculator.scaleMachineEnergy(baseEnergy, tier),
        inputFlowLimit = CostCalculator.calculateMachineWorkValue(baseInputFlowLimit, tier, 10, 0),
        logistics = CostCalculator.calculateMachineWorkValue(baseLogistic, tier, 10, 0),
        construction = CostCalculator.calculateMachineWorkValue(baseConstruction, tier, 10, 0),
        botSlots = CostCalculator.calculateMachineWorkValue(baseBotSlot, tier, 10, 0),
        materialSlots = baseMaterialSlots,
        recharge = CostCalculator.calculateMachineWorkValue(baseRecharge, tier, 10, 0),
        rechargeSlots = CostCalculator.calculateMachineWorkValue(baseSlots, tier, 10, 0)
    }
end

local function getRecipeIngredients(templates, tier)
    return CostCalculator.processIngredients(templates[tier], tier, {
        isBulkItem = false,
        skipTierScaling = true,
        applyMachineRecipeProgression = true,
        spaceAgeMaterialOverrides = roboportSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })
end

local function getUnlockTechnologyName(tier)
    if tier == 1 then
        return "logistic-robotics"
    end

    return "5d-roboport-" .. (tier - 1)
end

local function buildFamilyIconPath(familyName, tierNum)
    return "__5dim_logistic__/graphics/icons/roboport-" .. familyName .. "/roboport-icon-" .. tierNum .. ".png"
end

local function buildFamilyBasePath(familyName, tierNum)
    return "__5dim_logistic__/graphics/entities/roboport/roboport-base-" .. familyName .. "/roboport-base-" .. tierNum .. ".png"
end

local function buildFamilyBasePatchPath(familyName, tierNum)
    return "__5dim_logistic__/graphics/entities/roboport/roboport-base-patch-" .. familyName .. "/roboport-base-patch-" .. tierNum .. ".png"
end

local familyConfigs = {
    {
        familyName = "charging",
        namePrefix = "5d-roboport-charging-",
        subgroup = "logistic-roboport-charging",
        fastReplaceableGroup = "roboport-charging",
        templates = RecipeTemplates.roboportCharging,
        entityScale = 1.1,
        baseShift = chargingBaseShift,
        basePatchShift = chargingBaseShift,
        collisionBox = twoTileCollisionBox,
        selectionBox = twoTileSelectionBox,
        chargingOffsets = twoTileChargingOffsets,
        chargeApproachDistance = 3,
        drawingBoxVerticalExtension = 1.8,
        getStats = function(base, tier)
            local logisticRadius = math.max(6, rounded(base.logistics * 0.3))

            if tier == 1 then
                logisticRadius = math.max(logisticRadius, 8)
            end

            return {
                chargingEnergy = base.chargingEnergy,
                bufferCapacity = base.bufferCapacity,
                energyUsage = base.energyUsage,
                inputFlowLimit = base.inputFlowLimit,
                logistics = logisticRadius,
                construction = 0,
                botSlots = math.max(3, rounded(base.botSlots * 0.5)),
                materialSlots = 2,
                recharge = base.recharge,
                rechargeSlots = base.rechargeSlots,
                chargingDistance = 2.75
            }
        end
    },
    {
        familyName = "logistic",
        namePrefix = "5d-roboport-logistic-",
        subgroup = "logistic-roboport-logistic",
        fastReplaceableGroup = "roboport-logistic",
        templates = RecipeTemplates.roboportLogistic,
        entityScale = 1.32,
        baseShift = logisticBaseShift,
        basePatchShift = logisticBaseShift,
        collisionBox = twoTileCollisionBox,
        selectionBox = twoTileSelectionBox,
        chargingOffsets = twoTileChargingOffsets,
        chargeApproachDistance = 3,
        drawingBoxVerticalExtension = 1.8,
        getStats = function(base)
            return {
                chargingEnergy = rounded(base.chargingEnergy * 0.9),
                bufferCapacity = rounded(base.bufferCapacity * 0.9),
                energyUsage = base.energyUsage,
                inputFlowLimit = rounded(base.inputFlowLimit * 0.9),
                logistics = base.logistics,
                construction = math.max(4, rounded(base.construction * 0.35)),
                botSlots = math.max(4, rounded(base.botSlots * 0.85)),
                materialSlots = math.max(3, rounded(base.materialSlots * 0.6)),
                recharge = rounded(base.recharge * 0.9),
                rechargeSlots = math.max(4, rounded(base.rechargeSlots * 0.9)),
                chargingDistance = 3
            }
        end
    },
    {
        familyName = "construction",
        namePrefix = "5d-roboport-construction-",
        subgroup = "logistic-roboport-construction",
        fastReplaceableGroup = "roboport-construction",
        templates = RecipeTemplates.roboportConstruction,
        entityScale = 1.45,
        baseShift = constructionBaseShift,
        basePatchShift = constructionBaseShift,
        collisionBox = twoTileCollisionBox,
        selectionBox = twoTileSelectionBox,
        chargingOffsets = twoTileChargingOffsets,
        chargeApproachDistance = 3,
        drawingBoxVerticalExtension = 1.8,
        getStats = function(base)
            return {
                chargingEnergy = rounded(base.chargingEnergy * 0.9),
                bufferCapacity = rounded(base.bufferCapacity * 0.95),
                energyUsage = base.energyUsage,
                inputFlowLimit = rounded(base.inputFlowLimit * 0.9),
                logistics = math.max(5, rounded(base.logistics * 0.38)),
                construction = base.construction,
                botSlots = math.max(4, rounded(base.botSlots * 0.85)),
                materialSlots = base.materialSlots,
                recharge = rounded(base.recharge * 0.9),
                rechargeSlots = math.max(4, rounded(base.rechargeSlots * 0.85)),
                chargingDistance = 3
            }
        end
    },
    {
        familyName = "compact",
        namePrefix = "5d-roboport-compact-",
        subgroup = "logistic-roboport-compact",
        fastReplaceableGroup = "roboport-compact",
        templates = RecipeTemplates.roboportCompact,
        entityScale = 0.6,
        baseShift = compactBaseShift,
        basePatchShift = compactBaseShift,
        collisionBox = twoTileCollisionBox,
        selectionBox = twoTileSelectionBox,
        chargingOffsets = twoTileChargingOffsets,
        chargeApproachDistance = 3,
        drawingBoxVerticalExtension = 0.6,
        getStats = function(base)
            return {
                chargingEnergy = rounded(base.chargingEnergy * 0.8),
                bufferCapacity = rounded(base.bufferCapacity * 0.65),
                energyUsage = math.max(10, rounded(base.energyUsage * 0.75)),
                inputFlowLimit = rounded(base.inputFlowLimit * 0.75),
                logistics = math.max(8, rounded(base.logistics * 0.55)),
                construction = math.max(14, rounded(base.construction * 0.45)),
                botSlots = math.max(3, rounded(base.botSlots * 0.55)),
                materialSlots = math.max(2, rounded(base.materialSlots * 0.45)),
                recharge = rounded(base.recharge * 0.8),
                rechargeSlots = math.max(2, rounded(base.rechargeSlots * 0.55)),
                chargingDistance = 2.25
            }
        end
    }
}

for _, family in ipairs(familyConfigs) do
    for tier = 1, 10 do
        local tierNum = string.format("%02d", tier)
        local baseStats = getBaseStats(tier)
        local familyStats = family.getStats(baseStats, tier)
        local nextUpgrade = nil

        if tier < 10 then
            nextUpgrade = family.namePrefix .. string.format("%02d", tier + 1)
        end

        genRoboports {
            number = tierNum,
            itemName = family.namePrefix .. tierNum,
            subgroup = family.subgroup,
            iconPath = buildFamilyIconPath(family.familyName, tierNum),
            basePath = buildFamilyBasePath(family.familyName, tierNum),
            basePatchPath = buildFamilyBasePatchPath(family.familyName, tierNum),
            disableVanillaAnimations = true,
            chargingEnergy = familyStats.chargingEnergy,
            bufferCapacity = familyStats.bufferCapacity,
            energyUsage = familyStats.energyUsage,
            rechargeSlots = familyStats.rechargeSlots,
            chargingStationCount = familyStats.rechargeSlots,
            chargingDistance = familyStats.chargingDistance,
            new = true,
            order = tierOrders[tier],
            ingredients = getRecipeIngredients(family.templates, tier),
            inputFlowLimit = familyStats.inputFlowLimit,
            logistics = familyStats.logistics,
            construction = familyStats.construction,
            botSlots = familyStats.botSlots,
            materialSlots = familyStats.materialSlots,
            recharge = familyStats.recharge,
            nextUpdate = nextUpgrade,
            fastReplaceableGroup = family.fastReplaceableGroup,
            recipeCategory = CostCalculator.getSpaceAgeRecipeCategory(tier, roboportSpaceAgeMaterials),
            entityScale = family.entityScale,
            baseShift = family.baseShift,
            basePatchShift = family.basePatchShift,
            collisionBox = family.collisionBox,
            selectionBox = family.selectionBox,
            chargingOffsets = family.chargingOffsets,
            chargeApproachDistance = family.chargeApproachDistance,
            drawingBoxVerticalExtension = family.drawingBoxVerticalExtension,
            tech = {
                existingName = getUnlockTechnologyName(tier)
            }
        }
    end
end