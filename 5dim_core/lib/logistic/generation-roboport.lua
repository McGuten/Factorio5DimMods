local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

local function buildRoboportIcons(iconPath, tier, tint)
    local icons = TierBadgeIcons.buildTieredIcons(iconPath, tier, 64)

    if tint then
        icons[1].tint = tint
    end

    return icons
end

local function setPrototypeIcons(prototype, iconPath, tier, tint)
    prototype.icon = nil
    prototype.icon_size = nil
    prototype.icons = buildRoboportIcons(iconPath, tier, tint)
end

local function applyTintToSprite(sprite, tint)
    if not sprite or not tint then
        return
    end

    if sprite.layers then
        for _, layer in ipairs(sprite.layers) do
            applyTintToSprite(layer, tint)
        end

        return
    end

    if not sprite.draw_as_shadow and not sprite.apply_runtime_tint then
        sprite.tint = tint
        sprite.apply_runtime_tint = false
    end
end

local function applyScaleToSprite(sprite, scale)
    if not sprite or not scale or scale == 1 then
        return
    end

    if sprite.layers then
        for _, layer in ipairs(sprite.layers) do
            applyScaleToSprite(layer, scale)
        end

        return
    end

    sprite.scale = (sprite.scale or 1) * scale
end

local function getShiftComponent(shift, index, key)
    if not shift then
        return 0
    end

    return shift[index] or shift[key] or 0
end

local function applyShiftToSprite(sprite, shift)
    if not sprite or not shift then
        return
    end

    local shiftX = getShiftComponent(shift, 1, "x")
    local shiftY = getShiftComponent(shift, 2, "y")

    if shiftX == 0 and shiftY == 0 then
        return
    end

    if sprite.layers then
        for _, layer in ipairs(sprite.layers) do
            applyShiftToSprite(layer, shift)
        end

        return
    end

    local currentX = getShiftComponent(sprite.shift, 1, "x")
    local currentY = getShiftComponent(sprite.shift, 2, "y")

    sprite.shift = { currentX + shiftX, currentY + shiftY }
end

local function applyEntityVisuals(entity, tint, scale)
    local spriteFields = {
        "base",
        "base_patch",
        "base_animation",
        "door_animation_up",
        "door_animation_down",
        "recharging_animation"
    }

    for _, fieldName in ipairs(spriteFields) do
        applyTintToSprite(entity[fieldName], tint)
        applyScaleToSprite(entity[fieldName], scale)
    end
end

local function clearVanillaRoboportAnimations(entity)
    entity.base_animation = nil
    entity.door_animation_up = nil
    entity.door_animation_down = nil
    entity.recharging_animation = nil
    entity.open_door_trigger_effect = nil
    entity.close_door_trigger_effect = nil
end

local function appendUnlockRecipe(technologyName, recipeName)
    local technology = data.raw.technology[technologyName]

    if not technology then
        error("Technology not found for roboport unlock: " .. technologyName)
    end

    technology.effects = technology.effects or {}

    for _, effect in ipairs(technology.effects) do
        if effect.type == "unlock-recipe" and effect.recipe == recipeName then
            return
        end
    end

    table.insert(technology.effects, {
        type = "unlock-recipe",
        recipe = recipeName
    })
end

