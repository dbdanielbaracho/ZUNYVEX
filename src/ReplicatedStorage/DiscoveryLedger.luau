--!strict
local Ledger = {}
export type State = {[number]: {[string]: boolean}}
function Ledger.claim(state: State, userId: number, discovery: string): boolean
    if discovery == "" then return false end
    local entries = state[userId]
    if not entries then entries = {}; state[userId] = entries end
    if entries[discovery] then return false end
    entries[discovery] = true
    return true
end
return Ledger
