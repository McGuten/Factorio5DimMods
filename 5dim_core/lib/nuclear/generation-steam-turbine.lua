function genSteamTurbines(inputs)
    -- Copy electric furnace
    local itemSteamTurbine = table.deepcopy(data.raw.item["steam-turbine"])
    local recipeSteamTurbine = table.deepcopy(data.raw.recipe["steam-turbine"])
    local entitySteamTurbine = table.deepcopy(data.raw["generator"]["steam-turbine"])
    local technologySteamTurbine = table.deepcopy(data.raw.technology["nuclear-power"])

    --Item
    if inputs.new then
        itemSteamTurbine.name = "5d-steam-turbine-" .. inputs.number
    end
    -- itemSteamTurbine.icon =
    --     "__5dim_energy__/graphics/icon/steam-turbine/steam-turbine-icon-" .. inputs.number .. ".png"
    itemSteamTurbine.subgroup = inputs.subgroup
    itemSteamTurbine.order = inputs.order
    itemSteamTurbine.place_result = itemSteamTurbine.name

    --Recipe
    recipeSteamTurbine.name = itemSteamTurbine.name
    -- recipeSteamTurbine.icon = itemSteamTurbine.icon
    recipeSteamTurbine.result = itemSteamTurbine.name
    recipeSteamTurbine.icon_size = 64
    if inputs.new then
        recipeSteamTurbine.enabled = true
    end
    if recipeSteamTurbine.normal == nil then
        recipeSteamTurbine.result = itemSteamTurbine.name
        if inputs.new then
            recipeSteamTurbine.enabled = false
        end
        recipeSteamTurbine.ingredients = inputs.ingredients
    else
        recipeSteamTurbine.normal.result = itemSteamTurbine.name
        if inputs.new then
            recipeSteamTurbine.normal.enabled = false
        end
        recipeSteamTurbine.normal.ingredients = inputs.ingredients
        recipeSteamTurbine.expensive.result = itemSteamTurbine.name
        if inputs.new then
            recipeSteamTurbine.normal.enabled = false
        end
        recipeSteamTurbine.expensive.ingredients = inputs.ingredients
    end

    --Entity
    entitySteamTurbine.name = itemSteamTurbine.name
    -- entitySteamTurbine.icon = itemSteamTurbine.icon
    entitySteamTurbine.minable.result = itemSteamTurbine.name
    entitySteamTurbine.effectivity = inputs.craftingSpeed
    entitySteamTurbine.fluid_usage_per_tick = inputs.energyUsage
    entitySteamTurbine.fast_replaceable_group = "steam-turbine"

    -- Base
    -- entitySteamTurbine.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/steam-turbine/steam-turbine-" .. inputs.number .. ".png"

    data:extend({entitySteamTurbine, recipeSteamTurbine, itemSteamTurbine})

    -- Technology
    if inputs.tech then
        technologySteamTurbine.name = "5d-steam-turbine-" .. inputs.tech.number
        technologySteamTurbine.icon = itemSteamTurbine.icon
        technologySteamTurbine.icon_size = 64
        technologySteamTurbine.unit.count = inputs.tech.count
        technologySteamTurbine.unit.ingredients = inputs.tech.packs
        technologySteamTurbine.prerequisites = inputs.tech.prerequisites
        technologySteamTurbine.effects = {
            {
                type = "unlock-recipe",
                recipe = itemSteamTurbine.name
            }
        }
        data:extend({technologySteamTurbine})
    end
end