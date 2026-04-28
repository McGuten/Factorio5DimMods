-- 5Dim's Development Tools
-- Final fixes stage debugging (after all mods have loaded)

local DevTools = require("lib.dev-tools")

log("================================================================================")
log("[5dim_dev] Final Stage Report - All Mods Loaded")
log("================================================================================")

-- Final report of all spawners
DevTools.reportSpawners()

-- Final report of all units
DevTools.reportUnits()

-- Report spawner result units (what each spawner can spawn)
DevTools.reportSpawnerUnits()

-- Report enemy statistics summary
DevTools.reportEnemySummary()

log("================================================================================")
log("[5dim_dev] Final Stage Report Complete")
log("================================================================================")
