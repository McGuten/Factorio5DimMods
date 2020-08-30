function genSteamEngines(inputs)
    -- Copy electric furnace
    local itemSteamEngine = table.deepcopy(data.raw.item["steam-engine"])
    local recipeSteamEngine = table.deepcopy(data.raw.recipe["steam-engine"])
    local entitySteamEngine = table.deepcopy(data.raw["generator"]["steam-engine"])
    local technologySteamEngine = table.deepcopy(data.raw.technology["electric-energy-accumulators"])

    --Item
    if inputs.new then
        itemSteamEngine.name = "5d-steam-engine-" .. inputs.number
    end
    -- itemSteamEngine.icon =
    --     "__5dim_energy__/graphics/icon/steam-engine/steam-engine-icon-" .. inputs.number .. ".png"
    itemSteamEngine.subgroup = inputs.subgroup
    itemSteamEngine.order = inputs.order
    itemSteamEngine.place_result = itemSteamEngine.name

    --Recipe
    recipeSteamEngine.name = itemSteamEngine.name
    -- recipeSteamEngine.icon = itemSteamEngine.icon
    recipeSteamEngine.result = itemSteamEngine.name
    recipeSteamEngine.icon_size = 64
    if inputs.new then
        recipeSteamEngine.enabled = false
    end
    if recipeSteamEngine.normal == nil then
        recipeSteamEngine.result = itemSteamEngine.name
        if inputs.new then
            recipeSteamEngine.enabled = false
        end
        recipeSteamEngine.ingredients = inputs.ingredients
    else
        recipeSteamEngine.normal.result = itemSteamEngine.name
        if inputs.new then
            recipeSteamEngine.normal.enabled = false
        end
        recipeSteamEngine.normal.ingredients = inputs.ingredients
        recipeSteamEngine.expensive.result = itemSteamEngine.name
        if inputs.new then
            recipeSteamEngine.normal.enabled = false
        end
        recipeSteamEngine.expensive.ingredients = inputs.ingredients
    end

    --Entity
    entitySteamEngine.name = itemSteamEngine.name
    -- entitySteamEngine.icon = itemSteamEngine.icon
    entitySteamEngine.minable.result = itemSteamEngine.name
    entitySteamEngine.effectivity = inputs.craftingSpeed
    entitySteamEngine.fluid_usage_per_tick = inputs.energyUsage

    -- Base
    -- entitySteamEngine.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/SteamEngine/SteamEngine-" .. inputs.number .. ".png"

    data:extend({entitySteamEngine, recipeSteamEngine, itemSteamEngine})

    -- Technology
    if inputs.tech then
        technologySteamEngine.name = "5d-steam-engine-" .. inputs.tech.number
        --technologySteamEngine.icon = "__base__/graphics/technology/oil-refinery.png"
        technologySteamEngine.unit.count = inputs.tech.count
        technologySteamEngine.unit.ingredients = inputs.tech.packs
        technologySteamEngine.prerequisites = inputs.tech.prerequisites
        technologySteamEngine.effects = {
            {
                type = "unlock-recipe",
                recipe = itemSteamEngine.name
            }
        }
        data:extend({technologySteamEngine})
    end
end