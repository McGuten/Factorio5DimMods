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

-- Maximum entities processed per tick. The surface is scanned in bounded
-- batches across consecutive ticks instead of all at once every INTERVAL ticks,
-- so the per-tick cost stays flat even on a large Yeters base.
local ENTITIES_PER_TICK = 64

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

-- Advance every spoilable stack in an inventory by `push` ticks, matching the
-- real time elapsed since this entity was last touched so its freshness stays
-- frozen. A push of 0 (first cycle, before an interval has been measured) is a
-- harmless no-op.
local function pause_inventory(inventory, push)
    if not inventory or not inventory.valid then
        return
    end
    for i = 1, #inventory do
        local stack = inventory[i]
        if stack.valid_for_read and stack.spoil_tick ~= 0 then
            stack.spoil_tick = stack.spoil_tick + push
        end
    end
end

-- Cached entity list for the current scan cycle. Kept as a file-local (not in
-- storage) so it is rebuilt deterministically on load without bloating saves;
-- only the cursor/timing lives in storage. find_entities_filtered is
-- deterministic, so every peer rebuilds an identical list in multiplayer.
local entityCache = nil

script.on_event(defines.events.on_tick, function(event)
    local surface = game.surfaces[SURFACE_NAME]
    if not surface or not surface.valid then
        return
    end

    local state = storage.yeters
    if not state then
        state = { cursor = 1, push = 0 }
        storage.yeters = state
    end

    -- Start a new cycle when the previous one is exhausted or the cache was
    -- dropped (e.g. after load). The push applied across this cycle equals the
    -- duration of the previous full cycle, so each stack is advanced by exactly
    -- the time since it was last touched regardless of how many entities live
    -- on the surface.
    if not entityCache or state.cursor > #entityCache then
        state.push = state.cycle_start and (event.tick - state.cycle_start) or 0
        state.cycle_start = event.tick
        entityCache = surface.find_entities_filtered({ type = TARGET_TYPES })
        state.cursor = 1
    end

    local total = #entityCache
    if total == 0 then
        return
    end

    local push = state.push
    local cursor = state.cursor
    local processed = 0

    while cursor <= total and processed < ENTITIES_PER_TICK do
        local entity = entityCache[cursor]
        if entity and entity.valid then
            for _, index in pairs(INVENTORY_INDICES) do
                pause_inventory(entity.get_inventory(index), push)
            end
        end
        cursor = cursor + 1
        processed = processed + 1
    end

    state.cursor = cursor
end)
