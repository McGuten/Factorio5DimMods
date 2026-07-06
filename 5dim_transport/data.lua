-- Pipe Ground 30
require("prototypes.pipe-ground-1-30")

-- Pipe Ground 50
require("prototypes.pipe-ground-1-50")

-- Transport belt
require("prototypes.gen-transport-belt")

-- Inserters
require("prototypes.gen-inserter")

--small pump
require("prototypes.gen-pump")

--Changes
require("prototypes.changes")

-- Stack inserters (Space Age only: the vanilla "stack-inserter" prototype this
-- generator extends does not exist without the DLC)
if mods["space-age"] then
    require("prototypes.gen-stack-inserter")
end
