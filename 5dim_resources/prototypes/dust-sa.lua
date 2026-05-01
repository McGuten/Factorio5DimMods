-------------------------------------------------------------------------------
-- 5Dim's Resources - Space Age planetary dust & alt recipes
-- Aplica el patron del hierro (1 ore -> 2 dust) a los materiales SA, manteniendo
-- la mecanica original de cada planeta:
--   Vulcanus: foundry + molten-iron
--   Fulgora:  chemistry + holmium-solution + EM plant
--   Gleba:    biochamber + seed probability
--   Aquilo:   ammonia + lithium-brine + cryogenic chemistry
-- Beneficio neto objetivo: 2x respecto al ore/fruta vanilla.
-- Gated por mods["space-age"]; recetas desbloqueadas en tech-sa.lua.
-------------------------------------------------------------------------------

if not mods["space-age"] then
    return
end

local items = {}
local recipes = {}

---------------------------------------------------------------------------
-- VULCANUS: Tungsten
-- Vanilla: 4 ore + 10 molten-iron -> 1 plate (foundry)
-- 5dim:    1 ore -> 2 dust (masher)
--          4 dust + 10 molten-iron -> 1 plate (foundry, metallurgy)
-- Net: 2 ore -> 1 plate (vs vanilla 4:1) = 2x
---------------------------------------------------------------------------
table.insert(items, {
    type      = "item",
    name      = "5d-tungsten-dust",
    icons = {
        {
            icon = "__space-age__/graphics/icons/tungsten-ore.png",
            icon_size = 64
        },
        {
            icon = "__5dim_resources__/graphics/icon/resources/5d-iron-dust.png",
            icon_size = 32,
            scale = 0.85,
            shift = { 10, 10 }
        }
    },
    subgroup  = "plates-dust",
    order     = "k",
    stack_size = 100
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-tungsten-dust",
    enabled         = false,
    subgroup        = "vulcanus-metallurgy-tungsten",
    order           = "c[tungsten]-b[5d-tungsten-dust]",
    icons = {
        {
            icon = "__space-age__/graphics/icons/tungsten-ore.png",
            icon_size = 64
        },
        {
            icon = "__5dim_resources__/graphics/icon/resources/5d-iron-dust.png",
            icon_size = 32,
            scale = 0.85,
            shift = { 10, 10 }
        }
    },
    category        = "mashering",
    energy_required = 3.2,
    allow_productivity = true,
    ingredients = { { type = "item", name = "tungsten-ore", amount = 1 } },
    results     = { { type = "item", name = "5d-tungsten-dust", amount = 2 } }
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-tungsten-plate",
    icon            = "__space-age__/graphics/icons/tungsten-plate.png",
    icon_size       = 64,
    subgroup        = "vulcanus-metallurgy-tungsten",
    order           = "c[tungsten]-d[5d-tungsten-plate]",
    enabled         = false,
    category        = "metallurgy",
    energy_required = 10,
    allow_productivity = true,
    ingredients = {
        { type = "item",  name = "5d-tungsten-dust", amount = 4 },
        { type = "fluid", name = "molten-iron",     amount = 10 }
    },
    results = { { type = "item", name = "tungsten-plate", amount = 1 } }
})

