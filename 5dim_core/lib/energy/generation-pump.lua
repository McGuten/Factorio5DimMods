function genPumps(inputs)
    -- Copy electric furnace
    itemPump = table.deepcopy(data.raw.item["pump"])
    recipePump = table.deepcopy(data.raw.recipe["pump"])
    entityPump = table.deepcopy(data.raw["pump"]["pump"])
    technologyPump = table.deepcopy(data.raw.technology["oil-processing"])

    --Item
    if inputs.new then
        itemPump.name = "5d-pump-" .. inputs.number
    end
    -- itemPump.icon =
    --     "__5dim_energy__/graphics/icon/pump/pump-icon-" .. inputs.number .. ".png"
    itemPump.subgroup = inputs.subgroup
    itemPump.order = inputs.order
    itemPump.place_result = itemPump.name

    --Recipe
    recipePump.name = itemPump.name
    -- recipePump.icon = itemPump.icon
    recipePump.result = itemPump.name
    recipePump.icon_size = 64
    if inputs.new then
        recipePump.enabled = false
    end
    recipePump.ingredients = inputs.ingredients

    --Entity
    entityPump.name = itemPump.name
    -- entityPump.icon = itemPump.icon
    entityPump.minable.result = itemPump.name
    entityPump.pumping_speed = inputs.craftingSpeed
    entityPump.energy_usage = inputs.energyUsage .. "kW"

    -- North
    -- entityPump.animations.north.hr_version.filename =
    --     "__5dim_energy__/graphics/entities/offshore-pump/north/offshore-pump-north-" .. inputs.number .. ".png"

    -- -- East
    -- entityPump.animations.east.hr_version.filename =
    --     "__5dim_energy__/graphics/entities/offshore-pump/east/offshore-pump-east-" .. inputs.number .. ".png"

    -- -- South
    -- entityPump.animations.south.hr_version.filename =
    --     "__5dim_energy__/graphics/entities/offshore-pump/south/offshore-pump-south-" .. inputs.number .. ".png"

    -- -- West
    -- entityPump.animations.west.hr_version.filename =
    --     "__5dim_energy__/graphics/entities/offshore-pump/west/offshore-pump-west-" .. inputs.number .. ".png"

    data:extend({entityPump, recipePump, itemPump})

    -- Technology
    if inputs.tech then
        technologyPump.name = "5d-pump-" .. inputs.tech.number
        technologyPump.icon = itemPump.icon
        technologyPump.icon_size = 64
        technologyPump.unit.count = inputs.tech.count
        technologyPump.unit.ingredients = inputs.tech.packs
        technologyPump.prerequisites = inputs.tech.prerequisites
        technologyPump.effects = {
            {
                type = "unlock-recipe",
                recipe = itemPump.name
            }
        }
        data:extend({technologyPump})
    end
end
