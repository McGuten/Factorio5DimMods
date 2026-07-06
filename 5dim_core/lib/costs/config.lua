-------------------------------------------------------------------------------
-- 5Dim's Mod - Cost Configuration
-- Centralized cost configuration for all 5Dim's modules
-------------------------------------------------------------------------------

local CostConfig = {}

-------------------------------------------------------------------------------
-- SETTINGS
-------------------------------------------------------------------------------

-- Space Age integration toggle (single option for planetary materials and science packs)
CostConfig.spaceAgeIntegration_enabled = settings.startup["5d-space-age-materials"].value
CostConfig.spaceAgeMaterials_enabled = CostConfig.spaceAgeIntegration_enabled
CostConfig.spaceAgeSciencePacks_enabled = CostConfig.spaceAgeIntegration_enabled

-- Machine progression settings
CostConfig.machineWorkFactor = settings.startup["5d-machine-work-factor"].value
CostConfig.machineEnergyFactor = settings.startup["5d-machine-energy-factor"].value
CostConfig.machineRecipeFactor = settings.startup["5d-machine-recipe-factor"].value
CostConfig.machineTechFactor = settings.startup["5d-machine-tech-factor"].value
CostConfig.machineT10NextTierWork = settings.startup["5d-machine-t10-next-tier-work"].value
CostConfig.machineT10ExtraModuleSlots = settings.startup["5d-machine-t10-extra-module-slots"].value

-- techMultiplier retained as a neutral compatibility value: technology cost is
-- controlled by the 5d-machine-tech-factor progression setting, not a global
-- tech multiplier (there is no 5d-tech-cost-multiplier setting).
CostConfig.techMultiplier = 1.0
-- Global recipe cost multiplier (player-facing). Applies to legacy ingredient
-- scaling and Space Age material amounts; machine families that use
-- calculateMachineRecipeAmount are governed by 5d-machine-recipe-factor instead.
CostConfig.recipeMultiplier = settings.startup["5d-recipe-cost-multiplier"].value
CostConfig.craftingTimeMultiplier = settings.startup["5d-crafting-time-multiplier"].value

-- Check if Space Age is installed
CostConfig.hasSpaceAge = mods["space-age"] ~= nil

-------------------------------------------------------------------------------
-- INTERNAL RECIPE RARITY POLICY
-- One global player-facing recipe factor, with fixed internal rarity weights to
-- keep exotic deltas from exploding in quantity.
-------------------------------------------------------------------------------

CostConfig.recipeRarityWeights = {
    common = 1.0,
    processed = 0.75,
    advanced = 0.55,
    exotic = 0.25,
    fluid = 0.45
}

CostConfig.recipeRarityByName = {
    ["advanced-circuit"] = "processed",
    ["battery"] = "processed",
    ["concrete"] = "processed",
    ["electric-engine-unit"] = "processed",
    ["engine-unit"] = "processed",
    ["molten-iron"] = "processed",
    ["molten-copper"] = "processed",

    ["bioflux"] = "advanced",
    ["carbon-fiber"] = "advanced",
    ["electrolyte"] = "advanced",
    ["holmium-plate"] = "advanced",
    ["lithium-plate"] = "advanced",
    ["low-density-structure"] = "advanced",
    ["processing-unit"] = "advanced",
    ["refined-concrete"] = "advanced",
    ["speed-module-2"] = "advanced",
    ["productivity-module-2"] = "advanced",
    ["tungsten-carbide"] = "advanced",
    ["tungsten-plate"] = "advanced",
    ["uranium-235"] = "advanced",
    ["fluorine"] = "advanced",

    ["capture-robot-rocket"] = "exotic",
    ["fluoroketone-cold"] = "exotic",
    ["fluoroketone-hot"] = "exotic",
    ["fusion-power-cell"] = "exotic",
    ["productivity-module-3"] = "exotic",
    ["quantum-processor"] = "exotic",
    ["speed-module-3"] = "exotic",
    ["supercapacitor"] = "exotic",
    ["superconductor"] = "exotic"
}

-------------------------------------------------------------------------------
-- TIER SCALING
-- Progressive scaling based on tier number
-------------------------------------------------------------------------------

-- Returns a multiplier for a given tier (1-10)
-- Uses a slightly exponential curve for better balance
-- Tier 1: 1.0x, Tier 5: 2.0x, Tier 10: 4.0x
function CostConfig.getTierMultiplier(tier)
    if tier <= 1 then
        return 1.0
    end
    -- Formula: 1 + (tier-1)*0.2 + ((tier-1)/10)^2
    return 1.0 + (tier - 1) * 0.2 + ((tier - 1) / 10) ^ 2
end

-- Returns the tech count scaling for a given tier
-- More aggressive scaling for late-game techs
-- Tier 1: baseCount, Tier 5: baseCount*2.5, Tier 10: baseCount*5
function CostConfig.getTechCountMultiplier(tier)
    if tier <= 1 then
        return 1.0
    end
    -- Quadratic scaling: tier * (1 + tier/20)
    return tier * (1 + tier / 20)
end

-------------------------------------------------------------------------------
-- SPACE AGE MATERIALS BY TIER
-- Materials from different planets required for high-tier items
-- Only used when Space Age is installed AND integration is enabled
-------------------------------------------------------------------------------

CostConfig.spaceAgeMaterials = {
    -- Tier 5-6: Vulcanus materials
    [5] = {
        material = "tungsten-plate",
        amount = 10
    },
    [6] = {
        material = "tungsten-carbide",
        amount = 10
    },
    -- Tier 7-8: Fulgora materials
    [7] = {
        material = "supercapacitor",
        amount = 5
    },
    [8] = {
        material = "holmium-plate",
        amount = 10
    },
    -- Tier 9-10: Aquilo materials
    -- These are among the most expensive items in the game and apply to every
    -- non-bulk family at t9/t10, so the absolute amounts are kept low to avoid
    -- a tedious end-game grind.
    [9] = {
        material = "superconductor",
        amount = 2
    },
    [10] = {
        material = "quantum-processor",
        amount = 3
    }
}

