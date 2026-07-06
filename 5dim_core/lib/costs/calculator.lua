-------------------------------------------------------------------------------
-- 5Dim's Mod - Cost Calculator
-- Functions to calculate recipe ingredients and technology costs
-------------------------------------------------------------------------------

local CostConfig = require("__5dim_core__.lib.costs.config")

local CostCalculator = {}

local function roundNearest(value)
    return math.floor(value + 0.5)
end

local function roundToMultiple(value, multiple)
    if multiple <= 1 then
        return math.max(1, roundNearest(value))
    end

    local rounded = multiple * math.floor((value / multiple) + 0.5)
    return math.max(multiple, rounded)
end

local function roundToDecimals(value, decimals)
    local factor = 10 ^ (decimals or 0)
    return math.floor((value * factor) + 0.5) / factor
end

local function getModeIngredientMultiplier(isBulkItem)
    local modeMultiplier = CostConfig.getRecipeMultiplier()

    if isBulkItem and modeMultiplier > 1 then
        return 1 + ((modeMultiplier - 1) * 0.5)
    end

    return modeMultiplier
end

local function getTierIngredientMultiplier(tier, isBulkItem)
    local tierMultiplier = 1 + ((CostConfig.getTierMultiplier(tier) - 1) * 0.3)

    if isBulkItem and tierMultiplier > 1 then
        return 1 + ((tierMultiplier - 1) * 0.5)
    end

    return tierMultiplier
end

local function findIngredient(ingredients, ingredientType, ingredientName)
    for _, ingredient in ipairs(ingredients) do
        if ingredient.type == ingredientType and ingredient.name == ingredientName then
            return ingredient
        end
    end

    return nil
end

local function addOrMergeIngredient(ingredients, ingredientType, ingredientName, amount)
    local existing = findIngredient(ingredients, ingredientType, ingredientName)

    if existing then
        existing.amount = existing.amount + amount
        return
    end

    table.insert(ingredients, {
        type = ingredientType,
        name = ingredientName,
        amount = amount
    })
end

local function isCarryIngredient(index, tier, ingredient)
    return tier > 1 and index == 1 and ingredient.type == "item" and ingredient.amount == 1
end

local function moveIngredientToFront(ingredients, ingredientType, ingredientName)
    for index, ingredient in ipairs(ingredients) do
        if ingredient.type == ingredientType and ingredient.name == ingredientName then
            if index > 1 then
                table.remove(ingredients, index)
                table.insert(ingredients, 1, ingredient)
            end

            return ingredients
        end
    end

    return ingredients
end

local function prioritizeLeadingCarryIngredient(ingredients, baseIngredients, tier)
    if tier <= 1 or not baseIngredients or not baseIngredients[1] then
        return ingredients
    end

    local carryIngredient = baseIngredients[1]

    if not isCarryIngredient(1, tier, carryIngredient) then
        return ingredients
    end

    return moveIngredientToFront(ingredients, carryIngredient.type, carryIngredient.name)
end

local function getWorkTierExponent(tier, totalTiers)
    totalTiers = totalTiers or 10

    if tier == totalTiers and CostConfig.shouldUseT10NextTierWork() then
        return tier
    end

    return tier - 1
end

-------------------------------------------------------------------------------
-- INGREDIENT SCALING
-------------------------------------------------------------------------------

-- Scale a single ingredient amount based on tier and mode
-- @param baseAmount: The base amount of the ingredient
-- @param tier: The tier number (1-10)
-- @param isBulkItem: If true, uses smaller scaling for bulk-produced items
-- @return: The scaled amount (rounded up)
function CostCalculator.scaleIngredientAmount(baseAmount, tier, isBulkItem)
    local scaled = baseAmount * getModeIngredientMultiplier(isBulkItem) * getTierIngredientMultiplier(tier, isBulkItem)

    return math.ceil(scaled)
end

