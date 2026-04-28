-- Data updates for 5dim_equipment
-- Apply mod graphics to vanilla Space Age equipment

if mods["space-age"] then
    -- Apply 5dim graphics to battery-mk3-equipment (tier 03)
    local batteryItem = data.raw.item["battery-mk3-equipment"]
    if batteryItem then
        batteryItem.icon = "__5dim_equipment__/graphics/icon/battery/battery-equipment-icon-03.png"
        batteryItem.icon_size = 64
    end
    
    local batteryEquipment = data.raw["battery-equipment"]["battery-mk3-equipment"]
    if batteryEquipment then
        batteryEquipment.sprite = {
            filename = "__5dim_equipment__/graphics/equipment/battery/battery-equipment-03.png",
            width = 32,
            height = 64,
            priority = "medium"
        }
    end
    
    local batteryRecipe = data.raw.recipe["battery-mk3-equipment"]
    if batteryRecipe then
        batteryRecipe.icon = "__5dim_equipment__/graphics/icon/battery/battery-equipment-icon-03.png"
        batteryRecipe.icon_size = 64
    end
    
    local batteryTech = data.raw.technology["battery-mk3-equipment"]
    if batteryTech then
        batteryTech.icon = "__5dim_equipment__/graphics/icon/battery/battery-equipment-icon-03.png"
        batteryTech.icon_size = 64
    end
end
