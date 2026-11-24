--!strict
-- Versioned, bounded build serialization. This module never writes DataStore by itself.
-- DataStore integration remains opt-in until Studio multiplayer and recovery tests pass.
local Persistence = {}
local MAX = 80
local GRID = 4
local COLORS = {Sky = true, Pink = true, Gold = true, Mint = true}
local function finite(n: any): boolean
    return typeof(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end
local function denseCount(value: any, limit: number): number?
    if typeof(value) ~= "table" then return nil end
    local count = 0
    for key, _ in pairs(value) do
        if typeof(key) ~= "number" or key % 1 ~= 0 or key < 1 or key > limit then return nil end
        count += 1
    end
    for index = 1, count do
        if rawget(value, index) == nil then return nil end
    end
    return count
end
local function coordinate(n: any): boolean
    return finite(n) and n % GRID == 0
end
function Persistence.encode(entries: {{x: number, y: number, z: number, color: string}}): {[string]: any}?
    if denseCount(entries, MAX) == nil then return nil end
    local result = {}
    local occupied = {}
    for _, entry in ipairs(entries) do
        if typeof(entry) ~= "table" then return nil end
        if not coordinate(entry.x) or not coordinate(entry.y) or not coordinate(entry.z) then return nil end
        if math.abs(entry.x) > 106 or math.abs(entry.z) > 106 or entry.y < 4 or entry.y > 44 then return nil end
        if typeof(entry.color) ~= "string" or not COLORS[entry.color] then return nil end
        local key = string.format("%d:%d:%d", entry.x, entry.y, entry.z)
        if occupied[key] then return nil end
        occupied[key] = true
        table.insert(result, {entry.x, entry.y, entry.z, entry.color})
    end
    return {version = 1, pieces = result}
end
function Persistence.decode(payload: any): {{x: number, y: number, z: number, color: string}}?
    if typeof(payload) ~= "table" or payload.version ~= 1 or typeof(payload.pieces) ~= "table" then return nil end
    if denseCount(payload.pieces, MAX) == nil then return nil end
    local entries = {}
    for _, row in ipairs(payload.pieces) do
        if denseCount(row, 4) ~= 4 then return nil end
        table.insert(entries, {x = row[1], y = row[2], z = row[3], color = row[4]})
    end
    if not Persistence.encode(entries) then return nil end
    return entries
end
return Persistence
