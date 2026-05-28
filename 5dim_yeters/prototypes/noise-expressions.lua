local resource_autoplace = require("resource-autoplace")

local expressions = {
    {
        type = "noise-expression",
        name = "yeters_biome_scale",
        expression = "1 / (500 + 300 * control:yeters_biomes:size)"
    },
    {
        type = "noise-expression",
        name = "yeters_quadrant_blend",
        expression = "120 + 100 * control:yeters_biomes:size"
    },
    {
        type = "noise-expression",
        name = "yeters_quadrant_wobble_x",
        expression = "0"
    },
    {
        type = "noise-expression",
        name = "yeters_quadrant_wobble_y",
        expression = "0"
    },
    {
        type = "noise-expression",
        name = "yeters_quadrant_x",
        expression = "x + yeters_quadrant_wobble_x"
    },
    {
        type = "noise-expression",
        name = "yeters_quadrant_y",
        expression = "y + yeters_quadrant_wobble_y"
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_zone",
        expression = "0"
    },
    {
        type = "noise-expression",
        name = "yeters_vulcanus_zone",
        expression = "(yeters_quadrant_x >= 0) * (yeters_quadrant_y < 0)"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_zone",
        expression = "(yeters_quadrant_x < 0) * (yeters_quadrant_y >= 0)"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_zone",
        expression = "(yeters_quadrant_x >= 0) * (yeters_quadrant_y >= 0)"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_zone",
        expression = "(yeters_quadrant_x < 0) * (yeters_quadrant_y < 0)"
    },
    {
        type = "noise-expression",
        name = "yeters_starting_safe_zone",
        expression = "clamp(1 - distance / 180, 0, 1)"
    },
    {
        type = "noise-expression",
        name = "yeters_cross_safe_paths",
        expression = "max(clamp(1 - abs(yeters_quadrant_x) / 56, 0, 1), clamp(1 - abs(yeters_quadrant_y) / 56, 0, 1)) * clamp(1 - distance / 1300, 0, 1)"
    },
    {
        type = "noise-expression",
        name = "yeters_hazard_safe_zone",
        expression = "max(yeters_starting_safe_zone, yeters_cross_safe_paths)"
    },
    {
        type = "noise-expression",
        name = "yeters_elevation",
        expression = "if(yeters_aquilo_zone > 0.5, yeters_aquilo_elevation, if(yeters_vulcanus_zone > 0.5, vulcanus_elevation, if(yeters_fulgora_zone > 0.5, fulgora_elevation, gleba_elevation)))"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_ocean_field",
        expression = "multioctave_noise{x = x, y = y, persistence = 0.62, seed0 = map_seed, seed1 = 51031, octaves = 4, input_scale = 1 / 260}"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_ocean_probability",
        expression = "yeters_aquilo_zone * (1 - yeters_hazard_safe_zone) * (45 * (yeters_aquilo_ocean_field > -0.42) + 12 * yeters_aquilo_ocean_field)"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_deep_ocean_probability",
        expression = "yeters_aquilo_zone * (1 - yeters_hazard_safe_zone) * (55 * (yeters_aquilo_ocean_field > 0.12) + 14 * yeters_aquilo_ocean_field)"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_oil_field",
        expression = "multioctave_noise{x = x, y = y, persistence = 0.6, seed0 = map_seed, seed1 = 51033, octaves = 4, input_scale = 1 / 240}"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_oil_ocean_probability",
        expression = "yeters_fulgora_zone * (1 - yeters_hazard_safe_zone) * (42 * (yeters_fulgora_oil_field > -0.36) + 11 * yeters_fulgora_oil_field)"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_deep_oil_ocean_probability",
        expression = "yeters_fulgora_zone * (1 - yeters_hazard_safe_zone) * (50 * (yeters_fulgora_oil_field > 0.18) + 13 * yeters_fulgora_oil_field)"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_tile_mask",
        expression = "yeters_aquilo_zone"
    },
    {
        type = "noise-function",
        name = "yeters_aquilo_min_elevation",
        parameters = { "min_elevation" },
        expression = "-1 + 2 * (yeters_aquilo_elevation > min_elevation)"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_ammoniacal_ocean",
        expression = "0.01 * (aquilo_aux - 0.5)"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_ammoniacal_ocean_2",
        expression = "-0.01 * (aquilo_aux - 0.5)"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_brash_ice",
        expression = "0.05 * (yeters_aquilo_elevation / 5 - aquilo_aux / 3 + 0.75)"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_icebergs",
        expression = "min(1, aquilo_high_frequency_peaks, 2 * ((yeters_aquilo_elevation / 5 - aquilo_aux / 3) + 1.5))"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_snow_flat",
        expression = "100 * yeters_aquilo_min_elevation(1.5) - (aquilo_snow_ice + 0.5) - abs(aquilo_tile_variant - 0.5) + yeters_aquilo_elevation / 25 + 1"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_snow_crests",
        expression = "100 * yeters_aquilo_min_elevation(1) - abs(aquilo_snow_ice - 0.2) - abs(aquilo_tile_variant - 0.2) + yeters_aquilo_elevation / 25 + 1.2"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_snow_lumpy",
        expression = "100 * yeters_aquilo_min_elevation(0.5) - abs(aquilo_snow_ice + 0.1) - abs(aquilo_tile_variant + 0.3) + yeters_aquilo_elevation / 25 + 1.2"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_snow_patchy",
        expression = "100 * yeters_aquilo_min_elevation(0) - abs(aquilo_snow_ice + 0.4) - abs(aquilo_tile_variant + 0.6) + yeters_aquilo_elevation / 25 + 1"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_ice_rough",
        expression = "100 * yeters_aquilo_min_elevation(-1) + aquilo_snow_ice - abs(aquilo_tile_variant) - yeters_aquilo_elevation / 10 + 0.5"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_ice_smooth",
        expression = "100 * yeters_aquilo_min_elevation(-1) + aquilo_snow_ice - abs(aquilo_tile_variant + 1) - yeters_aquilo_elevation / 25 + 1"
    },
    {
        type = "noise-expression",
        name = "yeters_vulcanus_tile_mask",
        expression = "yeters_vulcanus_zone"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_tile_mask",
        expression = "yeters_fulgora_zone"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_tile_mask",
        expression = "yeters_gleba_zone"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_yumako_grove",
        expression = "if(yeters_gleba_zone > 0.5, max(starting_grove, wild_groves), 0)",
        local_expressions = {
            starting_grove = "clamp(max(0, 1 - sqrt((x + wobble_x * 70 - 180) * (x + wobble_x * 70 - 180) / 1.6 + (y + wobble_y * 70 - 150) * (y + wobble_y * 70 - 150) / 0.85) / 78) * (0.25 + 1.6 * texture), 0, 1)",
            wild_groves = "clamp(spot_noise{x = x + wobble_x * 24, y = y + wobble_y * 24, seed0 = map_seed, seed1 = 51071, candidate_spot_count = 18, suggested_minimum_candidate_point_spacing = 360, skip_span = 1, skip_offset = 0, region_size = 1024, density_expression = 10, spot_quantity_expression = 360, spot_radius_expression = 30, hard_region_target_quantity = 0, spot_favorability_expression = yeters_gleba_zone * 22, basement_value = -0.6, maximum_spot_basement_radius = 88} * (0.25 + 1.4 * texture), 0, 1)",
            texture = "abs(multioctave_noise{x = x + wobble_x * 30, y = y + wobble_y * 30, persistence = 0.7, seed0 = map_seed, seed1 = 51081, octaves = 2, input_scale = 1 / 18})",
            wobble_x = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51091, octaves = 2, input_scale = 1 / 58}",
            wobble_y = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51092, octaves = 2, input_scale = 1 / 58}"
        }
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_jellynut_grove",
        expression = "if(yeters_gleba_zone > 0.5, max(starting_grove, wild_groves), 0)",
        local_expressions = {
            starting_grove = "clamp(max(0, 1 - sqrt((x + wobble_x * 70 - 280) * (x + wobble_x * 70 - 280) / 1.45 + (y + wobble_y * 70 - 180) * (y + wobble_y * 70 - 180) / 0.95) / 78) * (0.25 + 1.6 * texture), 0, 1)",
            wild_groves = "clamp(spot_noise{x = x + wobble_x * 24, y = y + wobble_y * 24, seed0 = map_seed, seed1 = 51072, candidate_spot_count = 18, suggested_minimum_candidate_point_spacing = 360, skip_span = 1, skip_offset = 0, region_size = 1024, density_expression = 10, spot_quantity_expression = 360, spot_radius_expression = 30, hard_region_target_quantity = 0, spot_favorability_expression = yeters_gleba_zone * 22, basement_value = -0.6, maximum_spot_basement_radius = 88} * (0.25 + 1.4 * texture), 0, 1)",
            texture = "abs(multioctave_noise{x = x + wobble_x * 30, y = y + wobble_y * 30, persistence = 0.7, seed0 = map_seed, seed1 = 51082, octaves = 2, input_scale = 1 / 18})",
            wobble_x = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51093, octaves = 2, input_scale = 1 / 58}",
            wobble_y = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51094, octaves = 2, input_scale = 1 / 58}"
        }
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_yumako_wetland_grove",
        expression = "if(yeters_gleba_zone > 0.5, max(starting_grove, wild_groves), 0)",
        local_expressions = {
            starting_grove = "0",
            wild_groves = "clamp(spot_noise{x = x + wobble_x * 26, y = y + wobble_y * 26, seed0 = map_seed, seed1 = 51073, candidate_spot_count = 12, suggested_minimum_candidate_point_spacing = 420, skip_span = 1, skip_offset = 0, region_size = 1024, density_expression = 6, spot_quantity_expression = 260, spot_radius_expression = 24, hard_region_target_quantity = 0, spot_favorability_expression = yeters_gleba_zone * 16, basement_value = -0.65, maximum_spot_basement_radius = 72} * (0.25 + 1.3 * texture), 0, 1)",
            texture = "abs(multioctave_noise{x = x + wobble_x * 28, y = y + wobble_y * 28, persistence = 0.7, seed0 = map_seed, seed1 = 51083, octaves = 2, input_scale = 1 / 16})",
            wobble_x = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51095, octaves = 2, input_scale = 1 / 62}",
            wobble_y = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51096, octaves = 2, input_scale = 1 / 62}"
        }
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_jellynut_wetland_grove",
        expression = "if(yeters_gleba_zone > 0.5, max(starting_grove, wild_groves), 0)",
        local_expressions = {
            starting_grove = "0",
            wild_groves = "clamp(spot_noise{x = x + wobble_x * 26, y = y + wobble_y * 26, seed0 = map_seed, seed1 = 51074, candidate_spot_count = 12, suggested_minimum_candidate_point_spacing = 420, skip_span = 1, skip_offset = 0, region_size = 1024, density_expression = 6, spot_quantity_expression = 260, spot_radius_expression = 24, hard_region_target_quantity = 0, spot_favorability_expression = yeters_gleba_zone * 16, basement_value = -0.65, maximum_spot_basement_radius = 72} * (0.25 + 1.3 * texture), 0, 1)",
            texture = "abs(multioctave_noise{x = x + wobble_x * 28, y = y + wobble_y * 28, persistence = 0.7, seed0 = map_seed, seed1 = 51084, octaves = 2, input_scale = 1 / 16})",
            wobble_x = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51097, octaves = 2, input_scale = 1 / 62}",
            wobble_y = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51098, octaves = 2, input_scale = 1 / 62}"
        }
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_yumako_soil_probability",
        expression = "2 * abs(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 51101, octaves = 2, input_scale = 1 / 16}) * yeters_gleba_yumako_grove * 50000 - 40000"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_jellynut_soil_probability",
        expression = "2 * abs(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 51102, octaves = 2, input_scale = 1 / 16}) * yeters_gleba_jellynut_grove * 50000 - 40000"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_yumako_wetland_probability",
        expression = "2 * abs(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 51103, octaves = 2, input_scale = 1 / 16}) * yeters_gleba_yumako_wetland_grove * 32000 - 28000"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_jellynut_wetland_probability",
        expression = "2 * abs(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 51104, octaves = 2, input_scale = 1 / 16}) * yeters_gleba_jellynut_wetland_grove * 32000 - 28000"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_yumako_tree_probability",
        expression = "min(0.07, 0.08 * yeters_gleba_yumako_grove * control:gleba_plants:size)"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_jellystem_probability",
        expression = "min(0.07, 0.08 * yeters_gleba_jellynut_grove * control:gleba_plants:size)"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_iron_stromatolite_probability",
        expression = "min(0.08, 0.12 * yeters_gleba_iron_stromatolite_patch * control:gleba_plants:size)"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_copper_stromatolite_probability",
        expression = "min(0.08, 0.12 * yeters_gleba_copper_stromatolite_patch * control:gleba_plants:size)"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_iron_stromatolite_patch",
        expression = "if(yeters_gleba_zone > 0.5, max(starting_patch, wild_patches), 0)",
        local_expressions = {
            starting_patch = "clamp(max(0, 1 - sqrt((x + wobble_x * 68 - 170) * (x + wobble_x * 68 - 170) / 1.35 + (y + wobble_y * 68 - 245) * (y + wobble_y * 68 - 245) / 0.9) / 88) * (0.25 + 1.45 * texture), 0, 1)",
            wild_patches = "clamp(spot_noise{x = x + wobble_x * 22, y = y + wobble_y * 22, seed0 = map_seed, seed1 = 51075, candidate_spot_count = 12, suggested_minimum_candidate_point_spacing = 390, skip_span = 1, skip_offset = 0, region_size = 1024, density_expression = 7, spot_quantity_expression = 230, spot_radius_expression = 24, hard_region_target_quantity = 0, spot_favorability_expression = yeters_gleba_zone * 16, basement_value = -0.65, maximum_spot_basement_radius = 76} * (0.25 + 1.25 * texture), 0, 1)",
            texture = "abs(multioctave_noise{x = x + wobble_x * 28, y = y + wobble_y * 28, persistence = 0.68, seed0 = map_seed, seed1 = 51085, octaves = 2, input_scale = 1 / 17})",
            wobble_x = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51099, octaves = 2, input_scale = 1 / 60}",
            wobble_y = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51100, octaves = 2, input_scale = 1 / 60}"
        }
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_copper_stromatolite_patch",
        expression = "if(yeters_gleba_zone > 0.5, max(starting_patch, wild_patches), 0)",
        local_expressions = {
            starting_patch = "clamp(max(0, 1 - sqrt((x + wobble_x * 68 - 290) * (x + wobble_x * 68 - 290) / 1.25 + (y + wobble_y * 68 - 255) * (y + wobble_y * 68 - 255) / 0.95) / 82) * (0.25 + 1.45 * texture), 0, 1)",
            wild_patches = "clamp(spot_noise{x = x + wobble_x * 22, y = y + wobble_y * 22, seed0 = map_seed, seed1 = 51076, candidate_spot_count = 12, suggested_minimum_candidate_point_spacing = 390, skip_span = 1, skip_offset = 0, region_size = 1024, density_expression = 7, spot_quantity_expression = 230, spot_radius_expression = 24, hard_region_target_quantity = 0, spot_favorability_expression = yeters_gleba_zone * 16, basement_value = -0.65, maximum_spot_basement_radius = 76} * (0.25 + 1.25 * texture), 0, 1)",
            texture = "abs(multioctave_noise{x = x + wobble_x * 28, y = y + wobble_y * 28, persistence = 0.68, seed0 = map_seed, seed1 = 51086, octaves = 2, input_scale = 1 / 17})",
            wobble_x = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51105, octaves = 2, input_scale = 1 / 60}",
            wobble_y = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51106, octaves = 2, input_scale = 1 / 60}"
        }
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_enemy_zone",
        expression = "max(yeters_vulcanus_zone, yeters_fulgora_zone, yeters_gleba_zone)"
    },
    {
        type = "noise-expression",
        name = "yeters_tile_detail",
        expression = "0.07 * basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 51021, input_scale = 1 / 360, output_scale = 1}"
    },
    {
        type = "noise-expression",
        name = "yeters_base_ground_probability",
        expression = "-0.4"
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_grass_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_dirt_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_sand_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_snow_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_ice_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_vulcanus_soil_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_vulcanus_ash_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_vulcanus_cracks_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_rock_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_dust_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_highland_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_lowland_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_visual_detail",
        expression = "multioctave_noise{x = x, y = y, persistence = 0.55, seed0 = map_seed, seed1 = 51023, octaves = 3, input_scale = 1 / 260}"
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_decorative_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_vulcanus_decorative_probability",
        expression = "0.85 * yeters_vulcanus_zone + 0.18 * yeters_visual_detail - 0.58"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_decorative_probability",
        expression = "0.72 * yeters_fulgora_zone + 0.16 * yeters_visual_detail - 0.64"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_decorative_probability",
        expression = "0.78 * yeters_gleba_zone + 0.18 * yeters_visual_detail - 0.62"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_decorative_probability",
        expression = "0.62 * yeters_aquilo_zone + 0.14 * yeters_visual_detail - 0.74"
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_visual_entity_probability",
        expression = "-1"
    },
    {
        type = "noise-expression",
        name = "yeters_vulcanus_visual_entity_probability",
        expression = "0.62 * yeters_vulcanus_zone + 0.16 * yeters_visual_detail - 0.78"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_visual_entity_probability",
        expression = "0.52 * yeters_fulgora_zone + 0.14 * yeters_visual_detail - 0.84"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_visual_entity_probability",
        expression = "0.5 * yeters_gleba_zone + 0.14 * yeters_visual_detail - 0.82"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_visual_entity_probability",
        expression = "0.42 * yeters_aquilo_zone + 0.1 * yeters_visual_detail - 0.88"
    },
    {
        type = "noise-expression",
        name = "yeters_resource_favorability",
        expression = "0.06"
    },
    {
        type = "noise-expression",
        name = "yeters_basic_resource_favorability",
        expression = "max(0.16, clamp((max(yeters_aquilo_zone, yeters_vulcanus_zone, yeters_fulgora_zone, yeters_gleba_zone) - 0.08) * 1.8, 0, 0.8))"
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_resource_favorability",
        expression = "max(yeters_resource_favorability, clamp((yeters_nauvis_zone - 0.08) * 3, 0, 1))"
    },
    {
        type = "noise-expression",
        name = "yeters_vulcanus_resource_favorability",
        expression = "max(yeters_resource_favorability, clamp((yeters_vulcanus_zone - 0.08) * 3, 0, 1))"
    },
    {
        type = "noise-expression",
        name = "yeters_fulgora_resource_favorability",
        expression = "max(yeters_resource_favorability, clamp((yeters_fulgora_zone - 0.08) * 3, 0, 1))"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_resource_favorability",
        expression = "max(yeters_resource_favorability, clamp((yeters_aquilo_zone - 0.08) * 2.4, 0, 0.8))"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_resource_favorability",
        expression = "max(yeters_resource_favorability, clamp((yeters_gleba_zone - 0.08) * 3, 0, 1))"
    },
    {
        type = "noise-expression",
        name = "yeters_demolisher_territory_radius",
        expression = "256"
    },
    {
        type = "noise-expression",
        name = "yeters_demolisher_starting_area",
        expression = "distance < 360"
    },
    {
        type = "noise-expression",
        name = "yeters_demolisher_territory_expression",
        expression = "if(yeters_vulcanus_zone > 0.5, voronoi_cell_id{x = x + 1000 * yeters_demolisher_territory_radius, y = y + 1000 * yeters_demolisher_territory_radius, seed0 = map_seed, seed1 = 57221, grid_size = yeters_demolisher_territory_radius, distance_type = 'manhattan', jitter = 1} - yeters_demolisher_starting_area, -99)"
    },
    {
        type = "noise-expression",
        name = "yeters_demolisher_variation_expression",
        expression = "floor(clamp(distance / (14 * 32) - 0.25, 0, 4)) + (-99 * no_enemies_mode)"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_enemy_base_radius",
        expression = "gleba_enemy_base_radius"
    },
    {
        type = "noise-expression",
        name = "yeters_gleba_enemy_base_frequency",
        expression = "if(yeters_gleba_zone > 0.5, gleba_enemy_base_frequency * (distance > 320), 0)"
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_enemy_base_radius",
        expression = "sqrt(var('control:enemy-base:size')) * (15 + 4 * enemy_base_intensity)"
    },
    {
        type = "noise-expression",
        name = "yeters_nauvis_enemy_base_frequency",
        expression = "if(yeters_nauvis_enemy_zone > 0.5, (0.00001 + 0.000003 * enemy_base_intensity) * var('control:enemy-base:frequency'), 0)"
    },
    {
        type = "noise-expression",
        name = "yeters_enemy_base_radius",
        expression = "if(yeters_gleba_zone > 0.5, max(yeters_nauvis_enemy_base_radius, yeters_gleba_enemy_base_radius), yeters_nauvis_enemy_base_radius)"
    },
    {
        type = "noise-expression",
        name = "yeters_enemy_base_frequency",
        expression = "if(yeters_aquilo_zone > 0.5, 0, max(yeters_nauvis_enemy_base_frequency, yeters_gleba_enemy_base_frequency))"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_starting_crude_oil",
        expression = "starting_spot_at_angle{angle = 300, distance = 40, radius = aquilo_spot_size * 0.8, x_distortion = 0, y_distortion = 0}"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_starting_lithium_brine",
        expression = "starting_spot_at_angle{angle = 315, distance = 80, radius = aquilo_spot_size * 0.6, x_distortion = 0, y_distortion = 0}"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_starting_fluorine_vent",
        expression = "starting_spot_at_angle{angle = 330, distance = 160, radius = aquilo_spot_size * 0.6, x_distortion = 0, y_distortion = 0}"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_starting_fluorine_vent_tiny",
        expression = "starting_spot_at_angle{angle = 330, distance = 80, radius = 1, x_distortion = 0, y_distortion = 0}"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_crude_oil_spots",
        expression = "aquilo_spot_noise{seed = 567, count = 4, skip_offset = 0, region_size = 600 + 400 / control:yeters_crude_oil:frequency, density = 1, radius = aquilo_spot_size * sqrt(control:yeters_crude_oil:size), favorability = 1}"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_lithium_brine_spots",
        expression = "aquilo_spot_noise{seed = 567, count = 3, skip_offset = 1, region_size = 600 + 400 / control:yeters_lithium_brine:frequency, density = 1, radius = aquilo_spot_size * 1.2 * sqrt(control:yeters_lithium_brine:size), favorability = 1}"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_fluorine_vent_spots",
        expression = "aquilo_spot_noise{seed = 567, count = 2, skip_offset = 2, region_size = 600 + 400 / control:yeters_fluorine_vent:frequency, density = 1, radius = aquilo_spot_size * 1.5 * sqrt(control:yeters_fluorine_vent:size), favorability = 1}"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_island_peaks",
        expression = "max(1.7 * (0.3 + aquilo_starting_island), 1.5 * (0.5 + max(yeters_aquilo_starting_crude_oil, yeters_aquilo_crude_oil_spots, yeters_aquilo_starting_lithium_brine, yeters_aquilo_lithium_brine_spots, yeters_aquilo_starting_fluorine_vent, yeters_aquilo_fluorine_vent_spots)))"
    },
    {
        type = "noise-expression",
        name = "yeters_aquilo_elevation",
        expression = "lerp(blended, maxed, 0.4)",
        local_expressions = {
            maxed = "max(formation_clumped, formation_broken)",
            blended = "lerp(formation_clumped, formation_broken, 0.4)",
            formation_clumped = "-25 + 12 * max(yeters_aquilo_island_peaks, random_island_peaks) + 15 * tri_crack",
            formation_broken = "-20 + 8 * max(yeters_aquilo_island_peaks * 1.1, min(0., random_island_peaks - 0.2)) + 13 * (pow(voronoi_large * max(0, voronoi_large_cell * 1.2 - 0.2) + 0.5 * voronoi_small * max(0, aux + 0.1), 0.5))",
            random_island_peaks = "abs(amplitude_corrected_multioctave_noise{x = x, y = y, seed0 = map_seed, seed1 = 1000, input_scale = segmentation_mult / 1.2, offset_x = -10000, octaves = 6, persistence = 0.8, amplitude = 1})",
            voronoi_large = "voronoi_facet_noise{x = x + aquilo_wobble_x * 2, y = y + aquilo_wobble_y * 2, seed0 = map_seed, seed1 = 'aquilo-cracks', grid_size = 24, distance_type = 'euclidean', jitter = 1}",
            voronoi_large_cell = "voronoi_cell_id{x = x + aquilo_wobble_x * 2, y = y + aquilo_wobble_y * 2, seed0 = map_seed, seed1 = 'aquilo-cracks', grid_size = 24, distance_type = 'euclidean', jitter = 1}",
            voronoi_small = "voronoi_facet_noise{x = x + aquilo_wobble_x * 2, y = y + aquilo_wobble_y * 2, seed0 = map_seed, seed1 = 'aquilo-cracks', grid_size = 10, distance_type = 'euclidean', jitter = 1}",
            tri_crack = "min(aquilo_simple_billows{seed1 = 2000, octaves = 3, input_scale = segmentation_mult / 1.5}, aquilo_simple_billows{seed1 = 3000, octaves = 3, input_scale = segmentation_mult / 1.2}, aquilo_simple_billows{seed1 = 4000, octaves = 3, input_scale = segmentation_mult})",
            segmentation_mult = "aquilo_segmentation_multiplier / 25"
        }
    }
}

