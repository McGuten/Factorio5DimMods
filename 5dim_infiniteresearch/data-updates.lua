-- 5Dim's Infinite Research - Space Age science pack integration
-- When Space Age is active and the global integration setting is enabled,
-- late-game infinite techs added by this mod gain a staged planetary science
-- progression. The DLC-owned research-productivity technology is left intact.

if not mods["space-age"] then return end
if not settings.startup["5d-space-age-materials"].value then return end

local finalSpaceAgePacks = {
    "metallurgic-science-pack",
    "electromagnetic-science-pack",
    "cryogenic-science-pack"
}

local techProgressions = {
    ["crafting-speed-16"] = {
        packs = { "metallurgic-science-pack" },
        prerequisites = { "metallurgic-science-pack" }
    },
    ["crafting-speed-21"] = {
        packs = { "electromagnetic-science-pack" },
        prerequisites = { "electromagnetic-science-pack" }
    },
    ["crafting-speed-26"] = {
        packs = { "cryogenic-science-pack" },
        prerequisites = { "cryogenic-science-pack" }
    },
    ["mining-speed-16"] = {
        packs = { "metallurgic-science-pack" },
        prerequisites = { "metallurgic-science-pack" }
    },
    ["mining-speed-21"] = {
        packs = { "electromagnetic-science-pack" },
        prerequisites = { "electromagnetic-science-pack" }
    },
    ["mining-speed-26"] = {
        packs = { "cryogenic-science-pack" },
        prerequisites = { "cryogenic-science-pack" }
    },
    ["worker-robots-battery-6"] = {
        packs = { "electromagnetic-science-pack" },
        prerequisites = { "electromagnetic-science-pack" }
    },
    ["worker-robots-storage-4"] = {
        packs = { "electromagnetic-science-pack" },
        prerequisites = { "electromagnetic-science-pack" }
    },
    ["weapon-shooting-speed-7"] = {
        packs = finalSpaceAgePacks,
        prerequisites = finalSpaceAgePacks
    },
    ["laser-shooting-speed-8"] = {
        packs = finalSpaceAgePacks,
        prerequisites = finalSpaceAgePacks
    },
    ["research-speed-7"] = {
        packs = finalSpaceAgePacks,
        prerequisites = finalSpaceAgePacks
    },
    ["braking-force-8"] = {
        packs = finalSpaceAgePacks,
        prerequisites = finalSpaceAgePacks
    },
    ["inserter-capacity-bonus-8"] = {
        packs = finalSpaceAgePacks,
        prerequisites = finalSpaceAgePacks
    }
}

local function hasIngredient(ingredients, name)
    for _, pack in ipairs(ingredients) do
        if pack[1] == name or pack.name == name then
            return true
        end
    end
    return false
end

local function hasPrerequisite(prerequisites, name)
    for _, prerequisite in ipairs(prerequisites) do
        if prerequisite == name then
            return true
        end
    end
    return false
end

local function addIngredientIfMissing(ingredients, name)
    if not hasIngredient(ingredients, name) then
        table.insert(ingredients, { name, 1 })
    end
end

local function addPrerequisiteIfMissing(prerequisites, name)
    if not hasPrerequisite(prerequisites, name) then
        table.insert(prerequisites, name)
    end
end

for techName, config in pairs(techProgressions) do
    local tech = data.raw.technology[techName]
    if tech and tech.unit and tech.unit.ingredients then
        for _, pack in ipairs(config.packs or {}) do
            addIngredientIfMissing(tech.unit.ingredients, pack)
        end

        tech.prerequisites = tech.prerequisites or {}

        for _, prerequisite in ipairs(config.prerequisites or {}) do
            addPrerequisiteIfMissing(tech.prerequisites, prerequisite)
        end
    end
end
