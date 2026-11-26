--!strict
local Ledger = {}
function Ledger.new(limit: number)
    local cells: {[string]: number} = {}
    local counts: {[number]: number} = {}
    local grants: {[number]: {[number]: boolean}} = {}
    local state = {}
    function state.setCollaborator(owner: number, guest: number, allowed: boolean): boolean
        if owner == guest then return false end
        if allowed then
            local group = grants[owner] or {}
            group[guest] = true
            grants[owner] = group
        elseif grants[owner] then
            grants[owner][guest] = nil
        end
        return true
    end
    function state.canEdit(owner: number, actor: number): boolean
        return owner == actor or (grants[owner] ~= nil and grants[owner][actor] == true)
    end
    function state.ownerOf(id: string): number?
        return cells[id]
    end
    function state.canRecolor(actor: number, id: string): boolean
        return cells[id] == actor
    end
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
        local actual = cells[id]
        if actual == nil or not state.canEdit(actual, owner) then return false end
        cells[id] = nil
        counts[actual] = state.count(actual) - 1
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
        grants[owner] = nil
        for _, group in pairs(grants) do group[owner] = nil end
        counts[owner] = nil
        return removed
    end
    return state
end
return Ledger
