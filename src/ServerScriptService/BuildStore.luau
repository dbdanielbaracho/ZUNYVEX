--!strict
-- Inactive DataStore adapter; integrate only after Studio tests.
local Codec = require(script.Parent.BuildPersistence)
local Store = {}
local function samePayload(left: any, right: any): boolean
    local a = Codec.decode(left)
    local b = Codec.decode(right)
    if a == nil or b == nil or #a ~= #b then return false end
    for i = 1, #a do
        local x, y = a[i], b[i]
        if x.x ~= y.x or x.y ~= y.y or x.z ~= y.z or x.color ~= y.color then return false end
    end
    return true
end
local function keyFor(userId: number): string
    assert(userId > 0 and userId % 1 == 0 and userId < math.huge, "invalid user id")
    return "builds:v1:" .. tostring(userId)
end
function Store.load(dataStore: any, userId: number): (any?, string)
    local ok, value = pcall(function()
        return dataStore:GetAsync(keyFor(userId))
    end)
    if not ok then return nil, "read_failed" end
    if value == nil then return {entries = {}, revision = 0, userId = userId}, "ok" end
    if typeof(value) ~= "table" or typeof(value.revision) ~= "number" or
        value.revision < 1 or value.revision % 1 ~= 0 or value.revision == math.huge then
        return nil, "invalid_record"
    end
    local entries = Codec.decode(value.payload)
    if entries == nil then return nil, "invalid_record" end
    return {entries = entries, revision = value.revision, userId = userId}, "ok"
end
function Store.save(dataStore: any, session: any, entries: any): (any?, string)
    if typeof(session) ~= "table" or typeof(session.revision) ~= "number" or
        typeof(session.userId) ~= "number" or session.userId <= 0 or
        session.userId % 1 ~= 0 or session.userId == math.huge or session.revision < 0 or
        session.revision % 1 ~= 0 or session.revision == math.huge then
        return nil, "invalid_session"
    end
    local payload = Codec.encode(entries)
    if payload == nil then return nil, "invalid_build" end
    local expected = session.revision
    local ok, result = pcall(function()
        return dataStore:UpdateAsync(keyFor(session.userId), function(current)
            local revision = 0
            if current ~= nil then
                if typeof(current) ~= "table" or typeof(current.revision) ~= "number" or
                    current.revision < 1 or current.revision % 1 ~= 0 or
                    current.revision == math.huge or Codec.decode(current.payload) == nil then
                    return nil
                end
                revision = current.revision
            end
            if revision ~= expected then return nil end
            return {revision = revision + 1, payload = payload}
        end)
    end)
    if not ok then return nil, "write_failed" end
    if result == nil then return nil, "conflict" end
    if typeof(result) ~= "table" or result.revision ~= expected + 1 or
        not samePayload(result.payload, payload) then return nil, "invalid_write_result" end
    return {entries = entries, revision = expected + 1, userId = session.userId}, "ok"
end
return Store