---------------------------------------------------------------------------
-- FULGORA: Holmium
-- Vanilla: 2 ore + 1 stone + 10 water -> 100 solution (chemistry, EM plant)
-- 5dim:    1 ore -> 2 dust (masher)
--          2 dust + 1 stone + 10 water -> 100 solution (chemistry, EM plant)
-- Net: 1 ore -> 100 sol (vs vanilla 2 ore -> 100 sol) = 2x
---------------------------------------------------------------------------
table.insert(items, {
    type      = "item",
    name      = "5d-holmium-dust",
    icons = {
        {
            icon = "__space-age__/graphics/icons/holmium-ore.png",
            icon_size = 64
        },
        {
            icon = "__5dim_resources__/graphics/icon/resources/5d-iron-dust.png",
            icon_size = 32,
            scale = 0.85,
            shift = { 10, 10 }
        }
    },
    subgroup  = "plates-dust",
    order     = "m",
    stack_size = 100
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-holmium-dust",
    enabled         = false,
    subgroup        = "fulgora-resources",
    order           = "b[holmium]-b[5d-holmium-dust]",
    icons = {
        {
            icon = "__space-age__/graphics/icons/holmium-ore.png",
            icon_size = 64
        },
        {
            icon = "__5dim_resources__/graphics/icon/resources/5d-iron-dust.png",
            icon_size = 32,
            scale = 0.85,
            shift = { 10, 10 }
        }
    },
    category        = "mashering",
    energy_required = 3.2,
    allow_productivity = true,
    ingredients = { { type = "item", name = "holmium-ore", amount = 1 } },
    results     = { { type = "item", name = "5d-holmium-dust", amount = 2 } }
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-holmium-solution",
    icon            = "__space-age__/graphics/icons/fluid/holmium-solution.png",
    icon_size       = 64,
    subgroup        = "fulgora-liquids",
    order           = "b[holmium]-c[5d-holmium-solution]",
    enabled         = false,
    category        = "chemistry",
    energy_required = 10,
    allow_productivity = true,
    ingredients = {
        { type = "item",  name = "5d-holmium-dust", amount = 2 },
        { type = "item",  name = "stone",           amount = 1 },
        { type = "fluid", name = "water",           amount = 10 }
    },
    results     = { { type = "fluid", name = "holmium-solution", amount = 100 } },
    main_product = "holmium-solution"
})

---------------------------------------------------------------------------
-- GLEBA: Yumako & Jellynut
-- Vanilla yumako: 1 yumako -> 2 mash + 2% seed (organic, biochamber)
-- 5dim:           1 yumako -> 4 mash + 2% seed (organic, biochamber)
-- Vanilla jellynut: 1 -> 4 jelly + 2% seed
-- 5dim:             1 -> 8 jelly + 2% seed
-- Net: 2x. Mantiene biochamber y probabilidad de semilla.
-- Penalizacion: tiempo de receta x2 para que la mecanica de freshness aporte coste.
---------------------------------------------------------------------------
table.insert(recipes, {
    type            = "recipe",
    name            = "5d-yumako-processing",
    icon            = "__space-age__/graphics/icons/yumako-processing.png",
    icon_size       = 64,
    subgroup        = "gleba-agricultural-processing",
    order           = "a[seeds]-a[5d-yumako-processing]",
    enabled         = false,
    category        = "organic-or-hand-crafting",
    energy_required = 2,
    allow_productivity = true,
    ingredients = { { type = "item", name = "yumako", amount = 1 } },
    results = {
        { type = "item", name = "yumako-seed", amount = 1, probability = 0.02 },
        { type = "item", name = "yumako-mash", amount = 4 }
    }
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-jellynut-processing",
    icon            = "__space-age__/graphics/icons/jellynut-processing.png",
    icon_size       = 64,
    subgroup        = "gleba-agricultural-processing",
    order           = "a[seeds]-b[5d-jellynut-processing]",
    enabled         = false,
    category        = "organic-or-hand-crafting",
    energy_required = 2,
    allow_productivity = true,
    ingredients = { { type = "item", name = "jellynut", amount = 1 } },
    results = {
        { type = "item", name = "jellynut-seed", amount = 1, probability = 0.02 },
        { type = "item", name = "jelly",         amount = 8 }
    }
})

