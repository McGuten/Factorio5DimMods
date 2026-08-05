function genBoilers(inputs)
    -- Copy electric furnace
    local item = table.deepcopy(data.raw.item["boiler"])
    local recipe = table.deepcopy(data.raw.recipe["boiler"])
    local entity = table.deepcopy(data.raw["boiler"]["boiler"])
    local tech = table.deepcopy(data.raw.technology["advanced-oil-processing"])

    --Item
    if inputs.new then
        item.name = "5d-boiler-" .. inputs.number
    end
    item.icon =
        "__5dim_energy__/graphics/icon/boiler/boiler-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    if inputs.new then
        recipe.enabled = false
        recipe.results = { { type = "item", name = item.name, amount = 1 } }
        recipe.ingredients = inputs.ingredients
    end
    if inputs.recipeCategory then recipe.categories = { inputs.recipeCategory } end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    -- energy_consumption es la produccion de vapor: 1 unidad de vapor a 165 grados
    -- cuesta 30kJ, asi que 1.8MW dan los 60 vapor/s de vanilla. La effectivity del
    -- burner se deja en el 1 de vanilla: escalarla haria que un boiler de tier alto
    -- produjese mas vapor del que justifica su combustible.
    entity.energy_consumption = inputs.craftingSpeed .. "MW"
    entity.energy_source.emissions_per_minute = inputs.pollution
    entity.fast_replaceable_group = "boiler"

    -- North
    entity.pictures.north.structure.layers[1].filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-N-idle/boiler-N-idle-" .. inputs.number .. ".png"
    -- East
    entity.pictures.east.structure.layers[1].filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-E-idle/boiler-E-idle-" .. inputs.number .. ".png"
    -- South
    entity.pictures.south.structure.layers[1].filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-S-idle/boiler-S-idle-" .. inputs.number .. ".png"
    -- West
    entity.pictures.west.structure.layers[1].filename =
        "__5dim_energy__/graphics/entities/boiler/boiler-W-idle/boiler-W-idle-" .. inputs.number .. ".png"

    data:extend({entity, recipe, item})

    -- Technology
    if inputs.tech then
        tech.name = "5d-boiler-" .. inputs.tech.number
        tech.icon = item.icon
        tech.icon_size = 64
        tech.unit.count = inputs.tech.count
        tech.unit.ingredients = inputs.tech.packs
        tech.prerequisites = inputs.tech.prerequisites
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = item.name
            }
        }
        data:extend({tech})
    end
end
