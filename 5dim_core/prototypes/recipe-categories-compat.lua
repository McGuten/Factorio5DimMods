-------------------------------------------------------------------------------
-- 5Dim's Core - Compound recipe-category compatibility
--
-- Several 5Dim recipes use "combined" crafting categories such as
-- "cryogenics-or-assembling", expressing the intent "craftable in the
-- specialised machine OR in a normal assembler / by hand". Factorio has no such
-- built-in categories, so we register them here and grant each one to every
-- crafting entity that already supports any of its component categories. This
-- keeps those recipes craftable wherever the author intended.
-------------------------------------------------------------------------------

-- compound category -> list of real component categories it should map onto.
-- "assembling" / "hand-crafting" map to the normal player/assembler categories.
local compoundCategories = {
    ["electronics"] = { "electromagnetics", "crafting", "advanced-crafting" },
    ["electronics-or-assembling"] = { "electromagnetics", "crafting", "advanced-crafting" },
    ["chemistry-or-cryogenics"] = { "chemistry", "cryogenics" },
    ["crafting-with-fluid-or-metallurgy"] = { "crafting-with-fluid", "metallurgy" },
    ["cryogenics-or-assembling"] = { "cryogenics", "crafting", "advanced-crafting" },
    ["metallurgy-or-assembling"] = { "metallurgy", "crafting", "advanced-crafting" },
    ["organic-or-assembling"] = { "organic", "crafting", "advanced-crafting" },
    ["organic-or-chemistry"] = { "organic", "chemistry" },
    ["organic-or-hand-crafting"] = { "organic", "crafting" },
    ["recycling-or-hand-crafting"] = { "recycling", "crafting" }
}

-- Register the categories so recipes referencing them pass assignID.
local newCategories = {}
for name in pairs(compoundCategories) do
    if not data.raw["recipe-category"][name] then
        newCategories[#newCategories + 1] = { type = "recipe-category", name = name }
    end
end
if #newCategories > 0 then
    data:extend(newCategories)
end

local function listContains(list, value)
    for _, v in ipairs(list) do
        if v == value then
            return true
        end
    end
    return false
end

-- Grant each compound category to every crafting entity that supports one of
-- its components. Covers assemblers (incl. foundry/biochamber/etc.), furnaces,
-- rocket silos and the character (hand crafting).
local craftingTypes = { "assembling-machine", "furnace", "rocket-silo", "character" }
for _, entityType in ipairs(craftingTypes) do
    for _, entity in pairs(data.raw[entityType] or {}) do
        local cats = entity.crafting_categories
        if cats then
            for compoundName, components in pairs(compoundCategories) do
                if not listContains(cats, compoundName) then
                    for _, component in ipairs(components) do
                        if listContains(cats, component) then
                            cats[#cats + 1] = compoundName
                            break
                        end
                    end
                end
            end
        end
    end
end

-- Some 5Dim machine recipes gain a fluid ingredient at higher tiers (via Space
-- Age material progression) while keeping an item-only crafting category copied
-- from their vanilla base. Such recipes fail setup ("category but has a non-item
-- ingredient"), so swap item-only categories for "crafting-with-fluid" whenever
-- the recipe actually uses a fluid.
local itemOnlyCategories = {
    ["crafting"] = true,
    ["advanced-crafting"] = true
}

local function recipeUsesFluid(recipe)
    for _, ingredient in pairs(recipe.ingredients or {}) do
        if ingredient.type == "fluid" then
            return true
        end
    end
    for _, result in pairs(recipe.results or {}) do
        if result.type == "fluid" then
            return true
        end
    end
    return false
end

for _, recipe in pairs(data.raw.recipe) do
    if recipe.categories and recipeUsesFluid(recipe) then
        local rebuilt = {}
        local seen = {}
        for _, category in ipairs(recipe.categories) do
            local resolved = itemOnlyCategories[category] and "crafting-with-fluid" or category
            if not seen[resolved] then
                seen[resolved] = true
                rebuilt[#rebuilt + 1] = resolved
            end
        end
        recipe.categories = rebuilt
    end
end

-- Prune any crafting_categories that reference a recipe-category which does not
-- exist (e.g. aspirational categories like "basic-crafting" / "pressing" that no
-- recipe ever uses). assignID rejects undefined categories, and a machine cannot
-- craft a category that has no recipes anyway, so dropping them is safe.
for _, entityType in ipairs(craftingTypes) do
    for _, entity in pairs(data.raw[entityType] or {}) do
        local cats = entity.crafting_categories
        if cats then
            local pruned = {}
            for _, category in ipairs(cats) do
                if data.raw["recipe-category"][category] then
                    pruned[#pruned + 1] = category
                end
            end
            entity.crafting_categories = pruned
        end
    end
end
