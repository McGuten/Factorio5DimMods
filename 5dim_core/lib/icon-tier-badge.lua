-- 5Dim's Core - Tier badge icons
-- Builds a top-left tier marker that avoids the stack count in the bottom-right
-------------------------------------------------------------------------------

local function isIconTierOverlayEnabled()
    return settings.startup["5d-icon-tier-overlay"] == nil
        or settings.startup["5d-icon-tier-overlay"].value
end

local function useBlackIconTierOverlayBackground()
    return settings.startup["5d-icon-tier-overlay-black-background"] == nil
        or settings.startup["5d-icon-tier-overlay-black-background"].value
end

local function buildTierBadgeLayer(tier, shift)
    local iconPath = "__5dim_core__/graphics/icon/tier-badges/tier-badge-"
    if not useBlackIconTierOverlayBackground() then
        iconPath = iconPath .. "plain-"
    end

    local badgeLayer = {
        icon = iconPath .. string.format("%02d", tier) .. ".png",
        icon_size = 64
    }

    if shift then
        badgeLayer.shift = shift
    end

    return badgeLayer
end

local function buildTieredIcons(baseIcon, tier, baseIconSize, badgeShift)
    if not isIconTierOverlayEnabled() then
        return {
            {
                icon = baseIcon,
                icon_size = baseIconSize or 64
            }
        }
    end

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
    if not isIconTierOverlayEnabled() then
        return table.deepcopy(baseIcons)
    end

    local icons = table.deepcopy(baseIcons)
    table.insert(icons, buildTierBadgeLayer(tier, badgeShift))

    return icons
end

return {
    buildTieredIcons = buildTieredIcons,
    buildTieredIconsFromIcons = buildTieredIconsFromIcons
}