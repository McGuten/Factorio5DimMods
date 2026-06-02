-------------------------------------------------------------------------------
-- 5Dim's Quality - Technology prototypes
--
-- Extends the vanilla quality research chain so every added quality tier has a
-- dedicated unlock technology.
-------------------------------------------------------------------------------

local ICON_PATH = "__5dim_quality__/graphics/icons/"
local ICON_SIZE = 64
local hasCryogenicScience = data.raw["tool"] and data.raw["tool"]["cryogenic-science-pack"]
local hasPromethiumScience = data.raw["tool"] and data.raw["tool"]["promethium-science-pack"]
local hasYetersDiscovery = data.raw["technology"] and data.raw["technology"]["yeters-discovery"]

local aquiloScienceIngredients = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "production-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
}

if hasCryogenicScience then
    aquiloScienceIngredients[#aquiloScienceIngredients + 1] = { "metallurgic-science-pack", 1 }
    aquiloScienceIngredients[#aquiloScienceIngredients + 1] = { "agricultural-science-pack", 1 }
    aquiloScienceIngredients[#aquiloScienceIngredients + 1] = { "electromagnetic-science-pack", 1 }
    aquiloScienceIngredients[#aquiloScienceIngredients + 1] = { "cryogenic-science-pack", 1 }
end

local promethiumScienceIngredients = table.deepcopy(aquiloScienceIngredients)
if hasPromethiumScience then
    promethiumScienceIngredients[#promethiumScienceIngredients + 1] = { "promethium-science-pack", 1 }
end

local function appendPrerequisite(technology, prerequisite)
    if not technology or not prerequisite then
        return
    end

    technology.prerequisites = technology.prerequisites or {}

    for _, existing in ipairs(technology.prerequisites) do
        if existing == prerequisite then
            return
        end
    end

    technology.prerequisites[#technology.prerequisites + 1] = prerequisite
end

local function setTechnologyIcon(technology, iconName)
    if not technology or not iconName then
        return
    end

    technology.icons = {
        {
            icon = ICON_PATH .. iconName,
            icon_size = ICON_SIZE,
        },
    }
    technology.icon = nil
    technology.icon_size = nil
end

appendPrerequisite(data.raw["technology"]["epic-quality"], "quality-module-3")
appendPrerequisite(data.raw["technology"]["legendary-quality"], "quality-module-3")

setTechnologyIcon(data.raw["technology"]["epic-quality"], "quality-epic.png")
setTechnologyIcon(data.raw["technology"]["legendary-quality"], "quality-legendary.png")

local legendaryQuality = data.raw["technology"]["legendary-quality"]
if legendaryQuality then
    legendaryQuality.unit = legendaryQuality.unit or {}
    legendaryQuality.unit.count = 10000
    legendaryQuality.unit.ingredients = table.deepcopy(aquiloScienceIngredients)
end

data:extend({
    {
        type = "technology",
        name = "5d-mythic-quality",
        icon = ICON_PATH .. "quality-5d-mythic.png",
        icon_size = ICON_SIZE,
        effects = {
            {
                type = "unlock-quality",
                quality = "5d-mythic",
            },
        },
        prerequisites = hasPromethiumScience and { "legendary-quality", "promethium-science-pack" } or { "legendary-quality" },
        unit = {
            count = 15000,
            ingredients = table.deepcopy(promethiumScienceIngredients),
            time = 60,
        },
    },
    {
        type = "technology",
        name = "5d-ascended-quality",
        icon = ICON_PATH .. "quality-5d-ascended.png",
        icon_size = ICON_SIZE,
        effects = {
            {
                type = "unlock-quality",
                quality = "5d-ascended",
            },
        },
        prerequisites = { "5d-mythic-quality" },
        unit = {
            count = 20000,
            ingredients = table.deepcopy(promethiumScienceIngredients),
            time = 60,
        },
    },
    {
        type = "technology",
        name = "5d-divine-quality",
        icon = ICON_PATH .. "quality-5d-divine.png",
        icon_size = ICON_SIZE,
        effects = {
            {
                type = "unlock-quality",
                quality = "5d-divine",
            },
        },
        prerequisites = { "5d-ascended-quality" },
        unit = {
            count = 25000,
            ingredients = table.deepcopy(promethiumScienceIngredients),
            time = 60,
        },
    },
    {
        type = "technology",
        name = "5d-cosmic-quality",
        icon = ICON_PATH .. "quality-5d-cosmic.png",
        icon_size = ICON_SIZE,
        effects = {
            {
                type = "unlock-quality",
                quality = "5d-cosmic",
            },
        },
        prerequisites = { "5d-divine-quality" },
        unit = {
            count = 30000,
            ingredients = table.deepcopy(promethiumScienceIngredients),
            time = 60,
        },
    },
    {
        type = "technology",
        name = "5d-eternal-quality",
        icon = ICON_PATH .. "quality-5d-eternal.png",
        icon_size = ICON_SIZE,
        effects = {
            {
                type = "unlock-quality",
                quality = "5d-eternal",
            },
        },
        prerequisites = { "5d-cosmic-quality" },
        unit = {
            count = 35000,
            ingredients = table.deepcopy(promethiumScienceIngredients),
            time = 60,
        },
    },
})

if hasYetersDiscovery then
    appendPrerequisite(data.raw["technology"]["5d-mythic-quality"], "yeters-discovery")
end