--!strict
local Expedition = {}
export type State = {found: {[number]: boolean}, count: number, finished: boolean}
function Expedition.new(): State
    return {found={}, count=0, finished=false}
end
function Expedition.collect(state: State, id: number): string
    if state.finished or id ~= id or id % 1 ~= 0 or id < 1 or id > 5 or state.found[id] then return "ignored" end
    state.found[id]=true
    state.count+=1
    if state.count == 5 then state.finished=true; return "finished" end
    return "advanced"
end
return Expedition
