local RepairSpeedScaling = {}

function RepairSpeedScaling.linear(baseHealth, scaledHealth)
    if not baseHealth or not scaledHealth or baseHealth <= 0 then
        return nil
    end

    return math.max(1, scaledHealth / baseHealth)
end

function RepairSpeedScaling.conservative(baseHealth, scaledHealth)
    local ratio = RepairSpeedScaling.linear(baseHealth, scaledHealth)
    if not ratio then
        return nil
    end

    return 1 + 0.6 * (ratio - 1)
end

return RepairSpeedScaling