require("prototypes.tin-ore")
require("prototypes.lead-ore")
require("prototypes.zinc-ore")
require("prototypes.gold-ore")
require("prototypes.bauxite-ore")
bobmods.lib.resource.generate(bauxite)
bobmods.lib.resource.generate(gold)
bobmods.lib.resource.generate(zinc)
bobmods.lib.resource.generate(lead)
bobmods.lib.resource.generate(tin)
require("prototypes.changes")

if mods["5dim_automatization"] then
    require("prototypes.automatization")
end

-- if battlefield == true then
-- require("prototypes.battlefield")
-- end

-- if equipment == true then
-- require("prototypes.equipment")
-- end

if mods["5dim_energy"] then
    require("prototypes.energy")
end

if mods["5dim_logistic"] then
    require("prototypes.logistic")
end

if mods["5dim_mining"] then
    require("prototypes.mining")
end

if mods["5dim_modules"] then
    require("prototypes.modules")
end

if mods["5dim_resources"] then
    require("prototypes.resources")
end

if mods["5dim_transport"] then
    require("prototypes.transport")
end

if mods["5dim_vehicles"] then
    require("prototypes.vehicles")
end