function genRoboports(inputs)
    local tierNumber = tonumber(inputs.number) or 1
    local iconPath = inputs.iconPath or ("__5dim_logistic__/graphics/icons/roboport/roboport-icon-" .. inputs.number .. ".png")
    local itemName = inputs.new and (inputs.itemName or ((inputs.namePrefix or "5d-roboport-") .. inputs.number))
        or (inputs.baseItemName or "roboport")
    local rechargeMinimum = inputs.recharge or 0

    if rechargeMinimum < inputs.energyUsage then
        rechargeMinimum = inputs.energyUsage
    end

    -- Copy roboport prototype
    local item = table.deepcopy(data.raw.item["roboport"])
    local recipe = table.deepcopy(data.raw.recipe["roboport"])
    local entity = table.deepcopy(data.raw["roboport"]["roboport"])
    local tech = table.deepcopy(data.raw.technology["logistic-robotics"])

    --Item
    item.name = itemName
    setPrototypeIcons(item, iconPath, tierNumber, inputs.iconTint)
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    setPrototypeIcons(recipe, iconPath, tierNumber, inputs.iconTint)
    recipe.enabled = false
    recipe.subgroup = inputs.recipeSubgroup or inputs.subgroup
    recipe.order = inputs.order
    if inputs.new then
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end
    if inputs.recipeCategory then
        recipe.category = inputs.recipeCategory
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    setPrototypeIcons(entity, iconPath, tierNumber, inputs.iconTint)
    entity.minable.result = item.name
    entity.charging_energy = inputs.chargingEnergy .. "kW"
    entity.energy_usage = inputs.energyUsage .. "kW"
    entity.energy_source.buffer_capacity = inputs.bufferCapacity .. "MJ"
    entity.energy_source.input_flow_limit = inputs.inputFlowLimit .. "MW"
    entity.logistics_radius = inputs.logistics
    entity.construction_radius = inputs.construction
    entity.robot_slots_count = math.max(inputs.botSlots or entity.robot_slots_count or 1, 1)
    entity.material_slots_count = math.max(inputs.materialSlots or entity.material_slots_count or 1, 1)
    entity.recharge_minimum = rechargeMinimum .. "MJ"
    entity.fast_replaceable_group = inputs.fastReplaceableGroup or "roboport"
    entity.charging_offsets = inputs.chargingOffsets
    entity.charging_station_count = inputs.chargingStationCount or inputs.rechargeSlots
    entity.charging_distance = inputs.chargingDistance or 3

    if inputs.chargeApproachDistance then
        entity.charge_approach_distance = inputs.chargeApproachDistance
    end

    if inputs.collisionBox then
        entity.collision_box = inputs.collisionBox
    end

    if inputs.selectionBox then
        entity.selection_box = inputs.selectionBox
    end

    if inputs.stationingOffset then
        entity.stationing_offset = inputs.stationingOffset
    end

    if inputs.drawingBoxVerticalExtension then
        entity.drawing_box_vertical_extension = inputs.drawingBoxVerticalExtension
    end

    -- Base
    entity.base.layers[1].filename =
        inputs.basePath or ("__5dim_logistic__/graphics/entities/roboport/roboport-base/roboport-base-" .. inputs.number .. ".png")
    -- Base patch
    entity.base_patch.filename =
        inputs.basePatchPath or ("__5dim_logistic__/graphics/entities/roboport/roboport-base-patch/roboport-base-patch-" .. inputs.number .. ".png")

    if inputs.disableVanillaAnimations then
        clearVanillaRoboportAnimations(entity)
    end

    applyEntityVisuals(entity, inputs.entityTint, inputs.entityScale)

    if inputs.baseShift then
        applyShiftToSprite(entity.base, inputs.baseShift)
    end

    if inputs.basePatchShift then
        applyShiftToSprite(entity.base_patch, inputs.basePatchShift)
    end

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        if inputs.tech.existingName then
            appendUnlockRecipe(inputs.tech.existingName, item.name)
        else
            tech.name = inputs.tech.name or ((inputs.techNamePrefix or "5d-roboport-") .. inputs.tech.number)
            setPrototypeIcons(tech, iconPath, tierNumber, inputs.iconTint)
            tech.unit.count = inputs.tech.count
            tech.unit.ingredients = inputs.tech.packs
            tech.prerequisites = inputs.tech.prerequisites
            tech.effects = inputs.tech.effects or {
                {
                    type = "unlock-recipe",
                    recipe = item.name
                }
            }
            data:extend({tech})
        end
    end
end
