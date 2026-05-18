function genModules(inputs)
    local technologyIcons = {
        speed = {
            icon = "__base__/graphics/technology/speed-module-3.png",
            icon_size = 256
        },
        effectivity = {
            icon = "__base__/graphics/technology/efficiency-module-3.png",
            icon_size = 256
        },
        productivity = {
            icon = "__base__/graphics/technology/productivity-module-3.png",
            icon_size = 256
        },
        quality = {
            icon = "__quality__/graphics/technology/quality-module-3.png",
            icon_size = 256
        },
        merged = {
            icon = "__5dim_module__/graphics/icons/merged-module-03.png",
            icon_size = 64
        }
    }

    local function recipeCategory(moduleType)
        if inputs.recipeCategories and inputs.recipeCategories[moduleType] then
            return inputs.recipeCategories[moduleType]
        end

        if mods["space-age"] then
            return "electronics"
        end

        return nil
    end

    local function techPacks(moduleType)
        if inputs.tech.packsByType and inputs.tech.packsByType[moduleType] then
            return inputs.tech.packsByType[moduleType]
        end

        return inputs.tech.packs
    end

    local function techCount(moduleType)
        if inputs.tech.countsByType and inputs.tech.countsByType[moduleType] then
            return inputs.tech.countsByType[moduleType]
        end

        return inputs.tech.count
    end

    -- Copy Speed module
    local itemSpeed
    local recipeSpeed
    local techSpeed
    if inputs.tier == 2 or inputs.tier == 3 then
        itemSpeed = table.deepcopy(data.raw.module["speed-module-" .. inputs.tier])
        recipeSpeed = table.deepcopy(data.raw.recipe["speed-module-" .. inputs.tier])
        techSpeed = table.deepcopy(data.raw.technology["speed-module-" .. inputs.tier])
    else
        itemSpeed = table.deepcopy(data.raw.module["speed-module"])
        recipeSpeed = table.deepcopy(data.raw.recipe["speed-module"])
        techSpeed = table.deepcopy(data.raw.technology["speed-module"])
    end
    --Item
    if inputs.new then
        itemSpeed.name = "5d-speed-module-" .. inputs.number
    end
    itemSpeed.icon =
        "__5dim_module__/graphics/icons/speed-module/speed-module-" .. inputs.number .. ".png"
    itemSpeed.subgroup = "speed"
    itemSpeed.order = inputs.order
    itemSpeed.effect = inputs.effects.speed
    itemSpeed.tier = inputs.tier

    --Recipe
    recipeSpeed.name = itemSpeed.name
    recipeSpeed.icon = itemSpeed.icon
    if recipeCategory("speed") then
        recipeSpeed.category = recipeCategory("speed")
    end
    recipeSpeed.results = { { type = "item", name = itemSpeed.name, amount = 1 } }
    recipeSpeed.icon_size = 64
    if inputs.new then
        recipeSpeed.enabled = false
    end
    recipeSpeed.ingredients = inputs.ingredients.speed
    recipeSpeed.energy_required = inputs.timeCraft

    data:extend({ recipeSpeed, itemSpeed })

    -- Technology
    if inputs.new then
        techSpeed.name = "speed-module-" .. inputs.tech.number
        techSpeed.icon = technologyIcons.speed.icon
        techSpeed.icon_size = technologyIcons.speed.icon_size
        techSpeed.icons = nil
            techSpeed.unit.count = techCount("speed")
        techSpeed.unit.ingredients = techPacks("speed")
        techSpeed.prerequisites = inputs.tech.prerequisites.speed
        techSpeed.effects = {
            {
                type = "unlock-recipe",
                recipe = itemSpeed.name
            }
        }
        data:extend({ techSpeed })
    end
    -- Copy effectivity module
    local itemEffectivity
    local recipeEffectivity
    local techEffectivity
    if inputs.tier == 2 or inputs.tier == 3 then
        itemEffectivity = table.deepcopy(data.raw.module["efficiency-module-" .. inputs.tier])
        recipeEffectivity = table.deepcopy(data.raw.recipe["efficiency-module-" .. inputs.tier])
        techEffectivity = table.deepcopy(data.raw.technology["efficiency-module-" .. inputs.tier])
    else
        itemEffectivity = table.deepcopy(data.raw.module["efficiency-module"])
        recipeEffectivity = table.deepcopy(data.raw.recipe["efficiency-module"])
        techEffectivity = table.deepcopy(data.raw.technology["efficiency-module"])
    end

    --Item
    if inputs.new then
        itemEffectivity.name = "5d-efficiency-module-" .. inputs.number
    end
    itemEffectivity.icon =
        "__5dim_module__/graphics/icons/efficiency-module/efficiency-module-" .. inputs.number .. ".png"
    itemEffectivity.subgroup = "efficiency"
    itemEffectivity.order = inputs.order
    itemEffectivity.effect = inputs.effects.effectivity
    itemEffectivity.tier = inputs.tier

    --Recipe
    recipeEffectivity.name = itemEffectivity.name
    recipeEffectivity.icon = itemEffectivity.icon
    if recipeCategory("effectivity") then
        recipeEffectivity.category = recipeCategory("effectivity")
    end
    recipeEffectivity.results = { { type = "item", name = itemEffectivity.name, amount = 1 } }
    recipeEffectivity.icon_size = 64
    if inputs.new then
        recipeEffectivity.enabled = false
    end
    recipeEffectivity.ingredients = inputs.ingredients.effectivity
    recipeEffectivity.energy_required = inputs.timeCraft

    data:extend({ recipeEffectivity, itemEffectivity })

    -- Technology
    if inputs.new then
        techEffectivity.name = "efficiency-module-" .. inputs.tech.number
        techEffectivity.icon = technologyIcons.effectivity.icon
        techEffectivity.icon_size = technologyIcons.effectivity.icon_size
        techEffectivity.icons = nil
        techEffectivity.unit.count = techCount("effectivity")
        techEffectivity.unit.ingredients = techPacks("effectivity")
        techEffectivity.prerequisites = inputs.tech.prerequisites.effectivity
        techEffectivity.effects = {
            {
                type = "unlock-recipe",
                recipe = itemEffectivity.name
            }
        }
        data:extend({ techEffectivity })
    end
    -- Copy productivity module
    local itemProductivity
    local recipeProductivity
    local techProductivity
    if inputs.tier == 2 or inputs.tier == 3 then
        itemProductivity = table.deepcopy(data.raw.module["productivity-module-" .. inputs.tier])
        recipeProductivity = table.deepcopy(data.raw.recipe["productivity-module-" .. inputs.tier])
        techProductivity = table.deepcopy(data.raw.technology["productivity-module-" .. inputs.tier])
    else
        itemProductivity = table.deepcopy(data.raw.module["productivity-module"])
        recipeProductivity = table.deepcopy(data.raw.recipe["productivity-module"])
        techProductivity = table.deepcopy(data.raw.technology["productivity-module"])
    end

    --Item
    if inputs.new then
        itemProductivity.name = "5d-productivity-module-" .. inputs.number
    end
    itemProductivity.icon =
        "__5dim_module__/graphics/icons/productivity-module/productivity-module-" .. inputs.number .. ".png"
    itemProductivity.subgroup = "productivity"
    itemProductivity.order = inputs.order
    itemProductivity.effect = inputs.effects.productivity
    itemProductivity.tier = inputs.tier

    --Recipe
    recipeProductivity.name = itemProductivity.name
    recipeProductivity.icon = itemProductivity.icon
    if recipeCategory("productivity") then
        recipeProductivity.category = recipeCategory("productivity")
    end
    recipeProductivity.results = { { type = "item", name = recipeProductivity.name, amount = 1 } }
    recipeProductivity.icon_size = 64
    if inputs.new then
        recipeProductivity.enabled = false
    end
    recipeProductivity.ingredients = inputs.ingredients.productivity
    recipeProductivity.energy_required = inputs.timeCraft

    data:extend({ recipeProductivity, itemProductivity })

    -- Technology
    if inputs.new then
        techProductivity.name = "productivity-module-" .. inputs.tech.number
        techProductivity.icon = technologyIcons.productivity.icon
        techProductivity.icon_size = technologyIcons.productivity.icon_size
        techProductivity.icons = nil
        techProductivity.unit.count = techCount("productivity")
        techProductivity.unit.ingredients = techPacks("productivity")
        techProductivity.prerequisites = inputs.tech.prerequisites.productivity
        techProductivity.effects = {
            {
                type = "unlock-recipe",
                recipe = itemProductivity.name
            }
        }
        data:extend({ techProductivity })
    end
    if mods['quality'] then
        -- Copy Quality module
        local itemQuality
        local recipeQuality
        local techQuality
        if inputs.tier == 2 or inputs.tier == 3 then
            itemQuality = table.deepcopy(data.raw.module["quality-module-" .. inputs.tier])
            recipeQuality = table.deepcopy(data.raw.recipe["quality-module-" .. inputs.tier])
            techQuality = table.deepcopy(data.raw.technology["quality-module-" .. inputs.tier])
        else
            itemQuality = table.deepcopy(data.raw.module["quality-module"])
            recipeQuality = table.deepcopy(data.raw.recipe["quality-module"])
            techQuality = table.deepcopy(data.raw.technology["quality-module"])
        end
        --Item
        if inputs.new then
            itemQuality.name = "5d-quality-module-" .. inputs.number
        end
        itemQuality.icon =
            "__5dim_module__/graphics/icons/quality-module/quality-module-" .. inputs.number .. ".png"
        itemQuality.subgroup = "quality"
        itemQuality.order = inputs.order
        itemQuality.effect = inputs.effects.quality
        itemQuality.tier = inputs.tier
        itemQuality.localised_description = nil

        --Recipe
        recipeQuality.name = itemQuality.name
        recipeQuality.icon = itemQuality.icon
        if recipeCategory("quality") then
            recipeQuality.category = recipeCategory("quality")
        end
        recipeQuality.results = { { type = "item", name = recipeQuality.name, amount = 1 } }
        recipeQuality.icon_size = 64
        if inputs.new then
            recipeQuality.enabled = false
        end
        recipeQuality.ingredients = inputs.ingredients.quality
        recipeQuality.energy_required = inputs.timeCraft

        data:extend({ recipeQuality, itemQuality })

        if inputs.new then
            -- Technology
            techQuality.name = "quality-module-" .. inputs.tech.number
            techQuality.icon = technologyIcons.quality.icon
            techQuality.icon_size = technologyIcons.quality.icon_size
            techQuality.icons = nil
            techQuality.unit.count = techCount("quality")
            techQuality.unit.ingredients = techPacks("quality")
            techQuality.prerequisites = inputs.tech.prerequisites.quality
            techQuality.effects = {
                {
                    type = "unlock-recipe",
                    recipe = itemQuality.name
                }
            }
            data:extend({ techQuality })
        end
    end

    -- Copy merged module
    local itemMerged
    local recipeMerged
    local techMerged
    if inputs.tier == 2 or inputs.tier == 3 then
        itemMerged = table.deepcopy(data.raw.module["productivity-module-" .. inputs.tier])
        recipeMerged = table.deepcopy(data.raw.recipe["productivity-module-" .. inputs.tier])
        techMerged = table.deepcopy(data.raw.technology["productivity-module-" .. inputs.tier])
    else
        itemMerged = table.deepcopy(data.raw.module["productivity-module"])
        recipeMerged = table.deepcopy(data.raw.recipe["productivity-module"])
        techMerged = table.deepcopy(data.raw.technology["productivity-module"])
    end
    --Item
    itemMerged.name = "5d-merged-module-" .. inputs.number
    itemMerged.icon =
        "__5dim_module__/graphics/icons/merged-module/merged-module-" .. inputs.number .. ".png"
    itemMerged.subgroup = "merged"
    itemMerged.order = inputs.order
    local product = inputs.effects.productivity
    local consump = inputs.effects.effectivity
    local speed = inputs.effects.speed
    local mergedSpeed = (speed.speed or 0) + (product.speed or 0)
    local mergedConsumption = (speed.consumption or 0)
        + (product.consumption or 0)
        + (consump.consumption or 0)
    local mergedPollution = product.pollution or 0
    itemMerged.effect = {
        productivity = product.productivity,
        consumption = mergedConsumption,
        pollution = mergedPollution,
        speed = mergedSpeed,
    }
    itemMerged.tier = inputs.tier
    itemMerged.localised_description = nil

    --Recipe
    recipeMerged.name = itemMerged.name
    recipeMerged.icon = itemMerged.icon
    if recipeCategory("merged") then
        recipeMerged.category = recipeCategory("merged")
    end
    recipeMerged.results = { { type = "item", name = recipeMerged.name, amount = 1 } }
    recipeMerged.icon_size = 64
    if inputs.new then
        recipeMerged.enabled = false
    end
    recipeMerged.ingredients = inputs.ingredients.merged
    recipeMerged.energy_required = inputs.timeCraft

    data:extend({ recipeMerged, itemMerged })

    -- Technology
    techMerged.name = "5d-merged-module-" .. inputs.tech.number
    techMerged.icon = technologyIcons.merged.icon
    techMerged.icon_size = technologyIcons.merged.icon_size
    techMerged.icons = nil
    techMerged.unit.count = techCount("merged")
    techMerged.unit.ingredients = techPacks("merged")
    techMerged.prerequisites = inputs.tech.prerequisites.merged
    techMerged.effects = {
        {
            type = "unlock-recipe",
            recipe = itemMerged.name
        }
    }
    data:extend({ techMerged })
end
