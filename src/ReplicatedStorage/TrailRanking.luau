--!strict
local Ranking = {}
export type Entry = {userId: number, milliseconds: number}
export type State = {[number]: number}
function Ranking.record(s: State, userId: number, elapsed: number): boolean
    if elapsed ~= elapsed or elapsed <= 0 or elapsed > 30 then return false end
    local ms = math.max(1, math.floor(elapsed * 1000 + 0.5))
    if s[userId] and s[userId] <= ms then return false end
    s[userId] = ms
    return true
end
function Ranking.top(s: State, limit: number): {Entry}
    local entries: {Entry} = {}
    for id, ms in s do table.insert(entries, {userId=id, milliseconds=ms}) end
    table.sort(entries, function(a,b)
        if a.milliseconds == b.milliseconds then return a.userId < b.userId end
        return a.milliseconds < b.milliseconds
    end)
    while #entries > math.max(0, limit) do table.remove(entries) end
    return entries
end
return Ranking