---------------------------------------------------------------------------
-- VULCANUS: Calcite (catalizador 2x)
-- Vanilla:
--   molten-iron-from-lava:   500 lava + 1 calcite -> 250 molten-iron + 10 stone
--   molten-copper-from-lava: 500 lava + 1 calcite -> 250 molten-copper + 15 stone
-- 5dim:
--   1 calcite -> 2 calcite-dust (masher)
--   500 lava + 1 calcite-dust -> 250 molten-iron + 10 stone (foundry)
--   500 lava + 1 calcite-dust -> 250 molten-copper + 15 stone (foundry)
-- Net: el catalizador rinde 2x (1 calcite produce 500 molten en vez de 250).
-- Mantiene foundry, lava, stone byproduct y la mecanica catalitica vanilla.
---------------------------------------------------------------------------
table.insert(items, {
    type      = "item",
    name      = "5d-calcite-dust",
    icons = {
        {
            icon = "__space-age__/graphics/icons/calcite.png",
            icon_size = 64
        },
        {
            icon = "__5dim_resources__/graphics/icon/resources/5d-iron-dust.png",
            icon_size = 32,
            scale = 0.85,
            shift = { 10, 10 }
        }
    },
    subgroup  = "plates-dust",
    order     = "n",
    stack_size = 100
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-calcite-dust",
    enabled         = false,
    subgroup        = "vulcanus-metallurgy-tungsten",
    order           = "a[melting]-b[5d-calcite-dust]",
    icons = {
        {
            icon = "__space-age__/graphics/icons/calcite.png",
            icon_size = 64
        },
        {
            icon = "__5dim_resources__/graphics/icon/resources/5d-iron-dust.png",
            icon_size = 32,
            scale = 0.85,
            shift = { 10, 10 }
        }
    },
    category        = "mashering",
    energy_required = 3.2,
    allow_productivity = true,
    ingredients = { { type = "item", name = "calcite", amount = 1 } },
    results     = { { type = "item", name = "5d-calcite-dust", amount = 2 } }
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-molten-iron-from-lava",
    icon            = "__space-age__/graphics/icons/fluid/molten-iron-from-lava.png",
    icon_size       = 64,
    subgroup        = "vulcanus-metallurgy",
    order           = "a[melting]-a[lava-a]-b[5d]",
    auto_recycle    = false,
    enabled         = false,
    category        = "metallurgy",
    energy_required = 16,
    allow_productivity = true,
    ingredients = {
        { type = "fluid", name = "lava",            amount = 500 },
        { type = "item",  name = "5d-calcite-dust", amount = 1 }
    },
    results = {
        { type = "fluid", name = "molten-iron", amount = 250 },
        { type = "item",  name = "stone",       amount = 10 }
    },
    main_product = "molten-iron"
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-molten-copper-from-lava",
    icon            = "__space-age__/graphics/icons/fluid/molten-copper-from-lava.png",
    icon_size       = 64,
    subgroup        = "vulcanus-metallurgy",
    order           = "a[melting]-a[lava-b]-b[5d]",
    auto_recycle    = false,
    enabled         = false,
    category        = "metallurgy",
    energy_required = 16,
    allow_productivity = true,
    ingredients = {
        { type = "fluid", name = "lava",            amount = 500 },
        { type = "item",  name = "5d-calcite-dust", amount = 1 }
    },
    results = {
        { type = "fluid", name = "molten-copper", amount = 250 },
        { type = "item",  name = "stone",         amount = 15 }
    },
    main_product = "molten-copper"
})

---------------------------------------------------------------------------
-- FULGORA: Scrap (compactacion -> recycler)
-- Vanilla scrap-recycling: 1 scrap -> outputs con probabilidades pequenas.
-- 5dim:
--   2 scrap -> 1 compacted-scrap (masher)
--   1 compacted-scrap -> outputs vanilla x4 (recycler)
-- Net: 2 scrap rinde 4x outputs vs 2x = 2x. Mantiene recycler, probabilidades
-- y la mecanica de calidad/productividad propia del recycler.
---------------------------------------------------------------------------
table.insert(items, {
    type      = "item",
    name      = "5d-compacted-scrap",
    icons = {
        {
            icon = "__space-age__/graphics/icons/scrap.png",
            icon_size = 64
        },
        {
            icon = "__quality__/graphics/icons/recycling-top.png",
            icon_size = 64,
            scale = 0.45,
            shift = { 8, 8 }
        }
    },
    subgroup  = "fulgora-resources",
    order     = "a[scrap]-b[5d-compacted-scrap]",
    stack_size = 50
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-scrap-compact",
    enabled         = false,
    subgroup        = "fulgora-resources",
    order           = "a[trash]-a[5d-scrap-compact]",
    icons = {
        {
            icon = "__space-age__/graphics/icons/scrap.png",
            icon_size = 64
        },
        {
            icon = "__quality__/graphics/icons/recycling-top.png",
            icon_size = 64,
            scale = 0.45,
            shift = { 8, 8 }
        }
    },
    category        = "mashering",
    energy_required = 1,
    allow_productivity = true,
    ingredients = { { type = "item", name = "scrap",              amount = 2 } },
    results     = { { type = "item", name = "5d-compacted-scrap", amount = 1 } }
})

