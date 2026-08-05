-------------------------------------------------------------------------------
-- 5Dim's Space Age - Rocket Silo Generation
-- Mirrors generation-foundry.lua but adds the silo-specific levers.
--
-- IMPORTANT: this generator is meant to run at the data-updates stage, after
-- the base "space-age" mod has reshaped the vanilla rocket silo (it sets
-- rocket_parts_required = 50, launch_to_space_platforms = true, lift_weight,
-- logistic_trash_inventory_size, surface_conditions, heating_energy, ...).
-- Cloning the silo here means every tier inherits the Space Age behaviour.
-------------------------------------------------------------------------------

local applyTierArt = require("__5dim_core__.lib.space-age.tier-art")

function genRocketSilo(inputs)
    -- Copy the (already Space Age-shaped) rocket silo
    local item = table.deepcopy(data.raw.item["rocket-silo"])
    local recipe = table.deepcopy(data.raw.recipe["rocket-silo"])
    local entity = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
    -- Base technology: the vanilla rocket-silo tech uses a `unit` (not research_trigger)
    local tech = table.deepcopy(data.raw.technology["rocket-silo"])

    -- Item
    if inputs.new then
        item.name = "5d-rocket-silo-" .. inputs.number
    end
    item.icon = "__5dim_space_age__/graphics/icon/rocket-silo/rocket-silo-" .. inputs.number .. ".png"
    item.icons = nil
    item.icon_size = 64
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    -- Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icons = nil
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
        recipe.ingredients = inputs.ingredients
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
    end
    if inputs.recipeCategory then
        recipe.category = inputs.recipeCategory
    end

    -- Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.icons = nil
    entity.icon_size = 64
    entity.minable.result = item.name
    entity.crafting_speed = inputs.craftingSpeed
    entity.module_slots = inputs.moduleSlots
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.fast_replaceable_group = "rocket-silo"

    -- Silo-specific levers (all optional, only applied when provided)
    if inputs.rocketPartsRequired then
        entity.rocket_parts_required = inputs.rocketPartsRequired
        entity.rocket_parts_storage_cap =
            math.max(inputs.rocketPartsRequired, entity.rocket_parts_storage_cap or inputs.rocketPartsRequired)
    end
    if inputs.doorOpeningSpeed then entity.door_opening_speed = inputs.doorOpeningSpeed end
    if inputs.rocketRisingDelay then entity.rocket_rising_delay = inputs.rocketRisingDelay end
    if inputs.launchWaitTime then entity.launch_wait_time = inputs.launchWaitTime end
    if inputs.liftWeight then entity.lift_weight = inputs.liftWeight end
    if inputs.logisticTrashInventory then entity.logistic_trash_inventory_size = inputs.logisticTrashInventory end
    if inputs.canLaunchWithoutLandingPads then entity.can_launch_without_landing_pads = true end

    -- Overlay de recolor del tier sobre el arte vanilla. El tier 1 tambien lo
    -- lleva (amarillo), asi que va fuera del `if inputs.new`.
    applyTierArt(entity, "rocket-silo", tonumber(inputs.number))

    -- Optional per-tier rocket clone (phase 2): faster ascent and bigger cargo.
    -- The shared shadow_slave_entity / cargo_pod_entity references are kept as-is.
    if inputs.rocket and inputs.new then
        local rocket = table.deepcopy(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"])
        rocket.name = "5d-rocket-silo-rocket-" .. inputs.number
        if inputs.rocket.risingSpeed then rocket.rising_speed = inputs.rocket.risingSpeed end
        if inputs.rocket.engineStartingSpeed then rocket.engine_starting_speed = inputs.rocket.engineStartingSpeed end
        if inputs.rocket.inventorySize then rocket.inventory_size = inputs.rocket.inventorySize end
        data:extend({ rocket })
        entity.rocket_entity = rocket.name
    end

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "5d-rocket-silo-" .. inputs.tech.number
        tech.icon = item.icon
        tech.icons = nil
        tech.icon_size = 64
        tech.unit.count = inputs.tech.count
        tech.unit.ingredients = inputs.tech.packs
        tech.prerequisites = inputs.tech.prerequisites
        tech.research_trigger = nil
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = item.name
            }
        }
        data:extend({ tech })
    end
end