local yetersUraniumAutoplace = resource_autoplace.resource_autoplace_settings
{
    name = "yeters_uranium_ore",
    order = "c",
    autoplace_set_name = "yeters",
    patch_set_name = "uranium-ore",
    autoplace_control_name = "yeters_uranium_ore",
    base_density = 0.9,
    base_spots_per_km2 = 1.25,
    has_starting_area_placement = false,
    random_spot_size_minimum = 2,
    random_spot_size_maximum = 4,
    regular_rq_factor_multiplier = 1
}

expressions[#expressions + 1] = {
    type = "noise-expression",
    name = "yeters_uranium_ore_presence",
    expression = "if(yeters_aquilo_zone <= 0.5, -1 + 2 * ((" .. yetersUraniumAutoplace.probability_expression .. ") > 0), -1)"
}

local resources = {
    { prefix = "yeters_stone", control = "yeters_stone", spot_function = "vulcanus_place_non_metal_spots", seed = 61113, count = 8, multiplier = 10, richness = 4000, favorability = "yeters_gleba_resource_favorability", allowed = "yeters_gleba_zone > 0.5", separation_group = "basic", probability_expression = "if(yeters_gleba_zone > 0.5, (control:yeters_stone:size > 0) * (yeters_stone_richness > 1), -1)", richness_expression = "if(yeters_gleba_zone > 0.5, 4000 * max(starting_spot_at_angle{angle = gleba_starting_angle + 85 * gleba_starting_direction, distance = 80 * gleba_starting_area_multiplier, radius = 7 * sqrt(control:yeters_stone:size), x_distortion = gleba_wobble_x * 8, y_distortion = gleba_wobble_x * 8}, gleba_simple_spot(1000, 6 * sqrt(control:yeters_stone:size), 80 / sqrt(control:yeters_stone:frequency), gleba_highland) * max(gleba_highland, gleba_midland_aux_2)) * control:yeters_stone:richness / control:yeters_stone:size, 0)" },
    { prefix = "yeters_coal", control = "yeters_coal", spot_function = "vulcanus_place_non_metal_spots", seed = 782349, count = 12, multiplier = 25, richness = 18000, favorability = "vulcanus_ashlands_resource_favorability", allowed = "yeters_vulcanus_zone > 0.5", separation_group = "vulcanus", starting_region_expression = "starting_spot_at_angle{angle = 38, distance = 180 * vulcanus_starting_area_radius, radius = 30 * yeters_coal_size, x_distortion = 0.5 * vulcanus_resource_wobble_x, y_distortion = 0.5 * vulcanus_resource_wobble_y}" },
    { prefix = "yeters_uranium_ore", control = "yeters_uranium_ore", spot_function = "vulcanus_place_metal_spots", seed = 61115, count = 8, multiplier = 10, richness = 0.9, favorability = "yeters_basic_resource_favorability", allowed = "yeters_aquilo_zone <= 0.5", separation_group = "basic", separation_region = "yeters_uranium_ore_presence", probability_expression = "if(yeters_aquilo_zone <= 0.5, " .. yetersUraniumAutoplace.probability_expression .. ", -1)", richness_expression = "if(yeters_aquilo_zone <= 0.5, " .. yetersUraniumAutoplace.richness_expression .. ", 0)" },
    { prefix = "yeters_calcite", control = "yeters_calcite", spot_function = "vulcanus_place_non_metal_spots", seed = 749, count = 12, multiplier = 25, richness = 24000, favorability = "vulcanus_mountains_resource_favorability", allowed = "yeters_vulcanus_zone > 0.5", separation_group = "vulcanus", starting_region_expression = "starting_spot_at_angle{angle = 54, distance = 350 * vulcanus_starting_area_radius, radius = 35 / 1.5 * yeters_calcite_size, x_distortion = 0.5 * vulcanus_resource_wobble_x, y_distortion = 0.5 * vulcanus_resource_wobble_y}" },
    { prefix = "yeters_tungsten_ore", control = "yeters_tungsten_ore", spot_function = "vulcanus_place_metal_spots", seed = 789, count = 15, offset = 2, multiplier = 25, richness = 10000, favorability = "vulcanus_basalts_resource_favorability", allowed = "yeters_vulcanus_zone > 0.5", separation_group = "vulcanus", starting_region_expression = "starting_spot_at_angle{angle = 24, distance = 450 * vulcanus_starting_area_radius, radius = 30 / 1.5, x_distortion = 0.5 * vulcanus_resource_wobble_x, y_distortion = 0.5 * vulcanus_resource_wobble_y}" },
    { prefix = "yeters_scrap", control = "yeters_scrap", spot_function = "vulcanus_place_non_metal_spots", seed = 61118, count = 10, multiplier = 12, richness = 14000, favorability = "yeters_fulgora_resource_favorability", allowed = "yeters_fulgora_zone > 0.5", probability_expression = "if(yeters_fulgora_zone > 0.5, (control:yeters_scrap:size > 0) * (1 - fulgora_starting_mask) * (min((fulgora_structure_cells < min(0.1 * control:yeters_scrap:frequency, 0.05 + 0.05 * control:yeters_scrap:frequency)) * (1 + fulgora_structure_subnoise) * (fulgora_elevation > (fulgora_coastline + 10)) * fulgora_artificial_mask + (fulgora_spots_prebanding < (1.2 + 0.4 * slider_to_linear(control:yeters_scrap:size, -1, 1))) * fulgora_vaults_and_starting_vault * 10, 0.5) * (1 - fulgora_road_paving_2c)), -1)", richness_expression = "if(yeters_fulgora_zone > 0.5, (1 + fulgora_structure_subnoise) * 1000 * (7 / (6 + control:yeters_scrap:frequency) + 100 * fulgora_vaults_and_starting_vault) * control:yeters_scrap:richness, 0)" },
    { prefix = "yeters_crude_oil", control = "yeters_crude_oil", spot_function = "vulcanus_place_non_metal_spots", seed = 61119, count = 4, multiplier = 8, richness = 90000, favorability = "yeters_aquilo_resource_favorability", allowed = "yeters_aquilo_zone > 0.5", probability_expression = "if(yeters_aquilo_zone > 0.5, (control:yeters_crude_oil:size > 0) * max(yeters_aquilo_starting_crude_oil * 0.02, min(aquilo_starting_mask, yeters_aquilo_crude_oil_spots) * 0.015), -1)", richness_expression = "max(yeters_aquilo_starting_crude_oil * 1800000, yeters_aquilo_crude_oil_spots * 1440000) * control:yeters_crude_oil:richness" },
    { prefix = "yeters_lithium_brine", control = "yeters_lithium_brine", spot_function = "vulcanus_place_non_metal_spots", seed = 61120, count = 3, multiplier = 8, richness = 80000, favorability = "yeters_aquilo_resource_favorability", allowed = "yeters_aquilo_zone > 0.5", probability_expression = "if(yeters_aquilo_zone > 0.5, (control:yeters_lithium_brine:size > 0) * max(yeters_aquilo_starting_lithium_brine * 0.02, min(aquilo_starting_mask, yeters_aquilo_lithium_brine_spots) * 0.012), -1)", richness_expression = "max(yeters_aquilo_starting_lithium_brine * 480000, yeters_aquilo_lithium_brine_spots * 720000) * control:yeters_lithium_brine:richness" },
    { prefix = "yeters_fluorine_vent", control = "yeters_fluorine_vent", spot_function = "vulcanus_place_non_metal_spots", seed = 61121, count = 2, multiplier = 8, richness = 80000, favorability = "yeters_aquilo_resource_favorability", allowed = "yeters_aquilo_zone > 0.5", probability_expression = "if(yeters_aquilo_zone > 0.5, (control:yeters_fluorine_vent:size > 0) * max(yeters_aquilo_starting_fluorine_vent * 0.02, yeters_aquilo_starting_fluorine_vent_tiny > 0, min(aquilo_starting_mask, yeters_aquilo_fluorine_vent_spots) * 0.008), -1)", richness_expression = "max(yeters_aquilo_starting_fluorine_vent * 420000, (yeters_aquilo_starting_fluorine_vent_tiny > 0) * 420000, yeters_aquilo_fluorine_vent_spots * 520000) * control:yeters_fluorine_vent:richness" },
    { prefix = "yeters_sulfuric_acid_geyser", control = "yeters_sulfuric_acid_geyser", spot_function = "vulcanus_place_sulfur_spots", seed = 759, count = 9, offset = 0, multiplier = 25, richness = 120000, favorability = "vulcanus_mountains_sulfur_favorability", allowed = "yeters_vulcanus_zone > 0.5", fluid = true, patchy = true, patch_seed = 21000, separation_group = "vulcanus", separation_region = "yeters_sulfuric_acid_geyser_region_patchy", starting_region_expression = "max(starting_spot_at_angle{angle = 54, distance = 590, radius = 30, x_distortion = 0.75 * vulcanus_resource_wobble_x, y_distortion = 0.75 * vulcanus_resource_wobble_y}, starting_spot_at_angle{angle = 66, distance = 200, radius = 25 * yeters_sulfuric_acid_geyser_size, x_distortion = 0.75 * vulcanus_resource_wobble_x, y_distortion = 0.75 * vulcanus_resource_wobble_y})", richness_expression = "(yeters_sulfuric_acid_geyser_region > 0) * random_penalty_between(0.5, 1, 1) * 80000 * 40 * vulcanus_richness_multiplier * vulcanus_starting_area_multiplier * control:yeters_sulfuric_acid_geyser:richness / yeters_sulfuric_acid_geyser_size" }
}

