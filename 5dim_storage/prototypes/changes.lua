-- Storage tank changes
data.raw["storage-tank"]["storage-tank"].fast_replaceable_group = "storage-tank"

-- Steel chest changes - enable fast replace and set next upgrade
data.raw["container"]["steel-chest"].fast_replaceable_group = "container"
data.raw["container"]["steel-chest"].next_upgrade = "5d-steel-chest-02"

-- Logistic chest changes (only if 5dim_logistic is installed)
if mods["5dim_logistic"] then
    data.raw["logistic-container"]["passive-provider-chest"].next_upgrade = "5d-passive-provider-chest-02"
    data.raw["logistic-container"]["active-provider-chest"].next_upgrade = "5d-active-provider-chest-02"
    data.raw["logistic-container"]["storage-chest"].next_upgrade = "5d-storage-chest-02"
    data.raw["logistic-container"]["buffer-chest"].next_upgrade = "5d-buffer-chest-02"
    data.raw["logistic-container"]["requester-chest"].next_upgrade = "5d-requester-chest-02"
end