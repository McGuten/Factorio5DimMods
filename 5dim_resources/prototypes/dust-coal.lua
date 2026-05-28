local DustCommon = require("prototypes.dust-common")

data:extend({
    {
        type = "item",
        name = "5d-coal-dust",
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/coal.png", DustCommon.tints.coal),
        subgroup = "plates-dust",
        order = "d",
        stack_size = 200
    },
    {
        type = "item",
        name = "5d-refined-coal",
        icons = DustCommon.make_dust_icons(
            "__base__/graphics/icons/coal.png",
            DustCommon.tints.refined_coal,
            { overlay_scale = 0.72, overlay_shift = { 0, 0 } }
        ),
        subgroup = "plates-fuel",
        order = "b-a",
        fuel_category = "chemical",
        fuel_value = "8MJ",
        stack_size = 50
    },
    {
        type = "recipe",
        name = "5d-coal-dust",
        enabled = false,
        category = "mashering",
        subgroup = "plates-fuel",
        order = "b[coal]-a[5d-coal-dust]",
        energy_required = 3.2,
        allow_productivity = true,
        icons = DustCommon.make_dust_icons("__base__/graphics/icons/coal.png", DustCommon.tints.coal),
        ingredients = {
            { type = "item", name = "coal", amount = 1 }
        },
        results = {
            { type = "item", name = "5d-coal-dust", amount = 2 }
        }
    },
    {
        type = "recipe",
        name = "5d-refined-coal",
        enabled = false,
        category = "chemistry",
        subgroup = "plates-fuel",
        order = "b[coal]-b[5d-refined-coal]",
        energy_required = 2,
        allow_productivity = true,
        icons = DustCommon.make_dust_icons(
            "__base__/graphics/icons/coal.png",
            DustCommon.tints.refined_coal,
            { overlay_scale = 0.72, overlay_shift = { 0, 0 } }
        ),
        ingredients = {
            { type = "item",  name = "5d-coal-dust", amount = 2 },
            { type = "fluid", name = "sulfuric-acid", amount = 10 }
        },
        results = {
            { type = "item", name = "5d-refined-coal", amount = 1 }
        }
    }
})

if mods["space-age"] then
    local function add_unlock(technology_name, recipe_name)
        local technology = data.raw.technology[technology_name]

        if not technology or not technology.effects then
            return
        end

        table.insert(technology.effects, {
            type = "unlock-recipe",
            recipe = recipe_name
        })
    end

    local function add_coal_dust_variant(source_recipe_name, variant_recipe_name)
        local source_recipe = data.raw.recipe[source_recipe_name]

        if not source_recipe or data.raw.recipe[variant_recipe_name] then
            return false
        end

        local variant_recipe = table.deepcopy(source_recipe)
        local replaced = false

        variant_recipe.name = variant_recipe_name

        for _, ingredient in pairs(variant_recipe.ingredients or {}) do
            if ingredient.type == "item" and ingredient.name == "coal" then
                ingredient.name = "5d-coal-dust"
                replaced = true
            end
        end

        if not replaced then
            return false
        end

        if variant_recipe.order then
            variant_recipe.order = variant_recipe.order .. "-b[5d]"
        end

        data:extend({ variant_recipe })

        return true
    end

    if add_coal_dust_variant("simple-coal-liquefaction", "5d-simple-coal-liquefaction") then
        add_unlock("calcite-processing", "5d-simple-coal-liquefaction")
    end

    if add_coal_dust_variant("carbon", "5d-carbon-from-coal-dust") then
        add_unlock("tungsten-carbide", "5d-carbon-from-coal-dust")
    end
end