-- Nota: usa la categoria "recycling-or-hand-crafting" (igual que scrap-recycling)
-- para que se procese en el recycler con probabilidades y quality vanilla.
table.insert(recipes, {
    type            = "recipe",
    name            = "5d-compacted-scrap-recycling",
    icons = {
        { icon = "__quality__/graphics/icons/recycling.png" },
        { icon = "__space-age__/graphics/icons/scrap.png", scale = 0.4 },
        { icon = "__quality__/graphics/icons/recycling-top.png" }
    },
    subgroup        = "fulgora-resources",
    order           = "a[trash]-b[5d-compacted-scrap-recycling]",
    enabled         = false,
    auto_recycle    = false,
    category        = "recycling-or-hand-crafting",
    energy_required = 0.4,
    ingredients = { { type = "item", name = "5d-compacted-scrap", amount = 1 } },
    results = {
        { type = "item", name = "iron-gear-wheel",       amount = 4, probability = 0.20, show_details_in_recipe_tooltip = false },
        { type = "item", name = "solid-fuel",            amount = 4, probability = 0.07, show_details_in_recipe_tooltip = false },
        { type = "item", name = "concrete",              amount = 4, probability = 0.06, show_details_in_recipe_tooltip = false },
        { type = "item", name = "ice",                   amount = 4, probability = 0.05, show_details_in_recipe_tooltip = false },
        { type = "item", name = "steel-plate",           amount = 4, probability = 0.04, show_details_in_recipe_tooltip = false },
        { type = "item", name = "battery",               amount = 4, probability = 0.04, show_details_in_recipe_tooltip = false },
        { type = "item", name = "stone",                 amount = 4, probability = 0.04, show_details_in_recipe_tooltip = false },
        { type = "item", name = "advanced-circuit",      amount = 4, probability = 0.03, show_details_in_recipe_tooltip = false },
        { type = "item", name = "copper-cable",          amount = 4, probability = 0.03, show_details_in_recipe_tooltip = false },
        { type = "item", name = "processing-unit",       amount = 4, probability = 0.02, show_details_in_recipe_tooltip = false },
        { type = "item", name = "low-density-structure", amount = 4, probability = 0.01, show_details_in_recipe_tooltip = false },
        { type = "item", name = "holmium-ore",           amount = 4, probability = 0.01, show_details_in_recipe_tooltip = false }
    }
})

---------------------------------------------------------------------------
-- AQUILO: Ammonia & Lithium
-- Vanilla ammoniacal separation: 50 solution -> 5 ice + 50 ammonia
-- 5dim:                         50 solution -> 10 ice + 50 ammonia = 2x ice
-- Vanilla lithium: 1 holmium-plate + 50 lithium-brine + 50 ammonia -> 5 lithium
-- 5dim:         1 holmium-plate + 50 lithium-brine + 50 ammonia -> 10 lithium
-- Net: 2x. Mantiene la quimica/cryogenics propia de Aquilo.
---------------------------------------------------------------------------
table.insert(recipes, {
    type                 = "recipe",
    name                 = "5d-ammoniacal-solution-separation",
    icon                 = "__space-age__/graphics/icons/fluid/ammoniacal-solution-separation.png",
    icon_size            = 64,
    subgroup             = "aquilo-items",
    order                = "a[ammonia]-a[ammoniacal-solution-separation]-b[5d]",
    auto_recycle         = false,
    enabled              = false,
    category             = "chemistry-or-cryogenics",
    energy_required      = 1,
    allow_productivity   = true,
    always_show_made_in  = true,
    always_show_products = true,
    allow_decomposition  = false,
    ingredients = {
        { type = "fluid", name = "ammoniacal-solution", amount = 50 }
    },
    results = {
        { type = "item",  name = "ice",     amount = 10 },
        { type = "fluid", name = "ammonia", amount = 50 }
    }
})

table.insert(recipes, {
    type            = "recipe",
    name            = "5d-lithium",
    icon            = "__space-age__/graphics/icons/lithium.png",
    icon_size       = 64,
    subgroup        = "aquilo-items",
    order           = "c[lithium]-a[lithium]-b[5d]",
    auto_recycle    = false,
    enabled         = false,
    category        = "chemistry-or-cryogenics",
    energy_required = 20,
    allow_productivity = true,
    ingredients = {
        { type = "item",  name = "holmium-plate", amount = 1 },
        { type = "fluid", name = "lithium-brine", amount = 50 },
        { type = "fluid", name = "ammonia",       amount = 50 }
    },
    results = {
        { type = "item", name = "lithium", amount = 10 }
    }
})

data:extend(items)
data:extend(recipes)
