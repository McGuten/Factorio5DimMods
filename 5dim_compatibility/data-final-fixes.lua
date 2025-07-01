-- Compatibility
require("prototypes.compatible-mods")

if mods["Warehousing"] then
    -- Warehouse sort
    require("prototypes.sort-warehouse")
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

if mods["deadlock-beltboxes-loaders"] then
    -- Deadlock sort
    require("prototypes.sort-deadlock")

    if mods["5dim_transport"] then
        if deadlock then
            -- This funtion uses Deadlock's API to add tiers of loaders and beltboxes.
            deadlock.add_tier({
                transport_belt = "5d-transport-belt-04",
                colour = {
                    r = 239,
                    g = 142,
                    b = 231
                },
                underground_belt = "5d-underground-belt-04",
                splitter = "5d-splitter-04",
                groundBelt30 = "5d-underground-belt-30-04",
                groundBelt50 = "5d-underground-belt-50-04",
                technology = "logistics-4",
                order = "d"
            })
            -- rgba(76,216,69,255)
            deadlock.add_tier({
                transport_belt = "5d-transport-belt-05",
                colour = {
                    r = 76,
                    g = 216,
                    b = 69
                },
                underground_belt = "5d-underground-belt-05",
                splitter = "5d-splitter-05",
                groundBelt30 = "5d-underground-belt-30-05",
                groundBelt50 = "5d-underground-belt-50-05",
                technology = "logistics-5",
                order = "d"
            })
            -- rgba(119,79,53,255)
            deadlock.add_tier({
                transport_belt = "5d-transport-belt-06",
                colour = {
                    r = 119,
                    g = 79,
                    b = 53
                },
                underground_belt = "5d-underground-belt-06",
                splitter = "5d-splitter-06",
                groundBelt30 = "5d-underground-belt-30-06",
                groundBelt50 = "5d-underground-belt-50-06",
                technology = "logistics-6",
                order = "d"
            })
            -- rgba(112,54,151,255)
            deadlock.add_tier({
                transport_belt = "5d-transport-belt-07",
                colour = {
                    r = 112,
                    g = 54,
                    b = 151
                },
                underground_belt = "5d-underground-belt-07",
                splitter = "5d-splitter-07",
                groundBelt30 = "5d-underground-belt-30-07",
                groundBelt50 = "5d-underground-belt-50-07",
                technology = "logistics-7",
                order = "d"

            })
            -- rgba(217,216,215,255)
            deadlock.add_tier({
                transport_belt = "5d-transport-belt-08",
                colour = {
                    r = 217,
                    g = 216,
                    b = 215
                },
                underground_belt = "5d-underground-belt-08",
                splitter = "5d-splitter-08",
                groundBelt30 = "5d-underground-belt-30-08",
                groundBelt50 = "5d-underground-belt-50-08",
                technology = "logistics-8",
                order = "d"
            })
            -- rgba(206,99,1,255)
            deadlock.add_tier({
                transport_belt = "5d-transport-belt-09",
                colour = {
                    r = 206,
                    g = 99,
                    b = 1
                },
                underground_belt = "5d-underground-belt-09",
                splitter = "5d-splitter-09",
                groundBelt30 = "5d-underground-belt-30-09",
                groundBelt50 = "5d-underground-belt-50-09",
                technology = "logistics-9",
                order = "d"
            })
            -- rgba(75,77,235,255)
            deadlock.add_tier({
                transport_belt = "5d-transport-belt-10",
                colour = {
                    r = 75,
                    g = 77,
                    b = 235
                },
                underground_belt = "5d-underground-belt-10",
                splitter = "5d-splitter-10",
                groundBelt30 = "5d-underground-belt-30-10",
                groundBelt50 = "5d-underground-belt-50-10",
                technology = "logistics-10",
                order = "d"
            })
        end

        -- Deadlock5Dim sort
        require("prototypes.sort-deadlock5dim")
    end
end
