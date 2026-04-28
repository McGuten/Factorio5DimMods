-------------------------------------------------------------------------------
-- 5Dim's Mod - Cost Configuration
-- Centralized cost configuration for all 5Dim's modules
-------------------------------------------------------------------------------

local CostConfig = {}

-------------------------------------------------------------------------------
-- SETTINGS
-------------------------------------------------------------------------------

-- Space Age integration toggles (separate for materials and science packs)
CostConfig.spaceAgeMaterials_enabled = settings.startup["5d-space-age-materials"].value
CostConfig.spaceAgeSciencePacks_enabled = settings.startup["5d-space-age-science-packs"].value

-- Custom multipliers from settings
CostConfig.techMultiplier = settings.startup["5d-tech-cost-multiplier"].value
CostConfig.recipeMultiplier = settings.startup["5d-recipe-cost-multiplier"].value
CostConfig.craftingTimeMultiplier = settings.startup["5d-crafting-time-multiplier"].value

-- Check if Space Age is installed
CostConfig.hasSpaceAge = mods["space-age"] ~= nil

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
    [9] = {
        material = "superconductor",
        amount = 5
    },
    [10] = {
        material = "quantum-processor",
        amount = 10
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

-- Check if Space Age materials should be used in recipes
-- Requires: Space Age mod installed AND materials integration setting enabled
function CostConfig.shouldUseSpaceAgeMaterials()
    return CostConfig.hasSpaceAge and CostConfig.spaceAgeMaterials_enabled
end

-- Check if Space Age science packs should be used in technologies
-- Requires: Space Age mod installed AND science packs integration setting enabled
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
    log("  Space Age Materials: " .. tostring(CostConfig.spaceAgeMaterials_enabled))
    log("  Space Age Science Packs: " .. tostring(CostConfig.spaceAgeSciencePacks_enabled))
    log("  Recipe Multiplier: " .. CostConfig.getRecipeMultiplier())
    log("  Tech Multiplier: " .. CostConfig.getTechMultiplier())
    log("  Crafting Time Multiplier: " .. CostConfig.getCraftingTimeMultiplier())
    log("  Use Space Age Materials: " .. tostring(CostConfig.shouldUseSpaceAgeMaterials()))
    log("  Use Space Age Science Packs: " .. tostring(CostConfig.shouldUseSpaceAgeSciencePacks()))
end

return CostConfig
