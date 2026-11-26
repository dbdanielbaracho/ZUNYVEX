--!strict
local M = {}
export type State = {sequence: {number}, nextIndex: number, started: number, active: boolean}
function M.start(sequence: {number}, now: number): State
    assert(#sequence == 4)
    return {sequence=table.clone(sequence), nextIndex=1, started=now, active=true}
end
function M.touch(s: State, color: number, now: number): string
    if not s.active then return "ignored" end
    if now ~= now or now < s.started or now - s.started > 25 then
        s.active=false; return "expired"
    end
    if color % 1 ~= 0 or color < 1 or color > 4 then return "ignored" end
    if color ~= s.sequence[s.nextIndex] then s.active=false; return "wrong" end
    s.nextIndex += 1
    if s.nextIndex > #s.sequence then s.active=false; return "finished" end
    return "advanced"
end
return M