local function resourceSeparationExpression(resource)
    if not resource.separation_group then
        return nil
    end

    local blockers = {}

    for _, other in ipairs(resources) do
        if other ~= resource and other.separation_group == resource.separation_group then
            local otherRegion = other.separation_region or (other.prefix .. "_region")
            blockers[#blockers + 1] = "max(0, " .. otherRegion .. " + 0.08)"
        end
    end

    if #blockers == 0 then
        return nil
    end

    local blockerExpression = blockers[1]

    if #blockers > 1 then
        blockerExpression = "max(" .. table.concat(blockers, ", ") .. ")"
    end

    return "clamp(1 - 2.6 * " .. blockerExpression .. ", 0, 1)"
end

for _, resource in ipairs(resources) do
    local startingRegion = "0"
    local startingLocalExpressions = nil

    if resource.starting_region_expression then
        startingRegion = resource.starting_region_expression
    elseif resource.starting_angle then
        startingRegion = "max(0, min(1, yeters_starting_resource_base * (0.9 + 0.45 * yeters_starting_resource_edge_noise + 0.18 * yeters_starting_resource_grain_noise) - 0.08))"
        startingLocalExpressions = {
            yeters_starting_resource_base = "starting_spot_at_angle{angle = " .. resource.starting_angle .. ", distance = " .. resource.starting_distance .. ", radius = " .. resource.starting_radius .. ", x_distortion = yeters_starting_resource_x_distortion, y_distortion = yeters_starting_resource_y_distortion}",
            yeters_starting_resource_x_distortion = "18 * multioctave_noise{x = x, y = y, persistence = 0.58, seed0 = map_seed, seed1 = " .. (resource.seed + 1000) .. ", octaves = 3, input_scale = 1 / 42}",
            yeters_starting_resource_y_distortion = "18 * multioctave_noise{x = x, y = y, persistence = 0.58, seed0 = map_seed, seed1 = " .. (resource.seed + 2000) .. ", octaves = 3, input_scale = 1 / 42}",
            yeters_starting_resource_edge_noise = "multioctave_noise{x = x, y = y, persistence = 0.62, seed0 = map_seed, seed1 = " .. (resource.seed + 3000) .. ", octaves = 3, input_scale = 1 / 20}",
            yeters_starting_resource_grain_noise = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = " .. (resource.seed + 4000) .. ", input_scale = 1 / 8, output_scale = 1}"
        }
    end

    local startingExpression = {
        type = "noise-expression",
        name = resource.prefix .. "_starting_region",
        expression = startingRegion
    }

    if startingLocalExpressions then
        startingExpression.local_expressions = startingLocalExpressions
    end

    expressions[#expressions + 1] = startingExpression
    expressions[#expressions + 1] = {
        type = "noise-expression",
        name = resource.prefix .. "_size",
        expression = "slider_rescale(control:" .. resource.control .. ":size, 2)"
    }
    expressions[#expressions + 1] = {
        type = "noise-expression",
        name = resource.prefix .. "_region",
        expression = "if(" .. (resource.allowed or "1") .. ", max(" .. resource.prefix .. "_starting_region, min(1 - vulcanus_starting_circle, " .. resource.spot_function .. "(" .. resource.seed .. ", " .. resource.count .. ", " .. (resource.offset or 1) .. ", " .. resource.prefix .. "_size * min(1.2, vulcanus_ore_dist) * " .. resource.multiplier .. ", control:" .. resource.control .. ":frequency, " .. resource.favorability .. "))), -1)"
    }

    if resource.patchy then
        expressions[#expressions + 1] = {
            type = "noise-expression",
            name = resource.prefix .. "_patches",
            expression = "0.8 * abs(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = " .. (resource.patch_seed or resource.seed + 5000) .. ", octaves = 2, input_scale = 1 / 3})"
        }
        expressions[#expressions + 1] = {
            type = "noise-expression",
            name = resource.prefix .. "_region_patchy",
            expression = "(1 + " .. resource.prefix .. "_region) * (0.5 + 0.5 * " .. resource.prefix .. "_patches) - 1"
        }
    end

    local separationExpression = resourceSeparationExpression(resource)

    if separationExpression then
        expressions[#expressions + 1] = {
            type = "noise-expression",
            name = resource.prefix .. "_separation",
            expression = separationExpression
        }
    end

    local probabilityExpression = resource.probability_expression

    if not probabilityExpression then
        if resource.fluid and resource.patchy then
            probabilityExpression = "(control:" .. resource.control .. ":size > 0) * (0.025 * ((" .. resource.prefix .. "_region_patchy > 0) + 2 * " .. resource.prefix .. "_region_patchy))"
        elseif resource.fluid then
            probabilityExpression = "(control:" .. resource.control .. ":size > 0) * max(0, " .. resource.prefix .. "_region) * 0.012"
        else
            probabilityExpression = "(control:" .. resource.control .. ":size > 0) * (1000 * ((1 + " .. resource.prefix .. "_region) * random_penalty_between(0.9, 1, 1) - 1))"
        end
    end

    if separationExpression then
        probabilityExpression = "min((" .. probabilityExpression .. "), (" .. probabilityExpression .. ") * " .. resource.prefix .. "_separation)"
    end

    expressions[#expressions + 1] = {
        type = "noise-expression",
        name = resource.prefix .. "_probability",
        expression = probabilityExpression
    }
    local richnessExpression = resource.richness_expression

    if not richnessExpression then
        richnessExpression = resource.prefix .. "_region * random_penalty_between(0.9, 1, 1) * " .. resource.richness .. " * vulcanus_starting_area_multiplier * control:" .. resource.control .. ":richness / " .. resource.prefix .. "_size"
    end

    expressions[#expressions + 1] = {
        type = "noise-expression",
        name = resource.prefix .. "_richness",
        expression = richnessExpression
    }
end

data:extend(expressions)