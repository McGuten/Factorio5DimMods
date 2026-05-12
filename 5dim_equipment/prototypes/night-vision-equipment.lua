local TierBadgeIcons = require("__5dim_core__.lib.icon-tier-badge")

local CostConfig = require("__5dim_core__.lib.costs.config")
local CostCalculator = require("__5dim_core__.lib.costs.calculator")

local config = {
    baseTechCount = 100,
    subgroup = "armor-util"
}

local nightVisionSpaceAgeMaterials = {
    [8] = { name = "holmium-plate", amount = 6, category = "electromagnetics" },
    [9] = { name = "supercapacitor", amount = 4, category = "electromagnetics" },
    [10] = { name = "quantum-processor", amount = 1, category = "cryogenics" }
}

local nightVisionSpaceAgeSciencePacks = {
    [8] = { "space-science-pack", "electromagnetic-science-pack" },
    [9] = { "space-science-pack", "electromagnetic-science-pack" },
    [10] = { "space-science-pack", "cryogenic-science-pack" }
}

local nightVisionSpaceAgeDeltaPrerequisites = {
    [8] = "electromagnetic-plant",
    [9] = "electromagnetic-plant",
    [10] = "quantum-processor"
}

local nightVisionDeltaPrerequisites = {
    [2] = "electronics",
    [3] = "advanced-electronics",
    [4] = "battery",
    [5] = "advanced-electronics-2",
    [6] = "low-density-structure",
    [7] = "speed-module",
    [8] = "speed-module-2",
    [9] = "speed-module-3",
    [10] = "efficiency-module-3"
}

local baseIngredients = {
    [2] = {
        { type = "item", name = "night-vision-equipment", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 10 }
    },
    [3] = {
        { type = "item", name = "5d-night-vision-equipment-02", amount = 1 },
        { type = "item", name = "advanced-circuit", amount = 8 }
    },
    [4] = {
        { type = "item", name = "5d-night-vision-equipment-03", amount = 1 },
        { type = "item", name = "battery", amount = 10 }
    },
    [5] = {
        { type = "item", name = "5d-night-vision-equipment-04", amount = 1 },
        { type = "item", name = "processing-unit", amount = 8 }
    },
    [6] = {
        { type = "item", name = "5d-night-vision-equipment-05", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 }
    },
    [7] = {
        { type = "item", name = "5d-night-vision-equipment-06", amount = 1 },
        { type = "item", name = "speed-module", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-night-vision-equipment-07", amount = 1 },
        { type = "item", name = "speed-module-2", amount = 2 }
    },
    [9] = {
        { type = "item", name = "5d-night-vision-equipment-08", amount = 1 },
        { type = "item", name = "speed-module-3", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-night-vision-equipment-09", amount = 1 },
        { type = "item", name = "efficiency-module-3", amount = 2 }
    }
}

local techConfig = {
    [2] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "night-vision-equipment", "production-science-pack" }
    },
    [3] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "night-vision-equipment-2" }
    },
    [4] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 }
        },
        prerequisites = { "night-vision-equipment-3" }
    },
    [5] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "night-vision-equipment-4", "utility-science-pack" }
    },
    [6] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "night-vision-equipment-5" }
    },
    [7] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "night-vision-equipment-6" }
    },
    [8] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "night-vision-equipment-7" }
    },
    [9] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "night-vision-equipment-8" }
    },
    [10] = {
        basePacks = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 }
        },
        prerequisites = { "night-vision-equipment-9" }
    }
}

local tiers = {
    [2] = { number = "02", order = "b", energyInput = 10 },
    [3] = { number = "03", order = "c", energyInput = 12 },
    [4] = { number = "04", order = "d", energyInput = 14 },
    [5] = { number = "05", order = "e", energyInput = 16 },
    [6] = { number = "06", order = "f", energyInput = 18 },
    [7] = { number = "07", order = "g", energyInput = 20 },
    [8] = { number = "08", order = "h", energyInput = 22 },
    [9] = { number = "09", order = "i", energyInput = 24 },
    [10] = { number = "10", order = "j", energyInput = 26 }
}

local function copyPrerequisites(values)
    local result = {}

    for _, value in ipairs(values) do
        table.insert(result, value)
    end

    return result
end

local function addPrerequisiteIfMissing(prerequisites, prerequisite)
    if not prerequisite then
        return
    end

    for _, current in ipairs(prerequisites) do
        if current == prerequisite then
            return
        end
    end

    table.insert(prerequisites, prerequisite)
end

local function getNightVisionDeltaPrerequisite(tier)
    if CostConfig.shouldUseSpaceAgeMaterials() and nightVisionSpaceAgeDeltaPrerequisites[tier] then
        return nightVisionSpaceAgeDeltaPrerequisites[tier]
    end

    return nightVisionDeltaPrerequisites[tier]
end

local function setPrototypeIcons(prototype, tier)
    prototype.icon = nil
    prototype.icon_size = nil
    prototype.icons = TierBadgeIcons.buildTieredIcons("__base__/graphics/icons/night-vision-equipment.png", tier, 64)
end

for i = 2, 10 do
    local tier = tiers[i]
    local item = table.deepcopy(data.raw.item["night-vision-equipment"])
    local recipe = table.deepcopy(data.raw.recipe["night-vision-equipment"])
    local equipment = table.deepcopy(data.raw["night-vision-equipment"]["night-vision-equipment"])
    local tech = table.deepcopy(data.raw.technology["night-vision-equipment"])
    local itemName = "5d-night-vision-equipment-" .. tier.number

    setPrototypeIcons(item, i)
    item.name = itemName
    item.subgroup = config.subgroup
    item.order = tier.order
    item.place_as_equipment_result = item.name

    local ingredients = CostCalculator.processIngredients(baseIngredients[i], i, {
        skipTierScaling = true,
        spaceAgeMaterialOverrides = nightVisionSpaceAgeMaterials,
        replaceSpaceAgeDelta = true
    })

    recipe.name = item.name
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.enabled = false
    recipe.ingredients = ingredients
    setPrototypeIcons(recipe, i)
    recipe.category = CostCalculator.getSpaceAgeRecipeCategory(i, nightVisionSpaceAgeMaterials)

    equipment.name = item.name
    equipment.take_result = item.name
    equipment.energy_input = tier.energyInput .. "kW"
    equipment.sprite.filename = "__5dim_equipment__/graphics/equipment/night-vision/night-vision-equipment-02.png"
    equipment.color_lookup = {
        { 0.5, "__core__/graphics/color_luts/identity-lut.png" }
    }

    local tc = techConfig[i]
    local prerequisites = copyPrerequisites(tc.prerequisites)
    addPrerequisiteIfMissing(prerequisites, getNightVisionDeltaPrerequisite(i))

    tech.name = "night-vision-equipment-" .. i
    tech.unit.count = CostCalculator.calculateTechCount(config.baseTechCount, i - 1)
    tech.unit.ingredients = CostCalculator.getTechPacks(tc.basePacks, i, {
        spaceAgePackOverrides = nightVisionSpaceAgeSciencePacks,
        forceSpaceAgePackOverrides = CostConfig.shouldUseSpaceAgeMaterials()
    })
    tech.prerequisites = prerequisites
    tech.effects = {
        {
            type = "unlock-recipe",
            recipe = item.name
        }
    }
    setPrototypeIcons(tech, i)

    data:extend({ equipment, recipe, item, tech })
end
