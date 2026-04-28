-- Changes
require("prototypes.changes")

-- Storage tank
require("prototypes.gen-storage-tank")

-- Storage tank multi connection
require("prototypes.gen-storage-tank-multi")

-- Steel chests
require("prototypes.gen-steel-chest")

-- Logistic chests (only if 5dim_logistic is installed)
if mods["5dim_logistic"] then
    require("prototypes.gen-logistic-chest")
end