--!strict
local Ledger = {}
function Ledger.new(limit: number)
    local cells: {[string]: number} = {}
    local counts: {[number]: number} = {}
    local state = {}
    function state.count(owner: number): number
        return counts[owner] or 0
    end
    function state.canPlace(owner: number, id: string): boolean
        return cells[id] == nil and state.count(owner) < limit
    end
    function state.place(owner: number, id: string): boolean
        if not state.canPlace(owner, id) then return false end
        cells[id] = owner
        counts[owner] = state.count(owner) + 1
        return true
    end
    function state.remove(owner: number, id: string): boolean
        if cells[id] ~= owner then return false end
        cells[id] = nil
        counts[owner] = state.count(owner) - 1
        return true
    end
    function state.clear(owner: number): {string}
        local removed = {}
        for id, current in pairs(cells) do
            if current == owner then
                cells[id] = nil
                table.insert(removed, id)
            end
        end
        counts[owner] = nil
        return removed
    end
    return state
end
return Ledger
