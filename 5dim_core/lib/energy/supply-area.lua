-------------------------------------------------------------------------------
-- 5Dim's Core - Electric pole supply area alignment
--
-- Factorio draws the supply area as a square of side 2 * supply_area_distance
-- centred on the entity, so grid alignment depends on the tile footprint:
--   * odd footprint  (1x1 poles)  -> entity sits on a tile centre, only x.5
--                                    distances land on tile borders
--   * even footprint (2x2 poles)  -> entity sits on a tile corner, only whole
--                                    distances land on tile borders
-- Any other value leaves half covered tiles and slivers between neighbouring
-- poles, so tier values are always rounded up to the next aligned distance.
-------------------------------------------------------------------------------

local SupplyArea = {}

local EPSILON = 1e-6

local function getX(point)
    if not point then
        return nil
    end

    return point.x or point[1]
end

local function getTileWidth(entity)
    if entity.tile_width then
        return entity.tile_width
    end

    local box = entity.collision_box
    local left = box and getX(box[1])
    local right = box and getX(box[2])

    if not left or not right then
        return 1
    end

    return math.max(1, math.ceil(right - left))
end

--- Round a supply area distance up to the next tile aligned value.
--- @param entity table Prototype the distance will be applied to
--- @param distance number Raw distance produced by the tier progression
--- @return number Aligned distance (never smaller than the raw one)
function SupplyArea.align(entity, distance)
    local offset = (getTileWidth(entity) % 2 == 1) and 0.5 or 0
    local aligned = math.ceil(distance - offset - EPSILON) + offset
    local minimum = (offset > 0) and 0.5 or 1

    return math.max(minimum, aligned)
end

return SupplyArea
