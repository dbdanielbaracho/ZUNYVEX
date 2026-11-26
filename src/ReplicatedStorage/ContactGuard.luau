--!strict
local Guard = {}
-- Reject non-finite coordinates and contacts outside a generous server-observed radius.
function Guard.near(distance: number, radius: number): boolean
    return distance == distance and radius == radius and distance >= 0
        and radius >= 0 and radius < math.huge and distance <= radius
end
return Guard
