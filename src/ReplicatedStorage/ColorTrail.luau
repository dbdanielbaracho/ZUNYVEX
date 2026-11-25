--!strict
local Trail = {}
export type State = {nextGate: number, started: number, active: boolean}
function Trail.start(now: number): State
    return {nextGate=1, started=now, active=true}
end
function Trail.touch(s: State, gate: number, now: number): string
    if not s.active then return "ignored" end
    if now < s.started or now-s.started > 30 then
        s.active=false
        return "expired"
    end
    if gate ~= s.nextGate then return "ignored" end
    s.nextGate += 1
    if gate == 4 then
        s.active=false
        return "finished"
    end
    return "advanced"
end
return Trail
