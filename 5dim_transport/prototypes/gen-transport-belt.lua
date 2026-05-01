-------------------------------------------------------------------------------
-- 5Dim's Transport - Transport Belt Generation
-- Uses the centralized cost system from 5dim_core
-- 
-- Note: This file handles complex vanilla/Space Age tier mappings
-- and generates multiple entity types per tier (belt, underground, splitter, loader)
-------------------------------------------------------------------------------

require("__5dim_core__.lib.transport.generation-transport-belt")

local CostCalculator = require("__5dim_core__.lib.costs.calculator")

-------------------------------------------------------------------------------
-- BASE CONFIGURATION
-------------------------------------------------------------------------------

local transportBeltSpeed = 0.03125
local baseTechCount = 200

-------------------------------------------------------------------------------
-- HELPER FUNCTION: Get belt name for previous tier
-------------------------------------------------------------------------------

local function getPrevBeltName(tier)
    if tier == 1 then return nil end
    if tier == 2 then return "transport-belt" end
    if tier == 3 then return "fast-transport-belt" end
    if tier == 4 then return "express-transport-belt" end
    if tier == 5 then return mods["space-age"] and "turbo-transport-belt" or "5d-transport-belt-04" end
    return "5d-transport-belt-" .. string.format("%02d", tier - 1)
end

local function getPrevUndergroundName(tier)
    if tier == 1 then return nil end
    if tier == 2 then return "underground-belt" end
    if tier == 3 then return "fast-underground-belt" end
    if tier == 4 then return "express-underground-belt" end
    if tier == 5 then return mods["space-age"] and "turbo-underground-belt" or "5d-underground-belt-04" end
    return "5d-underground-belt-" .. string.format("%02d", tier - 1)
end

local function getPrevSplitterName(tier)
    if tier == 1 then return nil end
    if tier == 2 then return "splitter" end
    if tier == 3 then return "fast-splitter" end
    if tier == 4 then return "express-splitter" end
    if tier == 5 then return mods["space-age"] and "turbo-splitter" or "5d-splitter-04" end
    return "5d-splitter-" .. string.format("%02d", tier - 1)
end

local function getPrevLoaderName(tier)
    if tier == 1 then return nil end
    if tier == 2 then return "loader" end
    if tier == 3 then return "fast-loader" end
    if tier == 4 then return "express-loader" end
    if tier == 5 then return mods["space-age"] and "turbo-loader" or "5d-loader-04" end
    return "5d-loader-" .. string.format("%02d", tier - 1)
end

-------------------------------------------------------------------------------
-- TIER CONFIGURATION
-- Handles vanilla vs Space Age differences
-------------------------------------------------------------------------------

local function getTierConfig(tier)
    local orders = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j" }
    
    -- Tiers 1-4 have special handling for vanilla entities
    if tier == 1 then
        return {
            copy = { name = { preName = "", postName = "" }, tech = "logistics" },
            name = { preName = "" },
            speed = transportBeltSpeed * 1,
            new = false,
            liquids = false,
            order = orders[tier],
            isVanilla = true
        }
    elseif tier == 2 then
        return {
            copy = { name = { preName = "fast-", postName = "" }, tech = "logistics" },
            name = { preName = "fast-" },
            speed = transportBeltSpeed * 2,
            new = false,
            liquids = false,
            order = orders[tier],
            isVanilla = true
        }
    elseif tier == 3 then
        return {
            copy = { name = { preName = "express-", postName = "" }, tech = "logistics" },
            name = { preName = "express-" },
            speed = transportBeltSpeed * 3,
            new = false,
            liquids = true,
            order = orders[tier],
            isVanilla = true
        }
    elseif tier == 4 then
        -- With Space Age: use turbo belts as tier 4 (vanilla Space Age)
        -- Without Space Age: generate 5dim tier 4
        if mods["space-age"] then
            return {
                copy = { name = { preName = "turbo-", postName = "" }, tech = "turbo-transport-belt" },
                name = { preName = "turbo-" },
                speed = transportBeltSpeed * 4,
                new = false,
                liquids = true,
                order = orders[tier],
                isVanilla = true
            }
        else
            return {
                copy = { name = { preName = "express-", postName = "" }, tech = "logistics" },
                name = { preName = "" },
                speed = transportBeltSpeed * 4,
                new = true,
                liquids = true,
                order = orders[tier],
                isVanilla = false
            }
        end
    elseif tier == 5 then
        return {
            copy = { name = { preName = "express-", postName = "" }, tech = "logistics-3" },
            name = { preName = "" },
            speed = transportBeltSpeed * 5,
            new = true,
            liquids = true,
            order = orders[tier],
            isVanilla = false
        }
    else
        return {
            copy = { name = { preName = "express-", postName = "" }, tech = "logistics-3" },
            name = { preName = "" },
            speed = transportBeltSpeed * tier,
            new = true,
            liquids = true,
            order = orders[tier],
            isVanilla = false
        }
    end
