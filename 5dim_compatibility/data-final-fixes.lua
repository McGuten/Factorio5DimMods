-- Compatibility
require("prototypes.compatible-mods")

if mods["Warehousing"] then
    -- Warehouse sort
    require("prototypes.sort-warehouse")
end

if mods["deadlock-beltboxes-loaders"] then
    -- Deadlock sort
    require("prototypes.sort-deadlock")

    if mods["Deadlock5Dims"] then
        -- Deadlock5Dim sort
        require("prototypes.sort-deadlock5dim")
    end
end

if mods["aai-containers"] then
    -- Warehouse sort
    require("prototypes.sort-aai-containers")
end

if mods["deep-storage-unit"] then
    -- Warehouse sort
    require("prototypes.sort-deep-storage-unit")
end

if mods["fluid-memory-storage"] then
    -- Warehouse sort
    require("prototypes.sort-fluid-memory-storage")
end

if mods["logistic-memory-units"] then
    -- Warehouse sort
    require("prototypes.sort-logistic-memory-units")
end