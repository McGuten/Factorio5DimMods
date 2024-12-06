function genModules(inputs)
    -- Copy Speed module
    local itemSpeed = ""
    local recipeSpeed = ""
    local techSpeed = ""
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
    if mods["space-age"] then
        recipeSpeed.category = "electronics"
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
        --tech.icon = "__base__/graphics/technology/oil-refinery.png"
        techSpeed.unit.count = inputs.tech.count
        techSpeed.unit.ingredients = inputs.tech.packs
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
    local itemEffectivity = ""
    local recipeEffectivity = ""
    local techEffectivity = ""
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
    if mods["space-age"] then
        recipeEffectivity.category = "electronics"
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
        --tech.icon = "__base__/graphics/technology/oil-refinery.png"
        techEffectivity.unit.count = inputs.tech.count
        techEffectivity.unit.ingredients = inputs.tech.packs
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
    local itemProductivity = ""
    local recipeProductivity = ""
    local techProductivity = ""
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
    if mods["space-age"] then
        recipeProductivity.category = "electronics"
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
        --tech.icon = "__base__/graphics/technology/oil-refinery.png"
        techProductivity.unit.count = inputs.tech.count
        techProductivity.unit.ingredients = inputs.tech.packs
        techProductivity.prerequisites = inputs.tech.prerequisites.productivity
        techProductivity.effects = {
            {
                type = "unlock-recipe",
                recipe = itemProductivity.name
            }
        }
        data:extend({ techProductivity })
    end
    -- Copy pollution module
    local itemPollution = ""
    local recipePollution = ""
    local techPollution = ""
    if inputs.tier == 2 or inputs.tier == 3 then
        itemPollution = table.deepcopy(data.raw.module["speed-module-" .. inputs.tier])
        recipePollution = table.deepcopy(data.raw.recipe["speed-module-" .. inputs.tier])
        techPollution = table.deepcopy(data.raw.technology["speed-module-" .. inputs.tier])
    else
        itemPollution = table.deepcopy(data.raw.module["speed-module"])
        recipePollution = table.deepcopy(data.raw.recipe["speed-module"])
        techPollution = table.deepcopy(data.raw.technology["speed-module"])
    end
    --Item
    itemPollution.name = "5d-pollution-module-" .. inputs.number
    itemPollution.icon =
        "__5dim_module__/graphics/icons/pollution-module/pollution-module-" .. inputs.number .. ".png"
    itemPollution.subgroup = "pollution"
    itemPollution.order = inputs.order
    itemPollution.effect = inputs.effects.pollution
    itemPollution.tier = inputs.tier
    itemPollution.localised_description = nil

    --Recipe
    recipePollution.name = itemPollution.name
    recipePollution.icon = itemPollution.icon
    if mods["space-age"] then
        recipePollution.category = "electronics"
    end
    recipePollution.results = { { type = "item", name = recipePollution.name, amount = 1 } }
    recipePollution.icon_size = 64
    if inputs.new then
        recipePollution.enabled = false
    end
    recipePollution.ingredients = inputs.ingredients.pollution
    recipePollution.energy_required = inputs.timeCraft

    data:extend({ recipePollution, itemPollution })

    -- Technology
    techPollution.name = "5d-pollution-module-" .. inputs.tech.number
    --tech.icon = "__base__/graphics/technology/oil-refinery.png"
    techPollution.unit.count = inputs.tech.count
    techPollution.unit.ingredients = inputs.tech.packs
    techPollution.prerequisites = inputs.tech.prerequisites.pollution
    techPollution.effects = {
        {
            type = "unlock-recipe",
            recipe = itemPollution.name
        }
    }
    data:extend({ techPollution })

    if mods['quality'] then
        -- Copy Quality module
        local itemQuality = ""
        local recipeQuality = ""
        local techQuality = ""
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
        if mods["space-age"] then
            recipeQuality.category = "electronics"
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
            --tech.icon = "__base__/graphics/technology/oil-refinery.png"
            techQuality.unit.count = inputs.tech.count
            techQuality.unit.ingredients = inputs.tech.packs
            techQuality.prerequisites = inputs.tech.prerequisites.quality
            techQuality.effects = {
                {
                    type = "unlock-recipe",
                    recipe = itemQuality.name
                }
            }
        end
        data:extend({ techQuality })
    end

    -- Copy merged module
    local itemMerged = ""
    local recipeMerged = ""
    local techMerged = ""
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
    local pollu = inputs.effects.pollution
    itemMerged.effect = {
        productivity = product.productivity,
        consumption = consump.consumption,
        pollution = pollu.pollution,
        speed = speed.speed,
    }
    itemMerged.tier = inputs.tier
    itemMerged.localised_description = nil

    --Recipe
    recipeMerged.name = itemMerged.name
    recipeMerged.icon = itemMerged.icon
    if mods["space-age"] then
        recipeMerged.category = "electronics"
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
    --tech.icon = "__base__/graphics/technology/oil-refinery.png"
    techMerged.unit.count = inputs.tech.count
    techMerged.unit.ingredients = inputs.tech.packs
    techMerged.prerequisites = inputs.tech.prerequisites.merged
    techMerged.effects = {
        {
            type = "unlock-recipe",
            recipe = itemMerged.name
        }
    }
    data:extend({ techMerged })
end