end

-------------------------------------------------------------------------------
-- NEXT UPDATE CONFIGURATION
-------------------------------------------------------------------------------

local function getNextUpdate(tier)
    if tier >= 10 then return {} end
    
    local nextTier = string.format("%02d", tier + 1)
    
    -- Special handling for vanilla tiers
    if tier == 1 then
        return {
            transportBelt = "fast-transport-belt",
            groundBelt = "fast-underground-belt",
            groundBelt30 = "5d-fast-underground-belt-30-02",
            groundBelt50 = "5d-fast-underground-belt-50-02",
            splitter = "fast-splitter",
            loader = "fast-loader",
            loader1 = "5d-loader-1x1-02"
        }
    elseif tier == 2 then
        return {
            transportBelt = "express-transport-belt",
            groundBelt = "express-underground-belt",
            groundBelt30 = "5d-express-underground-belt-30-03",
            groundBelt50 = "5d-express-underground-belt-50-03",
            splitter = "express-splitter",
            loader = "express-loader",
            loader1 = "5d-loader-1x1-03"
        }
    elseif tier == 3 then
        -- With Space Age: point to turbo belts for main entities
        -- Extended variants (30, 50, 1x1) point to tier 4 which uses 5d naming (not turbo-)
        -- Without Space Age: point to 5dim tier 4
        if mods["space-age"] then
            return {
                transportBelt = "turbo-transport-belt",
                groundBelt = "turbo-underground-belt",
                groundBelt30 = "5d-underground-belt-30-04",  -- Tier 4 uses 5d naming
                groundBelt50 = "5d-underground-belt-50-04",  -- Tier 4 uses 5d naming
                splitter = "turbo-splitter",
                loader = "turbo-loader",                     -- turbo-loader exists in Space Age
                loader1 = "5d-loader-1x1-04"                 -- Tier 4 uses 5d naming
            }
        else
            return {
                transportBelt = "5d-transport-belt-04",
                groundBelt = "5d-underground-belt-04",
                groundBelt30 = "5d-underground-belt-30-04",
                groundBelt50 = "5d-underground-belt-50-04",
                splitter = "5d-splitter-04",
                loader = "5d-loader-04",
                loader1 = "5d-loader-1x1-04"
            }
        end
    else
        return {
            transportBelt = "5d-transport-belt-" .. nextTier,
            groundBelt = "5d-underground-belt-" .. nextTier,
            groundBelt30 = "5d-underground-belt-30-" .. nextTier,
            groundBelt50 = "5d-underground-belt-50-" .. nextTier,
            splitter = "5d-splitter-" .. nextTier,
            loader = "5d-loader-" .. nextTier,
            loader1 = "5d-loader-1x1-" .. nextTier
        }
    end
end

-------------------------------------------------------------------------------
-- INGREDIENTS CONFIGURATION
-------------------------------------------------------------------------------

