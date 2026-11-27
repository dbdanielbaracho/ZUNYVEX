--!strict
local Palette = {}
local entries = table.freeze({
    table.freeze({name="Sky", r=80, g=180, b=255}),
    table.freeze({name="Pink", r=255, g=120, b=190}),
    table.freeze({name="Gold", r=255, g=210, b=70}),
    table.freeze({name="Mint", r=100, g=230, b=170}),
})
Palette.entries = entries
function Palette.match(r: number, g: number, b: number): number?
    for i, entry in ipairs(entries) do
        local dr, dg, db = r-entry.r/255, g-entry.g/255, b-entry.b/255
        if dr*dr+dg*dg+db*db < 0.0001 then return i end
    end
    return nil
end
return table.freeze(Palette)
