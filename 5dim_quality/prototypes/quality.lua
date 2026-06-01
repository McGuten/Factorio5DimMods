-------------------------------------------------------------------------------
-- 5Dim's Quality - Quality prototypes
--
-- Extends the vanilla quality ladder up to 10 coloured levels (plus normal):
--   0 normal     -> tier 1 (yellow, icon only)
--   1 uncommon   -> tier 2
--   2 rare       -> tier 3
--   3 epic       -> tier 4
--   5 legendary  -> tier 5
--   6 5d-mythic  -> tier 6
--   7 5d-ascended-> tier 7
--   8 5d-divine  -> tier 8
--   9 5d-cosmic  -> tier 9
--  10 5d-eternal -> orange star
--
-- Vanilla qualities are only recoloured and re-iconed for visual consistency;
-- their ids and levels are preserved. The new qualities use Factorio's default
-- effect multipliers (no manual overrides).
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")

local ICON_PATH = "__5dim_quality__/graphics/icons/"
local ICON_SIZE = 64
local NEXT_PROBABILITY = 0.1

local utilityConstants = data.raw["utility-constants"] and data.raw["utility-constants"]["default"]
if utilityConstants then
    -- Vanilla switches the quality picker to a dropdown above 6 entries.
    utilityConstants.quality_selector_dropdown_threshold = 11
end

-- Recolour and re-icon an existing vanilla quality, keeping its id and level.
local function restyleVanilla(name, tier)
    local quality = data.raw["quality"][name]
    if not quality then
        return
    end

    local color = tierColors[tier]
    quality.color = { r = color.r, g = color.g, b = color.b, a = color.a }
    quality.icon = ICON_PATH .. "quality-" .. name .. ".png"
    quality.icon_size = ICON_SIZE
    quality.icons = nil
end

-- Normal keeps its baseline tint but takes the yellow tier-1 icon.
local normalQuality = data.raw["quality"]["normal"]
if normalQuality then
    normalQuality.icon = ICON_PATH .. "quality-normal.png"
    normalQuality.icon_size = ICON_SIZE
    normalQuality.icons = nil
end

restyleVanilla("uncommon", 2)
restyleVanilla("rare", 3)
restyleVanilla("epic", 4)
restyleVanilla("legendary", 5)

-- Legendary is no longer the final quality: chain it into the new ladder.
if data.raw["quality"]["legendary"] then
    data.raw["quality"]["legendary"].next = "5d-mythic"
    data.raw["quality"]["legendary"].next_probability = NEXT_PROBABILITY
end

-- New qualities, levels 6-10. Mythic..Cosmic use tiers 6-9; Eternal is a
-- dedicated orange star with its own colour (no tier index).
local newQualities = {
    { name = "5d-mythic",   level = 6,  tier = 6, order = "f", next = "5d-ascended" },
    { name = "5d-ascended", level = 7,  tier = 7, order = "g", next = "5d-divine" },
    { name = "5d-divine",   level = 8,  tier = 8, order = "h", next = "5d-cosmic" },
    { name = "5d-cosmic",   level = 9,  tier = 9, order = "i", next = "5d-eternal" },
    { name = "5d-eternal",  level = 10, order = "j", color = { r = 1.0, g = 0.65, b = 0.0, a = 1 } },
}

local qualityPrototypes = {}
for _, entry in ipairs(newQualities) do
    local color = entry.color or tierColors[entry.tier]
    qualityPrototypes[#qualityPrototypes + 1] = {
        type = "quality",
        name = entry.name,
        level = entry.level,
        order = entry.order,
        color = { r = color.r, g = color.g, b = color.b, a = color.a },
        subgroup = "qualities",
        icon = ICON_PATH .. "quality-" .. entry.name .. ".png",
        icon_size = ICON_SIZE,
        next = entry.next,
        next_probability = entry.next and NEXT_PROBABILITY or nil,
    }
end

data:extend(qualityPrototypes)
