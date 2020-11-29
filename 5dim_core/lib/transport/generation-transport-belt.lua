function genTransportBelts(inputs)
    --Set name
    local transportBeltName = inputs.copy.name.preName .. "transport-belt" .. inputs.copy.name.postName
    local undergroundName = inputs.copy.name.preName .. "underground-belt" .. inputs.copy.name.postName
    local splitterName = inputs.copy.name.preName .. "splitter" .. inputs.copy.name.postName
    local loaderName = inputs.copy.name.preName .. "loader" .. inputs.copy.name.postName

    -- Technology
    local tech = table.deepcopy(data.raw.technology[inputs.copy.tech])
    local loaderTech = table.deepcopy(data.raw.technology[inputs.copy.tech])

    -- Copy transport belt
    local itemTransportBelt = table.deepcopy(data.raw.item[transportBeltName])
    local recipeTransportBelt = table.deepcopy(data.raw.recipe[transportBeltName])
    local entityTransportBelt = table.deepcopy(data.raw["transport-belt"][transportBeltName])

    --Items
    -- transport belt
    if inputs.new then
        itemTransportBelt.name = "5d-transport-belt-" .. inputs.number
    end
    itemTransportBelt.icon =
        "__5dim_transport__/graphics/icon/transport-belt/transport-belt-icon-" .. inputs.number .. ".png"
    itemTransportBelt.subgroup = "transport-belt"
    itemTransportBelt.order = inputs.order
    itemTransportBelt.place_result = itemTransportBelt.name

    --Recipe
    recipeTransportBelt.name = itemTransportBelt.name
    recipeTransportBelt.icon = itemTransportBelt.icon
    recipeTransportBelt.result = itemTransportBelt.name
    recipeTransportBelt.icon_size = 64
    if recipeTransportBelt.normal == nil then
        recipeTransportBelt.ingredients = inputs.ingredients.transportBelt
        recipeTransportBelt.result = itemTransportBelt.name
        if inputs.new then
            recipeTransportBelt.enabled = false
        end
    else
        if inputs.new then
            recipeTransportBelt.enabled = false
        end
        recipeTransportBelt.enabled = false
        if inputs.new then
            recipeTransportBelt.ingredients = inputs.ingredients.transportBelt
            recipeTransportBelt.result = itemTransportBelt.name
            recipeTransportBelt.normal = nil
            recipeTransportBelt.expensive = nil
        else
            recipeTransportBelt.normal.ingredients = inputs.ingredients.transportBelt
            recipeTransportBelt.normal.result = itemTransportBelt.name
        end
    end

    --Entity
    entityTransportBelt.name = itemTransportBelt.name
    entityTransportBelt.next_upgrade = inputs.nextUpdate.transportBelt or nil
    entityTransportBelt.icon = itemTransportBelt.icon
    entityTransportBelt.minable.result = itemTransportBelt.name
    entityTransportBelt.speed = inputs.speed

    -- East
    if inputs.number ~= "01" then
        entityTransportBelt.belt_animation_set.animation_set.hr_version.filename =
            "__5dim_transport__/graphics/entities/transport-belt/transport-belt-" .. inputs.number .. ".png"
    end

    data:extend({entityTransportBelt, recipeTransportBelt, itemTransportBelt})

    -- Copy underground transport belt
    local itemUndergroundBelt = table.deepcopy(data.raw.item[undergroundName])
    local recipeUndergroundBelt = table.deepcopy(data.raw.recipe[undergroundName])
    local entityUndergroundBelt = table.deepcopy(data.raw["underground-belt"][undergroundName])

    -- underground transport belt
    if inputs.new then
        itemUndergroundBelt.name = "5d-underground-belt-" .. inputs.number
    end
    itemUndergroundBelt.icon =
        "__5dim_transport__/graphics/icon/underground-belt/underground-belt-icon-" .. inputs.number .. ".png"
    itemUndergroundBelt.subgroup = "transport-ground"
    itemUndergroundBelt.order = inputs.order
    itemUndergroundBelt.place_result = itemUndergroundBelt.name

    --Recipe
    recipeUndergroundBelt.name = itemUndergroundBelt.name
    recipeUndergroundBelt.icon = itemUndergroundBelt.icon
    recipeUndergroundBelt.icon_size = 64
    if recipeUndergroundBelt.normal == nil then
        recipeUndergroundBelt.ingredients = inputs.ingredients.groundBelt
        recipeUndergroundBelt.result = itemUndergroundBelt.name
        recipeUndergroundBelt.enabled = false
    else
        recipeUndergroundBelt.enabled = false
        if inputs.new then
            recipeUndergroundBelt.ingredients = inputs.ingredients.groundBelt
            recipeUndergroundBelt.result = itemUndergroundBelt.name
            recipeUndergroundBelt.normal = nil
            recipeUndergroundBelt.expensive = nil
        else
            recipeUndergroundBelt.normal.ingredients = inputs.ingredients.groundBelt
            recipeUndergroundBelt.normal.result = itemUndergroundBelt.name
        end
    end

    --Entity
    entityUndergroundBelt.name = itemUndergroundBelt.name
    entityUndergroundBelt.next_upgrade = inputs.nextUpdate.groundBelt or nil
    entityUndergroundBelt.icon = itemUndergroundBelt.icon
    entityUndergroundBelt.minable.result = itemUndergroundBelt.name
    entityUndergroundBelt.speed = inputs.speed

    if inputs.number ~= "01" then
        entityUndergroundBelt.belt_animation_set.animation_set.hr_version.filename =
            "__5dim_transport__/graphics/entities/transport-belt/transport-belt-" .. inputs.number .. ".png"
    end

    entityUndergroundBelt.structure.direction_in.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"
    entityUndergroundBelt.structure.direction_out.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"
    entityUndergroundBelt.structure.direction_in_side_loading.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"
    entityUndergroundBelt.structure.direction_out_side_loading.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"

    data:extend({entityUndergroundBelt, recipeUndergroundBelt, itemUndergroundBelt})

    -- Copy underground transport belt x30
    local itemUndergroundBelt30 = table.deepcopy(data.raw.item[undergroundName])
    local recipeUndergroundBelt30 = table.deepcopy(data.raw.recipe[undergroundName])
    local entityUndergroundBelt30 = table.deepcopy(data.raw["underground-belt"][undergroundName])

    -- underground transport belt
    itemUndergroundBelt30.name = "5d-" .. inputs.name.preName .. "underground-belt-30-" .. inputs.number
    itemUndergroundBelt30.icon =
        "__5dim_transport__/graphics/icon/underground-belt-30/underground-belt-icon-" .. inputs.number .. "-30.png"
    itemUndergroundBelt30.subgroup = "transport-ground-30"
    itemUndergroundBelt30.order = inputs.order
    itemUndergroundBelt30.place_result = itemUndergroundBelt30.name

    --Recipe
    recipeUndergroundBelt30.name = itemUndergroundBelt30.name
    recipeUndergroundBelt30.icon = itemUndergroundBelt30.icon
    recipeUndergroundBelt30.result = itemUndergroundBelt30.name
    recipeUndergroundBelt30.icon_size = 64
    recipeUndergroundBelt30.enabled = false
    if recipeUndergroundBelt30.normal == nil then
        recipeUndergroundBelt30.ingredients = inputs.ingredients.groundBelt30
        recipeUndergroundBelt30.result = itemUndergroundBelt30.name
        recipeUndergroundBelt30.enabled = false
    else
        recipeUndergroundBelt30.enabled = false
        if inputs.new then
            recipeUndergroundBelt30.ingredients = inputs.ingredients.groundBelt30
            recipeUndergroundBelt30.result = itemUndergroundBelt30.name
            recipeUndergroundBelt30.normal = nil
            recipeUndergroundBelt30.expensive = nil
        else
            recipeUndergroundBelt30.normal.ingredients = inputs.ingredients.groundBelt30
            recipeUndergroundBelt30.normal.result = itemUndergroundBelt30.name
        end
    end

    --Entity
    entityUndergroundBelt30.name = itemUndergroundBelt30.name
    entityUndergroundBelt30.next_upgrade = inputs.nextUpdate.groundBelt30 or nil
    entityUndergroundBelt30.icon = itemUndergroundBelt30.icon
    entityUndergroundBelt30.minable.result = itemUndergroundBelt30.name
    entityUndergroundBelt30.max_distance = 30
    entityUndergroundBelt30.speed = inputs.speed

    if inputs.number ~= "01" then
        entityUndergroundBelt30.belt_animation_set.animation_set.hr_version.filename =
            "__5dim_transport__/graphics/entities/transport-belt/transport-belt-" .. inputs.number .. ".png"
    end

    entityUndergroundBelt30.structure.direction_in.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"
    entityUndergroundBelt30.structure.direction_out.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"
    entityUndergroundBelt30.structure.direction_in_side_loading.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"
    entityUndergroundBelt30.structure.direction_out_side_loading.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"

    data:extend({entityUndergroundBelt30, recipeUndergroundBelt30, itemUndergroundBelt30})

    -- Copy underground transport belt x50
    local itemUndergroundBelt50 = table.deepcopy(data.raw.item[undergroundName])
    local recipeUndergroundBelt50 = table.deepcopy(data.raw.recipe[undergroundName])
    local entityUndergroundBelt50 = table.deepcopy(data.raw["underground-belt"][undergroundName])

    -- underground transport belt
    itemUndergroundBelt50.name = "5d-" .. inputs.name.preName .. "underground-belt-50-" .. inputs.number
    itemUndergroundBelt50.icon =
        "__5dim_transport__/graphics/icon/underground-belt-50/underground-belt-icon-" .. inputs.number .. "-50.png"
    itemUndergroundBelt50.subgroup = "transport-ground-50"
    itemUndergroundBelt50.order = inputs.order
    itemUndergroundBelt50.place_result = itemUndergroundBelt50.name

    --Recipe
    recipeUndergroundBelt50.name = itemUndergroundBelt50.name
    recipeUndergroundBelt50.icon = itemUndergroundBelt50.icon
    recipeUndergroundBelt50.result = itemUndergroundBelt50.name
    recipeUndergroundBelt50.icon_size = 64
    if recipeUndergroundBelt50.normal == nil then
        recipeUndergroundBelt50.ingredients = inputs.ingredients.groundBelt50
        recipeUndergroundBelt50.result = itemUndergroundBelt50.name
        recipeUndergroundBelt50.enabled = false
    else
        recipeUndergroundBelt50.enabled = false
        if inputs.new then
            recipeUndergroundBelt50.ingredients = inputs.ingredients.groundBelt50
            recipeUndergroundBelt50.result = itemUndergroundBelt50.name
            recipeUndergroundBelt50.normal = nil
            recipeUndergroundBelt50.expensive = nil
        else
            recipeUndergroundBelt50.normal.ingredients = inputs.ingredients.groundBelt50
            recipeUndergroundBelt50.normal.result = itemUndergroundBelt50.name
        end
    end

    --Entity
    entityUndergroundBelt50.name = itemUndergroundBelt50.name
    entityUndergroundBelt50.next_upgrade = inputs.nextUpdate.groundBelt50 or nil
    entityUndergroundBelt50.icon = itemUndergroundBelt50.icon
    entityUndergroundBelt50.minable.result = itemUndergroundBelt50.name
    entityUndergroundBelt50.max_distance = 50
    entityUndergroundBelt50.speed = inputs.speed

    if inputs.number ~= "01" then
        entityUndergroundBelt50.belt_animation_set.animation_set.hr_version.filename =
            "__5dim_transport__/graphics/entities/transport-belt/transport-belt-" .. inputs.number .. ".png"
    end

    entityUndergroundBelt50.structure.direction_in.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"
    entityUndergroundBelt50.structure.direction_out.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"
    entityUndergroundBelt50.structure.direction_in_side_loading.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"
    entityUndergroundBelt50.structure.direction_out_side_loading.sheet.hr_version.filename =
        "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. inputs.number .. ".png"

    data:extend({entityUndergroundBelt50, recipeUndergroundBelt50, itemUndergroundBelt50})

    -- Copy splitter transport belt
    local itemSplitter = table.deepcopy(data.raw.item[splitterName])
    local recipeSplitter = table.deepcopy(data.raw.recipe[splitterName])
    local entitySplitter = table.deepcopy(data.raw["splitter"][splitterName])

    -- underground transport belt
    if inputs.new then
        itemSplitter.name = "5d-splitter-" .. inputs.number
    end
    itemSplitter.icon = "__5dim_transport__/graphics/icon/splitter/splitter-icon-" .. inputs.number .. ".png"
    itemSplitter.subgroup = "transport-splitters"
    itemSplitter.order = inputs.order
    itemSplitter.place_result = itemSplitter.name

    --Recipe
    recipeSplitter.name = itemSplitter.name
    recipeSplitter.icon = itemSplitter.icon
    recipeSplitter.result = itemSplitter.name
    recipeSplitter.icon_size = 64
    if recipeSplitter.normal == nil then
        recipeSplitter.ingredients = inputs.ingredients.splitter
        recipeSplitter.result = itemSplitter.name
        recipeSplitter.enabled = false
    else
        recipeSplitter.enabled = false
        if inputs.new then
            recipeSplitter.ingredients = inputs.ingredients.splitter
            recipeSplitter.result = itemSplitter.name
            recipeSplitter.normal = nil
            recipeSplitter.expensive = nil
        else
            recipeSplitter.normal.ingredients = inputs.ingredients.splitter
            recipeSplitter.normal.result = itemSplitter.name
        end
    end

    --Entity
    entitySplitter.name = itemSplitter.name
    entitySplitter.next_upgrade = inputs.nextUpdate.splitter or nil
    entitySplitter.icon = itemSplitter.icon
    entitySplitter.minable.result = itemSplitter.name
    entitySplitter.speed = inputs.speed

    entitySplitter.belt_animation_set.animation_set.hr_version.filename =
        "__5dim_transport__/graphics/entities/transport-belt/transport-belt-" .. inputs.number .. ".png"

    entitySplitter.structure.north.hr_version.filename =
        "__5dim_transport__/graphics/entities/splitter/splitter-north/splitter-north-" .. inputs.number .. ".png"
    entitySplitter.structure.east.hr_version.filename =
        "__5dim_transport__/graphics/entities/splitter/splitter-east/splitter-east-" .. inputs.number .. ".png"
    entitySplitter.structure.south.hr_version.filename =
        "__5dim_transport__/graphics/entities/splitter/splitter-south/splitter-south-" .. inputs.number .. ".png"
    entitySplitter.structure.west.hr_version.filename =
        "__5dim_transport__/graphics/entities/splitter/splitter-west/splitter-west-" .. inputs.number .. ".png"

    entitySplitter.structure_patch.east.hr_version.filename =
        "__5dim_transport__/graphics/entities/splitter/splitter-east-top_patch/splitter-east-top_patch-" ..
        inputs.number .. ".png"
    entitySplitter.structure_patch.west.hr_version.filename =
        "__5dim_transport__/graphics/entities/splitter/splitter-west-top_patch/splitter-west-top_patch-" ..
        inputs.number .. ".png"

    if inputs.number == "01" or inputs.number == "02" then
        entitySplitter.structure.west.hr_version.width = 94
        entitySplitter.structure_patch.west.hr_version.width = 94
    end

    data:extend({entitySplitter, recipeSplitter, itemSplitter})

    -- Copy loader transport belt
    local itemLoader = table.deepcopy(data.raw.item[loaderName])
    local recipeLoader = table.deepcopy(data.raw.recipe[loaderName])
    local entityLoader = table.deepcopy(data.raw["loader"][loaderName])

    -- underground transport belt
    if inputs.new then
        itemLoader.name = "5d-loader-" .. inputs.number
    end
    itemLoader.icon = "__5dim_transport__/graphics/icon/loader/loader-icon-" .. inputs.number .. ".png"
    itemLoader.icon_size = 64
    itemLoader.subgroup = "transport-loader"
    itemLoader.order = inputs.order
    itemLoader.flags = nil
    itemLoader.place_result = itemLoader.name

    --Recipe
    recipeLoader.name = itemLoader.name
    recipeLoader.icon = itemLoader.icon
    recipeLoader.result = itemLoader.name
    recipeLoader.icon_size = 64
    if recipeLoader.normal == nil then
        recipeLoader.ingredients = inputs.ingredients.loader
        recipeLoader.result = itemLoader.name
        recipeLoader.enabled = false
    else
        recipeLoader.enabled = false
        if inputs.new then
            recipeLoader.ingredients = inputs.ingredients.loader
            recipeLoader.result = itemLoader.name
            recipeLoader.normal = nil
            recipeLoader.expensive = nil
        else
            recipeLoader.normal.ingredients = inputs.ingredients.loader
            recipeLoader.normal.result = itemLoader.name
        end
    end
    recipeLoader.hidden = false

    --Entity
    entityLoader.name = itemLoader.name
    entityLoader.next_upgrade = inputs.nextUpdate.loader or nil
    entityLoader.icon = itemLoader.icon
    entityLoader.minable.result = itemLoader.name
    entityLoader.speed = inputs.speed

    if inputs.number ~= "01" then
        entityLoader.belt_animation_set.animation_set.hr_version.filename =
            "__5dim_transport__/graphics/entities/transport-belt/transport-belt-" .. inputs.number .. ".png"
    end

    entityLoader.structure.direction_in.sheet.filename =
        "__5dim_transport__/graphics/entities/loader/loader-" .. inputs.number .. ".png"
    entityLoader.structure.direction_in.sheet.width = 128
    entityLoader.structure.direction_in.sheet.height = 128
    entityLoader.structure.direction_out.sheet.filename =
        "__5dim_transport__/graphics/entities/loader/loader-" .. inputs.number .. ".png"
    entityLoader.structure.direction_out.sheet.width = 128
    entityLoader.structure.direction_out.sheet.height = 128
    entityLoader.structure.direction_out.sheet.y = 128
    entityLoader.flags = nil
    data:extend({entityLoader, recipeLoader, itemLoader})

    -- Technology
    if inputs.tech then
        tech.name = "logistics-" .. inputs.tech.number
        -- tech.icon = itemTransportBelt.icon
        -- tech.icon_size = 64
        tech.unit.count = inputs.tech.count
        tech.unit.ingredients = inputs.tech.packs
        tech.prerequisites = inputs.tech.prerequisites
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = itemTransportBelt.name
            },
            {
                type = "unlock-recipe",
                recipe = itemUndergroundBelt.name
            },
            {
                type = "unlock-recipe",
                recipe = itemSplitter.name
            },
            {
                type = "unlock-recipe",
                recipe = itemUndergroundBelt30.name
            },
            {
                type = "unlock-recipe",
                recipe = itemUndergroundBelt50.name
            },
            {
                type = "unlock-recipe",
                recipe = entityLoader.name
            }
        }
        data:extend({tech})
    end
end