-- Scale all ingredients in a recipe
-- @param ingredients: Table of ingredients { {type, name, amount}, ... }
-- @param tier: The tier number (1-10)
-- @param isBulkItem: If true, uses smaller scaling
-- @return: New table with scaled ingredients
function CostCalculator.scaleIngredients(ingredients, tier, isBulkItem)
    local scaled = {}

    for i, ingredient in ipairs(ingredients) do
        local newIngredient = {
            type = ingredient.type,
            name = ingredient.name,
            amount = CostCalculator.scaleIngredientAmount(ingredient.amount, tier, isBulkItem)
        }
        table.insert(scaled, newIngredient)
    end
    
    return scaled
end

-- Add Space Age materials to ingredients if applicable
-- @param ingredients: Table of ingredients
-- @param tier: The tier number (1-10)
-- @param isBulkItem: If true, uses bulk material amounts
-- @return: Ingredients with Space Age materials added (if applicable)
function CostCalculator.addSpaceAgeMaterials(ingredients, tier, isBulkItem)
    if not CostConfig.shouldUseSpaceAgeMaterials() then
        return ingredients
    end
    
    local materials = isBulkItem and CostConfig.spaceAgeMaterialsBulk or CostConfig.spaceAgeMaterials
    local spaceAgeMaterial = materials[tier]
    
    if spaceAgeMaterial then
        -- Scale the Space Age material amount based on recipe multiplier
        local scaledAmount = math.ceil(spaceAgeMaterial.amount * CostConfig.getRecipeMultiplier())

        addOrMergeIngredient(ingredients, "item", spaceAgeMaterial.material, scaledAmount)
    end
    
    return ingredients
end

