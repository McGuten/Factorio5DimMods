-- Biter
require("prototypes.biter.gen-biters")

-- Spitter
require("prototypes.spitter.gen-spitter")

-- Experimentals
if settings.startup["5d-exp"].value then
    require("prototypes.biter.experimental-biter")
    require("prototypes.spitter.experimental-spitter")
end
