-- 5Dim's Space Age mod - data-updates
-- Applies the spoil time multiplier to all perishable items after all mods have loaded.

if not mods["space-age"] then return end

-- Rocket silo tiers: generated here (not in data.lua) so the base "space-age"
-- mod has already reshaped the vanilla silo (rocket_parts_required = 50,
-- launch_to_space_platforms, lift_weight, ...) before we clone it.
require("prototypes.gen-rocket-silo")

local mult = settings.startup["5d-spoil-time-multiplier"].value
if mult == 1.0 then return end

local item_types = {
    "item", "tool", "ammo", "armor", "capsule", "gun", "module",
    "repair-tool", "item-with-entity-data", "rail-planner",
    "selection-tool", "space-platform-starter-pack",
    "spidertron-remote", "item-with-tags", "item-with-label",
    "item-with-inventory"
}

for _, item_type in ipairs(item_types) do
    for _, item in pairs(data.raw[item_type] or {}) do
        if item.spoil_ticks and item.spoil_ticks > 0 then
            item.spoil_ticks = math.max(1, math.floor(item.spoil_ticks * mult))
        end
    end
end
