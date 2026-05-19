local RepairSpeedScaling = require("__5dim_core__.lib.repair-speed-scaling")

local function applyWallTintToSprite(sprite, tint, inheritedShadow)
    if type(sprite) ~= "table" or not tint then
        return
    end

    local isShadow = inheritedShadow or sprite.draw_as_shadow
    if (sprite.filename or sprite.filenames or sprite.stripes) and not isShadow then
        sprite.tint = tint
    end

    for key, value in pairs(sprite) do
        if key ~= "tint" and type(value) == "table" then
            applyWallTintToSprite(value, tint, isShadow)
        end
    end
end

local function applyWallTint(entity, tint)
    if not entity or not entity.pictures or not tint then
        return
    end

    applyWallTintToSprite(entity.pictures, tint, false)
end

function genStoneWalls(inputs)
    if not inputs.new then
        local entity = data.raw.wall["stone-wall"]
        if not entity then
            return
        end

        entity.resistances = inputs.resistances or entity.resistances
        entity.hide_resistances = false
        applyWallTint(entity, inputs.tint)
        return
    end
    
    -- Copy stone wall
    local item = table.deepcopy(data.raw.item["stone-wall"])
    local recipe = table.deepcopy(data.raw.recipe["stone-wall"])
    local entity = table.deepcopy(data.raw["wall"]["stone-wall"])
    local tech = table.deepcopy(data.raw.technology["stone-wall"])

    --Item
    item.name = "5d-stone-wall-" .. inputs.number
    item.icon =
        "__5dim_battlefield__/graphics/icon/stone-wall/stone-wall-icon-" .. inputs.number .. ".png"
    item.subgroup = inputs.subgroup
    item.order = inputs.order
    item.place_result = item.name

    --Recipe
    recipe.name = item.name
    recipe.icon = item.icon
    recipe.icon_size = 64
    recipe.enabled = false
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.ingredients = inputs.ingredients
    if inputs.recipeCategory then
        recipe.category = inputs.recipeCategory
    end

    --Entity
    entity.name = item.name
    entity.next_upgrade = inputs.nextUpdate or nil
    entity.icon = item.icon
    entity.minable.result = item.name
    entity.max_health = inputs.health
    entity.repair_speed_modifier = inputs.repairSpeedModifier or RepairSpeedScaling.linear(inputs.repairBaseHealth or 350, entity.max_health)
    entity.fast_replaceable_group = "wall"
    if inputs.resistances then
        entity.resistances = inputs.resistances
        entity.hide_resistances = false
    end
    applyWallTint(entity, inputs.tint)

    -- Base
    -- entity.picture.layers[1].hr_version.filename =
    --     "__5dim_energy__/graphics/entities/laser-turret/laser-turret-" .. inputs.number .. ".png"

    data:extend({ entity, recipe, item })

    -- Technology
    if inputs.tech then
        tech.name = "stone-wall-" .. inputs.tech.number
        tech.unit.count = inputs.tech.count
        tech.unit.ingredients = inputs.tech.packs
        tech.prerequisites = inputs.tech.prerequisites
        tech.effects = {
            {
                type = "unlock-recipe",
                recipe = item.name
            }
        }
        data:extend({ tech })
    end
end