-- Smaller amounts for items that are produced in bulk (robots, ammo, etc.)
CostConfig.spaceAgeMaterialsBulk = {
    [5] = {
        material = "tungsten-plate",
        amount = 2
    },
    [6] = {
        material = "tungsten-carbide",
        amount = 2
    },
    [7] = {
        material = "supercapacitor",
        amount = 1
    },
    [8] = {
        material = "holmium-plate",
        amount = 2
    },
    [9] = {
        material = "superconductor",
        amount = 1
    },
    [10] = {
        material = "quantum-processor",
        amount = 1
    }
}

-------------------------------------------------------------------------------
-- SPACE AGE SCIENCE PACKS BY TIER
-- Additional science packs required when Space Age integration is enabled
-------------------------------------------------------------------------------

CostConfig.spaceAgeSciencePacks = {
    -- Tier 5-6: Vulcanus science (metallurgic)
    [5] = { "metallurgic-science-pack", 1 },
    [6] = { "metallurgic-science-pack", 1 },
    -- Tier 7-8: Fulgora science (electromagnetic)
    [7] = { "electromagnetic-science-pack", 1 },
    [8] = { "electromagnetic-science-pack", 1 },
    -- Tier 9-10: Aquilo science (cryogenic)
    [9] = { "cryogenic-science-pack", 1 },
    [10] = { "cryogenic-science-pack", 1 }
}

-------------------------------------------------------------------------------
-- HELPER FUNCTIONS
-------------------------------------------------------------------------------

-- Check if Space Age planetary integration should add materials to recipes
function CostConfig.shouldUseSpaceAgeMaterials()
    return CostConfig.hasSpaceAge and CostConfig.spaceAgeMaterials_enabled
end

-- Check if Space Age planetary integration should add science packs to technologies
function CostConfig.shouldUseSpaceAgeSciencePacks()
    return CostConfig.hasSpaceAge and CostConfig.spaceAgeSciencePacks_enabled
end

-- Get the final recipe multiplier (from setting)
function CostConfig.getRecipeMultiplier()
    return CostConfig.recipeMultiplier
end

-- Get the final tech multiplier (from setting)
function CostConfig.getTechMultiplier()
    return CostConfig.techMultiplier
end

-- Get the final crafting time multiplier (from setting)
function CostConfig.getCraftingTimeMultiplier()
    return CostConfig.craftingTimeMultiplier
end

function CostConfig.getMachineWorkFactor()
    return CostConfig.machineWorkFactor
end

function CostConfig.getMachineEnergyFactor()
    return CostConfig.machineEnergyFactor
end

function CostConfig.getMachineRecipeFactor()
    return CostConfig.machineRecipeFactor
end

function CostConfig.getMachineTechFactor()
    return CostConfig.machineTechFactor
end

function CostConfig.shouldUseT10NextTierWork()
    return CostConfig.machineT10NextTierWork
end

function CostConfig.getT10ExtraModuleSlots()
    return CostConfig.machineT10ExtraModuleSlots
end

function CostConfig.getRecipeRarityWeight(ingredientType, ingredientName)
    local rarityKey = CostConfig.recipeRarityByName[ingredientName]

    if rarityKey then
        return CostConfig.recipeRarityWeights[rarityKey]
    end

    if ingredientType == "fluid" then
        return CostConfig.recipeRarityWeights.fluid
    end

    return CostConfig.recipeRarityWeights.common
end

-- Get Space Age material for a tier (returns nil if not applicable)
function CostConfig.getSpaceAgeMaterial(tier, isBulk)
    if not CostConfig.shouldUseSpaceAgeMaterials() then
        return nil
    end
    
    if isBulk then
        return CostConfig.spaceAgeMaterialsBulk[tier]
    else
        return CostConfig.spaceAgeMaterials[tier]
    end
end

-- Get Space Age science pack for a tier (returns nil if not applicable)
function CostConfig.getSpaceAgeSciencePack(tier)
    if not CostConfig.shouldUseSpaceAgeSciencePacks() then
        return nil
    end
    return CostConfig.spaceAgeSciencePacks[tier]
end

-------------------------------------------------------------------------------
-- DEBUG INFO
-------------------------------------------------------------------------------

function CostConfig.printDebugInfo()
    log("5Dim's Cost Config:")
    log("  Has Space Age: " .. tostring(CostConfig.hasSpaceAge))
    log("  Space Age Planetary Integration: " .. tostring(CostConfig.spaceAgeIntegration_enabled))
    log("  Machine Work Factor: " .. CostConfig.getMachineWorkFactor())
    log("  Machine Energy Factor: " .. CostConfig.getMachineEnergyFactor())
    log("  Machine Recipe Factor: " .. CostConfig.getMachineRecipeFactor())
    log("  Machine Tech Factor: " .. CostConfig.getMachineTechFactor())
    log("  T10 Uses Next Tier Work: " .. tostring(CostConfig.shouldUseT10NextTierWork()))
    log("  T10 Extra Module Slots: " .. CostConfig.getT10ExtraModuleSlots())
    log("  Crafting Time Multiplier: " .. CostConfig.getCraftingTimeMultiplier())
    log("  Use Space Age Materials: " .. tostring(CostConfig.shouldUseSpaceAgeMaterials()))
    log("  Use Space Age Science Packs: " .. tostring(CostConfig.shouldUseSpaceAgeSciencePacks()))
end

return CostConfig