local function replaceLastDirectDelta(ingredients)
    if #ingredients <= 1 then
        return ingredients
    end

    table.remove(ingredients, #ingredients)
    return ingredients
end

local function addIngredientWithRecipeScaling(ingredients, ingredient)
    addOrMergeIngredient(
        ingredients,
        ingredient.type or "item",
        ingredient.name,
        math.ceil((ingredient.amount or 1) * CostConfig.getRecipeMultiplier())
    )
end

local function addIngredientWithProgressionScaling(ingredients, ingredient, tier, applyMachineRecipeProgression)
    local amount = ingredient.amount or 1

    if applyMachineRecipeProgression then
        amount = CostCalculator.calculateMachineRecipeAmount(amount, tier, ingredient.type or "item", ingredient.name)
    else
        amount = math.ceil(amount * CostConfig.getRecipeMultiplier())
    end

    addOrMergeIngredient(
        ingredients,
        ingredient.type or "item",
        ingredient.name,
        amount
    )
end

-- Add family-specific Space Age materials if applicable.
-- Overrides intentionally replace the old global tier mapping for that recipe family.
-- @param ingredients: Table of ingredients
-- @param tier: The tier number (1-10)
-- @param overrides: Table keyed by tier; each value can be one ingredient or a list
-- @param replaceDelta: When true, replace the last direct delta before adding the override
-- @return: Ingredients with family-specific Space Age materials added
function CostCalculator.addSpaceAgeMaterialOverrides(ingredients, tier, overrides, replaceDelta, applyMachineRecipeProgression, progressionTier)
    if not CostConfig.shouldUseSpaceAgeMaterials() or not overrides then
        return ingredients
    end

    local override = overrides[tier]
    if not override then
        return ingredients
    end

    if replaceDelta then
        ingredients = replaceLastDirectDelta(ingredients)
    end

    progressionTier = progressionTier or tier

    if override.name then
        addIngredientWithProgressionScaling(ingredients, override, progressionTier, applyMachineRecipeProgression)
        return ingredients
    end

    for _, ingredient in ipairs(override) do
        addIngredientWithProgressionScaling(ingredients, ingredient, progressionTier, applyMachineRecipeProgression)
    end

    return ingredients
end

-------------------------------------------------------------------------------
-- MACHINE PROGRESSION
-------------------------------------------------------------------------------

function CostCalculator.getMachineWorkMultiplier(tier, totalTiers)
    if tier <= 1 then
        return 1.0
    end

    return CostConfig.getMachineWorkFactor() ^ getWorkTierExponent(tier, totalTiers)
end

function CostCalculator.calculateMachineWorkValue(baseValue, tier, totalTiers, decimals)
    local value = baseValue * CostCalculator.getMachineWorkMultiplier(tier, totalTiers)

    if decimals then
        return roundToDecimals(value, decimals)
    end

    return value
end

function CostCalculator.calculateCappedMachineWorkValue(baseValue, tier, totalTiers, maxValue, decimals)
    totalTiers = totalTiers or 10

    local capstoneValue = CostCalculator.calculateMachineWorkValue(baseValue, totalTiers, totalTiers)
    local value

    if capstoneValue <= maxValue or baseValue >= maxValue then
        value = math.min(CostCalculator.calculateMachineWorkValue(baseValue, tier, totalTiers), maxValue)
    else
        local currentExponent = getWorkTierExponent(tier, totalTiers)
        local maxExponent = getWorkTierExponent(totalTiers, totalTiers)

        if maxExponent <= 0 then
            value = math.min(baseValue, maxValue)
        else
            -- Compress capped prototype stats so the whole family stays distinct
            -- and T10 still lands on the theoretical next-tier capstone value.
            value = baseValue * ((maxValue / baseValue) ^ (currentExponent / maxExponent))
        end
    end

    if decimals then
        return roundToDecimals(value, decimals)
    end

    return value
end

function CostCalculator.scaleMachineEnergy(baseEnergy, tier, decimals)
    local scaled = baseEnergy

    if tier > 1 then
        scaled = baseEnergy * (CostConfig.getMachineEnergyFactor() ^ (tier - 1))
    end

    if decimals then
        return roundToDecimals(scaled, decimals)
    end

    return roundNearest(scaled)
end

function CostCalculator.applyT10CapstoneModuleBonus(moduleSlots, tier, totalTiers, previousTierModuleSlots)
    totalTiers = totalTiers or 10

    if tier == totalTiers then
        if previousTierModuleSlots then
            return math.max(moduleSlots, previousTierModuleSlots + CostConfig.getT10ExtraModuleSlots())
        end

        return moduleSlots + CostConfig.getT10ExtraModuleSlots()
    end

    return moduleSlots
end

function CostCalculator.getMachineRecipeMultiplierForIngredient(tier, ingredientType, ingredientName)
    if tier <= 1 then
        return 1.0
    end

    local rarityWeight = CostConfig.getRecipeRarityWeight(ingredientType, ingredientName)
    return CostConfig.getMachineRecipeFactor() ^ ((tier - 1) * rarityWeight)
end

function CostCalculator.calculateMachineRecipeAmount(baseAmount, tier, ingredientType, ingredientName)
    return math.ceil(baseAmount * CostCalculator.getMachineRecipeMultiplierForIngredient(tier, ingredientType, ingredientName))
end

function CostCalculator.calculateMachineTechCount(baseCount, tier, roundTo)
    local scaled = baseCount * (CostConfig.getMachineTechFactor() ^ (tier - 1))
    return roundToMultiple(scaled, roundTo or 5)
end

function CostCalculator.getSpaceAgeRecipeCategory(tier, overrides)
    if not CostConfig.shouldUseSpaceAgeMaterials() or not overrides then
        return nil
    end

    local override = overrides[tier]
    if not override then
        return nil
    end

    if override.name then
        return override.category
    end

    for _, ingredient in ipairs(override) do
        if ingredient.category then
            return ingredient.category
        end
    end

    return nil
end

-- Complete ingredient processing: scale and add Space Age materials
-- @param baseIngredients: Original ingredients
-- @param tier: Tier number (1-10)
-- @param options: Table with options { isBulkItem = false, skipTierScaling = false, skipSpaceAgeMaterials = false, spaceAgeMaterialOverrides = nil, replaceSpaceAgeDelta = false }
-- @return: Processed ingredients
function CostCalculator.processIngredients(baseIngredients, tier, options)
    options = options or {}
    local isBulkItem = options.isBulkItem or false
    local skipTierScaling = options.skipTierScaling or false
    local skipSpaceAgeMaterials = options.skipSpaceAgeMaterials or false
    local spaceAgeMaterialOverrides = options.spaceAgeMaterialOverrides
    local replaceSpaceAgeDelta = options.replaceSpaceAgeDelta or false
    local applyMachineRecipeProgression = options.applyMachineRecipeProgression
    local progressionTier = options.progressionTier or tier

    if applyMachineRecipeProgression == nil then
        applyMachineRecipeProgression = skipTierScaling
    end
    
    local ingredients = {}
    local modeMultiplier = getModeIngredientMultiplier(isBulkItem)

    -- Deep copy and scale ingredients
    for index, ing in ipairs(baseIngredients) do
        local amount

        if applyMachineRecipeProgression then
            if ing.fixedAmount or isCarryIngredient(index, tier, ing) then
                amount = ing.amount
            else
                amount = CostCalculator.calculateMachineRecipeAmount(ing.amount, progressionTier, ing.type, ing.name)
            end
        elseif skipTierScaling then
            amount = math.ceil(ing.amount * modeMultiplier)
        else
            amount = CostCalculator.scaleIngredientAmount(ing.amount, tier, isBulkItem)
        end

        table.insert(ingredients, {
            type = ing.type,
            name = ing.name,
            amount = amount
        })
    end
    
    -- Add Space Age materials. Family-specific overrides take precedence over
    -- the legacy global tier mapping.
    if spaceAgeMaterialOverrides then
        ingredients = CostCalculator.addSpaceAgeMaterialOverrides(ingredients, tier, spaceAgeMaterialOverrides,
            replaceSpaceAgeDelta, applyMachineRecipeProgression, progressionTier)
    elseif not skipSpaceAgeMaterials then
        ingredients = CostCalculator.addSpaceAgeMaterials(ingredients, tier, isBulkItem)
    end

    ingredients = prioritizeLeadingCarryIngredient(ingredients, baseIngredients, tier)

    return ingredients
end

-------------------------------------------------------------------------------
-- TECHNOLOGY COST SCALING
-------------------------------------------------------------------------------

-- Calculate technology research count
-- @param baseCount: The base research count
-- @param tier: The tier number (1-10)
-- @return: Scaled research count
function CostCalculator.calculateTechCount(baseCount, tier)
    if tier <= 1 then
        return roundToMultiple(baseCount, 5)
    end

    return CostCalculator.calculateMachineTechCount(baseCount, tier)
end

function CostCalculator.scaleAbsoluteTechCount(baseCount)
    return roundToMultiple(baseCount, 5)
end

local function copyTechPacks(basePacks)
    local packs = {}

    for _, pack in ipairs(basePacks) do
        table.insert(packs, { pack[1], pack[2] })
    end

    return packs
end

local function addPackIfMissing(packs, packName, amount)
    for _, pack in ipairs(packs) do
        if pack[1] == packName then
            return
        end
    end

    table.insert(packs, { packName, amount or 1 })
end

-- Get science packs for a given tier, including Space Age packs if applicable
-- @param basePacks: Table of base science packs
-- @param tier: The tier number (1-10)
-- @param options: Optional table. Use skipSpaceAgePacks to keep the base packs
-- unchanged, spaceAgePackOverrides for exact per-tier additions, or
-- spaceAgePackThresholds for cumulative Space Age science progression.
-- @return: Science packs with Space Age additions
function CostCalculator.getTechPacks(basePacks, tier, options)
    options = options or {}

    local packs = copyTechPacks(basePacks)

    if options.skipSpaceAgePacks then
        return packs
    end

    if options.spaceAgePackOverrides then
        if CostConfig.shouldUseSpaceAgeSciencePacks() or options.forceSpaceAgePackOverrides then
            local override = options.spaceAgePackOverrides[tier]
            if override then
                if type(override) == "string" then
                    addPackIfMissing(packs, override, 1)
                else
                    for _, pack in ipairs(override) do
                        if type(pack) == "string" then
                            addPackIfMissing(packs, pack, 1)
                        else
                            addPackIfMissing(packs, pack.name or pack[1], pack.amount or pack[2] or 1)
                        end
                    end
                end
            end
        end

        return packs
    end

    if options.spaceAgePackThresholds then
        if CostConfig.shouldUseSpaceAgeSciencePacks() then
            for _, threshold in ipairs(options.spaceAgePackThresholds) do
                if tier >= threshold.tier then
                    addPackIfMissing(packs, threshold.pack, threshold.amount)
                end
            end
        end

        return packs
    end
    
    -- Add Space Age science packs if applicable
    if CostConfig.shouldUseSpaceAgeSciencePacks() then
        local spaceAgePack = CostConfig.spaceAgeSciencePacks[tier]
        if spaceAgePack then
            addPackIfMissing(packs, spaceAgePack[1], spaceAgePack[2])
        end
    end
    
    return packs
end

-- Complete technology processing
-- @param baseTech: Original tech definition { count, packs, prerequisites, ... }
-- @param tier: Tier number (1-10)
-- @param baseCount: Base count for this entity type
-- @return: Processed technology definition
function CostCalculator.processTechnology(baseTech, tier, baseCount)
    if not baseTech then
        return nil
    end
    
    local tech = {}
    
    -- Copy basic properties
    tech.number = baseTech.number
    tech.prerequisites = baseTech.prerequisites
    
    -- Calculate scaled count
    tech.count = CostCalculator.calculateTechCount(baseCount, tier)
    
    -- Process science packs
    tech.packs = CostCalculator.getTechPacks(baseTech.packs, tier)
    
    return tech
end

-------------------------------------------------------------------------------
-- CRAFTING TIME SCALING
-------------------------------------------------------------------------------

-- Scale crafting time based on mode
-- @param baseTime: Base crafting time in seconds
-- @return: Scaled crafting time
function CostCalculator.scaleCraftingTime(baseTime)
    return baseTime * CostConfig.getCraftingTimeMultiplier()
end

-------------------------------------------------------------------------------
-- ENERGY SCALING
-- Based on Factorio vanilla scaling (assembling machines):
-- Tier 1: 75kW (base), Tier 2: 150kW (2x), Tier 3: 375kW (5x)
-- This gives approximately a 1.5x exponential increase per tier
-------------------------------------------------------------------------------

-- Scale energy usage with non-linear (exponential) increase per tier
-- Follows Factorio vanilla pattern: higher tiers are significantly more power-hungry
-- @param baseEnergy: Base energy in kW (tier 1 value)
-- @param tier: Tier number (1-10)
-- @param preserveDecimals: If true, don't round to integer (for fluid_usage_per_tick, etc.)
-- @return: Scaled energy value in kW
function CostCalculator.scaleEnergy(baseEnergy, tier, preserveDecimals)
    if tier <= 1 then
        if preserveDecimals then
            return baseEnergy
        end
        return roundNearest(baseEnergy)
    end
    local scaled = baseEnergy * (CostConfig.getMachineEnergyFactor() ^ (tier - 1))
    if preserveDecimals then
        return math.floor(scaled * 100) / 100  -- Round to 2 decimal places
    end
    return roundNearest(scaled)
end

-- Scale energy with a custom exponential factor
-- @param baseEnergy: Base energy in kW (tier 1 value)
-- @param tier: Tier number (1-10)
-- @param factor: Exponential factor (default 1.58 for vanilla-like scaling)
-- @return: Scaled energy value in kW
function CostCalculator.scaleEnergyCustom(baseEnergy, tier, factor)
    factor = factor or 1.58
    if tier <= 1 then
        return math.floor(baseEnergy)
    end
    return math.floor(baseEnergy * (factor ^ (tier - 1)))
end

-- Scale energy based on performance (speed/throughput) with superlinear growth
-- Energy grows FASTER than speed (exponent > 1 means higher tiers are less efficient)
-- This ensures faster machines consume disproportionately more power
-- Example with exponent=1.5: 2x speed = 2.83x energy, 3x speed = 5.2x energy
-- @param baseEnergy: Base energy in kW (at base speed)
-- @param baseSpeed: Base speed/performance value
-- @param currentSpeed: Current tier's speed/performance
-- @param exponent: Growth rate (default 1.5, higher = more energy hungry)
-- @return: Scaled energy value in kW
function CostCalculator.scaleEnergyBySpeed(baseEnergy, baseSpeed, currentSpeed, exponent)
    exponent = exponent or 1.5  -- Default: energy grows ~50% faster than speed
    local speedRatio = currentSpeed / baseSpeed
    return math.floor(baseEnergy * (speedRatio ^ exponent))
end

-------------------------------------------------------------------------------
-- POLLUTION/EMISSIONS SCALING
-- Pollution growth is moderate by default and can be overridden per family.
-- This keeps electric general-purpose machines mostly constrained by power,
-- while dirtier industries can opt into steeper pollution scaling.
-------------------------------------------------------------------------------

-- Scale pollution based on performance with superlinear growth.
-- Default exponent 0.4 gives roughly +18% pollution for +50% speed.
-- @param basePollution: Base pollution value at base performance
-- @param basePerformance: Base speed/performance value
-- @param currentPerformance: Current tier's speed/performance
-- @param exponent: Growth rate (default 0.4)
-- @return: Scaled pollution value rounded to 2 decimals
function CostCalculator.scalePollution(basePollution, basePerformance, currentPerformance, exponent)
    exponent = exponent or 0.4
    local performanceRatio = currentPerformance / basePerformance

    if basePollution < 0 then
        local reducedCleanup = math.abs(basePollution) / (performanceRatio ^ exponent)
        return -(math.floor(reducedCleanup * 100) / 100)
    end

    return math.floor(basePollution * (performanceRatio ^ exponent) * 100) / 100
end

-- Scale pollution with a custom performance exponent.
-- @param basePollution: Base pollution value at base performance
-- @param basePerformance: Base speed/performance value
-- @param currentPerformance: Current tier's speed/performance
-- @param exponent: Growth rate (default 0.4)
-- @return: Scaled pollution value rounded to 2 decimals
function CostCalculator.scalePollutionCustom(basePollution, basePerformance, currentPerformance, exponent)
    return CostCalculator.scalePollution(basePollution, basePerformance, currentPerformance, exponent)
end

-------------------------------------------------------------------------------
-- UTILITY FUNCTIONS
-------------------------------------------------------------------------------

-- Create a standard tiered recipe with proper scaling
-- @param params: Table with recipe parameters
-- @return: Recipe definition ready for data:extend
function CostCalculator.createTieredRecipe(params)
    local tier = params.tier or 1
    local ingredients = CostCalculator.processIngredients(
        params.ingredients,
        tier,
        { isBulkItem = params.isBulkItem }
    )
    
    local recipe = {
        type = "recipe",
        name = params.name,
        enabled = params.enabled or false,
        ingredients = ingredients,
        results = params.results or {{ type = "item", name = params.name, amount = 1 }},
        energy_required = CostCalculator.scaleCraftingTime(params.energy_required or 0.5)
    }
    
    return recipe
end

-- Log current cost configuration (for debugging)
function CostCalculator.logConfig()
    log("=== 5Dim's Cost Calculator Config ===")
    log("Machine Work Factor: " .. CostConfig.getMachineWorkFactor())
    log("Machine Energy Factor: " .. CostConfig.getMachineEnergyFactor())
    log("Machine Recipe Factor: " .. CostConfig.getMachineRecipeFactor())
    log("Machine Tech Factor: " .. CostConfig.getMachineTechFactor())
    log("Time Multiplier: " .. CostConfig.getCraftingTimeMultiplier())
    log("Space Age Materials: " .. tostring(CostConfig.shouldUseSpaceAgeMaterials()))
    log("Space Age Science Packs: " .. tostring(CostConfig.shouldUseSpaceAgeSciencePacks()))
    log("======================================")
end

return CostCalculator
