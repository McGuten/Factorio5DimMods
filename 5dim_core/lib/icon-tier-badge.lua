-------------------------------------------------------------------------------
-- 5Dim's Core - Tier badge icons
-- Builds a top-left tier marker that avoids the stack count in the bottom-right
-------------------------------------------------------------------------------

local function buildTieredIcons(baseIcon, tier, baseIconSize)
    local icons = {
        {
            icon = baseIcon,
            icon_size = baseIconSize or 64
        },
        {
            icon = "__5dim_core__/graphics/icon/tier-badges/tier-badge-" .. string.format("%02d", tier) .. ".png",
            icon_size = 64
        }
    }

    return icons
end

return {
    buildTieredIcons = buildTieredIcons
}