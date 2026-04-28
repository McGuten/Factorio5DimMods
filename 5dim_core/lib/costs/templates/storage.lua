-------------------------------------------------------------------------------
-- 5DIM'S MOD - STORAGE TEMPLATES
-- Templates for storage entities: tanks, chests, logistic chests
-- Each template defines 10 tiers of ingredient progression
-------------------------------------------------------------------------------

local Templates = {}

-------------------------------------------------------------------------------
-- FLUID STORAGE TEMPLATES
-------------------------------------------------------------------------------

-- Storage Tank templates
Templates.storageTank = {
    [1] = {
        { type = "item", name = "iron-plate", amount = 20 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [2] = {
        { type = "item", name = "storage-tank", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "stone-brick", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-storage-tank-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "concrete", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-storage-tank-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "concrete", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-storage-tank-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "concrete", amount = 5 },
        { type = "item", name = "speed-module", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-storage-tank-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    [7] = {
        { type = "item", name = "5d-storage-tank-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "speed-module-2", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-storage-tank-07", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "productivity-module-2", amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-storage-tank-08", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "speed-module-3", amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-storage-tank-09", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "productivity-module-3", amount = 1 }
    }
}

-- Storage Tank Multi templates
Templates.storageTankMulti = {
    [1] = {
        { type = "item", name = "iron-plate", amount = 20 },
        { type = "item", name = "steel-plate", amount = 5 }
    },
    [2] = {
        { type = "item", name = "5d-storage-tank-multi-01", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "stone-brick", amount = 5 }
    },
    [3] = {
        { type = "item", name = "5d-storage-tank-multi-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "concrete", amount = 5 }
    },
    [4] = {
        { type = "item", name = "5d-storage-tank-multi-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "concrete", amount = 5 }
    },
    [5] = {
        { type = "item", name = "5d-storage-tank-multi-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "concrete", amount = 5 },
        { type = "item", name = "speed-module", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-storage-tank-multi-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "productivity-module", amount = 1 }
    },
    [7] = {
        { type = "item", name = "5d-storage-tank-multi-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "advanced-circuit", amount = 3 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "speed-module-2", amount = 1 }
    },
    [8] = {
        { type = "item", name = "5d-storage-tank-multi-07", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "productivity-module-2", amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-storage-tank-multi-08", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 1 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "speed-module-3", amount = 1 }
    },
    [10] = {
        { type = "item", name = "5d-storage-tank-multi-09", amount = 1 },
        { type = "item", name = "steel-plate", amount = 5 },
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "refined-concrete", amount = 5 },
        { type = "item", name = "productivity-module-3", amount = 1 }
    }
}

-------------------------------------------------------------------------------
-- ITEM STORAGE TEMPLATES
-------------------------------------------------------------------------------

-- Steel Chest templates
Templates.steelChest = {
    [1] = {
        { type = "item", name = "steel-plate", amount = 8 }
    },
    [2] = {
        { type = "item", name = "steel-chest", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "electronic-circuit", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-steel-chest-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "electronic-circuit", amount = 3 }
    },
    [4] = {
        { type = "item", name = "5d-steel-chest-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "electronic-circuit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-steel-chest-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [6] = {
        { type = "item", name = "5d-steel-chest-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "advanced-circuit", amount = 3 }
    },
    [7] = {
        { type = "item", name = "5d-steel-chest-06", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "advanced-circuit", amount = 4 }
    },
    [8] = {
        { type = "item", name = "5d-steel-chest-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "processing-unit", amount = 1 }
    },
    [9] = {
        { type = "item", name = "5d-steel-chest-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [10] = {
        { type = "item", name = "5d-steel-chest-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 },
        { type = "item", name = "processing-unit", amount = 3 }
    }
}

-------------------------------------------------------------------------------
-- LOGISTIC CHEST TEMPLATES
-------------------------------------------------------------------------------

-- Passive Provider Chest templates
Templates.passiveProviderChest = {
    [1] = {
        { type = "item", name = "steel-chest", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "advanced-circuit", amount = 1 }
    },
    [2] = {
        { type = "item", name = "passive-provider-chest", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-passive-provider-chest-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 3 }
    },
    [4] = {
        { type = "item", name = "5d-passive-provider-chest-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "advanced-circuit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-passive-provider-chest-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "processing-unit", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-passive-provider-chest-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-passive-provider-chest-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-passive-provider-chest-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [9] = {
        { type = "item", name = "5d-passive-provider-chest-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [10] = {
        { type = "item", name = "5d-passive-provider-chest-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "processing-unit", amount = 4 }
    }
}

-- Active Provider Chest templates
Templates.activeProviderChest = {
    [1] = {
        { type = "item", name = "steel-chest", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "advanced-circuit", amount = 1 }
    },
    [2] = {
        { type = "item", name = "active-provider-chest", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-active-provider-chest-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 3 }
    },
    [4] = {
        { type = "item", name = "5d-active-provider-chest-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "advanced-circuit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-active-provider-chest-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "processing-unit", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-active-provider-chest-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-active-provider-chest-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-active-provider-chest-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [9] = {
        { type = "item", name = "5d-active-provider-chest-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [10] = {
        { type = "item", name = "5d-active-provider-chest-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "processing-unit", amount = 4 }
    }
}

-- Storage Chest templates
Templates.storageChest = {
    [1] = {
        { type = "item", name = "steel-chest", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "advanced-circuit", amount = 1 }
    },
    [2] = {
        { type = "item", name = "storage-chest", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-storage-chest-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 3 }
    },
    [4] = {
        { type = "item", name = "5d-storage-chest-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "advanced-circuit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-storage-chest-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "processing-unit", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-storage-chest-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-storage-chest-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-storage-chest-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [9] = {
        { type = "item", name = "5d-storage-chest-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [10] = {
        { type = "item", name = "5d-storage-chest-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "processing-unit", amount = 4 }
    }
}

-- Buffer Chest templates
Templates.bufferChest = {
    [1] = {
        { type = "item", name = "steel-chest", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "advanced-circuit", amount = 1 }
    },
    [2] = {
        { type = "item", name = "buffer-chest", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-buffer-chest-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 3 }
    },
    [4] = {
        { type = "item", name = "5d-buffer-chest-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "advanced-circuit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-buffer-chest-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "processing-unit", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-buffer-chest-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-buffer-chest-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-buffer-chest-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [9] = {
        { type = "item", name = "5d-buffer-chest-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [10] = {
        { type = "item", name = "5d-buffer-chest-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "processing-unit", amount = 4 }
    }
}

-- Requester Chest templates
Templates.requesterChest = {
    [1] = {
        { type = "item", name = "steel-chest", amount = 1 },
        { type = "item", name = "electronic-circuit", amount = 3 },
        { type = "item", name = "advanced-circuit", amount = 1 }
    },
    [2] = {
        { type = "item", name = "requester-chest", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 2 }
    },
    [3] = {
        { type = "item", name = "5d-requester-chest-02", amount = 1 },
        { type = "item", name = "steel-plate", amount = 4 },
        { type = "item", name = "advanced-circuit", amount = 3 }
    },
    [4] = {
        { type = "item", name = "5d-requester-chest-03", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "advanced-circuit", amount = 4 }
    },
    [5] = {
        { type = "item", name = "5d-requester-chest-04", amount = 1 },
        { type = "item", name = "steel-plate", amount = 6 },
        { type = "item", name = "processing-unit", amount = 1 }
    },
    [6] = {
        { type = "item", name = "5d-requester-chest-05", amount = 1 },
        { type = "item", name = "steel-plate", amount = 8 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [7] = {
        { type = "item", name = "5d-requester-chest-06", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 2 },
        { type = "item", name = "processing-unit", amount = 2 }
    },
    [8] = {
        { type = "item", name = "5d-requester-chest-07", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 3 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [9] = {
        { type = "item", name = "5d-requester-chest-08", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 4 },
        { type = "item", name = "processing-unit", amount = 3 }
    },
    [10] = {
        { type = "item", name = "5d-requester-chest-09", amount = 1 },
        { type = "item", name = "low-density-structure", amount = 5 },
        { type = "item", name = "processing-unit", amount = 4 }
    }
}

return Templates
