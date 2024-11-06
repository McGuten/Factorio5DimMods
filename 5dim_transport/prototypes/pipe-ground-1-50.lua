data:extend({
  -- Item
  {
    type = "item",
    name = "5d-pipe-to-ground-mk1-50",
    icon = "__5dim_transport__/graphics/icon/pipe/icon_5d_pipe-to-underground_1_50_.png",
    -- flags = {"goes-to-quickbar"},
    icon_size = 32,
    subgroup = "transport-pipe-ground-50",
    order = "a[basic-pipe-ground]",
    place_result = "5d-pipe-to-ground-mk1-50",
    stack_size = 50
  },

  --Recipe
  {
    type = "recipe",
    name = "5d-pipe-to-ground-mk1-50",
    enabled = false,
    ingredients = {
      { type = "item", name = "pipe",       amount = 50 },
      { type = "item", name = "iron-plate", amount = 5 }
    },
    results = {
      { type = "item", name = "5d-pipe-to-ground-mk1-50", amount = 2 }
    }
  },

  --Entity
  {
    type = "pipe-to-ground",
    name = "5d-pipe-to-ground-mk1-50",
    icon = "__5dim_transport__/graphics/icon/pipe/icon_5d_pipe-to-underground_1_50_.png",
    flags = { "placeable-neutral", "player-creation" },
    minable = { hardness = 0.2, mining_time = 0.5, result = "5d-pipe-to-ground-mk1-50" },
    icon_size = 32,
    max_health = 50,
    corpse = "small-remnants",
    resistances = {
      {
        type = "fire",
        percent = 80
      }
    },
    fast_replaceable_group = "pipe-to-ground",
    collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } },
    drawing_mask = { { -0.29, -0.29 }, { 0.29, 0.29 } },
    collision_mask = { layers = { item = true, meltable = true, object = true, water_tile = true, is_object = true, is_lower_object = true } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    fluid_box =
    {
      volume = 100,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { direction = defines.direction.north, position = { 0, 0 } },
        {
          connection_type = "underground",
          direction = defines.direction.south,
          position = { 0, 0 },
          max_underground_distance = 50
        }
      },
      hide_connection_info = true
    },
    underground_sprite = {
      filename = "__core__/graphics/arrows/underground-lines.png",
      priority = "extra-high-no-scale",
      width = 64,
      height = 64,
      scale = 0.5
    },
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    pictures =
    {
      north =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-up.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5
      },
      south =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-down.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5
      },
      west =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-left.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5
      },
      east =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-right.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5
      }
    },
    visualization =
    {
      north =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 64,
        size = 64,
        scale = 0.5,
        flags = { "icon" }
      },
      south =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 192,
        size = 64,
        scale = 0.5,
        flags = { "icon" }
      },
      west =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 256,
        size = 64,
        scale = 0.5,
        flags = { "icon" }
      },
      east =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 128,
        size = 64,
        scale = 0.5,
        flags = { "icon" }
      },
    },
    disabled_visualization =
    {
      north =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 64,
        size = 64,
        scale = 0.5,
        flags = { "icon" }
      },
      south =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 192,
        size = 64,
        scale = 0.5,
        flags = { "icon" }
      },
      west =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 256,
        size = 64,
        scale = 0.5,
        flags = { "icon" }
      },
      east =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 128,
        size = 64,
        scale = 0.5,
        flags = { "icon" }
      },
    },
  }
})
