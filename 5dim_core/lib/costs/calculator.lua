-------------------------------------------------------------------------------
-- 5Dim's Mod - Cost Calculator
-- Functions to calculate recipe ingredients and technology costs
-------------------------------------------------------------------------------

local CostConfig = require("__5dim_core__.lib.costs.config")

local CostCalculator = {}

-------------------------------------------------------------------------------
-- INGREDIENT SCALING
-------------------------------------------------------------------------------

-- Scale a single ingredient amount based on tier and mode
-- @param baseAmount: The base amount of the ingredient
-- @param tier: The tier number (1-10)
-- @param isBulkItem: If true, uses smaller scaling for bulk-produced items
-- @return: The scaled amount (rounded up)
function CostCalculator.scaleIngredientAmount(baseAmount, tier, isBulkItem)
    local modeMultiplier = CostConfig.getRecipeMultiplier()
    local tierMultiplier = CostConfig.getTierMultiplier(tier)
    
    local scaled = baseAmount * modeMultiplier
    
    -- For bulk items (robots, ammo), use gentler scaling
    if isBulkItem then
        scaled = baseAmount * modeMultiplier * 0.5
    end
    
    return math.ceil(scaled)
end

-- Scale all ingredients in a recipe
-- @param ingredients: Table of ingredients { {type, name, amount}, ... }
-- @param tier: The tier number (1-10)
-- @param isBulkItem: If true, uses smaller scaling
-- @return: New table with scaled ingredients
function CostCalculator.scaleIngredients(ingredients, tier, isBulkItem)
    local scaled = {}
    local modeMultiplier = CostConfig.getRecipeMultiplier()
    
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
        
        table.insert(ingredients, {
            type = "item",
            name = spaceAgeMaterial.material,
            amount = scaledAmount
        })
    end
    
    return ingredients
end

-- Complete ingredient processing: scale and add Space Age materials
-- @param baseIngredients: Original ingredients
-- @param tier: Tier number (1-10)
-- @param options: Table with options { isBulkItem = false, skipTierScaling = false, skipSpaceAgeMaterials = false }
-- @return: Processed ingredients
function CostCalculator.processIngredients(baseIngredients, tier, options)
    options = options or {}
    local isBulkItem = options.isBulkItem or false
    local skipTierScaling = options.skipTierScaling or false
    local skipSpaceAgeMaterials = options.skipSpaceAgeMaterials or false
    
    local ingredients = {}
    
    -- Deep copy and scale ingredients
    for i, ing in ipairs(baseIngredients) do
        local amount = ing.amount
        
        -- Apply mode multiplier (expensive = x3)
        local modeMultiplier = CostConfig.getRecipeMultiplier()
        amount = math.ceil(amount * modeMultiplier)
        
        -- For bulk items, reduce the multiplier effect
        if isBulkItem and modeMultiplier > 1 then
            amount = math.ceil(ing.amount * (1 + (modeMultiplier - 1) * 0.5))
        end
        
        table.insert(ingredients, {
            type = ing.type,
            name = ing.name,
            amount = amount
        })
    end
    
    -- Add Space Age materials (unless explicitly skipped)
    if not skipSpaceAgeMaterials then
        ingredients = CostCalculator.addSpaceAgeMaterials(ingredients, tier, isBulkItem)
    end
    
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
    local modeMultiplier = CostConfig.getTechMultiplier()
    local tierMultiplier = CostConfig.getTechCountMultiplier(tier)
    
    return math.ceil(baseCount * tierMultiplier * modeMultiplier)
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
-- @param options: Optional table. Use spaceAgePackThresholds to override the
-- default Space Age science progression for specific infrastructure families.
-- @return: Science packs with Space Age additions
function CostCalculator.getTechPacks(basePacks, tier, options)
    options = options or {}

    local packs = copyTechPacks(basePacks)

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
        return math.floor(baseEnergy)
    end
    -- Exponential scaling based on vanilla pattern
    -- Factor ~1.58 gives: T1=1x, T2=1.58x, T3=2.5x, T4=3.95x, T5=6.25x...
    -- This closely matches vanilla: 75 -> 150 -> 375 (ratios: 2x, 2.5x)
    local factor = 1.58
    local scaled = baseEnergy * (factor ^ (tier - 1))
    if preserveDecimals then
        return math.floor(scaled * 100) / 100  -- Round to 2 decimal places
    end
    return math.floor(scaled)
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
-- Based on Factorio vanilla pattern: pollution DECREASES with higher tiers
-- This represents improved efficiency of advanced machines
-- Tier 1: 4, Tier 2: 3, Tier 3: 2 (assembling machines)
-------------------------------------------------------------------------------

-- Scale pollution with efficiency improvements at higher tiers
-- Higher tier machines are more efficient and pollute less per unit of work
-- @param basePollution: Base pollution value (tier 1)
-- @param tier: Tier number (1-10)
-- @param minPollution: Minimum pollution value (default 0.5)
-- @return: Scaled pollution value
function CostCalculator.scalePollution(basePollution, tier, minPollution)
    minPollution = minPollution or 0.5
    if tier <= 1 then
        return basePollution
    end
    -- Pollution decreases by ~15-20% per tier (efficiency improvement)
    -- Factor 0.85 gives: T1=1x, T2=0.85x, T3=0.72x, T4=0.61x, T5=0.52x...
    local factor = 0.85
    local scaled = basePollution * (factor ^ (tier - 1))
    return math.max(minPollution, math.floor(scaled * 100) / 100)  -- Round to 2 decimals
end

-- Scale pollution with custom factor
-- @param basePollution: Base pollution value (tier 1)
-- @param tier: Tier number (1-10)
-- @param factor: Reduction factor per tier (default 0.85)
-- @param minPollution: Minimum pollution value (default 0.5)
-- @return: Scaled pollution value
function CostCalculator.scalePollutionCustom(basePollution, tier, factor, minPollution)
    factor = factor or 0.85
    minPollution = minPollution or 0.5
    if tier <= 1 then
        return basePollution
    end
    local scaled = basePollution * (factor ^ (tier - 1))
    return math.max(minPollution, math.floor(scaled * 100) / 100)
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
    log("Recipe Multiplier: " .. CostConfig.getRecipeMultiplier())
    log("Tech Multiplier: " .. CostConfig.getTechMultiplier())
    log("Time Multiplier: " .. CostConfig.getCraftingTimeMultiplier())
    log("Space Age Materials: " .. tostring(CostConfig.shouldUseSpaceAgeMaterials()))
    log("Space Age Science Packs: " .. tostring(CostConfig.shouldUseSpaceAgeSciencePacks()))
    log("======================================")
end

return CostCalculator