local function getIngredients(tier)
    local tierNum = string.format("%02d", tier)
    local prevTierNum = string.format("%02d", tier - 1)
    
    -- Tier 1 - Base vanilla
    if tier == 1 then
        return {
            transportBelt = {
                { type = "item", name = "iron-plate", amount = 1 },
                { type = "item", name = "iron-gear-wheel", amount = 1 }
            },
            groundBelt = {
                { type = "item", name = "iron-plate", amount = 10 },
                { type = "item", name = "transport-belt", amount = 5 }
            },
            groundBelt30 = {
                { type = "item", name = "iron-plate", amount = 10 },
                { type = "item", name = "transport-belt", amount = 30 }
            },
            groundBelt50 = {
                { type = "item", name = "iron-plate", amount = 10 },
                { type = "item", name = "transport-belt", amount = 50 }
            },
            splitter = {
                { type = "item", name = "electronic-circuit", amount = 5 },
                { type = "item", name = "iron-plate", amount = 5 },
                { type = "item", name = "transport-belt", amount = 4 }
            },
            loader = {
                { type = "item", name = "inserter", amount = 5 },
                { type = "item", name = "electronic-circuit", amount = 5 },
                { type = "item", name = "iron-gear-wheel", amount = 5 },
                { type = "item", name = "iron-plate", amount = 5 },
                { type = "item", name = "transport-belt", amount = 5 }
            },
            loader1 = {
                { type = "item", name = "inserter", amount = 5 },
                { type = "item", name = "electronic-circuit", amount = 5 },
                { type = "item", name = "iron-gear-wheel", amount = 5 },
                { type = "item", name = "iron-plate", amount = 5 },
                { type = "item", name = "transport-belt", amount = 5 }
            }
        }
    -- Tier 2 - Fast
    elseif tier == 2 then
        return {
            transportBelt = {
                { type = "item", name = "iron-gear-wheel", amount = 5 },
                { type = "item", name = "transport-belt", amount = 1 }
            },
            groundBelt = {
                { type = "item", name = "iron-gear-wheel", amount = 40 },
                { type = "item", name = "underground-belt", amount = 2 }
            },
            groundBelt30 = {
                { type = "item", name = "iron-gear-wheel", amount = 40 },
                { type = "item", name = "5d-underground-belt-30-01", amount = 2 }
            },
            groundBelt50 = {
                { type = "item", name = "iron-gear-wheel", amount = 40 },
                { type = "item", name = "5d-underground-belt-50-01", amount = 2 }
            },
            splitter = {
                { type = "item", name = "splitter", amount = 1 },
                { type = "item", name = "iron-gear-wheel", amount = 10 },
                { type = "item", name = "electronic-circuit", amount = 10 }
            },
            loader = {
                { type = "item", name = "fast-transport-belt", amount = 5 },
                { type = "item", name = "loader", amount = 1 }
            },
            loader1 = {
                { type = "item", name = "fast-transport-belt", amount = 5 },
                { type = "item", name = "5d-loader-1x1-01", amount = 1 }
            }
        }
    -- Tier 3 - Express (requires lubricant)
    elseif tier == 3 then
        return {
            transportBelt = {
                { type = "item", name = "iron-gear-wheel", amount = 10 },
                { type = "item", name = "fast-transport-belt", amount = 1 },
                { type = "fluid", name = "lubricant", amount = 20 }
            },
            groundBelt = {
                { type = "item", name = "iron-gear-wheel", amount = 80 },
                { type = "item", name = "fast-underground-belt", amount = 2 },
                { type = "fluid", name = "lubricant", amount = 40 }
            },
            groundBelt30 = {
                { type = "item", name = "iron-gear-wheel", amount = 80 },
                { type = "item", name = "5d-fast-underground-belt-30-02", amount = 2 },
                { type = "fluid", name = "lubricant", amount = 40 }
            },
            groundBelt50 = {
                { type = "item", name = "iron-gear-wheel", amount = 80 },
                { type = "item", name = "5d-fast-underground-belt-50-02", amount = 2 },
                { type = "fluid", name = "lubricant", amount = 40 }
            },
            splitter = {
                { type = "item", name = "fast-splitter", amount = 1 },
                { type = "item", name = "iron-gear-wheel", amount = 10 },
                { type = "item", name = "advanced-circuit", amount = 10 },
                { type = "fluid", name = "lubricant", amount = 80 }
            },
            loader = {
                { type = "item", name = "express-transport-belt", amount = 5 },
                { type = "item", name = "fast-loader", amount = 1 }
            },
            loader1 = {
                { type = "item", name = "express-transport-belt", amount = 5 },
                { type = "item", name = "5d-loader-1x1-02", amount = 1 }
            }
        }
    -- Tier 4 - Turbo (Space Age) or 5d-04 (vanilla)
    elseif tier == 4 then
        local prevBelt = "express-transport-belt"
        local prevUnderground = "express-underground-belt"
        local prevUnderground30 = "5d-express-underground-belt-30-03"
        local prevUnderground50 = "5d-express-underground-belt-50-03"
        local prevSplitter = "express-splitter"
        local prevLoader = "express-loader"
        local prevLoader1 = "5d-loader-1x1-03"
        local currentBelt = mods["space-age"] and "turbo-transport-belt" or "5d-transport-belt-04"
        
        return {
            transportBelt = {
                { type = "item", name = "iron-gear-wheel", amount = 15 },
                { type = "item", name = prevBelt, amount = 1 },
                { type = "fluid", name = "lubricant", amount = 20 }
            },
            groundBelt = {
                { type = "item", name = "iron-gear-wheel", amount = 80 },
                { type = "item", name = prevUnderground, amount = 2 },
                { type = "fluid", name = "lubricant", amount = 40 }
            },
            groundBelt30 = {
                { type = "item", name = "iron-gear-wheel", amount = 80 },
                { type = "item", name = prevUnderground30, amount = 2 },
                { type = "fluid", name = "lubricant", amount = 40 }
            },
            groundBelt50 = {
                { type = "item", name = "iron-gear-wheel", amount = 80 },
                { type = "item", name = prevUnderground50, amount = 2 },
                { type = "fluid", name = "lubricant", amount = 40 }
            },
            splitter = {
                { type = "item", name = prevSplitter, amount = 1 },
                { type = "item", name = "iron-gear-wheel", amount = 10 },
                { type = "item", name = "advanced-circuit", amount = 10 },
                { type = "fluid", name = "lubricant", amount = 80 }
            },
            loader = {
                { type = "item", name = currentBelt, amount = 5 },
                { type = "item", name = prevLoader, amount = 1 }
            },
            loader1 = {
                { type = "item", name = currentBelt, amount = 5 },
                { type = "item", name = prevLoader1, amount = 1 }
            }
        }
    -- Tier 5+
    else
        local prevBelt, prevUnderground, prevUnderground30, prevUnderground50, prevSplitter, prevLoader, prevLoader1
        local currentBelt = "5d-transport-belt-" .. tierNum
        
        if tier == 5 then
            -- With Space Age: use turbo as previous tier for main belts
            -- Extended variants use tier 4 5dim naming (not turbo-)
            if mods["space-age"] then
                prevBelt = "turbo-transport-belt"
                prevUnderground = "turbo-underground-belt"
                prevUnderground30 = "5d-underground-belt-30-04"  -- Tier 4 uses 5d naming
                prevUnderground50 = "5d-underground-belt-50-04"  -- Tier 4 uses 5d naming
                prevSplitter = "turbo-splitter"
                prevLoader = "turbo-loader"                      -- turbo-loader exists in Space Age
                prevLoader1 = "5d-loader-1x1-04"                 -- Tier 4 uses 5d naming
            else
                prevBelt = "5d-transport-belt-04"
                prevUnderground = "5d-underground-belt-04"
                prevUnderground30 = "5d-underground-belt-30-04"
                prevUnderground50 = "5d-underground-belt-50-04"
                prevSplitter = "5d-splitter-04"
                prevLoader = "5d-loader-04"
                prevLoader1 = "5d-loader-1x1-04"
            end
        else
            prevBelt = "5d-transport-belt-" .. prevTierNum
            prevUnderground = "5d-underground-belt-" .. prevTierNum
            prevUnderground30 = "5d-underground-belt-30-" .. prevTierNum
            prevUnderground50 = "5d-underground-belt-50-" .. prevTierNum
            prevSplitter = "5d-splitter-" .. prevTierNum
            prevLoader = "5d-loader-" .. prevTierNum
            prevLoader1 = "5d-loader-1x1-" .. prevTierNum
        end
        
        return {
            transportBelt = {
                { type = "item", name = "iron-gear-wheel", amount = 15 },
                { type = "item", name = prevBelt, amount = 1 },
                { type = "fluid", name = "lubricant", amount = 20 }
            },
            groundBelt = {
                { type = "item", name = "iron-gear-wheel", amount = 80 },
                { type = "item", name = prevUnderground, amount = 2 },
                { type = "fluid", name = "lubricant", amount = 40 }
            },
            groundBelt30 = {
                { type = "item", name = "iron-gear-wheel", amount = 80 },
                { type = "item", name = prevUnderground30, amount = 2 },
                { type = "fluid", name = "lubricant", amount = 40 }
            },
            groundBelt50 = {
                { type = "item", name = "iron-gear-wheel", amount = 80 },
                { type = "item", name = prevUnderground50, amount = 2 },
                { type = "fluid", name = "lubricant", amount = 40 }
            },
            splitter = {
                { type = "item", name = prevSplitter, amount = 1 },
                { type = "item", name = "iron-gear-wheel", amount = 10 },
                { type = "item", name = "advanced-circuit", amount = 10 },
                { type = "fluid", name = "lubricant", amount = 80 }
            },
            loader = {
                { type = "item", name = currentBelt, amount = 5 },
                { type = "item", name = prevLoader, amount = 1 }
            },
            loader1 = {
                { type = "item", name = currentBelt, amount = 5 },
                { type = "item", name = prevLoader1, amount = 1 }
            }
        }
    end
