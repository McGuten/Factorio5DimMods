-- 5Dim's Core - Tier badge icons
-- Builds a top-left tier marker that avoids the stack count in the bottom-right
-------------------------------------------------------------------------------

local function buildTierBadgeLayer(tier, shift)
    local badgeLayer = {
        icon = "__5dim_core__/graphics/icon/tier-badges/tier-badge-" .. string.format("%02d", tier) .. ".png",
        icon_size = 64
    }

    if shift then
        badgeLayer.shift = shift
    end

    return badgeLayer
end

local function buildTieredIcons(baseIcon, tier, baseIconSize, badgeShift)
    local icons = {
        {
            icon = baseIcon,
            icon_size = baseIconSize or 64
        },
        buildTierBadgeLayer(tier, badgeShift)
    }

    return icons
end

local function buildTieredIconsFromIcons(baseIcons, tier, badgeShift)
    local icons = table.deepcopy(baseIcons)
    table.insert(icons, buildTierBadgeLayer(tier, badgeShift))

    return icons
end

return {
    buildTieredIcons = buildTieredIcons,
    buildTieredIconsFromIcons = buildTieredIconsFromIcons
}