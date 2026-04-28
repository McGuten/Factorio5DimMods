-- 5Dim's Development Tools
-- Data stage debugging

-- Register sprite for GUI button
data:extend({
    {
        type = "sprite",
        name = "5dim-dev-icon",
        filename = "__5dim_dev__/thumbnail.png",
        size = 144,
        scale = 0.25,  -- Scale down 144px to ~36px for GUI button
        flags = {"gui-icon"}
    }
})

local DevTools = require("lib.dev-tools")

log("================================================================================")
log("[5dim_dev] Development Tools Loaded - Data Stage")
log("================================================================================")

-- Report all spawners in the game
DevTools.reportSpawners()

-- Report all unit types
DevTools.reportUnits()

-- Report all damage types
DevTools.reportDamageTypes()

-- Report autoplace controls for enemies
DevTools.reportAutoplaceControls()

log("================================================================================")
log("[5dim_dev] Data Stage Report Complete")
log("================================================================================")
