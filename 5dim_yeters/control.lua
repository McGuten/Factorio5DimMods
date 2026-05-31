-- 5Dim's Yeters mod
-- Pauses item spoilage on the Yeters surface only.
--
-- There is no native per-surface property to stop spoilage in Factorio, so this
-- script keeps the remaining spoil time of every spoilable item stack on Yeters
-- constant. Every INTERVAL ticks each affected stack has its spoil_tick pushed
-- forward by INTERVAL, matching the elapsed game time so the freshness percent
-- does not advance. Partial spoil progress is preserved (the items are paused,
-- not reset to fresh).
--
-- Scope: container/logistic inventories, crafting machines, the player
-- character and ground vehicles. Items in transit on belts or held by inserters
-- are intentionally not covered to keep the per-tick cost bounded.

local INTERVAL = 60

local SURFACE_NAME = "yeters"

-- Entity types that can hold spoilable item stacks on Yeters.
local TARGET_TYPES = {
    "container",
    "logistic-container",
    "assembling-machine",
    "furnace",
    "character",
    "car",
    "spider-vehicle",
    "cargo-wagon",
    "agricultural-tower"
}

-- Inventory indices scanned per entity. Covers main/fuel/input/output style
-- inventories across the target types; get_inventory returns nil for indices
-- that do not apply to a given entity. Each index must appear only once so a
-- stack is never pushed forward more than once per pass.
local INVENTORY_INDICES = {
    defines.inventory.fuel,
    defines.inventory.chest,
    defines.inventory.crafter_input,
    defines.inventory.crafter_output,
    defines.inventory.assembling_machine_dump,
    defines.inventory.character_main,
    defines.inventory.character_trash,
    defines.inventory.car_trunk,
    defines.inventory.spider_trunk,
    defines.inventory.cargo_wagon,
    defines.inventory.logistic_container_trash
}

local function pause_inventory(inventory)
    if not inventory or not inventory.valid then
        return
    end
    for i = 1, #inventory do
        local stack = inventory[i]
        if stack.valid_for_read and stack.spoil_tick ~= 0 then
            stack.spoil_tick = stack.spoil_tick + INTERVAL
        end
    end
end

script.on_nth_tick(INTERVAL, function()
    local surface = game.surfaces[SURFACE_NAME]
    if not surface or not surface.valid then
        return
    end

    local entities = surface.find_entities_filtered({ type = TARGET_TYPES })
    for _, entity in pairs(entities) do
        if entity.valid then
            for _, index in pairs(INVENTORY_INDICES) do
                pause_inventory(entity.get_inventory(index))
            end
        end
    end
end)