end

-------------------------------------------------------------------------------
-- TECHNOLOGY CONFIGURATION
-------------------------------------------------------------------------------

local function getTech(tier)
    -- Vanilla tiers don't need tech (1-3)
    if tier <= 3 then return nil end
    
    -- With Space Age, tier 4 needs a bridge technology that depends on turbo-transport-belt
    -- This ensures logistics-4 exists so logistics-5 can have it as prerequisite
    if tier == 4 and mods["space-age"] then
        return {
            number = 4,
            count = baseTechCount,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "space-science-pack", 1 },
                { "metallurgic-science-pack", 1 }
            },
            prerequisites = { "turbo-transport-belt" },
            noRecipes = true  -- Flag to indicate no recipes should be unlocked
        }
    end
    
    local techConfigs = {
        [4] = {
            number = 4,
            count = baseTechCount * 2,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "logistics-3", "utility-science-pack" }
        },
        [5] = {
            number = 5,
            count = baseTechCount * 3,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "logistics-4" }
        },
        [6] = {
            number = 6,
            count = baseTechCount * 4,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "logistics-5" }
        },
        [7] = {
            number = 7,
            count = baseTechCount * 5,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "logistics-6" }
        },
        [8] = {
            number = 8,
            count = baseTechCount * 6,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "logistics-7" }
        },
        [9] = {
            number = 9,
            count = baseTechCount * 7,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "logistics-8" }
        },
        [10] = {
            number = 10,
            count = baseTechCount * 8,
            packs = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 }
            },
            prerequisites = { "logistics-9" }
        }
    }

    local cfg = techConfigs[tier]
    if cfg then
        -- Inject Space Age planet science packs (metallurgic / electromagnetic / cryogenic)
        -- following the project-wide progression in CostConfig.spaceAgeSciencePacks.
        cfg.packs = CostCalculator.getTechPacks(cfg.packs, tier)
    end
    return cfg
end

-------------------------------------------------------------------------------
-- GENERATION LOOP
-------------------------------------------------------------------------------

for tier = 1, 10 do
    local config = getTierConfig(tier)
    local tierNum = string.format("%02d", tier)
    
    genTransportBelts {
        copy = config.copy,
        name = config.name,
        speed = config.speed,
        new = config.new,
        liquids = config.liquids,
        number = tierNum,
        nextUpdate = getNextUpdate(tier),
        order = config.order,
        ingredients = getIngredients(tier),
        tech = getTech(tier)
    }
end
