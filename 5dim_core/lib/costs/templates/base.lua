-------------------------------------------------------------------------------
-- 5Dim's Mod - Recipe Templates (Base)
-- Common materials and helper functions used by all template modules
-------------------------------------------------------------------------------

local RecipeTemplates = {}

-------------------------------------------------------------------------------
-- BASE MATERIALS BY PROGRESSION LEVEL
-------------------------------------------------------------------------------

-- Early game materials (Tiers 1-3)
RecipeTemplates.earlyMaterials = {
    circuit = "electronic-circuit",
    plate = "iron-plate",
    advancedPlate = "steel-plate",
    gear = "iron-gear-wheel"
}

-- Mid game materials (Tiers 4-6)
RecipeTemplates.midMaterials = {
    circuit = "advanced-circuit",
    plate = "steel-plate",
    gear = "iron-gear-wheel",
    module1 = "speed-module",
    module2 = "productivity-module"
}

-- Late game materials (Tiers 7-10)
RecipeTemplates.lateMaterials = {
    circuit = "processing-unit",
    plate = "low-density-structure",
    module1 = "speed-module-3",
    module2 = "productivity-module-3"
}

-------------------------------------------------------------------------------
-- TECHNOLOGY TEMPLATES
-------------------------------------------------------------------------------

-- Standard science pack progression by tier
RecipeTemplates.sciencePacksByTier = {
    [1] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 }
    },
    [2] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 }
    },
    [3] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 }
    },
    [4] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 }
    },
    [5] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 }
    },
    [6] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 }
    },
    [7] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 }
    },
    [8] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 }
    },
    [9] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 }
    },
    [10] = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 }
    }
}

-- Get base tech count for different entity categories
RecipeTemplates.baseTechCounts = {
    miningDrill = 200,
    assemblingMachine = 150,
    chemicalPlant = 200,
    oilRefinery = 250,
    lab = 200,
    constructionRobot = 200,
    logisticRobot = 200,
    roboport = 300,
    pump = 150,
    inserter = 150,
    stackInserter = 200,
    bulkInserter = 200,
    accumulator = 200,
    boiler = 200,
    steamEngine = 200,
    solarPanel = 200,
    lamp = 100,
    bigElectricPole = 150,
    mediumElectricPole = 150,
    substation = 200,
    locomotive = 300,
    cargoWagon = 200,
    fluidWagon = 200,
    wall = 100,
    gate = 100,
    radar = 200,
    turret = 300,
    offshorePump = 150,
    pumpjack = 200,
    waterPumpjack = 200,
    electricFurnace = 200,
    masher = 200,
    storageTank = 150,
    centrifuge = 300,
    heatExchanger = 300,
    heatPipe = 200,
    nuclearReactor = 500,
    steamTurbine = 300,
    equipment = 200,
    beacon = 300,
    module = 250
}

return RecipeTemplates
