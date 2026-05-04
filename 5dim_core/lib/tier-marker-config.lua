local runtimeFamilies = {
    {
        id = "artillery",
        draw_runtime_tier = true,
        type_filters = { "artillery-turret", "artillery-wagon" },
        base_names = {
            ["artillery-turret"] = 1,
            ["artillery-wagon"] = 1
        },
        patterns = {
            "^5d%-artillery%-turret%-(%d+)$",
            "^5d%-artillery%-wagon%-(%d+)$"
        }
    },
    {
        id = "storage",
        draw_runtime_tier = true,
        required_mods = { "5dim_storage" },
        type_filters = { "container", "logistic-container" },
        base_names = {
            ["steel-chest"] = 1,
            ["passive-provider-chest"] = 1,
            ["active-provider-chest"] = 1,
            ["storage-chest"] = 1,
            ["buffer-chest"] = 1,
            ["requester-chest"] = 1
        },
        patterns = {
            "^5d%-steel%-chest%-(%d+)$",
            "^5d%-passive%-provider%-chest%-(%d+)$",
            "^5d%-active%-provider%-chest%-(%d+)$",
            "^5d%-storage%-chest%-(%d+)$",
            "^5d%-buffer%-chest%-(%d+)$",
            "^5d%-requester%-chest%-(%d+)$"
        }
    },
    {
        id = "battlefield",
        draw_runtime_tier = true,
        required_mods = { "5dim_battlefield" },
        type_filters = { "ammo-turret", "electric-turret", "land-mine" },
        base_names = {
            ["gun-turret"] = 1,
            ["laser-turret"] = 1,
            ["land-mine"] = 1
        },
        patterns = {
            "^5d%-gun%-turret%-(%d+)$",
            "^5d%-gun%-turret%-sniper%-(%d+)$",
            "^5d%-laser%-turret%-(%d+)$",
            "^5d%-laser%-turret%-sniper%-(%d+)$",
            "^5d%-poison%-turret%-(%d+)$",
            "^5d%-acid%-turret%-(%d+)$",
            "^5d%-mortar%-turret%-(%d+)$",
            "^5d%-robot%-deployer%-(%d+)$",
            "^5d%-flare%-turret%-(%d+)$",
            "^5d%-land%-mine%-(%d+)$",
            "^5d%-poison%-mine%-(%d+)$",
            "^5d%-acid%-mine%-(%d+)$"
        }
    },
    {
        id = "vehicles",
        draw_runtime_tier = true,
        required_mods = { "5dim_vehicles" },
        type_filters = { "car", "spider-vehicle" },
        base_names = {
            ["tank"] = 1,
            ["spidertron"] = 1
        },
        patterns = {
            "^5d%-tank%-(%d+)$",
            "^5d%-spidertron%-(%d+)$"
        }
    },
    {
        id = "nuclear",
        draw_runtime_tier = true,
        required_mods = { "5dim_nuclear" },
        type_filters = { "heat-pipe" },
        base_names = {
            ["heat-pipe"] = 1
        },
        patterns = {
            "^5d%-heat%-pipe%-(%d+)$"
        }
    },
    {
        id = "space-age",
        draw_runtime_tier = true,
        required_mods = { "5dim_space_age" },
        type_filters = { "cargo-landing-pad", "assembling-machine", "lightning-attractor", "reactor" },
        base_names = {
            ["cargo-landing-pad"] = 1,
            ["captive-biter-spawner"] = 1,
            ["cryogenic-plant"] = 1,
            ["heating-tower"] = 1,
            ["lightning-rod"] = 1
        },
        patterns = {
            "^5d%-cargo%-landing%-pad%-(%d+)$",
            "^5d%-captive%-biter%-spawner%-(%d+)$",
            "^5d%-cryogenic%-plant%-(%d+)$",
            "^5d%-heating%-tower%-(%d+)$",
            "^5d%-lightning%-rod%-(%d+)$"
        }
    }
}

local function isRuntimeFamilyEnabled(family, activeMods)
    if not family.required_mods then
        return true
    end

    for _, modName in ipairs(family.required_mods) do
        if not activeMods[modName] then
            return false
        end
    end

    return true
end

local function buildRuntimeTypeFilters(families)
    local filters = {}
    local seenTypes = {}

    for _, family in ipairs(families) do
        if family.draw_runtime_tier then
            for _, entityType in ipairs(family.type_filters or {}) do
                if not seenTypes[entityType] then
                    seenTypes[entityType] = true
                    table.insert(filters, { filter = "type", type = entityType })
                end
            end
        end
    end

    return filters
end

local function buildRuntimeRebuildTypes(families)
    local rebuildTypes = {}
    local seenTypes = {}

    for _, family in ipairs(families) do
        if family.draw_runtime_tier then
            for _, entityType in ipairs(family.type_filters or {}) do
                if not seenTypes[entityType] then
                    seenTypes[entityType] = true
                    table.insert(rebuildTypes, entityType)
                end
            end
        end
    end

    return rebuildTypes
end

return {
    runtime_families = runtimeFamilies,
    runtime_type_filters = buildRuntimeTypeFilters(runtimeFamilies),
    runtime_rebuild_types = buildRuntimeRebuildTypes(runtimeFamilies),
    is_runtime_family_enabled = isRuntimeFamilyEnabled
}