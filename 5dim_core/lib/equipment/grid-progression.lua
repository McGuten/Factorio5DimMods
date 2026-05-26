local GridProgression = {}

function GridProgression.sizeFromBase(baseWidth, baseHeight, steps, firstAxis)
    local width = baseWidth
    local height = baseHeight
    local nextAxis = firstAxis or "height"

    for _ = 1, steps do
        if nextAxis == "height" then
            height = height + 1
            nextAxis = "width"
        else
            width = width + 1
            nextAxis = "height"
        end
    end

    return {
        width = width,
        height = height
    }
end

function GridProgression.buildTierMap(baseWidth, baseHeight, firstTier, lastTier, firstAxis)
    local sizes = {}

    for tier = firstTier, lastTier do
        sizes[tier] = GridProgression.sizeFromBase(baseWidth, baseHeight, tier - firstTier + 1, firstAxis)
    end

    return sizes
end

return GridProgression