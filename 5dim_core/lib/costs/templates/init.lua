-------------------------------------------------------------------------------
-- 5DIM'S MOD - RECIPE TEMPLATES INDEX
-- This file loads all template modules and combines them into a single table.
-- Usage: local Templates = require("lib.costs.templates")
-------------------------------------------------------------------------------

local Templates = {}

-------------------------------------------------------------------------------
-- HELPER FUNCTION: Merge templates from a module into the main Templates table
-------------------------------------------------------------------------------
local function mergeTemplates(source)
    for key, value in pairs(source) do
        if Templates[key] then
            error("Template key collision: '" .. key .. "' already exists!")
        end
        Templates[key] = value
    end
end

-------------------------------------------------------------------------------
-- LOAD ALL TEMPLATE MODULES
-------------------------------------------------------------------------------

-- Base templates (materials, science packs, tech counts)
mergeTemplates(require("__5dim_core__.lib.costs.templates.base"))

-- Mining templates (mining drill, offshore pump, pumpjack, etc.)
mergeTemplates(require("__5dim_core__.lib.costs.templates.mining"))

-- Automation templates (assembling machine, chemical plant, lab, oil refinery)
mergeTemplates(require("__5dim_core__.lib.costs.templates.automation"))

-- Logistic templates (robots, roboport)
mergeTemplates(require("__5dim_core__.lib.costs.templates.logistic"))

-- Transport templates (pump, inserters)
mergeTemplates(require("__5dim_core__.lib.costs.templates.transport"))

-- Energy templates (accumulator, boiler, steam engine, solar panel, poles, etc.)
mergeTemplates(require("__5dim_core__.lib.costs.templates.energy"))

-- Trains templates (locomotive, wagons)
mergeTemplates(require("__5dim_core__.lib.costs.templates.trains"))

-- Battlefield templates (wall, gate, radar, turrets)
mergeTemplates(require("__5dim_core__.lib.costs.templates.battlefield"))

-- Resources templates (electric furnace, masher)
mergeTemplates(require("__5dim_core__.lib.costs.templates.resources"))

-- Storage templates (tanks, chests)
mergeTemplates(require("__5dim_core__.lib.costs.templates.storage"))

-- Nuclear templates (centrifuge, heat exchanger, reactor, turbine)
mergeTemplates(require("__5dim_core__.lib.costs.templates.nuclear"))

-- Equipment templates (battery, solar, reactor, shields, weapons, exoskeleton, etc.)
mergeTemplates(require("__5dim_core__.lib.costs.templates.equipment"))

-- Module templates (beacon, modules)
mergeTemplates(require("__5dim_core__.lib.costs.templates.module"))

-------------------------------------------------------------------------------
-- CONDITIONAL LOADING: Space Age DLC templates
-- Only load if Space Age mod is active
-------------------------------------------------------------------------------
if mods and mods["space-age"] then
    mergeTemplates(require("__5dim_core__.lib.costs.templates.space-age"))
end

-------------------------------------------------------------------------------
-- EXPORT
-------------------------------------------------------------------------------
return Templates
