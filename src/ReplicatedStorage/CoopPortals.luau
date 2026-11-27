--!strict
local Coop = {}
export type State = {player: number?, pad: number?, started: number}
function Coop.new(): State
    return {player=nil,pad=nil,started=0}
end
function Coop.clear(s: State)
    s.player=nil; s.pad=nil; s.started=0
end
function Coop.leave(s: State, user: number)
    if s.player==user then Coop.clear(s) end
end
function Coop.touch(s: State, user: number, pad: number, now: number): (string, number?)
    if user~=user or math.abs(user)==math.huge or user%1~=0 or (pad~=1 and pad~=2) or now~=now or now<0 or now==math.huge then
        return "ignored",nil
    end
    if s.player and (now<s.started or now-s.started>8) then Coop.clear(s) end
    if not s.player then
        s.player=user; s.pad=pad; s.started=now
        return "waiting",nil
    end
    if s.player==user or s.pad==pad then return "ignored",nil end
    local partner=s.player
    Coop.clear(s)
    return "finished",partner
end
return Coop
